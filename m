Return-Path: <SRS0=3Onk=JS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC542C433B4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Apr 2021 05:16:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C36F061182
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Apr 2021 05:16:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C36F061182
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FQ8161b0qz2yyb
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Apr 2021 15:16:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FQ80k6XJVz2y0B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Apr 2021 15:16:22 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4FQ80g3fKKzB09Zn;
 Wed, 21 Apr 2021 07:16:19 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id jT86auJ0Oz4z; Wed, 21 Apr 2021 07:16:19 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4FQ80g2rcszB09Zm;
 Wed, 21 Apr 2021 07:16:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 2BFF88B814;
 Wed, 21 Apr 2021 07:16:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id NEQhXkRjVj-D; Wed, 21 Apr 2021 07:16:20 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 9847B8B770;
 Wed, 21 Apr 2021 07:16:19 +0200 (CEST)
Subject: Re: [PATCH v10 06/10] powerpc/mm/ptdump: debugfs handler for W+X
 checks at runtime
To: Jordan Niethe <jniethe5@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>
References: <20210330045132.722243-1-jniethe5@gmail.com>
 <20210330045132.722243-7-jniethe5@gmail.com>
 <87im577eh3.fsf@mpe.ellerman.id.au>
 <CACzsE9pgZRaoHT0Ca=NB3srEMJMvLuiFkYA98xFDiUPyfmoV5Q@mail.gmail.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <825f6dc7-637a-dab3-f659-db5b62a9f73d@csgroup.eu>
Date: Wed, 21 Apr 2021 07:16:16 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <CACzsE9pgZRaoHT0Ca=NB3srEMJMvLuiFkYA98xFDiUPyfmoV5Q@mail.gmail.com>
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
Cc: ajd@linux.ibm.com, Kees Cook <keescook@chromium.org>,
 Nicholas Piggin <npiggin@gmail.com>, cmr@codefail.de,
 naveen.n.rao@linux.ibm.com, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Daniel Axtens <dja@axtens.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 21/04/2021 à 04:23, Jordan Niethe a écrit :
> On Wed, Mar 31, 2021 at 10:24 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>>
>> Jordan Niethe <jniethe5@gmail.com> writes:
>>> From: Russell Currey <ruscur@russell.cc>
>>>
>>> Optionally run W+X checks when dumping pagetable information to
>>> debugfs' kernel_page_tables.
>>>
>>> To use:
>>>      $ echo 1 > /sys/kernel/debug/check_wx_pages
>>>      $ cat /sys/kernel/debug/kernel_page_tables
>>>
>>> and check the kernel log.  Useful for testing strict module RWX.
>>>
>>> To disable W+X checks:
>>>        $ echo 0 > /sys/kernel/debug/check_wx_pages
>>>
>>> Update the Kconfig entry to reflect this.
>>>
>>> Also fix a typo.
>>>
>>> Reviewed-by: Kees Cook <keescook@chromium.org>
>>> Signed-off-by: Russell Currey <ruscur@russell.cc>
>>> [jpn: Change check_wx_pages to act as mode bit affecting
>>>        kernel_page_tables instead of triggering action on its own]
>>> Signed-off-by: Jordan Niethe <jniethe5@gmail.com>
>>> ---
>>> v10: check_wx_pages now affects kernel_page_tables rather then triggers
>>>       its own action.
>>
>> Hmm. I liked the old version better :)
>>
>> I think you changed it based on Christophe's comment:
>>
>>    Why not just perform the test everytime someone dumps kernel_page_tables ?
>>
>>
>> But I think he meant *always* do the check when someone dumps
>> kernel_page_tables, not have another file to enable checking and then
>> require someone to dump kernel_page_tables to do the actual check.
> Yes, I guess I misinterpreted that.
>>
>> Still I like the previous version where you can do the checks
>> separately, without having to dump the page tables, because dumping can
>> sometimes take quite a while.
>>
>> What would be even better is if ptdump_check_wx() returned an error when
>> wx pages were found, and that was plumbed out to the debugs file. That
>> way you can script around it.
> Ok I'll go back to how it was and add in returning an error.

I have a series to convert PPC_PTDUMP into GENERIC_PTDUMP, see 
https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=239795

>>
>> cheers
