Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe005.messaging.microsoft.com [207.46.163.28])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2B1FA2C009A
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Aug 2013 10:35:11 +1000 (EST)
Date: Wed, 7 Aug 2013 19:34:59 -0500
From: Scott Wood <scottwood@freescale.com>
To: Dongsheng Wang <dongsheng.wang@freescale.com>
Subject: Re: powerpc/mpc85xx: fix non-bootcpu cannot up after hibernation
 resume
Message-ID: <20130808003459.GA3964@home.buserror.net>
References: <1368518756-9850-1-git-send-email-dongsheng.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1368518756-9850-1-git-send-email-dongsheng.wang@freescale.com>
Cc: chenhui.zhao@freescale.com, rjw@sisk.pl, paulus@samba.org,
 johannes@sipsolutions.net, avorontsov@ru.mvista.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 14, 2013 at 04:05:56PM +0800, Dongsheng Wang wrote:
> This problem belongs to the core synchronization issues.
> The cpu1 already updated spin_table values, but bootcore cannot get
> this value in time.
> 
> After bootcpu hibiernation restore the pages. we are now running
> with the kernel data of the old kernel fully restored. if we reset
> the non-bootcpus that will be reset cache(tlb), the non-bootcpus
> will get new address(map virtual and physical address spaces).
> but bootcpu tlb cache still use boot kernel data, so we need to
> invalidate the bootcpu tlb cache make it to get new main memory data.
> 
> log:
> Enabling non-boot CPUs ...
> smp_85xx_kick_cpu: timeout waiting for core 1 to reset
> smp: failed starting cpu 1 (rc -2)
> Error taking CPU1 up: -2
> 
> Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
> Reviewed-by: Anton Vorontsov <anton@enomsg.org>
> 
> 
> diff --git a/arch/powerpc/kernel/swsusp_booke.S b/arch/powerpc/kernel/swsusp_booke.S
> index 11a3930..9503249 100644
> --- a/arch/powerpc/kernel/swsusp_booke.S
> +++ b/arch/powerpc/kernel/swsusp_booke.S
> @@ -141,6 +141,19 @@ _GLOBAL(swsusp_arch_resume)
>  	lis	r11,swsusp_save_area@h
>  	ori	r11,r11,swsusp_save_area@l
>  
> +	/*
> +	 * The boot core get a virtual address, when the boot process,
> +	 * the virtual address corresponds to a physical address. After
> +	 * hibernation resume memory snapshots, The corresponding
> +	 * relationship between the virtual memory and physical memory
> +	 * might change again. We need to get a new page table. So we
> +	 * need to invalidate TLB after resume pages.
> +	 *
> +	 * Invalidations TLB Using tlbilx/tlbivax/MMUCSR0.
> +	 * tlbilx used here.
> +	 */
> +	bl	_tlbil_all

Applied with the code comment changed to:

        /*
         * Mappings from virtual addresses to physical addresses may be
         * different than they were prior to restoring hibernation state.
         * Invalidate the TLB so that the boot CPU is using the new
         * mappings.
         */

-Scott
