Message-Id: <200006211723.NAA01191@p2.parker.boston.ma.us>
To: linuxppc-dev@lists.linuxppc.org
Subject: lastest fsmlabs "linuxppc_2_3" won't build for 8XX
Date: Wed, 21 Jun 2000 13:23:55 -0400
From: Brad Parker <brad@parker.boston.ma.us>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


The lastest bk 2.3 tree (linuxppc_2_3) on the fsmlabs server won't build
for 8XX.  This is the "-test1-ac21" tree (I love these version #'s)

arch/ppc/kernel/setup.c defines 3 globals conditionally.  If CONFIG_8XX is
set they dont' get defined.  I just duped the defines from inside the
conditional and now it compiles & links...  I have no idea if this is
the right thing (yet - I'm about to boot it :-)

-brad

brad@hp kernel]$ bk diffs -u setup.c
===== setup.c 1.38 vs edited =====
--- 1.38/arch/ppc/kernel/setup.c	Mon Jun 19 15:01:47 2000
+++ edited/setup.c	Wed Jun 21 13:19:16 2000
@@ -165,6 +165,10 @@
 	0,			/* orig-video-isVGA */
 	16			/* orig-video-points */
 };
+
+int dcache_bsize;
+int icache_bsize;
+int ucache_bsize;
 #endif /* !CONFIG_4xx && !CONFIG_8xx */

 void machine_restart(char *cmd)

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
