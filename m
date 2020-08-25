Return-Path: <SRS0=ZLNG=CD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2618C433DF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 25 Aug 2020 11:50:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B73E20706
	for <linuxppc-dev@archiver.kernel.org>; Tue, 25 Aug 2020 11:50:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B73E20706
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BbS452d5QzDqQf
	for <linuxppc-dev@archiver.kernel.org>; Tue, 25 Aug 2020 21:50:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=csgroup.eu
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BbS1p2zHnzDqCb
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Aug 2020 21:48:44 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4BbS1g3yCQz9tybg;
 Tue, 25 Aug 2020 13:48:39 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id P61qFMU1aYgl; Tue, 25 Aug 2020 13:48:39 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4BbS1g31k8z9tybd;
 Tue, 25 Aug 2020 13:48:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id A4CCB8B815;
 Tue, 25 Aug 2020 13:48:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id XBPx8gicxpnc; Tue, 25 Aug 2020 13:48:40 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id DFC4E8B80B;
 Tue, 25 Aug 2020 13:48:39 +0200 (CEST)
Subject: Re: [PATCH v5 4/8] powerpc/watchpoint: Move DAWR detection logic
 outside of hw_breakpoint.c
To: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20200825043617.1073634-1-ravi.bangoria@linux.ibm.com>
 <20200825043617.1073634-5-ravi.bangoria@linux.ibm.com>
 <0a73280b-c231-a7bb-18d9-abf2a37ba24b@csgroup.eu>
 <59ac33ed-4ed3-2c92-7b0b-1d14abf7186b@linux.ibm.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <f9bda668-01e7-8e72-100c-6c8ad40a63e9@csgroup.eu>
Date: Tue, 25 Aug 2020 13:48:24 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <59ac33ed-4ed3-2c92-7b0b-1d14abf7186b@linux.ibm.com>
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
Cc: mikey@neuling.org, pedromfc@linux.ibm.com, linux-kernel@vger.kernel.org,
 paulus@samba.org, jniethe5@gmail.com, rogealve@linux.ibm.com,
 naveen.n.rao@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 25/08/2020 à 13:08, Ravi Bangoria a écrit :
> Hi Christophe,
> 
>>> +static int cache_op_size(void)
>>> +{
>>> +#ifdef __powerpc64__
>>> +    return ppc64_caches.l1d.block_size;
>>> +#else
>>> +    return L1_CACHE_BYTES;
>>> +#endif
>>> +}
>>
>> You've got l1_dcache_bytes() in arch/powerpc/include/asm/cache.h to do 
>> that.
>>
>>> +
>>> +void wp_get_instr_detail(struct pt_regs *regs, struct ppc_inst *instr,
>>> +             int *type, int *size, unsigned long *ea)
>>> +{
>>> +    struct instruction_op op;
>>> +
>>> +    if (__get_user_instr_inatomic(*instr, (void __user *)regs->nip))
>>> +        return;
>>> +
>>> +    analyse_instr(&op, regs, *instr);
>>> +    *type = GETTYPE(op.type);
>>> +    *ea = op.ea;
>>> +#ifdef __powerpc64__
>>> +    if (!(regs->msr & MSR_64BIT))
>>> +        *ea &= 0xffffffffUL;
>>> +#endif
>>
>> This #ifdef is unneeded, it should build fine on a 32 bits too.
> 
> This patch is just a code movement from one file to another.
> I don't really change the logic. Would you mind if I do a
> separate patch for these changes (not a part of this series)?

Sure, do it in a separate patch.

Christophe
