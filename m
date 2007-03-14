Return-Path: <mgreer@mvista.com>
Received: from zipcode.az.mvista.com (unknown [65.200.49.156])
	by ozlabs.org (Postfix) with ESMTP id 78290DDDFF
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Mar 2007 08:47:25 +1100 (EST)
Date: Wed, 14 Mar 2007 14:48:05 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 17/19] bootwrapper: compatibility layer for old U-Boots
	(a.k.a. cuImage, cuboot)
Message-ID: <20070314214805.GA9546@mag.az.mvista.com>
References: <20070312204204.GQ28545@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070312204204.GQ28545@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 12, 2007 at 02:42:04PM -0600, Scott Wood wrote:

> diff --git a/arch/powerpc/boot/cuboot.c b/arch/powerpc/boot/cuboot.c
> new file mode 100644
> index 0000000..9689117
> --- /dev/null
> +++ b/arch/powerpc/boot/cuboot.c

<snip>

> +void platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
> +                   unsigned long r6, unsigned long r7)
> +{
> +	memcpy(&bd, (bd_t *)r3, sizeof(bd));
> +	loader_info.initrd_addr = r4;
> +	loader_info.initrd_size = r4 ? r5 : 0;
> +
> +	simple_alloc_init(_end, 512 * 1024, 32, 64);
                          ^^^^
> +	ft_init(_dtb_start, _dtb_end - _dtb_start, 32);

Are you sure that '_end' (which is the end of the zImage/cuImage)
is safe to use?  If the kernel is large enough (e.g., INITRAMFS)
it will overwrite your dtb when its decompressed and relocated to 0.
You need to grok the elfheader to figure out where the kernel will end
and take the max of that and _end.

I had some code to do that in a sandpoint patch I submitted a few
months ago.  It doesn't use David's new gunzip routines though.
Right now, I'm working on using David's stuff for a different board
that I should submit patches for in a day or two.

Mark
