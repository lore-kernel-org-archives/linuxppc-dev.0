Return-Path: <dgibson@ozlabs.org>
Date: Tue, 25 Sep 2007 12:29:35 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Valentine Barshak <vbarshak@ru.mvista.com>
Subject: Re: [RFC] [PATCH] PowerPC: add more than 4MB kernel image size
	support to bootwarapper
Message-ID: <20070925022935.GI30338@localhost.localdomain>
References: <20070924113627.GA30504@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070924113627.GA30504@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Sep 24, 2007 at 03:36:27PM +0400, Valentine Barshak wrote:
> Currently zImage is linked at the 4MB base address.
> Some platforms (using cuboot, treeboot) need the zImage's
> entry point and base address. They place zImage exactly
> at the base address it's been linked to. Sometimes 4MB left
> at the start of the memory is simply not enough to unpack zImage.
> This could happen with initramfs enabled, since the kernel image
> packed along with initramfs.cpio could be over 5MB in size.
> This patch checks vmlinux image size and links zImage at
> the base address that is equal to the unpacked image size
> aligned to 4MB boundary. This way zImage base address is 4MB
> only if unpacked kernel image size is less then 4MB.

Good plan.  However..

[snip]
> diff -ruN linux-2.6.orig/arch/powerpc/boot/zImage.lds.S linux-2.6/arch/powerpc/boot/zImage.lds.S
> --- linux-2.6.orig/arch/powerpc/boot/zImage.lds.S	2007-09-22 00:48:08.000000000 +0400
> +++ linux-2.6/arch/powerpc/boot/zImage.lds.S	2007-09-22 04:03:58.000000000 +0400
> @@ -3,7 +3,7 @@
>  EXTERN(_zimage_start)
>  SECTIONS
>  {
> -  . = (4*1024*1024);
> +  . = ALIGN((_kend - _kstart), (4*1024*1024));

..I don't see any reason to keep the 4MB granularity.  I would just
align the address to say a 64k boundary (64k because that's the
granularity used in the normal ABI).

>    _start = .;
>    .text      :
>    {
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
