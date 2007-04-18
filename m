Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id A5890DDE27
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Apr 2007 18:58:41 +1000 (EST)
Mime-Version: 1.0 (Apple Message framework v624)
In-Reply-To: <20070322030114.D5B9FDDF2B@ozlabs.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <daf73c54d92c0be4096aa40b4ae00fcd@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 2/4] powerpc: Fix 32 bits mm operations when not using BATs
Date: Wed, 18 Apr 2007 03:58:16 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: ppcdev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In commit ee4f2ea48674b6c9d91bc854edc51a3e6a7168c4 Ben patched:

> diff --git a/arch/powerpc/mm/pgtable_32.c 
> b/arch/powerpc/mm/pgtable_32.c
> index 95d3afe..f75f2fc 100644
> --- a/arch/powerpc/mm/pgtable_32.c
> +++ b/arch/powerpc/mm/pgtable_32.c
> @@ -282,16 +282,19 @@ int map_page(unsigned long va, phys_addr_t pa, 
> int flags)
...
> +               ktext = ((char *) v >= _stext && (char *) v < etext);
> +               f = ktext ?_PAGE_RAM_TEXT : _PAGE_RAM;
>                 map_page(v, p, f);
> +#ifdef CONFIG_PPC_STD_MMU_32
> +               if (ktext)
> +                       hash_preload(&init_mm, v, 0, 0x300);
> +#endif


We should preload text pages with trap 0x400, ISI, aka an
instruction storage miss, not 0x300, data storage miss, to
avoid any confusion with looking at the trap vs PAGE_EXEC.

Sorry for not catching this until it was applied.

milton
