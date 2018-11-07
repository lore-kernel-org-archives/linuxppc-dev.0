Return-Path: <SRS0=kkFw=NS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5773C0044C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Nov 2018 08:37:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EC50204FD
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Nov 2018 08:37:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EC50204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42qftp0YYBzF3HT
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Nov 2018 19:37:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42qfrm5Q9DzF3Cb
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Nov 2018 19:36:08 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 42qfrX0FWLz9tvr3;
 Wed,  7 Nov 2018 09:35:56 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id zilwr5LF1iFF; Wed,  7 Nov 2018 09:35:55 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 42qfrW366Fz9tvr2;
 Wed,  7 Nov 2018 09:35:55 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 12C638B7FF;
 Wed,  7 Nov 2018 09:35:52 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id EdwUbUtJJHpT; Wed,  7 Nov 2018 09:35:51 +0100 (CET)
Received: from PO15451 (unknown [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id CC5838B7FE;
 Wed,  7 Nov 2018 09:35:51 +0100 (CET)
Subject: Re: [PATCH 12/24] powerpc/mm: Fix reporting of kernel execute faults
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
References: <20170719044946.22030-1-benh@kernel.crashing.org>
 <20170719044946.22030-12-benh@kernel.crashing.org>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <64d43dc0-60ad-4346-96c9-2ff46867d9c9@c-s.fr>
Date: Wed, 7 Nov 2018 09:35:51 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20170719044946.22030-12-benh@kernel.crashing.org>
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
Cc: aneesh.kumar@linux.vnet.ibm.com, Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Ben,

I have an issue on the 8xx with this change

Le 19/07/2017 à 06:49, Benjamin Herrenschmidt a écrit :
> We currently test for is_exec and DSISR_PROTFAULT but that doesn't
> make sense as this is the wrong error bit to test for an execute
> permission failure.

On the 8xx, on an exec permission failure, this is the correct BIT, see 
below extract from reference manual:

Note that only one of bits 1, 3, and 4 will be set.
1 1 if the translation of an attempted access is not in the translation 
tables. Otherwise 0
3 1 if the fetch access was to guarded memory when MSR[IR] = 1. Otherwise 0
4 1 if the access is not permitted by the protection mechanism; otherwise 0.

So on the 8xx, bit 3 is not DSISR_NOEXEC_OR_G but only DSISR_G.
When the PPP bits are set to No-Execute, we really get bit 4 that is 
DSISR_PROTFAULT.

> 
> In fact, we had code that would return early if we had an exec
> fault in kernel mode so I think that was just dead code anyway.
> 
> Finally the location of that test is awkward and prevents further
> simplifications.
> 
> So instead move that test into a helper along with the existing
> early test for kernel exec faults and out of range accesses,
> and put it all in a "bad_kernel_fault()" helper. While at it
> test the correct error bits.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>   arch/powerpc/mm/fault.c | 21 +++++++++++++++------
>   1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
> index e8d6acc888c5..aead07cf8a5b 100644
> --- a/arch/powerpc/mm/fault.c
> +++ b/arch/powerpc/mm/fault.c
> @@ -180,6 +180,20 @@ static int mm_fault_error(struct pt_regs *regs, unsigned long addr, int fault)
>   	return MM_FAULT_CONTINUE;
>   }
>   
> +/* Is this a bad kernel fault ? */
> +static bool bad_kernel_fault(bool is_exec, unsigned long error_code,
> +			     unsigned long address)
> +{
> +	if (is_exec && (error_code & (DSISR_NOEXEC_OR_G | DSISR_KEYFAULT))) {

Do you mind if we had DSISR_PROTFAULT here as well ?

Christophe

> +		printk_ratelimited(KERN_CRIT "kernel tried to execute"
> +				   " exec-protected page (%lx) -"
> +				   "exploit attempt? (uid: %d)\n",
> +				   address, from_kuid(&init_user_ns,
> +						      current_uid()));
> +	}
> +	return is_exec || (address >= TASK_SIZE);
> +}
> +
>   /*
>    * Define the correct "is_write" bit in error_code based
>    * on the processor family
> @@ -252,7 +266,7 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
>   	 * The kernel should never take an execute fault nor should it
>   	 * take a page fault to a kernel address.
>   	 */
> -	if (!is_user && (is_exec || (address >= TASK_SIZE)))
> +	if (unlikely(!is_user && bad_kernel_fault(is_exec, error_code, address)))
>   		return SIGSEGV;
>   
>   	/* We restore the interrupt state now */
> @@ -491,11 +505,6 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
>   		return 0;
>   	}
>   
> -	if (is_exec && (error_code & DSISR_PROTFAULT))
> -		printk_ratelimited(KERN_CRIT "kernel tried to execute NX-protected"
> -				   " page (%lx) - exploit attempt? (uid: %d)\n",
> -				   address, from_kuid(&init_user_ns, current_uid()));
> -
>   	return SIGSEGV;
>   }
>   NOKPROBE_SYMBOL(__do_page_fault);
> 
