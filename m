Return-Path: <SRS0=AY7V=64=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C00C433E2
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 May 2020 13:00:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C124020728
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 May 2020 13:00:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C124020728
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49NBV25PFczDqmF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 May 2020 23:00:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=csgroup.eu
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49NBRQ2fPTzDqm6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2020 22:57:57 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 49NBR14QqDz9v00P;
 Thu, 14 May 2020 14:57:49 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id FmsWBXfN5yWv; Thu, 14 May 2020 14:57:49 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 49NBR13dM3z9v00N;
 Thu, 14 May 2020 14:57:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 68C9B8B845;
 Thu, 14 May 2020 14:57:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id iTGl6KQzQe-B; Thu, 14 May 2020 14:57:51 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id C94E98B849;
 Thu, 14 May 2020 14:57:50 +0200 (CEST)
Subject: Re: [PATCH v8 23/30] powerpc: Add prefixed instructions to
 instruction data type
To: Alistair Popple <alistair@popple.id.au>
References: <20200506034050.24806-1-jniethe5@gmail.com>
 <20200506034050.24806-24-jniethe5@gmail.com>
 <56ca6bcb-c719-a049-63b0-aae73023bde5@csgroup.eu>
 <1850220.JuIOMCfrUL@townsend>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <c3efa315-9d56-6fe8-2a46-15b1e05f65ce@csgroup.eu>
Date: Thu, 14 May 2020 14:57:50 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1850220.JuIOMCfrUL@townsend>
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
Cc: christophe.leroy@c-s.fr, Jordan Niethe <jniethe5@gmail.com>,
 npiggin@gmail.com, bala24@linux.ibm.com, naveen.n.rao@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, dja@axtens.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 14/05/2020 à 14:06, Alistair Popple a écrit :
> On Thursday, 14 May 2020 4:11:43 PM AEST Christophe Leroy wrote:
>> @@ -249,7 +249,7 @@ int arch_prepare_optimized_kprobe(struct
>> optimized_kprobe *op, struct kprobe *p)
>>> * Fixup the template with instructions to:
>>> * 1. load the address of the actual probepoint
>>> */
>>> -       patch_imm64_load_insns((unsigned long)op, buff + TMPL_OP_IDX);
>>> +       patch_imm64_load_insns((unsigned long)op, 3, buff + TMPL_OP_IDX);
>>>
>>> /*
>>> * 2. branch to optimized_callback() and emulate_step()
>>> @@ -282,7 +282,11 @@ int arch_prepare_optimized_kprobe(struct
>>> optimized_kprobe *op, struct kprobe *p) /*
>>> * 3. load instruction to be emulated into relevant register, and
>>> */
>>> -       patch_imm32_load_insns(*p->ainsn.insn, buff + TMPL_INSN_IDX);
>>> +       temp = ppc_inst_read((struct ppc_inst *)p->ainsn.insn);
>>> +       patch_imm64_load_insns(ppc_inst_val(temp) |
>>> +                              ((u64)ppc_inst_suffix(temp) << 32),
>>> +                              4,
>>
>> So now we are also using r4 ? Any explanation somewhere on the way it
>> works ? This change seems unrelated to this patch, nothing in the
>> description about it. Can we suddenly use a new register without problem ?
> 
> Unless I missed something there is no change in register usage here that I
> could see. patch_imm32_load_insns() was/is hardcoded to use register r4.
> 

Ah ... Euh ... Ok I missed the change from patch_imm32_load_insns() to 
patch_imm64_load_insns(), I'll check again.
