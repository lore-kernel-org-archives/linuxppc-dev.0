Return-Path: <SRS0=VXin=M6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D068ECDE43
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Oct 2018 11:21:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5F3E2087A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Oct 2018 11:21:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5F3E2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42bRSK55K8zF3LS
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Oct 2018 22:21:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42bRPS3KdnzF3HY
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Oct 2018 22:18:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 42bRPR70s0z8svF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Oct 2018 22:18:35 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 42bRPR5B6Cz9s9h; Thu, 18 Oct 2018 22:18:35 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 42bRPQ3sXtz9s8r
 for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2018 22:18:33 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 42bRPM0MHZz9ttF8;
 Thu, 18 Oct 2018 13:18:31 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 6JBaIJCzducc; Thu, 18 Oct 2018 13:18:30 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 42bRPL6vv2z9ttBS;
 Thu, 18 Oct 2018 13:18:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id A66458B8BB;
 Thu, 18 Oct 2018 13:18:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 1Hc-u2jFpSjP; Thu, 18 Oct 2018 13:18:30 +0200 (CEST)
Received: from PO15451 (unknown [192.168.232.3])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 7474F8B8AB;
 Thu, 18 Oct 2018 13:18:29 +0200 (CEST)
Subject: Re: [PATCH] powerpc: Don't print kernel instructions in
 show_user_instructions()
To: Jann Horn <jannh@google.com>
References: <20181005132123.6038-1-mpe@ellerman.id.au>
 <6b3b54e5-cbe3-c693-23ea-26928e7597c8@c-s.fr>
 <CAG48ez2C9M8zgmubC2DLwqWzS7WzUj=nKhUuT4KkfWwS4v1Dig@mail.gmail.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <73bd3821-2d5d-39f6-4d23-f8eae6d74cb3@c-s.fr>
Date: Thu, 18 Oct 2018 13:18:28 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAG48ez2C9M8zgmubC2DLwqWzS7WzUj=nKhUuT4KkfWwS4v1Dig@mail.gmail.com>
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
Cc: muriloo@linux.ibm.com, linuxppc-dev@ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 18/10/2018 à 13:12, Jann Horn a écrit :
> On Thu, Oct 18, 2018 at 11:28 AM Christophe LEROY
> <christophe.leroy@c-s.fr> wrote:
>> Le 05/10/2018 à 15:21, Michael Ellerman a écrit :
>>> Recently we implemented show_user_instructions() which dumps the code
>>> around the NIP when a user space process dies with an unhandled
>>> signal. This was modelled on the x86 code, and we even went so far as
>>> to implement the exact same bug, namely that if the user process
>>> crashed with its NIP pointing into the kernel we will dump kernel text
>>> to dmesg. eg:
>>>
>>>     bad-bctr[2996]: segfault (11) at c000000000010000 nip c000000000010000 lr 12d0b0894 code 1
>>>     bad-bctr[2996]: code: fbe10068 7cbe2b78 7c7f1b78 fb610048 38a10028 38810020 fb810050 7f8802a6
>>>     bad-bctr[2996]: code: 3860001c f8010080 48242371 60000000 <7c7b1b79> 4082002c e8010080 eb610048
>>>
>>> This was discovered on x86 by Jann Horn and fixed in commit
>>> 342db04ae712 ("x86/dumpstack: Don't dump kernel memory based on usermode RIP").
>>>
>>> Fix it by checking the adjusted NIP value (pc) and number of
>>> instructions against USER_DS, and bail if we fail the check, eg:
>>>
>>>     bad-bctr[2969]: segfault (11) at c000000000010000 nip c000000000010000 lr 107930894 code 1
>>>     bad-bctr[2969]: Bad NIP, not dumping instructions.
>>>
>>> Fixes: 88b0fe175735 ("powerpc: Add show_user_instructions()")
>>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>>> ---
>>>    arch/powerpc/kernel/process.c | 10 ++++++++++
>>>    1 file changed, 10 insertions(+)
>>>
>>> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
>>> index 913c5725cdb2..bb6ac471a784 100644
>>> --- a/arch/powerpc/kernel/process.c
>>> +++ b/arch/powerpc/kernel/process.c
>>> @@ -1306,6 +1306,16 @@ void show_user_instructions(struct pt_regs *regs)
>>>
>>>        pc = regs->nip - (instructions_to_print * 3 / 4 * sizeof(int));
>>>
>>> +     /*
>>> +      * Make sure the NIP points at userspace, not kernel text/data or
>>> +      * elsewhere.
>>> +      */
>>> +     if (!__access_ok(pc, instructions_to_print * sizeof(int), USER_DS)) {
>>> +             pr_info("%s[%d]: Bad NIP, not dumping instructions.\n",
>>> +                     current->comm, current->pid);
>>> +             return;
>>> +     }
>>> +
>>
>> Is there any reason for not using access_ok() here ?
> 
> It's probably more robust this way, in case someone decides to call
> into this from kernel exception context at some point, or something
> like that?
> 

But access_ok() uses current->thread.addr_limit, while USER_DS may 
provide a larger segment:

#ifdef __powerpc64__
/* We use TASK_SIZE_USER64 as TASK_SIZE is not constant */
#define USER_DS		MAKE_MM_SEG(TASK_SIZE_USER64 - 1)
#else
#define USER_DS		MAKE_MM_SEG(TASK_SIZE - 1)
#endif

Christophe
