To: Daniel Wu <Daniel.Wu@alcatel.com.au>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Using zImage.initrd 
In-reply-to: Your message of "Fri, 09 Jun 2000 08:38:20 +1000"
             <00Jun9.083821est.115346@border.alcanet.com.au>
Mime-Version: 1.0
Content-Type: text/plain
Date: Fri, 09 Jun 2000 12:40:30 +1000
Message-ID: <27066.960518430@msa.cmst.csiro.au>
From: Murray Jensen <Murray.Jensen@cmst.csiro.au>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, 9 Jun 2000 08:38:20 +1000, Daniel Wu <Daniel.Wu@alcatel.com.au> writes:
>Does anyone what the difference between making a kernel with "make zImage" and
>"Make zImage.initrd"? - Apart from the obvious fact that the later builds a
>kernel which expects the rootfs to be on the RAM disk.

Firstly, you need to select both CONFIG_BLK_DEV_RAM and CONFIG_BLK_DEV_INITRD
to build zImage.initrd. Secondly, you need a file in arch/ppc/mbxboot called
ramdisk.image.gz. When you build zImage.initrd, the secondary boot loader
is re-compiled with INITRD_OFFSET and INITRD_SIZE set, which are used to
locate the start and end of the ramdisk.image.gz file in memory. The start
and end are passed to the kernel in registers (r4/r5??), which it saves into
the variables initrd_start and initrd_end. The secondary boot loader also
changes the kernel command line arguments so that root=/dev/ram instead of
root=/dev/nfs. The kernel does various things if initrd_start is non-zero,
but the main one is to decompress the ramdisk.image.gz data into ramdisk 0,
and because root=/dev/ram, this is then mounted as the root filesystem. Others
can point out anything I have left out - I tried my best :-)

>The crash location is in the __wake_up function according to the map.

Try this patch:

--- fs/buffer.c	2000/05/16 01:31:41	1.1.1.12
+++ fs/buffer.c	2000/06/02 04:26:16
@@ -2336,7 +2336,7 @@
 {
 	DECLARE_WAITQUEUE(wait, current);

-	if (current == bdflush_tsk)
+	if (bdflush_tsk == 0 || current == bdflush_tsk)
 		return;

 	if (!block) {

It is against the 2.3.x kernel, but I think it should apply to the 2.2.x
kernel ok. Cheers!
								Murray...
--
Murray Jensen, CSIRO Manufacturing Sci & Tech,         Phone: +61 3 9662 7763
Locked Bag No. 9, Preston, Vic, 3072, Australia.         Fax: +61 3 9662 7853
Internet: Murray.Jensen@cmst.csiro.au  (old address was mjj@mlb.dmt.csiro.au)


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
