Return-Path: <miltonm@bga.com>
Received: from mail4.comsite.net (mail4.comsite.net [205.238.176.238])
	by ozlabs.org (Postfix) with ESMTP id 0F51EB71A5
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 21 May 2011 20:36:32 +1000 (EST)
Subject: Re: [v2] powerpc: Force page alignment for initrd
To: Dave Carroll <dcarroll@astekcorp.com>
From: Milton Miller <miltonm@bga.com>
Message-Id: <initrd-reserve-alignment@mdm.bga.com>
In-Reply-To: <522F24EF533FC546962ECFA2054FF777373072AB72@MAILSERVER2.cos.astekcorp.com>
References: <522F24EF533FC546962ECFA2054FF777373072AB72@MAILSERVER2.cos.astekcorp.com>
Date: Sat, 21 May 2011 05:36:27 -0500
Cc: Paul Mackerras <paulus@samba.org>, LPPC <linuxppc-dev@lists.ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 20 May 2011 about 13:23:36 -0000, Dave Carroll wrote:
> When using 64K pages with a separate cpio rootfs, U-Boot will align
> the rootfs on a 4K page boundary. When the memory is reserved, and
> subsequent early memblock_alloc is called, it will allocate memory
> between the 64K page alignment and reserved memory. When the reserved
> memory is subsequently freed, it is done so by pages, causing the
> early memblock_alloc requests to be re-used, which in my case, caused
> the device-tree to be clobbered.
> 
> This patch forces initrd to be kernel page aligned, to match the
> mechanism used to free reserved memory.

Actually it is only forcing the memory reserved for the initrd (its
not moving the contents nor filling the extra space).

> 
> @@ -555,7 +555,8 @@ static void __init early_reserve_mem(void)
>  #ifdef CONFIG_BLK_DEV_INITRD
>         /* then reserve the initrd, if any */
>         if (initrd_start && (initrd_end > initrd_start))
> -               memblock_reserve(__pa(initrd_start), initrd_end - initrd_start);
> +               memblock_reserve(_ALIGN_DOWN(__pa(initrd_start), PAGE_SIZE),
> +                       PAGE_ALIGN(initrd_end) - _ALIGN_DOWN(initrd_start, PAGE_SIZE));

Please align up the end, then change free_initrd_mem (32 and 64 bit)
to do the same range extension.

Thanks,
milton
