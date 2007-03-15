Return-Path: <dgibson@ozlabs.org>
Date: Thu, 15 Mar 2007 11:01:21 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [PATCH 17/19] bootwrapper: compatibility layer for old U-Boots
	(a.k.a. cuImage, cuboot)
Message-ID: <20070315000121.GD12573@localhost.localdomain>
References: <20070312204204.GQ28545@ld0162-tx32.am.freescale.net>
	<20070314214805.GA9546@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070314214805.GA9546@mag.az.mvista.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 14, 2007 at 02:48:05PM -0700, Mark A. Greer wrote:
> On Mon, Mar 12, 2007 at 02:42:04PM -0600, Scott Wood wrote:
> 
> > diff --git a/arch/powerpc/boot/cuboot.c b/arch/powerpc/boot/cuboot.c
> > new file mode 100644
> > index 0000000..9689117
> > --- /dev/null
> > +++ b/arch/powerpc/boot/cuboot.c
> 
> <snip>
> 
> > +void platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
> > +                   unsigned long r6, unsigned long r7)
> > +{
> > +	memcpy(&bd, (bd_t *)r3, sizeof(bd));
> > +	loader_info.initrd_addr = r4;
> > +	loader_info.initrd_size = r4 ? r5 : 0;
> > +
> > +	simple_alloc_init(_end, 512 * 1024, 32, 64);
>                           ^^^^
> > +	ft_init(_dtb_start, _dtb_end - _dtb_start, 32);
> 
> Are you sure that '_end' (which is the end of the zImage/cuImage)
> is safe to use?  If the kernel is large enough (e.g., INITRAMFS)
> it will overwrite your dtb when its decompressed and relocated to 0.
> You need to grok the elfheader to figure out where the kernel will end
> and take the max of that and _end.

This is ok with my bootloader patches which are now merged.  Well,
sort of.  If there isn't room for the kernel below the bootloader's
start, we're stuffed anyway (and there is a check for it).  The initrd
does not get relocated down low, so that's not a problem.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
