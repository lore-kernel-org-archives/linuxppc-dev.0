Message-ID: <3F81BEA6.50908@austin.ibm.com>
Date: Mon, 06 Oct 2003 14:12:38 -0500
From: Nathan Lynch <nathanl@austin.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [PATCH/RFC] add proc_dir_entry fields to device_node
References: <3F7DA229.7090409@austin.ibm.com> <1065254150.645.16.camel@gaston>
In-Reply-To: <1065254150.645.16.camel@gaston>
Content-Type: multipart/mixed;
 boundary="------------060000000703050505060202"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------060000000703050505060202
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

> The comment is valid. You cannot change the format of struct
> device_node on ppc32 without breaking BootX booting :(
>
> The solution to this is to finally break it by having a conversion
> step between the BootX-passed device-tree and the in-kernel one

What about something like this as a short term solution?  The ppc64
versions of the macros would store the proc_dir_entry pointers in the
device nodes as they are added, e.g.

#define set_node_proc_entry(node,entry) node->pde = entry
#define set_node_name_link(node,entry) node->name_link = entry
#define set_node_addr_link(node,entry) node->addr_link = entry

while the ppc versions are no-ops.  This would preserve source
compatibility while keeping us from breaking BootX.

Separate patches against kernel.org 2.6.0-test6 attached.

Nathan

--------------060000000703050505060202
Content-Type: text/plain;
 name="proc_devtree.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="proc_devtree.patch"

diff -ur a/fs/proc/proc_devtree.c b/fs/proc/proc_devtree.c
--- a/fs/proc/proc_devtree.c	2003-09-27 19:50:38.000000000 -0500
+++ b/fs/proc/proc_devtree.c	2003-10-06 12:46:21.000000000 -0500
@@ -53,6 +53,7 @@
 	int l;
 	struct proc_dir_entry *list, **lastp, *al;

+	set_node_proc_entry(np, de);
 	lastp = &list;
 	for (pp = np->properties; pp != 0; pp = pp->next) {
 		/*
@@ -102,6 +103,7 @@
 			al = proc_symlink(child->name, de, ent->name);
 			if (al == 0)
 				break;
+			set_node_name_link(child, al);
 			*lastp = al;
 			lastp = &al->next;
 		}
@@ -112,6 +114,7 @@
 		al = proc_symlink(at, de, ent->name);
 		if (al == 0)
 			break;
+		set_node_addr_link(child, al);
 		*lastp = al;
 		lastp = &al->next;
 	}

--------------060000000703050505060202
Content-Type: text/plain;
 name="ppc_device_node.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ppc_device_node.patch"

diff -ur a/include/asm-ppc/prom.h b/include/asm-ppc/prom.h
--- a/include/asm-ppc/prom.h	2003-09-27 19:50:38.000000000 -0500
+++ b/include/asm-ppc/prom.h	2003-10-06 12:43:12.000000000 -0500
@@ -59,6 +59,11 @@
 	struct	device_node *allnext;	/* next in list of all nodes */
 };

+/* for compatibility with ppc64 */
+#define set_node_proc_entry(node,entry) do { } while(0)
+#define set_node_name_link(node,entry) do { } while(0)
+#define set_node_addr_link(node,entry) do { } while(0)
+
 struct prom_args;
 typedef void (*prom_entry)(struct prom_args *);


--------------060000000703050505060202--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
