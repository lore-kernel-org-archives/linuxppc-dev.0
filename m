Message-ID: <15270-14190@sneakemail.com>
Date: Thu, 01 Apr 2004 18:38:19 -0800
From: "Stephen Williams" <612dlag102@sneakemail.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: SystemACE but not V2PRO
Content-Type: multipart/mixed;
 boundary="------------040300010006060504010609"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------040300010006060504010609
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


The attached patch is my spin at getting the existing xsysace
block driver working on systems that have SystemACE chips, but
do not use Virtex-II-Pro chips. The adapter.c file assumes that
the system ace halt will halt the processor. This is not the
case in general, so this patch ifdefs that part of the code out
using CONFIG_VIRTEX_II_PRO.

This is only part of the story for getting the systemace
working in general, but the remaining bits are configuration
issues, not code/driver support.

Question: Who is the maintainer for this section of code? It
is maybe MonteVista?
--
Steve Williams                "The woods are lovely, dark and deep.
steve at XXXXXXXXXX           But I have promises to keep,
http://www.XXXXXXXXXX         and lines to code before I sleep,
http://www.picturel.com       And lines to code before I sleep."

--------------040300010006060504010609
Content-Type: text/plain;
 name="sysace-without-v2pro.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sysace-without-v2pro.patch"

Index: drivers/block/xilinx_sysace/adapter.c
===================================================================
RCS file: /cvsroot/linuxppc_2_4_devel/drivers/block/xilinx_sysace/adapter.c,v
retrieving revision 1.3
diff -p -u -r1.3 adapter.c
--- drivers/block/xilinx_sysace/adapter.c	30 Oct 2003 00:32:49 -0000	1.3
+++ drivers/block/xilinx_sysace/adapter.c	2 Apr 2004 02:27:37 -0000
@@ -74,7 +74,9 @@ MODULE_LICENSE("GPL");
 static const int dont_spin = 0;

 static u32 save_BaseAddress;	/* Saved physical base address */
+#ifdef CONFIG_VIRTEX_II_PRO
 static void (*old_restart) (char *cmd) = NULL;	/* old ppc_md.restart */
+#endif

 static unsigned char heads;
 static unsigned char sectors;
@@ -277,6 +279,13 @@ proc_cleanup(void)
 }
 #endif

+#ifdef CONFIG_VIRTEX_II_PRO
+/*
+ * The XSysAce_ResetCfg function causes the SystemACE to reset the
+ * Xilinx chain that is attached to it. If I am a Virtex II Pro, then
+ * presumably that includes me. Thus, The ResetCfg will ultimately
+ * reset me, the processor, end of story.
+ */
 static void
 xsysace_restart(char *cmd)
 {
@@ -285,6 +294,7 @@ xsysace_restart(char *cmd)
 	/* Wait for reset. */
 	for (;;) ;
 }
+#endif

 /*
  * The code to handle the block device starts here.
@@ -725,8 +735,10 @@ cleanup(void)
 	iounmap((void *) cfg->BaseAddress);
 	cfg->BaseAddress = save_BaseAddress;

+#ifdef CONFIG_VIRTEX_II_PRO
 	if (old_restart)
 		ppc_md.restart = old_restart;
+#endif
 }

 static int __init
@@ -837,9 +849,11 @@ xsysace_init(void)
 	       DEVICE_NAME, save_BaseAddress, cfg->BaseAddress, XSA_IRQ,
 	       size / 2);

+#ifdef CONFIG_VIRTEX_II_PRO
 	/* Hook our reset function into system's restart code. */
 	old_restart = ppc_md.restart;
 	ppc_md.restart = xsysace_restart;
+#endif

 	if (proc_init())
 		printk(KERN_WARNING "%s: could not register /proc interface.\n",

--------------040300010006060504010609--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
