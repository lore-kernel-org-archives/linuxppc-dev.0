Return-Path: <arnd@arndb.de>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E58581A0AD8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2015 22:50:57 +1100 (AEDT)
From: Arnd Bergmann <arnd@arndb.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linuxppc-dev@ozlabs.org, thuth@redhat.com
Subject: Re: [PATCH 1/6] powerpc/kconfig: Move NR_IRQS into "Kernel Options"
Date: Mon, 12 Oct 2015 13:50:47 +0200
Message-ID: <5354986.Emc3ODSKdL@wuerfel>
In-Reply-To: <1444648065.31951.3.camel@ellerman.id.au>
References: <1444338557-14988-1-git-send-email-mpe@ellerman.id.au>
 <7516455.YEROTAngT1@wuerfel> <1444648065.31951.3.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Monday 12 October 2015 22:07:45 Michael Ellerman wrote:
> Yeah, this builds and boots at least on pseries KVM.
> 
> diff --git a/arch/powerpc/include/asm/irq.h b/arch/powerpc/include/asm/irq.h
> index e8e3a0a04eb0..35fba282b7f9 100644
> --- a/arch/powerpc/include/asm/irq.h
> +++ b/arch/powerpc/include/asm/irq.h
> @@ -23,11 +23,8 @@ extern atomic_t ppc_n_lost_interrupts;
>  /* This number is used when no interrupt has been assigned */
>  #define NO_IRQ                 (0)
>  
> -/* Total number of virq in the platform */
> -#define NR_IRQS                CONFIG_NR_IRQS
> -
> -/* Same thing, used by the generic IRQ code */
>  #define NR_IRQS_LEGACY         NUM_ISA_INTERRUPTS
> +#define NR_IRQS                        NR_IRQS_LEGACY
>  
>  extern irq_hw_number_t virq_to_hw(unsigned int virq);
>  

This looks like the way it's intended. I've also checked that no powerpc
platform defines a static IRQ larger than NUM_ISA_INTERRUPTS, and only
two files do it at all (arch/powerpc/platforms/chrp/pegasos_eth.c and arch/powerpc/sysdev/rtc_cmos_setup.c).

	Arnd
