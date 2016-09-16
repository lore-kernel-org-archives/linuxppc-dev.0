Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sb9sC5h4JzDsGT
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 20:05:51 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id 21so2016555pfy.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 03:05:51 -0700 (PDT)
Date: Fri, 16 Sep 2016 20:05:37 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, anton@samba.org,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 06/13] powerpc: reverse the soft_enable logic
Message-ID: <20160916200537.50562560@roar.ozlabs.ibm.com>
In-Reply-To: <1473944523-624-7-git-send-email-maddy@linux.vnet.ibm.com>
References: <1473944523-624-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1473944523-624-7-git-send-email-maddy@linux.vnet.ibm.com>
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

On Thu, 15 Sep 2016 18:31:56 +0530
Madhavan Srinivasan <maddy@linux.vnet.ibm.com> wrote:

> "paca->soft_enabled" is used as a flag to mask some of interrupts.
> Currently supported flags values and their details:
> 
> soft_enabled    MSR[EE]
> 
> 0               0       Disabled (PMI and HMI not masked)
> 1               1       Enabled
> 
> "paca->soft_enabled" is initialized to 1 to make the interripts as
> enabled. arch_local_irq_disable() will toggle the value when interrupts
> needs to disbled. At this point, the interrupts are not actually disabled,
> instead, interrupt vector has code to check for the flag and mask it when it occurs.
> By "mask it", it update interrupt paca->irq_happened and return.
> arch_local_irq_restore() is called to re-enable interrupts, which checks and
> replays interrupts if any occured.
> 
> Now, as mentioned, current logic doesnot mask "performance monitoring interrupts"
> and PMIs are implemented as NMI. But this patchset depends on local_irq_*
> for a successful local_* update. Meaning, mask all possible interrupts during
> local_* update and replay them after the update.
> 
> So the idea here is to reserve the "paca->soft_enabled" logic. New values and
> details:
> 
> soft_enabled    MSR[EE]
> 
> 1               0       Disabled  (PMI and HMI not masked)
> 0               1       Enabled
> 
> Reason for the this change is to create foundation for a third flag value "2"
> for "soft_enabled" to add support to mask PMIs. When ->soft_enabled is
> set to a value "2", PMI interrupts are mask and when set to a value
> of "1", PMI are not mask.
> 
> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/hw_irq.h | 4 ++--
>  arch/powerpc/kernel/entry_64.S    | 5 ++---
>  2 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
> index dc3c248f9244..fd9b421f9020 100644
> --- a/arch/powerpc/include/asm/hw_irq.h
> +++ b/arch/powerpc/include/asm/hw_irq.h
> @@ -30,8 +30,8 @@
>  /*
>   * flags for paca->soft_enabled
>   */
> -#define IRQ_DISABLE_MASK_NONE		1
> -#define IRQ_DISABLE_MASK_LINUX		0
> +#define IRQ_DISABLE_MASK_NONE		0
> +#define IRQ_DISABLE_MASK_LINUX		1
>  
>  #endif /* CONFIG_PPC64 */
>  
> diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
> index aef7b64cbbeb..879aeb11ad29 100644
> --- a/arch/powerpc/kernel/entry_64.S
> +++ b/arch/powerpc/kernel/entry_64.S
> @@ -131,8 +131,7 @@ END_FW_FTR_SECTION_IFSET(FW_FEATURE_SPLPAR)
>  	 */
>  #if defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_BUG)
>  	lbz	r10,PACASOFTIRQEN(r13)
> -	xori	r10,r10,IRQ_DISABLE_MASK_NONE
> -1:	tdnei	r10,0
> +1:	tdnei	r10,IRQ_DISABLE_MASK_NONE
>  	EMIT_BUG_ENTRY 1b,__FILE__,__LINE__,BUGFLAG_WARNING
>  #endif
>  
> @@ -1012,7 +1011,7 @@ _GLOBAL(enter_rtas)
>  	 * check it with the asm equivalent of WARN_ON
>  	 */
>  	lbz	r0,PACASOFTIRQEN(r13)
> -1:	tdnei	r0,IRQ_DISABLE_MASK_LINUX
> +1:	tdeqi	r0,IRQ_DISABLE_MASK_NONE
>  	EMIT_BUG_ENTRY 1b,__FILE__,__LINE__,BUGFLAG_WARNING
>  #endif
>  	

We specifically want to ensure that _LINUX interrupts are disabled
here. Not that we allow masking of others without _LINUX now, but
current behavior is checking that LINUX ones are masked.

Otherwise it seems okay.

It might be nice after this series to do a pass and rename
soft_enabled to soft_masked.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
