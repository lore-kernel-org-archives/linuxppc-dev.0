Date: Tue, 1 May 2001 04:56:10 -0700
From: Matt Porter <mporter@mvista.com>
To: Shoudong Xu <Shoudong.Xu@cern.ch>
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Question about linuxppc_2_5
Message-ID: <20010501045610.A30075@cx258813-a.chnd1.az.home.com>
References: <006201c0cda6$19cdd940$9bca8a89@cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <006201c0cda6$19cdd940$9bca8a89@cern.ch>; from Shoudong.Xu@cern.ch on Wed, Apr 25, 2001 at 06:38:03PM +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Apr 25, 2001 at 06:38:03PM +0200, Shoudong Xu wrote:
>
> Hi,
>
> I try to run linuxppc_2_5 (ramdisk size = 4096KB and initrd supported) with a root fs (build by myself) on a Force powerCore 6750 board with the following configuration : root =/dev/ram
> Here , I can not pass commond string the kernel , so I have to modify the file arch/ppc/kernel/setup.c direct
> -  sprintf(cmd_line,/*"nfsroot=10.0.0.69:/opt/hardhat/devkit/ppc/4xx/target */"ip=autoconf");
> + sprintf(cmd_line,"root=/dev/ram")
> Then make zImage.initrd to get a  kernel image -- zImage.initrd.pcore and I burn it to user_flash1

<snip>

> Questions:
> 1)Why can't linux mount the root filessystem?  How to mount ?

You need to apply the following patch (the second hunk actually fixes
the bug):

diff -u -r1.14 pcore_setup.c
--- pcore_setup.c	2001/03/30 02:41:29	1.14
+++ pcore_setup.c	2001/05/01 15:31:29
@@ -116,10 +116,15 @@
 	/* Lookup PCI host bridges */
 	board_type = pcore_find_bridges();

+#ifdef CONFIG_BLK_DEV_INITRD
+	if (initrd_start)
+		ROOT_DEV = MKDEV(RAMDISK_MAJOR, 0); /* /dev/ram */
+        else
+#endif
 #ifdef CONFIG_ROOT_NFS
-	ROOT_DEV = to_kdev_t(0x00ff); /* /dev/nfs pseudo device */
+		ROOT_DEV = to_kdev_t(0x00ff); /* /dev/nfs pseudo device */
 #else
-	ROOT_DEV = to_kdev_t(0x0802); /* /dev/sda2 */
+		ROOT_DEV = to_kdev_t(0x0802); /* /dev/sda2 */
 #endif
 }

@@ -216,6 +221,14 @@
 pcore_init(unsigned long r3, unsigned long r4, unsigned long r5,
 	  unsigned long r6, unsigned long r7)
 {
+#ifdef CONFIG_BLK_DEV_INITRD
+	if ( r4 )
+	{
+		initrd_start = r4 + KERNELBASE;
+		initrd_end = r5 + KERNELBASE;
+	}
+#endif
+
 	/* Copy cmd_line parameters */
 	if ( r6)
 	{

> 2)Can linux mount the flash as it's root filesystem direct?

Sure, just enable MTD/block/ffs support and provide a driver for your'
flash device if not supported.

--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
