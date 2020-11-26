Return-Path: <SRS0=1PmZ=FA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D6BC56202
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2020 07:44:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3D3A206C0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2020 07:44:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3D3A206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ChVCM73frzDr8L
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2020 18:44:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=csgroup.eu
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4ChV9c5PFXzDqtd
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2020 18:43:10 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4ChV9N0QZ3z9tyml;
 Thu, 26 Nov 2020 08:43:04 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id Zzh3qFKoj4i5; Thu, 26 Nov 2020 08:43:03 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4ChV9M6Z4Bz9tymk;
 Thu, 26 Nov 2020 08:43:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id D90558B7E5;
 Thu, 26 Nov 2020 08:43:04 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id ztElmbecXLrB; Thu, 26 Nov 2020 08:43:04 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 797138B7E4;
 Thu, 26 Nov 2020 08:43:04 +0100 (CET)
Subject: Re: [PATCH v6 09/22] powerpc/exec: Set thread.regs early during exec
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
References: <20201125051634.509286-1-aneesh.kumar@linux.ibm.com>
 <20201125051634.509286-10-aneesh.kumar@linux.ibm.com>
 <f5960226-f451-41ed-2992-bbe0acf9d190@csgroup.eu>
 <87k0u8tvoj.fsf@linux.ibm.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <88355dab-025e-ebb5-41f5-6b48035b48c0@csgroup.eu>
Date: Thu, 26 Nov 2020 08:43:00 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <87k0u8tvoj.fsf@linux.ibm.com>
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 26/11/2020 à 08:38, Aneesh Kumar K.V a écrit :
> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> 
>> Le 25/11/2020 à 06:16, Aneesh Kumar K.V a écrit :
> ....
> 
>> +++ b/arch/powerpc/kernel/process.c
>>> @@ -1530,10 +1530,32 @@ void flush_thread(void)
>>>    #ifdef CONFIG_PPC_BOOK3S_64
>>>    void arch_setup_new_exec(void)
>>>    {
>>> -	if (radix_enabled())
>>> -		return;
>>> -	hash__setup_new_exec();
>>> +	if (!radix_enabled())
>>> +		hash__setup_new_exec();
>>> +
>>> +	/*
>>> +	 * If we exec out of a kernel thread then thread.regs will not be
>>> +	 * set.  Do it now.
>>> +	 */
>>> +	if (!current->thread.regs) {
>>> +		struct pt_regs *regs = task_stack_page(current) + THREAD_SIZE;
>>> +		current->thread.regs = regs - 1;
>>> +	}
>>> +
>>> +}
>>> +#else
>>> +void arch_setup_new_exec(void)
>>> +{
>>> +	/*
>>> +	 * If we exec out of a kernel thread then thread.regs will not be
>>> +	 * set.  Do it now.
>>> +	 */
>>> +	if (!current->thread.regs) {
>>> +		struct pt_regs *regs = task_stack_page(current) + THREAD_SIZE;
>>> +		current->thread.regs = regs - 1;
>>> +	}
>>>    }
>>> +
>>>    #endif
>>
>> No need to duplicate arch_setup_new_exec() I think. radix_enabled() is defined at all time so the
>> first function should be valid at all time.
>>
> 
> arch/powerpc/kernel/process.c: In function ‘arch_setup_new_exec’:
> arch/powerpc/kernel/process.c:1529:3: error: implicit declaration of function ‘hash__setup_new_exec’; did you mean ‘arch_setup_new_exec’? [-Werror=implicit-function-declaration]
>   1529 |   hash__setup_new_exec();
>        |   ^~~~~~~~~~~~~~~~~~~~
>        |   arch_setup_new_exec
> 
> 
> That requires us to have hash__setup_new_exec prototype for all platforms.

Yes indeed.

So maybe, just enclose that part in the #ifdef instead of duplicating the common part ?

Christophe
