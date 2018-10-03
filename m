Return-Path: <SRS0=1oDC=MP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBEF4C00449
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 06:50:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53D0620835
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 06:50:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53D0620835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Q69D4GfVzF3Qv
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 16:50:40 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Q63F6MjBzF3Kk
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Oct 2018 16:45:29 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 42Q63B29l9z9ttBf;
 Wed,  3 Oct 2018 08:45:26 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id DfpDUv8INvGS; Wed,  3 Oct 2018 08:45:26 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 42Q63B1Ptqz9ttBW;
 Wed,  3 Oct 2018 08:45:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 688018B74C;
 Wed,  3 Oct 2018 08:45:26 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 0SsFmtUpynbv; Wed,  3 Oct 2018 08:45:26 +0200 (CEST)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.3])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id CEC7C8B8B9;
 Wed,  3 Oct 2018 08:45:25 +0200 (CEST)
Subject: Re: [RFC PATCH v3 4/7] powerpc: regain entire stack space
To: Nicholas Piggin <npiggin@gmail.com>
References: <cover.1538396658.git.christophe.leroy@c-s.fr>
 <8108de51846b7b34e4732753b2b65e435b6a2b7a.1538396659.git.christophe.leroy@c-s.fr>
 <20181003153448.3fb64e19@roar.ozlabs.ibm.com>
 <6a539614-abb6-d468-ccba-2e3c1fb8b680@c-s.fr>
 <20181003163024.281254bf@roar.ozlabs.ibm.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <38d58749-c058-a6d7-1ca2-23abe9dd34a3@c-s.fr>
Date: Wed, 3 Oct 2018 08:45:25 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181003163024.281254bf@roar.ozlabs.ibm.com>
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
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 aneesh.kumar@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 03/10/2018 à 08:30, Nicholas Piggin a écrit :
> On Wed, 3 Oct 2018 07:52:59 +0200
> Christophe LEROY <christophe.leroy@c-s.fr> wrote:
> 
>> Le 03/10/2018 à 07:34, Nicholas Piggin a écrit :
>>> On Mon,  1 Oct 2018 12:30:25 +0000 (UTC)
>>> Christophe Leroy <christophe.leroy@c-s.fr> wrote:
>>>    
>>>> thread_info is not anymore in the stack, so the entire stack
>>>> can now be used.
>>>
>>> Nice.
>>>    
>>>>
>>>> In the meantime, all pointers to the stacks are not anymore
>>>> pointers to thread_info so this patch changes them to void*
>>>
>>> Wasn't this previously effectively already the case with patch
>>> 3/7? You had thread_info sized space left there, but it was not
>>> used or initialized right? Does it make sense to move this part
>>> of it to the previous patch?
>>
>> Not really.
>>
>> In 3/7 I changed the prototypes of two functions that really used the
>> pointer as a task pointer only.

I meant 2/7 here sorry.

>>
>> Here it change things that before 4/7 were really used as both stack
>> pointers and thread_info pointers.

And here I meant 3/7

> 
> What uses it as a thread_info pointer? It seems more like a stack
> with some amount of unused space in it but that's all.

Before 3/7, we have

void do_softirq_own_stack(void)
{
	struct thread_info *curtp, *irqtp;

	curtp = current_thread_info();
	irqtp = softirq_ctx[smp_processor_id()];
	irqtp->task = curtp->task;
	irqtp->flags = 0;
	call_do_softirq(irqtp);
	irqtp->task = NULL;

	/* Set any flag that may have been set on the
	 * alternate stack
	 */
	if (irqtp->flags)
		set_bits(irqtp->flags, &curtp->flags);
}

After 3/7, we have

  void do_softirq_own_stack(void)
  {
	struct thread_info *irqtp;

  	irqtp = softirq_ctx[smp_processor_id()];
  	call_do_softirq(irqtp);
  }


So now only we can change irqtp to void* can't we ?

> 
> That said I don't care to nitpick too much where things go exactly
> if you like it better here that's fine.

No worry, I may have missed something, your comments are always welcome.

Thanks
Christophe

> 
> Thanks,
> Nick
> 
