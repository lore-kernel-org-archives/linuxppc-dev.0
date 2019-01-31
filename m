Return-Path: <SRS0=ULCe=QH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 909CDC169C4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 04:20:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B9F920833
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 04:20:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B9F920833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43qn9362DjzDqVh
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 15:20:55 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43qn7901vjzDqHq
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Jan 2019 15:19:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43qn7810Tdz9sBb;
 Thu, 31 Jan 2019 15:19:16 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Kees Cook <keescook@chromium.org>, Andrew Morton <akpm@linux-foundation.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH v3 2/2] powerpc: use probe_user_read()
In-Reply-To: <afd95fa4747f1c1eb66677025c2c7c9055f43cce.1547652372.git.christophe.leroy@c-s.fr>
References: <39fb6c5a191025378676492e140dc012915ecaeb.1547652372.git.christophe.leroy@c-s.fr>
 <afd95fa4747f1c1eb66677025c2c7c9055f43cce.1547652372.git.christophe.leroy@c-s.fr>
Date: Thu, 31 Jan 2019 15:19:13 +1100
Message-ID: <878sz1pigu.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> Instead of opencoding, use probe_user_read() to failessly
> read a user location.
>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  v3: No change
>
>  v2: Using probe_user_read() instead of probe_user_address()
>
>  arch/powerpc/kernel/process.c   | 12 +-----------
>  arch/powerpc/mm/fault.c         |  6 +-----
>  arch/powerpc/perf/callchain.c   | 20 +++-----------------
>  arch/powerpc/perf/core-book3s.c |  8 +-------
>  arch/powerpc/sysdev/fsl_pci.c   | 10 ++++------
>  5 files changed, 10 insertions(+), 46 deletions(-)

Looks good.

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers

> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index ce393df243aa..6a4b59d574c2 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -1298,16 +1298,6 @@ void show_user_instructions(struct pt_regs *regs)
>  
>  	pc = regs->nip - (NR_INSN_TO_PRINT * 3 / 4 * sizeof(int));
>  
> -	/*
> -	 * Make sure the NIP points at userspace, not kernel text/data or
> -	 * elsewhere.
> -	 */
> -	if (!__access_ok(pc, NR_INSN_TO_PRINT * sizeof(int), USER_DS)) {
> -		pr_info("%s[%d]: Bad NIP, not dumping instructions.\n",
> -			current->comm, current->pid);
> -		return;
> -	}
> -
>  	seq_buf_init(&s, buf, sizeof(buf));
>  
>  	while (n) {
> @@ -1318,7 +1308,7 @@ void show_user_instructions(struct pt_regs *regs)
>  		for (i = 0; i < 8 && n; i++, n--, pc += sizeof(int)) {
>  			int instr;
>  
> -			if (probe_kernel_address((const void *)pc, instr)) {
> +			if (probe_user_read(&instr, (void __user *)pc, sizeof(instr))) {
>  				seq_buf_printf(&s, "XXXXXXXX ");
>  				continue;
>  			}
> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
> index 887f11bcf330..ec74305fa330 100644
> --- a/arch/powerpc/mm/fault.c
> +++ b/arch/powerpc/mm/fault.c
> @@ -276,12 +276,8 @@ static bool bad_stack_expansion(struct pt_regs *regs, unsigned long address,
>  		if ((flags & FAULT_FLAG_WRITE) && (flags & FAULT_FLAG_USER) &&
>  		    access_ok(nip, sizeof(*nip))) {
>  			unsigned int inst;
> -			int res;
>  
> -			pagefault_disable();
> -			res = __get_user_inatomic(inst, nip);
> -			pagefault_enable();
> -			if (!res)
> +			if (!probe_user_read(&inst, nip, sizeof(inst)))
>  				return !store_updates_sp(inst);
>  			*must_retry = true;
>  		}
> diff --git a/arch/powerpc/perf/callchain.c b/arch/powerpc/perf/callchain.c
> index 0af051a1974e..0680efb2237b 100644
> --- a/arch/powerpc/perf/callchain.c
> +++ b/arch/powerpc/perf/callchain.c
> @@ -159,12 +159,8 @@ static int read_user_stack_64(unsigned long __user *ptr, unsigned long *ret)
>  	    ((unsigned long)ptr & 7))
>  		return -EFAULT;
>  
> -	pagefault_disable();
> -	if (!__get_user_inatomic(*ret, ptr)) {
> -		pagefault_enable();
> +	if (!probe_user_read(ret, ptr, sizeof(*ret)))
>  		return 0;
> -	}
> -	pagefault_enable();
>  
>  	return read_user_stack_slow(ptr, ret, 8);
>  }
> @@ -175,12 +171,8 @@ static int read_user_stack_32(unsigned int __user *ptr, unsigned int *ret)
>  	    ((unsigned long)ptr & 3))
>  		return -EFAULT;
>  
> -	pagefault_disable();
> -	if (!__get_user_inatomic(*ret, ptr)) {
> -		pagefault_enable();
> +	if (!probe_user_read(ret, ptr, sizeof(*ret)))
>  		return 0;
> -	}
> -	pagefault_enable();
>  
>  	return read_user_stack_slow(ptr, ret, 4);
>  }
> @@ -307,17 +299,11 @@ static inline int current_is_64bit(void)
>   */
>  static int read_user_stack_32(unsigned int __user *ptr, unsigned int *ret)
>  {
> -	int rc;
> -
>  	if ((unsigned long)ptr > TASK_SIZE - sizeof(unsigned int) ||
>  	    ((unsigned long)ptr & 3))
>  		return -EFAULT;
>  
> -	pagefault_disable();
> -	rc = __get_user_inatomic(*ret, ptr);
> -	pagefault_enable();
> -
> -	return rc;
> +	return probe_user_read(ret, ptr, sizeof(*ret));
>  }
>  
>  static inline void perf_callchain_user_64(struct perf_callchain_entry_ctx *entry,
> diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
> index b0723002a396..4b64ddf0db68 100644
> --- a/arch/powerpc/perf/core-book3s.c
> +++ b/arch/powerpc/perf/core-book3s.c
> @@ -416,7 +416,6 @@ static void power_pmu_sched_task(struct perf_event_context *ctx, bool sched_in)
>  static __u64 power_pmu_bhrb_to(u64 addr)
>  {
>  	unsigned int instr;
> -	int ret;
>  	__u64 target;
>  
>  	if (is_kernel_addr(addr)) {
> @@ -427,13 +426,8 @@ static __u64 power_pmu_bhrb_to(u64 addr)
>  	}
>  
>  	/* Userspace: need copy instruction here then translate it */
> -	pagefault_disable();
> -	ret = __get_user_inatomic(instr, (unsigned int __user *)addr);
> -	if (ret) {
> -		pagefault_enable();
> +	if (probe_user_read(&instr, (unsigned int __user *)addr, sizeof(instr)))
>  		return 0;
> -	}
> -	pagefault_enable();
>  
>  	target = branch_target(&instr);
>  	if ((!target) || (instr & BRANCH_ABSOLUTE))
> diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
> index 918be816b097..c8a1b26489f5 100644
> --- a/arch/powerpc/sysdev/fsl_pci.c
> +++ b/arch/powerpc/sysdev/fsl_pci.c
> @@ -1068,13 +1068,11 @@ int fsl_pci_mcheck_exception(struct pt_regs *regs)
>  	addr += mfspr(SPRN_MCAR);
>  
>  	if (is_in_pci_mem_space(addr)) {
> -		if (user_mode(regs)) {
> -			pagefault_disable();
> -			ret = get_user(inst, (__u32 __user *)regs->nip);
> -			pagefault_enable();
> -		} else {
> +		if (user_mode(regs))
> +			ret = probe_user_read(&inst, (void __user *)regs->nip,
> +					      sizeof(inst));
> +		else
>  			ret = probe_kernel_address((void *)regs->nip, inst);
> -		}
>  
>  		if (!ret && mcheck_handle_load(regs, inst)) {
>  			regs->nip += 4;
> -- 
> 2.13.3
