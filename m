Return-Path: <jkenisto@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8CDE0B710E
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  1 Dec 2010 07:55:28 +1100 (EST)
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e35.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id oAUKhAOt010344
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Nov 2010 13:43:10 -0700
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP
	id oAUKtFvl162218
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Nov 2010 13:55:15 -0700
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id oAUKtDXT025728
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Nov 2010 13:55:14 -0700
Subject: Re: [PATCH] powerpc: fix call to subpage_protection()
From: Jim Keniston <jkenisto@linux.vnet.ibm.com>
To: Milton Miller <miltonm@bga.com>
In-Reply-To: <mdm-initramfs-debug-fix@mdm.bga.com>
References: <1290104610.3067.32.camel@localhost>
	<1290110779.32570.9.camel@pasglop>
	<mdm-initramfs-debug-fix@mdm.bga.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 30 Nov 2010 12:55:11 -0800
Message-ID: <1291150511.2936.19.camel@localhost>
Mime-Version: 1.0
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2010-11-30 at 05:08 -0600, Milton Miller wrote:
> [fixed Michael Neuling's address]
> 
> On Fri Nov 19 about 07:06:19 EST in 2010, Benjamin Herrenschmidt wrote:
> > On Thu, 2010-11-18 at 10:23 -0800, Jim Keniston wrote:
> > > FWIW, this failure isn't an obstacle for me.  I'm in no way attached to
> > > my legacy configuration; pseries_defconfig is fine for me.  On the other
> > > hand, I can continue testing fixes, and/or make my system available to
> > > other IBMers when I'm not using it, if you want to continue to pursue
> > > this problem.
> 
> > From the look of it your "legacy" config is lacking the necessary
> > storage drivers...
> > 
> 
> Looking closer, it would appear he intended to get them from initramfs
> but unpacking it failed.  Pulling from his log in the original message:

Bingo!  Not only was I using a "legacy" .config file, I'd also copied
and pasted an older yaboot.conf entry without updating the initrd-size
clause.  The initrd-size value was apparently big enough until I enabled
the extra DEBUG code.  Mr. Miller's diagnostic message reported the
unpacking failure at just a few bytes past the specified initrd-size.
Adjusting the initrd-size to match the actual size of the file enables
the kernel to boot.

So... cockpit error.  Very sorry for the fuss, but thanks for the
detective work.

As for Mr. Miller's patch...
Tested-by: Jim Keniston <jkenisto@us.ibm.com>

Jim

> 
> > > 
> > > Calling ibm,client-architecture-support... not implemented
> > > command line: root=/dev/disk/by-id/scsi-SIBM_ST373453LC_3HW1CQ1400007445Q2A4-part3 quiet profile=2 sysrq=1 insmod=sym53c8xx insmod=ipr crashkernel=256M-:128M loglevel=8 
> > > 
> > > memory layout at init:
> > >   memory_limit : 0000000000000000 (16 MB aligned)
> > >   alloc_bottom : 0000000003550000
> > >   alloc_top    : 0000000008000000
> > >   alloc_top_hi : 0000000070000000
> > >   amo_top      : 0000000008000000
> > >   ram_top      : 0000000070000000
> > > instantiating rtas at 0x00000000076a0000... done
> > > boot cpu hw idx 0
> > > starting cpu hw idx 2... done
> > > copying OF device tree...
> > > Building dt strings...
> > > Building dt structure...
> > > Device tree strings 0x0000000003560000 -> 0x000000000356129c
> > > Device tree struct  0x0000000003570000 -> 0x0000000003580000
> ..
> > > Found initrd at 0xc000000002d00000:0xc00000000354e28a
> ..
> > > NET: Registered protocol family 1
> > > PCI: CLS 128 bytes, default 128
> > > Unpacking initramfs...
> > > Initramfs unpacking failed: read error
> 
> "read error" occurs in lib/decompress_inflate.c if the fill routine
> returns a negative count, which would inlclude a NULL fill pointer like
> init/initramfs.c.
> 
> 
> Maybe this debugging patch (against 2.6.35, applys with small offset to 
> 2.6.37-rc4) can help isolate the corruption?
> 
> From: Milton Miller <miltonm.bga.com>
> initramfs: show input and output offsets on unpacking failures
> 
> When the initramfs input is corrupted, having the pointer to the buffer
> segment being decompressed, and the decompress input and output byte
> counts from the compressed stream can help isolate the source of the
> corruption.
> 
> Signed-off-by: Milton Miller <miltonm@bga.com>
> 
> ---
>  init/initramfs.c |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> Index: sim/init/initramfs.c
> ===================================================================
> --- sim.orig/init/initramfs.c	2009-07-13 18:44:56.000000000 -0500
> +++ sim/init/initramfs.c	2009-07-13 18:59:32.000000000 -0500
> @@ -384,6 +384,9 @@ static int __init write_buffer(char *buf
>  	return len - count;
>  }
> 
> +static unsigned my_inptr;   /* index of next byte to be processed in inbuf */
> +static unsigned bytes_out;  /* count of chars processed from current archive */
> +
>  static int __init flush_buffer(void *bufv, unsigned len)
>  {
>  	char *buf = (char *) bufv;
> @@ -393,6 +396,7 @@ static int __init flush_buffer(void *buf
>  		return -1;
>  	while ((written = write_buffer(buf, len)) < len && !message) {
>  		char c = buf[written];
> +		bytes_out += written;
>  		if (c == '0') {
>  			buf += written;
>  			len -= written;
> @@ -407,8 +411,6 @@ static int __init flush_buffer(void *buf
>  	return origLen;
>  }
> 
> -static unsigned my_inptr;   /* index of next byte to be processed in inbuf */
> -
>  #include <linux/decompress/generic.h>
> 
>  static char * __init unpack_to_rootfs(char *buf, unsigned len)
> @@ -430,6 +432,8 @@ static char * __init unpack_to_rootfs(ch
>  	message = NULL;
>  	while (!message && len) {
>  		loff_t saved_offset = this_header;
> +		bytes_out = 0;
> +		my_inptr = 0;
>  		if (*buf == '0' && !(this_header & 3)) {
>  			state = Start;
>  			written = write_buffer(buf, len);
> @@ -462,6 +466,9 @@ static char * __init unpack_to_rootfs(ch
>  		buf += my_inptr;
>  		len -= my_inptr;
>  	}
> +	if (message) {
> +		printk(KERN_ERR "Failed unpacking at %p input %d output %d \n",buf - my_inptr, my_inptr, bytes_out);
> +	}
>  	dir_utime();
>  	kfree(name_buf);
>  	kfree(symlink_buf);
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
