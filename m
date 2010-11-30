Return-Path: <miltonm@bga.com>
Received: from mail4.comsite.net (mail4.comsite.net [205.238.176.238])
	by ozlabs.org (Postfix) with ESMTP id 5B1BCB70E3
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 30 Nov 2010 22:06:58 +1100 (EST)
From: Milton Miller <miltonm@bga.com>
To: Jim Keniston <jkenisto@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc: fix call to subpage_protection()
In-Reply-To: <1290110779.32570.9.camel@pasglop>
References: <1290104610.3067.32.camel@localhost>
	<1290110779.32570.9.camel@pasglop>
Message-Id: <mdm-initramfs-debug@mdm.bga.com>
Date: Tue, 30 Nov 2010 05:06:52 -0600
Cc: Michael Neuling <mikeyatneuling.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri Nov 19 about 07:06:19 EST in 2010, Benjamin Herrenschmidt wrote:
> On Thu, 2010-11-18 at 10:23 -0800, Jim Keniston wrote:
> > FWIW, this failure isn't an obstacle for me.  I'm in no way attached to
> > my legacy configuration; pseries_defconfig is fine for me.  On the other
> > hand, I can continue testing fixes, and/or make my system available to
> > other IBMers when I'm not using it, if you want to continue to pursue
> > this problem.

> From the look of it your "legacy" config is lacking the necessary
> storage drivers...
> 

Looking closer, it would appear he intended to get them from initramfs
but unpacking it failed.  Pulling from his log in the original message:

> > 
> > Calling ibm,client-architecture-support... not implemented
> > command line: root=/dev/disk/by-id/scsi-SIBM_ST373453LC_3HW1CQ1400007445Q2A4-part3 quiet profile=2 sysrq=1 insmod=sym53c8xx insmod=ipr crashkernel=256M-:128M loglevel=8 
> > 
> > memory layout at init:
> >   memory_limit : 0000000000000000 (16 MB aligned)
> >   alloc_bottom : 0000000003550000
> >   alloc_top    : 0000000008000000
> >   alloc_top_hi : 0000000070000000
> >   amo_top      : 0000000008000000
> >   ram_top      : 0000000070000000
> > instantiating rtas at 0x00000000076a0000... done
> > boot cpu hw idx 0
> > starting cpu hw idx 2... done
> > copying OF device tree...
> > Building dt strings...
> > Building dt structure...
> > Device tree strings 0x0000000003560000 -> 0x000000000356129c
> > Device tree struct  0x0000000003570000 -> 0x0000000003580000
..
> > Found initrd at 0xc000000002d00000:0xc00000000354e28a
..
> > NET: Registered protocol family 1
> > PCI: CLS 128 bytes, default 128
> > Unpacking initramfs...
> > Initramfs unpacking failed: read error

"read error" occurs in lib/decompress_inflate.c if the fill routine
returns a negative count, which would inlclude a NULL fill pointer like
init/initramfs.c.


Maybe this debugging patch (against 2.6.35, applys with small offset to 
2.6.37-rc4) can help isolate the corruption?

From: Milton Miller <miltonm.bga.com>
initramfs: show input and output offsets on unpacking failures

When the initramfs input is corrupted, having the pointer to the buffer
segment being decompressed, and the decompress input and output byte
counts from the compressed stream can help isolate the source of the
corruption.

Signed-off-by: Milton Miller <miltonm@bga.com>

---
 init/initramfs.c |    5 +++++
 1 file changed, 5 insertions(+)

Index: sim/init/initramfs.c
===================================================================
--- sim.orig/init/initramfs.c	2009-07-13 18:44:56.000000000 -0500
+++ sim/init/initramfs.c	2009-07-13 18:59:32.000000000 -0500
@@ -384,6 +384,9 @@ static int __init write_buffer(char *buf
 	return len - count;
 }
 
+static unsigned my_inptr;   /* index of next byte to be processed in inbuf */
+static unsigned bytes_out;  /* count of chars processed from current archive */
+
 static int __init flush_buffer(void *bufv, unsigned len)
 {
 	char *buf = (char *) bufv;
@@ -393,6 +396,7 @@ static int __init flush_buffer(void *buf
 		return -1;
 	while ((written = write_buffer(buf, len)) < len && !message) {
 		char c = buf[written];
+		bytes_out += written;
 		if (c == '0') {
 			buf += written;
 			len -= written;
@@ -407,8 +411,6 @@ static int __init flush_buffer(void *buf
 	return origLen;
 }
 
-static unsigned my_inptr;   /* index of next byte to be processed in inbuf */
-
 #include <linux/decompress/generic.h>
 
 static char * __init unpack_to_rootfs(char *buf, unsigned len)
@@ -430,6 +432,8 @@ static char * __init unpack_to_rootfs(ch
 	message = NULL;
 	while (!message && len) {
 		loff_t saved_offset = this_header;
+		bytes_out = 0;
+		my_inptr = 0;
 		if (*buf == '0' && !(this_header & 3)) {
 			state = Start;
 			written = write_buffer(buf, len);
@@ -462,6 +466,9 @@ static char * __init unpack_to_rootfs(ch
 		buf += my_inptr;
 		len -= my_inptr;
 	}
+	if (message) {
+		printk(KERN_ERR "Failed unpacking at %p input %d output %d \n",buf - my_inptr, my_inptr, bytes_out);
+	}
 	dir_utime();
 	kfree(name_buf);
 	kfree(symlink_buf);
