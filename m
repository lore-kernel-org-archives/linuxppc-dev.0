Return-Path: <SRS0=ZLNG=CD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 809A6C433DF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 25 Aug 2020 12:09:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E15B220706
	for <linuxppc-dev@archiver.kernel.org>; Tue, 25 Aug 2020 12:09:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E15B220706
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BbSTH6qvZzDqWb
	for <linuxppc-dev@archiver.kernel.org>; Tue, 25 Aug 2020 22:09:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=csgroup.eu
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BbSQQ31T5zDqT3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Aug 2020 22:06:35 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4BbSQF70Pmz9txtG;
 Tue, 25 Aug 2020 14:06:29 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 8AaT7tXaia4q; Tue, 25 Aug 2020 14:06:29 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4BbSQF5K6zz9txtB;
 Tue, 25 Aug 2020 14:06:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 0E4628B814;
 Tue, 25 Aug 2020 14:06:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 0TBW-9nZB4Hz; Tue, 25 Aug 2020 14:06:30 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 491A78B812;
 Tue, 25 Aug 2020 14:06:30 +0200 (CEST)
Subject: Re: [PATCH v5 5/8] powerpc/watchpoint: Fix exception handling for
 CONFIG_HAVE_HW_BREAKPOINT=N
To: Ravi Bangoria <ravi.bangoria@linux.ibm.com>, christophe.leroy@c-s.fr
References: <20200825043617.1073634-1-ravi.bangoria@linux.ibm.com>
 <20200825043617.1073634-6-ravi.bangoria@linux.ibm.com>
 <91d34b89-603a-fddc-ea0f-53a79b287eed@csgroup.eu>
 <1e706137-3de9-a713-5a86-48fbc5e6f740@linux.ibm.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <aeff0680-d260-26ab-9f32-ac6ac1df2df3@csgroup.eu>
Date: Tue, 25 Aug 2020 14:06:21 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1e706137-3de9-a713-5a86-48fbc5e6f740@linux.ibm.com>
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



Le 25/08/2020 à 13:07, Ravi Bangoria a écrit :
> Hi Christophe,
> 
>>> diff --git a/arch/powerpc/kernel/ptrace/ptrace-noadv.c 
>>> b/arch/powerpc/kernel/ptrace/ptrace-noadv.c
>>> index 57a0ab822334..866597b407bc 100644
>>> --- a/arch/powerpc/kernel/ptrace/ptrace-noadv.c
>>> +++ b/arch/powerpc/kernel/ptrace/ptrace-noadv.c
>>> @@ -286,11 +286,16 @@ long ppc_del_hwdebug(struct task_struct *child, 
>>> long data)
>>>       }
>>>       return ret;
>>>   #else /* CONFIG_HAVE_HW_BREAKPOINT */
>>> +    if (child->thread.hw_brk[data - 1].flags & HW_BRK_FLAG_DISABLED)
>>
>> I think child->thread.hw_brk[data - 1].flags & HW_BRK_FLAG_DISABLED 
>> should go around additionnal ()
> 
> Not sure I follow.

Neither do I ....

I thought that GCC would emit a warning for that, but in fact it only 
emit warnings for things like:

	if (flags & HW_BRK_FLAG_DISABLED == HW_BRK_FLAG_DISABLED)

> 
>>
>>> +        goto del;
>>> +
>>>       if (child->thread.hw_brk[data - 1].address == 0)
>>>           return -ENOENT;
>>
>> What about replacing the above if by:
>>      if (!(child->thread.hw_brk[data - 1].flags) & 
>> HW_BRK_FLAG_DISABLED) &&
>>          child->thread.hw_brk[data - 1].address == 0)
>>          return -ENOENT;
> okay.. that's more compact.
> 
> But more importantly, what I wanted to know is whether 
> CONFIG_HAVE_HW_BREAKPOINT
> is set or not in production/distro builds for 8xx. Because I see it's 
> not set in
> 8xx defconfigs.

Yes in our production configs with have CONFIG_PERF_EVENTS, that implies 
CONFIG_HAVE_HW_BREAKPOINT

Christophe
