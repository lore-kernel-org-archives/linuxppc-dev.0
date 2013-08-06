Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe002.messaging.microsoft.com [207.46.163.25])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EFCB92C0077
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Aug 2013 10:14:09 +1000 (EST)
Message-ID: <1375748040.13074.111.camel@snotra.buserror.net>
Subject: Re: [PATCH v2 7/8] powerpc/fsl_booke: make sure PAGE_OFFSET map to
 memstart_addr for relocatable kernel
From: Scott Wood <scottwood@freescale.com>
To: Kevin Hao <haokexin@gmail.com>
Date: Mon, 5 Aug 2013 19:14:00 -0500
In-Reply-To: <1372942454-25191-8-git-send-email-haokexin@gmail.com>
References: <1372942454-25191-1-git-send-email-haokexin@gmail.com>
 <1372942454-25191-8-git-send-email-haokexin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-07-04 at 20:54 +0800, Kevin Hao wrote:
> @@ -1222,6 +1266,9 @@ _GLOBAL(switch_to_as1)
>  /*
>   * Restore to the address space 0 and also invalidate the tlb entry created
>   * by switch_to_as1.
> + * r3 - the tlb entry which should be invalidated
> + * r4 - __pa(PAGE_OFFSET in AS0) - pa(PAGE_OFFSET in AS1)
> + * r5 - device tree virtual address
>  */
>  _GLOBAL(restore_to_as0)
[snip]
> diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
> index 3a65644..8280dbb 100644
> --- a/arch/powerpc/mm/mmu_decl.h
> +++ b/arch/powerpc/mm/mmu_decl.h
> @@ -149,7 +149,7 @@ extern void MMU_init_hw(void);
>  extern unsigned long mmu_mapin_ram(unsigned long top);
>  extern void adjust_total_lowmem(void);
>  extern int switch_to_as1(void);
> -extern void restore_to_as0(int);
> +extern void restore_to_as0(int, int, void *);

"int" seems wrong for the second argument.  Shouldn't it be phys_addr_t?

Also, please use parameter names.

-Scott
