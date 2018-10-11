Return-Path: <SRS0=4kvs=MX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69517C677FC
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Oct 2018 20:04:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC64520658
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Oct 2018 20:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VRYuKaRK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC64520658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42WMPH608szF3L4
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Oct 2018 07:04:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VRYuKaRK";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com;
 envelope-from=frowand.list@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="VRYuKaRK"; 
 dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42WMCn1syyzF3Jw
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Oct 2018 06:56:05 +1100 (AEDT)
Received: by mail-pg1-x542.google.com with SMTP id n31-v6so4666245pgm.7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Oct 2018 12:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=mRwR/eV8AC3ULdG+TuoWwU8vVuPkBiAH84wARhm7k/M=;
 b=VRYuKaRKEnWD2p4yJb9+dCIqz6KzbYPPZaGZjfsdhHydGSCbeyFBy/VnyTtf+neeRv
 Edb8rurWU9zG9AaBJDvTKz561lYHI7kmRxW9PgDy5vokJ8/37lWCaskOcEVN6FRCuBSy
 U5LtZ2SiPM9Oi9qyAoTZlntC8O4hFPmlCOUTCoMiZZj6IPKkaXCZRR86tXfrxK2y0vbn
 YpOHVWXhA7eu2h1i29Ejlf69j0Ra+pSgr3GicIKDXLVhzQ0dqS8WMcZjAcQWWymhcdty
 TA81VX5t+UCDtldrs5t4ziKItw5DuMK99018HZZpNHQY/6beEVXeE9Rm/WMz5zUk3Tjo
 D66w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mRwR/eV8AC3ULdG+TuoWwU8vVuPkBiAH84wARhm7k/M=;
 b=aDLDSMiGXlN1XljMEbcF6+snUAiFYn9XmyDLx2sb5t8nPnnNixAqLz+s+JsfmhkH+T
 JaTOacen2oxoQsYzintL3VWC4zQmcuOlTgUPleRhRatrV7BZAMWMtmvlniirvt9DHtsu
 5EZ/dNHZ751rKcYTN0g476rUQviBZCasu6sRI9HUc8EDg1ZG4OAsRYTCzCgd4cne5dBd
 GrQiHEi2RmHwPVxQN6hbehC8XKAmMO0LM15AMmiPLoj+BdhbfqSsm24vNXH7ICPGZV6M
 1ox+xcoaBtqYwNl3Ff1XBDuq1/WnJS2Y9/tplPS2ZoU31MvFSqkcQ8w14xaYbNkyNY2b
 FWhg==
X-Gm-Message-State: ABuFfojVeWTFTsqiARTHSGwFaPJj5LKQjLvRfsJTf8dgbHmsfEyPU448
 48i14/qXvN8nnh4pEB/QvO0=
X-Google-Smtp-Source: ACcGV61I/qQT6faAfWR08W5okHjAScVjfpvvma02IPENEaxGDjDCmg8zXECACjrbMLiyH94Pv5Glkg==
X-Received: by 2002:a63:1624:: with SMTP id
 w36-v6mr2558274pgl.409.1539287763353; 
 Thu, 11 Oct 2018 12:56:03 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id y19-v6sm47935709pff.14.2018.10.11.12.56.02
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 11 Oct 2018 12:56:02 -0700 (PDT)
Subject: Re: [RFC PATCH v2 2/3] powernv/cpuidle: Pass pointers instead of
 values to stop loop
To: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <20181011132237.14604-1-akshay.adiga@linux.vnet.ibm.com>
 <20181011132237.14604-3-akshay.adiga@linux.vnet.ibm.com>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <38ed1a99-0916-e293-7564-268b49001de0@gmail.com>
Date: Thu, 11 Oct 2018 12:56:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181011132237.14604-3-akshay.adiga@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: huntbag@linux.vnet.ibm.com, ego@linux.vnet.ibm.com, npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

+ devicetree mail list

On 10/11/18 06:22, Akshay Adiga wrote:
> Passing pointer to the pnv_idle_state instead of psscr value and mask.
> This helps us to pass more information to the stop loop. This will help to
> figure out the method to enter/exit idle state.
> 
> Signed-off-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
> 
> ---
> Changes from v1 :
>  - Code is rebased on Nick Piggin's v4 patch "powerpc/64s: reimplement book3s
>    idle code in C"
> 
>  arch/powerpc/include/asm/processor.h  |  5 ++-
>  arch/powerpc/platforms/powernv/idle.c | 47 ++++++++++-----------------
>  drivers/cpuidle/cpuidle-powernv.c     | 15 +++------
>  3 files changed, 24 insertions(+), 43 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
> index 936795acba48..822d3236ad7f 100644
> --- a/arch/powerpc/include/asm/processor.h
> +++ b/arch/powerpc/include/asm/processor.h
> @@ -43,6 +43,7 @@
>  #include <asm/thread_info.h>
>  #include <asm/ptrace.h>
>  #include <asm/hw_breakpoint.h>
> +#include <asm/cpuidle.h>
>  
>  /* We do _not_ want to define new machine types at all, those must die
>   * in favor of using the device-tree
> @@ -518,9 +519,7 @@ enum idle_boot_override {IDLE_NO_OVERRIDE = 0, IDLE_POWERSAVE_OFF};
>  extern int powersave_nap;	/* set if nap mode can be used in idle loop */
>  
>  extern void power7_idle_type(unsigned long type);
> -extern void power9_idle_type(unsigned long stop_psscr_val,
> -			      unsigned long stop_psscr_mask);
> -
> +extern void power9_idle_type(struct pnv_idle_states_t *state);
>  extern void flush_instruction_cache(void);
>  extern void hard_reset_now(void);
>  extern void poweroff_now(void);
> diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
> index 755918402591..681a23a066bb 100644
> --- a/arch/powerpc/platforms/powernv/idle.c
> +++ b/arch/powerpc/platforms/powernv/idle.c
> @@ -44,8 +44,7 @@ int nr_pnv_idle_states;
>   * The default stop state that will be used by ppc_md.power_save
>   * function on platforms that support stop instruction.
>   */
> -static u64 pnv_default_stop_val;
> -static u64 pnv_default_stop_mask;
> +struct pnv_idle_states_t *pnv_default_state;
>  static bool default_stop_found;
>  
>  /*
> @@ -72,9 +71,7 @@ const int nr_known_versions = 1;
>   * psscr value and mask of the deepest stop idle state.
>   * Used when a cpu is offlined.
>   */
> -static u64 pnv_deepest_stop_psscr_val;
> -static u64 pnv_deepest_stop_psscr_mask;
> -static u64 pnv_deepest_stop_flag;
> +static struct pnv_idle_states_t *pnv_deepest_state;
>  static bool deepest_stop_found;
>  
>  static unsigned long power7_offline_type;
> @@ -96,7 +93,7 @@ static int pnv_save_sprs_for_deep_states(void)
>  	uint64_t hid5_val	= mfspr(SPRN_HID5);
>  	uint64_t hmeer_val	= mfspr(SPRN_HMEER);
>  	uint64_t msr_val = MSR_IDLE;
> -	uint64_t psscr_val = pnv_deepest_stop_psscr_val;
> +	uint64_t psscr_val = pnv_deepest_state->psscr_val;
>  
>  	for_each_present_cpu(cpu) {
>  		uint64_t pir = get_hard_smp_processor_id(cpu);
> @@ -820,17 +817,15 @@ static unsigned long power9_offline_stop(unsigned long psscr)
>  	return srr1;
>  }
>  
> -static unsigned long __power9_idle_type(unsigned long stop_psscr_val,
> -				      unsigned long stop_psscr_mask)
> +static unsigned long __power9_idle_type(struct pnv_idle_states_t *state)
>  {
>  	unsigned long psscr;
>  	unsigned long srr1;
>  
>  	if (!prep_irq_for_idle_irqsoff())
>  		return 0;
> -
>  	psscr = mfspr(SPRN_PSSCR);
> -	psscr = (psscr & ~stop_psscr_mask) | stop_psscr_val;
> +	psscr = (psscr & ~state->psscr_mask) | state->psscr_val;
>  
>  	__ppc64_runlatch_off();
>  	srr1 = power9_idle_stop(psscr, true);
> @@ -841,12 +836,10 @@ static unsigned long __power9_idle_type(unsigned long stop_psscr_val,
>  	return srr1;
>  }
>  
> -void power9_idle_type(unsigned long stop_psscr_val,
> -				      unsigned long stop_psscr_mask)
> +void power9_idle_type(struct pnv_idle_states_t *state)
>  {
>  	unsigned long srr1;
> -
> -	srr1 = __power9_idle_type(stop_psscr_val, stop_psscr_mask);
> +	srr1 = __power9_idle_type(state);
>  	irq_set_pending_from_srr1(srr1);
>  }
>  
> @@ -855,7 +848,7 @@ void power9_idle_type(unsigned long stop_psscr_val,
>   */
>  void power9_idle(void)
>  {
> -	power9_idle_type(pnv_default_stop_val, pnv_default_stop_mask);
> +	power9_idle_type(pnv_default_state);
>  }
>  
>  #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
> @@ -974,8 +967,8 @@ unsigned long pnv_cpu_offline(unsigned int cpu)
>  		unsigned long psscr;
>  
>  		psscr = mfspr(SPRN_PSSCR);
> -		psscr = (psscr & ~pnv_deepest_stop_psscr_mask) |
> -						pnv_deepest_stop_psscr_val;
> +		psscr = (psscr & ~pnv_deepest_state->psscr_mask) |
> +						pnv_deepest_state->psscr_val;
>  		srr1 = power9_offline_stop(psscr);
>  	} else if (cpu_has_feature(CPU_FTR_ARCH_206) && power7_offline_type) {
>  		srr1 = power7_offline();
> @@ -1123,16 +1116,13 @@ static void __init pnv_power9_idle_init(void)
>  
>  		if (max_residency_ns < state->residency_ns) {
>  			max_residency_ns = state->residency_ns;
> -			pnv_deepest_stop_psscr_val = state->psscr_val;
> -			pnv_deepest_stop_psscr_mask = state->psscr_mask;
> -			pnv_deepest_stop_flag = state->flags;
> +			pnv_deepest_state = state;
>  			deepest_stop_found = true;
>  		}
>  
>  		if (!default_stop_found &&
>  		    (state->flags & OPAL_PM_STOP_INST_FAST)) {
> -			pnv_default_stop_val = state->psscr_val;
> -			pnv_default_stop_mask = state->psscr_mask;
> +			pnv_default_state = state;
>  			default_stop_found = true;
>  			WARN_ON(state->flags & OPAL_PM_LOSE_FULL_CONTEXT);
>  		}
> @@ -1143,15 +1133,15 @@ static void __init pnv_power9_idle_init(void)
>  	} else {
>  		ppc_md.power_save = power9_idle;
>  		pr_info("cpuidle-powernv: Default stop: psscr = 0x%016llx,mask=0x%016llx\n",
> -			pnv_default_stop_val, pnv_default_stop_mask);
> +			pnv_default_state->psscr_val, pnv_default_state->psscr_mask);
>  	}
>  
>  	if (unlikely(!deepest_stop_found)) {
>  		pr_warn("cpuidle-powernv: No suitable stop state for CPU-Hotplug. Offlined CPUs will busy wait");
>  	} else {
>  		pr_info("cpuidle-powernv: Deepest stop: psscr = 0x%016llx,mask=0x%016llx\n",
> -			pnv_deepest_stop_psscr_val,
> -			pnv_deepest_stop_psscr_mask);
> +			pnv_deepest_state->psscr_val,
> +			pnv_deepest_state->psscr_mask);
>  	}
>  
>  	pr_info("cpuidle-powernv: First stop level that may lose SPRs = 0x%lld\n",
> @@ -1173,16 +1163,15 @@ static void __init pnv_disable_deep_states(void)
>  	pr_warn("cpuidle-powernv: Idle power-savings, CPU-Hotplug affected\n");
>  
>  	if (cpu_has_feature(CPU_FTR_ARCH_300) &&
> -	    (pnv_deepest_stop_flag & OPAL_PM_LOSE_FULL_CONTEXT)) {
> +	    (pnv_deepest_state->flags & OPAL_PM_LOSE_FULL_CONTEXT)) {
>  		/*
>  		 * Use the default stop state for CPU-Hotplug
>  		 * if available.
>  		 */
>  		if (default_stop_found) {
> -			pnv_deepest_stop_psscr_val = pnv_default_stop_val;
> -			pnv_deepest_stop_psscr_mask = pnv_default_stop_mask;
> +			pnv_deepest_state = pnv_default_state;
>  			pr_warn("cpuidle-powernv: Offlined CPUs will stop with psscr = 0x%016llx\n",
> -				pnv_deepest_stop_psscr_val);
> +				pnv_deepest_state->psscr_val);
>  		} else { /* Fallback to snooze loop for CPU-Hotplug */
>  			deepest_stop_found = false;
>  			pr_warn("cpuidle-powernv: Offlined CPUs will busy wait\n");
> diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
> index a15514ebd1c3..5116d5991d30 100644
> --- a/drivers/cpuidle/cpuidle-powernv.c
> +++ b/drivers/cpuidle/cpuidle-powernv.c
> @@ -35,13 +35,7 @@ static struct cpuidle_driver powernv_idle_driver = {
>  static int max_idle_state __read_mostly;
>  static struct cpuidle_state *cpuidle_state_table __read_mostly;
>  
> -struct stop_psscr_table {
> -	u64 val;
> -	u64 mask;
> -};
> -
> -static struct stop_psscr_table stop_psscr_table[CPUIDLE_STATE_MAX] __read_mostly;
> -
> +struct pnv_idle_states_t idx_to_state_ptr[CPUIDLE_STATE_MAX] __read_mostly;
>  static u64 default_snooze_timeout __read_mostly;
>  static bool snooze_timeout_en __read_mostly;
>  
> @@ -143,8 +137,9 @@ static int stop_loop(struct cpuidle_device *dev,
>  		     struct cpuidle_driver *drv,
>  		     int index)
>  {
> -	power9_idle_type(stop_psscr_table[index].val,
> -			 stop_psscr_table[index].mask);
> +	struct pnv_idle_states_t *state;
> +	state = &pnv_idle_states[index];
> +	power9_idle_type(state);
>  	return index;
>  }
>  
> @@ -242,8 +237,6 @@ static inline void add_powernv_state(int index, const char *name,
>  	powernv_states[index].exit_latency = exit_latency;
>  	powernv_states[index].enter = idle_fn;
>  	/* For power8 and below psscr_* will be 0 */
> -	stop_psscr_table[index].val = psscr_val;
> -	stop_psscr_table[index].mask = psscr_mask;
>  }
>  
>  /*
> 

