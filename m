Return-Path: <SRS0=hsDs=PQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81AFEC43387
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 09:39:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF34B206B7
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 09:39:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF34B206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43YnKg55bfzDqQf
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 20:39:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43YnHS0Ry0zDqQR
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Jan 2019 20:37:56 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43YnHM1psYz9v1Hf;
 Tue,  8 Jan 2019 10:37:51 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id cA4zH0foTH8r; Tue,  8 Jan 2019 10:37:51 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43YnHM14gfz9v1Hc;
 Tue,  8 Jan 2019 10:37:51 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 21B668B7CB;
 Tue,  8 Jan 2019 10:37:52 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id B9UCLNJ6RJx1; Tue,  8 Jan 2019 10:37:52 +0100 (CET)
Received: from PO15451 (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 66F8D8B7C9;
 Tue,  8 Jan 2019 10:37:51 +0100 (CET)
Subject: Re: [PATCH v2 2/2] powerpc: use probe_user_read()
From: Christophe Leroy <christophe.leroy@c-s.fr>
To: Michael Ellerman <mpe@ellerman.id.au>, Russell Currey <ruscur@russell.cc>
References: <0b0db24e18063076e9d9f4e376994af83da05456.1546932949.git.christophe.leroy@c-s.fr>
 <e939991366b784ef13c7afcab51749e3b46327ac.1546932949.git.christophe.leroy@c-s.fr>
Message-ID: <293a653c-52aa-6326-4022-73fb25590354@c-s.fr>
Date: Tue, 8 Jan 2019 10:37:51 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <e939991366b784ef13c7afcab51749e3b46327ac.1546932949.git.christophe.leroy@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
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
Cc: Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
 Mike Rapoport <rppt@linux.ibm.com>, linux-mm@kvack.org,
 Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Michael and Russell,

Any idea why:
- checkpatch reports missing Signed-off-by:
- Snowpatch build fails on PPC64 (it seems unrelated to the patch, 
something wrong in lib/genalloc.c)

Thanks
Christophe

Le 08/01/2019 à 08:37, Christophe Leroy a écrit :
> Instead of opencoding, use probe_user_read() to failessly
> read a user location.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>   v2: Using probe_user_read() instead of probe_user_address()
> 
>   arch/powerpc/kernel/process.c   | 12 +-----------
>   arch/powerpc/mm/fault.c         |  6 +-----
>   arch/powerpc/perf/callchain.c   | 20 +++-----------------
>   arch/powerpc/perf/core-book3s.c |  8 +-------
>   arch/powerpc/sysdev/fsl_pci.c   | 10 ++++------
>   5 files changed, 10 insertions(+), 46 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index ce393df243aa..6a4b59d574c2 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -1298,16 +1298,6 @@ void show_user_instructions(struct pt_regs *regs)
>   
>   	pc = regs->nip - (NR_INSN_TO_PRINT * 3 / 4 * sizeof(int));
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
>   	seq_buf_init(&s, buf, sizeof(buf));
>   
>   	while (n) {
> @@ -1318,7 +1308,7 @@ void show_user_instructions(struct pt_regs *regs)
>   		for (i = 0; i < 8 && n; i++, n--, pc += sizeof(int)) {
>   			int instr;
>   
> -			if (probe_kernel_address((const void *)pc, instr)) {
> +			if (probe_user_read(&instr, (void __user *)pc, sizeof(instr))) {
>   				seq_buf_printf(&s, "XXXXXXXX ");
>   				continue;
>   			}
> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
> index 887f11bcf330..ec74305fa330 100644
> --- a/arch/powerpc/mm/fault.c
> +++ b/arch/powerpc/mm/fault.c
> @@ -276,12 +276,8 @@ static bool bad_stack_expansion(struct pt_regs *regs, unsigned long address,
>   		if ((flags & FAULT_FLAG_WRITE) && (flags & FAULT_FLAG_USER) &&
>   		    access_ok(nip, sizeof(*nip))) {
>   			unsigned int inst;
> -			int res;
>   
> -			pagefault_disable();
> -			res = __get_user_inatomic(inst, nip);
> -			pagefault_enable();
> -			if (!res)
> +			if (!probe_user_read(&inst, nip, sizeof(inst)))
>   				return !store_updates_sp(inst);
>   			*must_retry = true;
>   		}
> diff --git a/arch/powerpc/perf/callchain.c b/arch/powerpc/perf/callchain.c
> index 0af051a1974e..0680efb2237b 100644
> --- a/arch/powerpc/perf/callchain.c
> +++ b/arch/powerpc/perf/callchain.c
> @@ -159,12 +159,8 @@ static int read_user_stack_64(unsigned long __user *ptr, unsigned long *ret)
>   	    ((unsigned long)ptr & 7))
>   		return -EFAULT;
>   
> -	pagefault_disable();
> -	if (!__get_user_inatomic(*ret, ptr)) {
> -		pagefault_enable();
> +	if (!probe_user_read(ret, ptr, sizeof(*ret)))
>   		return 0;
> -	}
> -	pagefault_enable();
>   
>   	return read_user_stack_slow(ptr, ret, 8);
>   }
> @@ -175,12 +171,8 @@ static int read_user_stack_32(unsigned int __user *ptr, unsigned int *ret)
>   	    ((unsigned long)ptr & 3))
>   		return -EFAULT;
>   
> -	pagefault_disable();
> -	if (!__get_user_inatomic(*ret, ptr)) {
> -		pagefault_enable();
> +	if (!probe_user_read(ret, ptr, sizeof(*ret)))
>   		return 0;
> -	}
> -	pagefault_enable();
>   
>   	return read_user_stack_slow(ptr, ret, 4);
>   }
> @@ -307,17 +299,11 @@ static inline int current_is_64bit(void)
>    */
>   static int read_user_stack_32(unsigned int __user *ptr, unsigned int *ret)
>   {
> -	int rc;
> -
>   	if ((unsigned long)ptr > TASK_SIZE - sizeof(unsigned int) ||
>   	    ((unsigned long)ptr & 3))
>   		return -EFAULT;
>   
> -	pagefault_disable();
> -	rc = __get_user_inatomic(*ret, ptr);
> -	pagefault_enable();
> -
> -	return rc;
> +	return probe_user_read(ret, ptr, sizeof(*ret));
>   }
>   
>   static inline void perf_callchain_user_64(struct perf_callchain_entry_ctx *entry,
> diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
> index b0723002a396..4b64ddf0db68 100644
> --- a/arch/powerpc/perf/core-book3s.c
> +++ b/arch/powerpc/perf/core-book3s.c
> @@ -416,7 +416,6 @@ static void power_pmu_sched_task(struct perf_event_context *ctx, bool sched_in)
>   static __u64 power_pmu_bhrb_to(u64 addr)
>   {
>   	unsigned int instr;
> -	int ret;
>   	__u64 target;
>   
>   	if (is_kernel_addr(addr)) {
> @@ -427,13 +426,8 @@ static __u64 power_pmu_bhrb_to(u64 addr)
>   	}
>   
>   	/* Userspace: need copy instruction here then translate it */
> -	pagefault_disable();
> -	ret = __get_user_inatomic(instr, (unsigned int __user *)addr);
> -	if (ret) {
> -		pagefault_enable();
> +	if (probe_user_read(&instr, (unsigned int __user *)addr, sizeof(instr)))
>   		return 0;
> -	}
> -	pagefault_enable();
>   
>   	target = branch_target(&instr);
>   	if ((!target) || (instr & BRANCH_ABSOLUTE))
> diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
> index 918be816b097..c8a1b26489f5 100644
> --- a/arch/powerpc/sysdev/fsl_pci.c
> +++ b/arch/powerpc/sysdev/fsl_pci.c
> @@ -1068,13 +1068,11 @@ int fsl_pci_mcheck_exception(struct pt_regs *regs)
>   	addr += mfspr(SPRN_MCAR);
>   
>   	if (is_in_pci_mem_space(addr)) {
> -		if (user_mode(regs)) {
> -			pagefault_disable();
> -			ret = get_user(inst, (__u32 __user *)regs->nip);
> -			pagefault_enable();
> -		} else {
> +		if (user_mode(regs))
> +			ret = probe_user_read(&inst, (void __user *)regs->nip,
> +					      sizeof(inst));
> +		else
>   			ret = probe_kernel_address((void *)regs->nip, inst);
> -		}
>   
>   		if (!ret && mcheck_handle_load(regs, inst)) {
>   			regs->nip += 4;
> 
