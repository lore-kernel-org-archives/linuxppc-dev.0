Message-ID: <3F7DA229.7090409@austin.ibm.com>
Date: Fri, 03 Oct 2003 11:22:01 -0500
From: Nathan Lynch <nathanl@austin.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: [PATCH/RFC] add proc_dir_entry fields to device_node
Content-Type: multipart/mixed;
 boundary="------------000008040604030207060906"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------000008040604030207060906
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi-

I am doing some ppc64 work to enable dynamic addition and removal of
nodes in /proc/device-tree.  It seems that recording a node's directory
and symlinks (if any) in the device_node is the easiest way to assure
that a node is cleaned up properly after deletion.

I need to add a few lines to fs/proc/proc_devtree.c::add_node() to
record the proc entries for each node as it is processed.  These will
refer to fields that do not yet exist in ppc's device_node.  I propose
adding these fields to ppc's device_node (patch attached).  If that
comment in prom.h about breaking BootX is still valid, there are
alternatives, but they would likely involve ifdefs and macros.

I have attached the proposed changes in separate patches against linus
2.5 bk.  The proc_devtree patch is for illustration purposes -- the
patch I submit to lkml will make add_node() extern and place its
declaration in the proper header.

Comments?

Nathan

--------------000008040604030207060906
Content-Type: text/plain;
 name="ppc_device_node.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ppc_device_node.patch"

diff -Nru a/include/asm-ppc/prom.h b/include/asm-ppc/prom.h
--- a/include/asm-ppc/prom.h	Fri Oct  3 10:57:25 2003
+++ b/include/asm-ppc/prom.h	Fri Oct  3 10:57:25 2003
@@ -9,6 +9,7 @@
 #define _PPC_PROM_H

 #include <linux/config.h>
+#include <linux/proc_fs.h>

 typedef void *phandle;
 typedef void *ihandle;
@@ -57,6 +58,9 @@
 	struct	device_node *sibling;
 	struct	device_node *next;	/* next device of same type */
 	struct	device_node *allnext;	/* next in list of all nodes */
+	struct  proc_dir_entry *pde;       /* node's directory */
+	struct  proc_dir_entry *name_link; /* name symlink */
+	struct  proc_dir_entry *addr_link; /* address symlink */
 };

 struct prom_args;

--------------000008040604030207060906
Content-Type: text/plain;
 name="proc_devtree.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="proc_devtree.patch"

diff -Nru a/fs/proc/proc_devtree.c b/fs/proc/proc_devtree.c
--- a/fs/proc/proc_devtree.c	Fri Oct  3 11:05:05 2003
+++ b/fs/proc/proc_devtree.c	Fri Oct  3 11:05:05 2003
@@ -53,6 +53,7 @@
 	int l;
 	struct proc_dir_entry *list, **lastp, *al;

+	np->pde = de;
 	lastp = &list;
 	for (pp = np->properties; pp != 0; pp = pp->next) {
 		/*
@@ -102,6 +103,7 @@
 			al = proc_symlink(child->name, de, ent->name);
 			if (al == 0)
 				break;
+			child->name_link = al;
 			*lastp = al;
 			lastp = &al->next;
 		}
@@ -112,6 +114,7 @@
 		al = proc_symlink(at, de, ent->name);
 		if (al == 0)
 			break;
+		child->addr_link = al;
 		*lastp = al;
 		lastp = &al->next;
 	}

--------------000008040604030207060906--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
