Return-Path: <npiggin@gmail.com>
Received: from mail-pa0-x244.google.com (mail-pa0-x244.google.com
 [IPv6:2607:f8b0:400e:c03::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s2nvx4y1vzDqQD
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Aug 2016 15:29:48 +1000 (AEST)
Received: by mail-pa0-x244.google.com with SMTP id ez1so9222578pab.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 Jul 2016 22:29:48 -0700 (PDT)
Date: Mon, 1 Aug 2016 15:29:41 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, anton@samba.org,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH v2 09/11] powerpc: Add support to mask perf interrupts
Message-ID: <20160801152941.6a225a01@roar.ozlabs.ibm.com>
In-Reply-To: <1469991989-28409-10-git-send-email-maddy@linux.vnet.ibm.com>
References: <1469991989-28409-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1469991989-28409-10-git-send-email-maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon,  1 Aug 2016 00:36:27 +0530
Madhavan Srinivasan <maddy@linux.vnet.ibm.com> wrote:

>  /*
>   * flags for paca->soft_enabled
>   */
>  #define IRQ_DISABLE_LEVEL_NONE		0
>  #define IRQ_DISABLE_LEVEL_LINUX		1
> +#define IRQ_DISABLE_LEVEL_PMU		2
> +
> +#define MASK_IRQ_LEVEL		IRQ_DISABLE_LEVEL_LINUX | IRQ_DISABLE_LEVEL_PMU
>  
>  
>  #endif /* CONFIG_PPC64 */
> diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
> index 2c87e82ecbe4..56dc71b82824 100644
> --- a/arch/powerpc/kernel/exceptions-64s.S
> +++ b/arch/powerpc/kernel/exceptions-64s.S
> @@ -256,11 +256,11 @@ hardware_interrupt_pSeries:
>  hardware_interrupt_hv:
>  	BEGIN_FTR_SECTION
>  		_MASKABLE_EXCEPTION_PSERIES(0x502, hardware_interrupt,
> -					    EXC_HV, SOFTEN_TEST_HV, IRQ_DISABLE_LEVEL_LINUX)
> +					    EXC_HV, SOFTEN_TEST_HV, MASK_IRQ_LEVEL)

So what I was expecting is that each exception handler would specify the
level (or bit, if we use bitmask) at which it gets disabled. The test code
will then test the exception level with the enable level (or s/level/mask).

The way you have now is each exception handler specifying the bits which
cause it to be disabled, but I think that's kind of backwards -- the
disabler knows which interrupts it wants to disable, the exception handler
does not know what disablers want to disable it :)

So to disable PMU and "linux" interrupts for local_t operations, you would
have:

local_irq_set_mask(IRQ_DISABLE_LEVEL_LINUX|IRQ_DISABLE_LEVEL_PMU)

And that would disable both handlers that test with IRQ_DISABLE_LEVEL_LINUX
and IRQ_DISABLE_LEVEL_PMU

Does that make sense? What do you think?

Thanks,
Nick
