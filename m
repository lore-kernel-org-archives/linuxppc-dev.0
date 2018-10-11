Return-Path: <SRS0=4kvs=MX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 535ADC677FC
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Oct 2018 20:06:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC1932085B
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Oct 2018 20:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZYxPDcza"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC1932085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42WMSD1MHRzF3SL
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Oct 2018 07:06:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZYxPDcza";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com;
 envelope-from=frowand.list@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZYxPDcza"; 
 dkim-atps=neutral
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42WMCv0H6VzF3K1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Oct 2018 06:56:10 +1100 (AEDT)
Received: by mail-pl1-x641.google.com with SMTP id 30-v6so4716294plb.10
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Oct 2018 12:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=2nubfCgboQubIXGb0d4heQTt6hE/UvCBQtyPftUZwCc=;
 b=ZYxPDczapW29zhVFu3Y15maq25ymfci2l2IKDCHZN5ntJIkaYX1aywCSmIbI9A9CR3
 lHQCceIPjB9yXlIRsU55SffNk06A7ab2RGqBddvdt3k0ALUAdWPKKDx1JCXaH+V8NMj9
 N3Hc49REvUyRC5mJGAH01DnrB/fY8DQmzbuJQC4ZWoCuw6V8b+glTWkdPawInYxUNIJH
 FC8A/fnrd+F+v6tPWLZ+ktwVymj++k0b5VGsY6dF4jnpmxlclKx3zNvE+kWo1mT3fYxL
 DCl9BXEkVYStTJNL9l5Y7qu2fgI73wxPj9R4bWjwB7qA5+FwPBY5vw7FmJ8Z1o5VpvZ8
 LvZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2nubfCgboQubIXGb0d4heQTt6hE/UvCBQtyPftUZwCc=;
 b=sXO8mhoBdDj3CGRIBmEnhlvFI26hOVqe+4mvyAY/AVnrhhwglJYvBy7gUJox1YtuIr
 K9ANvgql4pCY+tpBNGoLLZsD3X/N62ZlcuEBwIGr2I3JofNVpkVuchAOYYQ0tXJFXnCA
 4u/GgL3/ju/q0RSbhtDq4KO2UxgpQ8bxuK1IwnvBGSgs8adk23ksoQBJPegjqE/kBJ09
 z22+/5X8yg5TrCEN15uI9etbB//wBcGvM5C12SjXOMY/w0/WrZrZnpXeDmka2mkZzy/F
 YhSoLohzBdHnqb7vZpmbz1TB9fdeKhgQIgXyJVsxy9S+b9hFy8yXonvBRVvF+QVgXZex
 MsIg==
X-Gm-Message-State: ABuFfojbd05CfXBl6ILZ6CfAmwlOoRPEn5rrRAPQZAfdCBMZc0pphPni
 R2IegM+IV2KSLLdJ27n7XeU=
X-Google-Smtp-Source: ACcGV6152kQ31eI4t8zZ1ZEcJTueYLlt2w6smxPJPvbxbyWB06EA8i3PpaYu/VBVy5LxdZT32JfVJA==
X-Received: by 2002:a17:902:7b83:: with SMTP id
 w3-v6mr2852751pll.285.1539287769125; 
 Thu, 11 Oct 2018 12:56:09 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id l10-v6sm49122033pgs.45.2018.10.11.12.56.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 11 Oct 2018 12:56:08 -0700 (PDT)
Subject: Re: [RFC PATCH v2 3/3] cpuidle/powernv: save-restore sprs in opal
To: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <20181011132237.14604-1-akshay.adiga@linux.vnet.ibm.com>
 <20181011132237.14604-4-akshay.adiga@linux.vnet.ibm.com>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <34eaec54-3846-54f5-463a-d80c9d95d79c@gmail.com>
Date: Thu, 11 Oct 2018 12:56:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181011132237.14604-4-akshay.adiga@linux.vnet.ibm.com>
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
> From: Abhishek Goel <huntbag@linux.vnet.ibm.com>
> 
> This patch moves the saving and restoring of sprs for P9 cpuidle
> from kernel to opal.
> In an attempt to make the powernv idle code backward compatible,
> and to some extent forward compatible, add support for pre-stop entry
> and post-stop exit actions in OPAL. If a kernel knows about this
> opal call, then just a firmware supporting newer hardware is required,
> instead of waiting for kernel updates.
> 
> Signed-off-by: Abhishek Goel <huntbag@linux.vnet.ibm.com>
> Signed-off-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
> ---
> Changes from v1 :
>  - Code is rebased on Nick Piggin's v4 patch "powerpc/64s: reimplement book3s
>    idle code in C"
>  - Set a global variable "request_opal_call" to indicate that deep
>    states should make opal_call.
>  - All the states that loses hypervisor states will be handled by OPAL
>  - All the decision making such as identifying first thread in
>    the core and taking locks before restoring in such cases have also been
>    moved to OPAL
>  arch/powerpc/include/asm/opal-api.h           |  4 +-
>  arch/powerpc/include/asm/opal.h               |  3 +
>  arch/powerpc/include/asm/processor.h          |  3 +-
>  arch/powerpc/kernel/idle_book3s.S             |  6 +-
>  arch/powerpc/platforms/powernv/idle.c         | 88 +++++++++++++------
>  .../powerpc/platforms/powernv/opal-wrappers.S |  2 +
>  6 files changed, 77 insertions(+), 29 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
> index 8365353330b4..93ea1f79e295 100644
> --- a/arch/powerpc/include/asm/opal-api.h
> +++ b/arch/powerpc/include/asm/opal-api.h
> @@ -210,7 +210,9 @@
>  #define OPAL_PCI_GET_PBCQ_TUNNEL_BAR		164
>  #define OPAL_PCI_SET_PBCQ_TUNNEL_BAR		165
>  #define	OPAL_NX_COPROC_INIT			167
> -#define OPAL_LAST				167
> +#define OPAL_IDLE_SAVE				170
> +#define OPAL_IDLE_RESTORE			171
> +#define OPAL_LAST				171
>  
>  #define QUIESCE_HOLD			1 /* Spin all calls at entry */
>  #define QUIESCE_REJECT			2 /* Fail all calls with OPAL_BUSY */
> diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
> index ff3866473afe..26995e16171e 100644
> --- a/arch/powerpc/include/asm/opal.h
> +++ b/arch/powerpc/include/asm/opal.h
> @@ -356,6 +356,9 @@ extern int opal_handle_hmi_exception(struct pt_regs *regs);
>  extern void opal_shutdown(void);
>  extern int opal_resync_timebase(void);
>  
> +extern int opal_cpuidle_save(u64 psscr);
> +extern int opal_cpuidle_restore(u64 psscr, u64 srr1);
> +
>  extern void opal_lpc_init(void);
>  
>  extern void opal_kmsg_init(void);
> diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
> index 822d3236ad7f..26fa6c1836f4 100644
> --- a/arch/powerpc/include/asm/processor.h
> +++ b/arch/powerpc/include/asm/processor.h
> @@ -510,7 +510,8 @@ static inline unsigned long get_clean_sp(unsigned long sp, int is_32)
>  
>  /* asm stubs */
>  extern unsigned long isa300_idle_stop_noloss(unsigned long psscr_val);
> -extern unsigned long isa300_idle_stop_mayloss(unsigned long psscr_val);
> +extern unsigned long isa300_idle_stop_mayloss(unsigned long psscr_val,
> +						bool request_opal_call);
>  extern unsigned long isa206_idle_insn_mayloss(unsigned long type);
>  
>  extern unsigned long cpuidle_disable;
> diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
> index ffdee1ab4388..a2014d152035 100644
> --- a/arch/powerpc/kernel/idle_book3s.S
> +++ b/arch/powerpc/kernel/idle_book3s.S
> @@ -52,14 +52,16 @@ _GLOBAL(isa300_idle_stop_noloss)
>  _GLOBAL(isa300_idle_stop_mayloss)
>  	mtspr 	SPRN_PSSCR,r3
>  	std	r1,PACAR1(r13)
> -	mflr	r4
> +	mflr	r7
>  	mfcr	r5
>  	/* use stack red zone rather than a new frame */
>  	addi	r6,r1,-INT_FRAME_SIZE
>  	SAVE_GPR(2, r6)
>  	SAVE_NVGPRS(r6)
> -	std	r4,_LINK(r6)
> +	std	r7,_LINK(r6)
>  	std	r5,_CCR(r6)
> +	cmpwi	r4,0
> +	bne	opal_cpuidle_save
>  	PPC_STOP
>  	b	.	/* catch bugs */
>  
> diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
> index 681a23a066bb..bcfe08022e65 100644
> --- a/arch/powerpc/platforms/powernv/idle.c
> +++ b/arch/powerpc/platforms/powernv/idle.c
> @@ -171,6 +171,7 @@ static void pnv_fastsleep_workaround_apply(void *info)
>  
>  static bool power7_fastsleep_workaround_entry = true;
>  static bool power7_fastsleep_workaround_exit = true;
> +static bool request_opal_call = false;
>  
>  /*
>   * Used to store fastsleep workaround state
> @@ -604,6 +605,7 @@ static unsigned long power9_idle_stop(unsigned long psscr, bool mmu_on)
>  	unsigned long mmcr0 = 0;
>  	struct p9_sprs sprs;
>  	bool sprs_saved = false;
> +	bool is_hv_loss = false;
>  
>  	memset(&sprs, 0, sizeof(sprs));
>  
> @@ -648,7 +650,9 @@ static unsigned long power9_idle_stop(unsigned long psscr, bool mmu_on)
>  		  */
>  		mmcr0		= mfspr(SPRN_MMCR0);
>  	}
> -	if ((psscr & PSSCR_RL_MASK) >= pnv_first_hv_loss_level) {
> +
> +	is_hv_loss = (psscr & PSSCR_RL_MASK) >= pnv_first_hv_loss_level;
> +	if (is_hv_loss && (!request_opal_call)) {
>  		sprs.lpcr	= mfspr(SPRN_LPCR);
>  		sprs.hfscr	= mfspr(SPRN_HFSCR);
>  		sprs.fscr	= mfspr(SPRN_FSCR);
> @@ -674,7 +678,8 @@ static unsigned long power9_idle_stop(unsigned long psscr, bool mmu_on)
>  		atomic_start_thread_idle();
>  	}
>  
> -	srr1 = isa300_idle_stop_mayloss(psscr);
> +	srr1 = isa300_idle_stop_mayloss(psscr,
> +			is_hv_loss && request_opal_call);
>  
>  #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
>  	local_paca->requested_psscr = 0;
> @@ -685,6 +690,25 @@ static unsigned long power9_idle_stop(unsigned long psscr, bool mmu_on)
>  	WARN_ON_ONCE(!srr1);
>  	WARN_ON_ONCE(mfmsr() & (MSR_IR|MSR_DR));
>  
> +	/*
> +	 * On POWER9, SRR1 bits do not match exactly as expected.
> +	 * SRR1_WS_GPRLOSS (10b) can also result in SPR loss, so
> +	 * always test PSSCR if there is any state loss.
> +	 */
> +	if (likely(((psscr & PSSCR_PLS) >> 60) < pnv_first_hv_loss_level)) {
> +		if (sprs_saved)
> +			atomic_stop_thread_idle();
> +		goto out;
> +	}
> +
> +	if (request_opal_call) {
> +		opal_cpuidle_restore(psscr, srr1);
> +		goto opal_return;
> +	}
> +
> +	/* HV state loss */
> +	BUG_ON(!sprs_saved);
> +
>  	if ((srr1 & SRR1_WAKESTATE) != SRR1_WS_NOLOSS) {
>  		unsigned long mmcra;
>  
> @@ -712,19 +736,6 @@ static unsigned long power9_idle_stop(unsigned long psscr, bool mmu_on)
>  	if (unlikely((srr1 & SRR1_WAKEMASK_P8) == SRR1_WAKEHMI))
>  		hmi_exception_realmode(NULL);
>  
> -	/*
> -	 * On POWER9, SRR1 bits do not match exactly as expected.
> -	 * SRR1_WS_GPRLOSS (10b) can also result in SPR loss, so
> -	 * always test PSSCR if there is any state loss.
> -	 */
> -	if (likely((psscr & PSSCR_RL_MASK) < pnv_first_hv_loss_level)) {
> -		if (sprs_saved)
> -			atomic_stop_thread_idle();
> -		goto out;
> -	}
> -
> -	/* HV state loss */
> -	BUG_ON(!sprs_saved);
>  
>  	atomic_lock_thread_idle();
>  
> @@ -771,6 +782,7 @@ static unsigned long power9_idle_stop(unsigned long psscr, bool mmu_on)
>  
>  	mtspr(SPRN_SPRG3,	local_paca->sprg_vdso);
>  
> +opal_return:
>  	if (!radix_enabled())
>  		__slb_restore_bolted_realmode();
>  
> @@ -1284,6 +1296,7 @@ static int pnv_parse_cpuidle_dt(void)
>  	u32 *temp_u32;
>  	u64 *temp_u64;
>  	const char **temp_string;
> +	bool fall_back_to_opal = false;
>  
>  	np = of_find_node_by_path("/ibm,opal/power-mgt");
>  	if (!np) {
> @@ -1396,23 +1409,48 @@ static int pnv_parse_cpuidle_dt(void)
>  	/* Parse each child node with appropriate parser_fn */
>  	for_each_child_of_node(np1, dt_node) {
>  		bool found_known_version = false;
> -		/* we don't have state falling back to opal*/
> -		for (i = 0; i < nr_known_versions ; i++) {
> -			if (of_device_is_compatible(dt_node, known_versions[i].name)) {
> -				rc = known_versions[i].parser_fn(dt_node);
> +		if (!fall_back_to_opal) {
> +			/* we don't have state falling back to opal*/
> +			for (i = 0; i < nr_known_versions ; i++) {
> +				if (of_device_is_compatible(dt_node, known_versions[i].name)) {
> +					rc = known_versions[i].parser_fn(dt_node);
> +					if (rc) {
> +						pr_err("%s could not parse\n", known_versions[i].name);
> +						continue;
> +					}
> +					found_known_version = true;
> +				}
> +			}
> +		}
> +
> +		/*
> +		 * If any previous state falls back to opal_call
> +		 * Then all futher states will either call opal_call
> +		 * or not be included for cpuidle/cpuoffline.
> +		 *
> +		 * Moreover, having any intermediate state with no
> +		 * kernel support or opal support can be potentially
> +		 * dangerous, as hardware can potentially wakeup from
> +		 * that state. Hence, no futher states are added to
> +		 * to cpuidle/cpuoffline
> +		 */
> +		if (!found_known_version || fall_back_to_opal) {
> +			if (of_device_is_compatible(dt_node, "opal-support")) {
> +				rc = known_versions[0].parser_fn(dt_node);
>  				if (rc) {
> -					pr_err("%s could not parse\n", known_versions[i].name);
> +					pr_err("%s could not parse\n", "opal-support");
>  					continue;
>  				}
> -				found_known_version = true;
> +				fall_back_to_opal = true;
> +			} else {
> +				pr_info("Unsupported state, skipping all further state\n");
> +				goto out;
>  			}
>  		}
> -		if (!found_known_version) {
> -			pr_info("Unsupported state, skipping all further state\n");
> -			goto out;
> -		}
>  		nr_pnv_idle_states++;
>  	}
> +	if (fall_back_to_opal)
> +		request_opal_call = true;
>  out:
>  	kfree(temp_u32);
>  	kfree(temp_u64);
> diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
> index 251528231a9e..7a039a81a67e 100644
> --- a/arch/powerpc/platforms/powernv/opal-wrappers.S
> +++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
> @@ -331,3 +331,5 @@ OPAL_CALL(opal_pci_set_pbcq_tunnel_bar,		OPAL_PCI_SET_PBCQ_TUNNEL_BAR);
>  OPAL_CALL(opal_sensor_read_u64,			OPAL_SENSOR_READ_U64);
>  OPAL_CALL(opal_sensor_group_enable,		OPAL_SENSOR_GROUP_ENABLE);
>  OPAL_CALL(opal_nx_coproc_init,			OPAL_NX_COPROC_INIT);
> +OPAL_CALL(opal_cpuidle_save,			OPAL_IDLE_SAVE);
> +OPAL_CALL(opal_cpuidle_restore,			OPAL_IDLE_RESTORE);
> 

