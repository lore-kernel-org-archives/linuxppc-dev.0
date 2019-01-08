Return-Path: <SRS0=hsDs=PQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA75C43387
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 09:06:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DE152087E
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 09:06:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DE152087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43YmZm4wDszDqQL
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 20:06:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com; envelope-from=david@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43YmXz6njrzDqQH
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Jan 2019 20:04:35 +1100 (AEDT)
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 353B17F6B3;
 Tue,  8 Jan 2019 09:04:33 +0000 (UTC)
Received: from [10.36.117.234] (ovpn-117-234.ams2.redhat.com [10.36.117.234])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C8ACC10027CE;
 Tue,  8 Jan 2019 09:04:29 +0000 (UTC)
Subject: Re: [PATCH v2 2/2] powerpc: use probe_user_read()
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Kees Cook <keescook@chromium.org>, Andrew Morton
 <akpm@linux-foundation.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Mike Rapoport <rppt@linux.ibm.com>
References: <0b0db24e18063076e9d9f4e376994af83da05456.1546932949.git.christophe.leroy@c-s.fr>
 <e939991366b784ef13c7afcab51749e3b46327ac.1546932949.git.christophe.leroy@c-s.fr>
From: David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <8a52b522-7b9d-e3d4-9c04-98292db11d85@redhat.com>
Date: Tue, 8 Jan 2019 10:04:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <e939991366b784ef13c7afcab51749e3b46327ac.1546932949.git.christophe.leroy@c-s.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Tue, 08 Jan 2019 09:04:33 +0000 (UTC)
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

On 08.01.19 08:37, Christophe Leroy wrote:
> Instead of opencoding, use probe_user_read() to failessly
> read a user location.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  v2: Using probe_user_read() instead of probe_user_address()
> 
>  arch/powerpc/kernel/process.c   | 12 +-----------
>  arch/powerpc/mm/fault.c         |  6 +-----
>  arch/powerpc/perf/callchain.c   | 20 +++-----------------
>  arch/powerpc/perf/core-book3s.c |  8 +-------
>  arch/powerpc/sysdev/fsl_pci.c   | 10 ++++------
>  5 files changed, 10 insertions(+), 46 deletions(-)
> 
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

What about also adding probe_user_address ?

> +		else
>  			ret = probe_kernel_address((void *)regs->nip, inst);
> -		}
>  
>  		if (!ret && mcheck_handle_load(regs, inst)) {
>  			regs->nip += 4;
> 


-- 

Thanks,

David / dhildenb
