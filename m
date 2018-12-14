Return-Path: <SRS0=7E7R=OX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2ECDC67839
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Dec 2018 08:04:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DEFA2080F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Dec 2018 08:04:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DEFA2080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43GNNl6h3rzDrJs
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Dec 2018 19:04:07 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 43GNLG46M2zDrDq
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Dec 2018 19:01:57 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43GNL74xnwz9vGy9;
 Fri, 14 Dec 2018 09:01:51 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 1YohcOmq4HKZ; Fri, 14 Dec 2018 09:01:51 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43GNL74CS4z9vGy8;
 Fri, 14 Dec 2018 09:01:51 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 88AF98B89E;
 Fri, 14 Dec 2018 09:01:52 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id gaXjU-IdF9US; Fri, 14 Dec 2018 09:01:52 +0100 (CET)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 48D898B89B;
 Fri, 14 Dec 2018 09:01:52 +0100 (CET)
Subject: Re: [PATCH] powerpc/mm: make NULL pointer deferences explicit on bad
 page faults.
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
References: <42e7e2e9b74af526523fb5a1451fdb29cfe2687a.1539060806.git.christophe.leroy@c-s.fr>
 <87zht9udqh.fsf@concordia.ellerman.id.au>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <276439ce-aad9-e72f-7bc9-c57fb4a59339@c-s.fr>
Date: Fri, 14 Dec 2018 09:01:52 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <87zht9udqh.fsf@concordia.ellerman.id.au>
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Michael,

Le 14/12/2018 à 01:57, Michael Ellerman a écrit :
> Hi Christophe,
> 
> You know it's the trivial patches that are going to get lots of review
> comments :)

I'm so happy to get comments.

> 
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>> As several other arches including x86, this patch makes it explicit
>> that a bad page fault is a NULL pointer dereference when the fault
>> address is lower than PAGE_SIZE
> 
> I'm being pedantic, but it's not necessarily a NULL pointer dereference.
> It might just be a direct access to a low address, eg:
> 
>   char *p = 0x100;
>   *p = 0;
> 
> That's not a NULL pointer dereference.
> 
> But other arches do print this so I guess it's OK to add, and in most
> cases it will be an actual NULL pointer dereference.
> 
> I wonder though if we should use 4096 rather than PAGE_SIZE, given
> that's the actual value other arches are using. We support 256K pages on
> some systems, which is getting quite large.

Those invalid accesses are catched because the first page is marked non 
present or non accessible in the page table, so I thing using PAGE_SIZE 
here is valid regardless of the page size.

Looks like the arches have PAGE_SHIFT ranging from 12 to 16 mainly.

> 
>> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
>> index d51cf5f4e45e..501a1eadb3e9 100644
>> --- a/arch/powerpc/mm/fault.c
>> +++ b/arch/powerpc/mm/fault.c
>> @@ -631,13 +631,16 @@ void bad_page_fault(struct pt_regs *regs, unsigned long address, int sig)
>>   	switch (TRAP(regs)) {
>>   	case 0x300:
>>   	case 0x380:
>> -		printk(KERN_ALERT "Unable to handle kernel paging request for "
>> -			"data at address 0x%08lx\n", regs->dar);
>> +		pr_alert("Unable to handle kernel %s for data at address 0x%08lx\n",
>> +			 regs->dar < PAGE_SIZE ? "NULL pointer dereference" :
>> +						 "paging request",
>> +			 regs->dar);
> 
> This is now too long I think, with printk time you get:
> 
> [ 1096.450711] Unable to handle kernel NULL pointer dereference for data at address 0x00000000
> 
> Which is 93 columns. It's true on many systems it doesn't really matter
> any more, but it would still be good if it was shorter.
> 
> I like that on x86 they prefix it with "BUG:", just to avoid any confusion.
> 
> What if we had for the NULL pointer case:
> 
>    BUG: Kernel NULL pointer dereference at 0x00000000
> 
> And for the normal case:
> 
>    BUG: Unable to handle kernel data access at 0x00000000
> 
> Note on the very next line we print:
>    Faulting instruction address: 0xc000000000795cc8
> 
> So there should be no confusion about whether "at" refers to the data
> address or the instruction address.

Agreed

> 
>>   	case 0x400:
>>   	case 0x480:
>> -		printk(KERN_ALERT "Unable to handle kernel paging request for "
>> -			"instruction fetch\n");
>> +		pr_alert("Unable to handle kernel %s for instruction fetch\n",
>> +			 regs->nip < PAGE_SIZE ? "NULL pointer dereference" :
>> +						 "paging request");
> 
> I don't really like using "NULL pointer dereference" here, that
> terminology makes me think of a load/store, I think it confuses things
> rather than making it clearer.
> 
> What about:
> 
>    BUG: Unable to handle kernel instruction fetch at 0x00000000

I think we still need to make it explicit that we jumped there due to a 
NULL function pointer, allthought I don't have a good text idea yet for 
this.

> 
> 
>>   		break;
>>   	case 0x600:
>>   		printk(KERN_ALERT "Unable to handle kernel paging request for "
> 
> It would be good to clean up these other cases as well. They seem to be
> trying to use the "page request for" terminology which leads to them
> being very wordy. I assume that was done to help people grepping kernel
> logs for errors, but I think we should not worry about that if we have
> the "BUG:" prefix.
> 
> So we have:
> 	printk(KERN_ALERT "Unable to handle kernel paging request for "
> 		"unaligned access at address 0x%08lx\n", regs->dar);
> 
> What about:
> 
>    BUG: Unable to handle kernel unaligned access at 0x00000000
> 
> And:
> 	printk(KERN_ALERT "Unable to handle kernel paging request for "
> 		"unknown fault\n");
> 
> What about:
> 
>    BUG: Unable to handle unknown paging fault at 0x00000000
> 
> 
> Thoughts?

Looks like good ideas I'll carry on.

Christophe
