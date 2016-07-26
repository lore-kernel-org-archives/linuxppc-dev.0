Return-Path: <npiggin@gmail.com>
Received: from mail-pa0-x243.google.com (mail-pa0-x243.google.com
 [IPv6:2607:f8b0:400e:c03::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rz6Yg5lGRzDr17
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 15:46:15 +1000 (AEST)
Received: by mail-pa0-x243.google.com with SMTP id q2so12672444pap.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 22:46:15 -0700 (PDT)
Date: Tue, 26 Jul 2016 15:46:05 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, anton@samba.org,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH 7/9] powerpc: Add support to mask perf interrupts
Message-ID: <20160726154605.4822815a@roar.ozlabs.ibm.com>
In-Reply-To: <1469458342-26233-8-git-send-email-maddy@linux.vnet.ibm.com>
References: <1469458342-26233-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1469458342-26233-8-git-send-email-maddy@linux.vnet.ibm.com>
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

On Mon, 25 Jul 2016 20:22:20 +0530
Madhavan Srinivasan <maddy@linux.vnet.ibm.com> wrote:

> To support masking of the PMI interrupts, couple of new interrupt
> handler macros are added MASKABLE_EXCEPTION_PSERIES_OOL and
> MASKABLE_RELON_EXCEPTION_PSERIES_OOL. These are needed to include the
> SOFTEN_TEST and implement the support at both host and guest kernel.
> 
> Couple of new irq #defs "PACA_IRQ_PMI" and "SOFTEN_VALUE_0xf0*" added
> to use in the exception code to check for PMI interrupts.
> 
> __SOFTEN_TEST macro is modified to support the PMI interrupt.
> Present __SOFTEN_TEST code loads the soft_enabled from paca and check
> to call masked_interrupt handler code. To support both current
> behaviour and PMI masking, these changes are added,
> 
> 1) Current LR register content are saved in R11
> 2) "bge" branch operation is changed to "bgel".
> 3) restore R11 to LR
> 
> Reason:
> 
> To retain PMI as NMI behaviour for flag state of 1, we save the LR
> regsiter value in R11 and branch to "masked_interrupt" handler with
> LR update. And in "masked_interrupt" handler, we check for the
> "SOFTEN_VALUE_*" value in R10 for PMI and branch back with "blr" if
> PMI.
> 
> To mask PMI for a flag >1 value, masked_interrupt vaoid's the above
> check and continue to execute the masked_interrupt code and disabled
> MSR[EE] and updated the irq_happend with PMI info.
> 
> Finally, saving of R11 is moved before calling SOFTEN_TEST in the
> __EXCEPTION_PROLOG_1 macro to support saving of LR values in
> SOFTEN_TEST.
> 
> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/exception-64s.h | 22 ++++++++++++++++++++--
>  arch/powerpc/include/asm/hw_irq.h        |  1 +
>  arch/powerpc/kernel/exceptions-64s.S     | 27
> ++++++++++++++++++++++++--- 3 files changed, 45 insertions(+), 5
> deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/exception-64s.h
> b/arch/powerpc/include/asm/exception-64s.h index
> 44d3f539d8a5..c951b7ab5108 100644 ---
> a/arch/powerpc/include/asm/exception-64s.h +++
> b/arch/powerpc/include/asm/exception-64s.h @@ -166,8 +166,8 @@
> END_FTR_SECTION_NESTED(ftr,ftr,943)
> OPT_SAVE_REG_TO_PACA(area+EX_CFAR, r10, CPU_FTR_CFAR);
> \ SAVE_CTR(r10, area);
> \ mfcr
> r9;							\
> -
> extra(vec);							\
> std
> r11,area+EX_R11(r13);					\
> +
> extra(vec);							\
> std
> r12,area+EX_R12(r13);					\
> GET_SCRATCH0(r10);						\
> std	r10,area+EX_R13(r13) @@ -403,12 +403,17 @@
> label##_relon_hv:						\
> #define SOFTEN_VALUE_0xe82	PACA_IRQ_DBELL #define
> SOFTEN_VALUE_0xe60	PACA_IRQ_HMI #define
> SOFTEN_VALUE_0xe62	PACA_IRQ_HMI +#define
> SOFTEN_VALUE_0xf01	PACA_IRQ_PMI +#define
> SOFTEN_VALUE_0xf00	PACA_IRQ_PMI

#define __SOFTEN_TEST(h,
> vec)						\ lbz
> r10,PACASOFTIRQEN(r13);					\
> cmpwi
> r10,LAZY_INTERRUPT_DISABLED;				\
> li
> r10,SOFTEN_VALUE_##vec;					\
> -	bge	masked_##h##interrupt

At which point, can't we pass in the interrupt level we want to mask
for to SOFTEN_TEST, and avoid all this extra code changes?


PMU masked interrupt will compare with SOFTEN_LEVEL_PMU, existing
interrupts will compare with SOFTEN_LEVEL_EE (or whatever suitable
names there are).


> +	mflr
> r11;							\
> +	bgel
> masked_##h##interrupt;					\
> +	mtlr	r11;

This might corrupt return prediction when masked_interrupt does not
return. I guess that's uncommon case though. But I think we can avoid
this if we do the above, no?

Thanks,
Nick
