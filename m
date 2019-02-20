Return-Path: <SRS0=+mMX=Q3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 380BEC43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 14:06:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66F762146E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 14:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="oJ1ysyAB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66F762146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 444KCj01qWzDqDf
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 01:06:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="oJ1ysyAB"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 444K554bMqzDqCK
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Feb 2019 01:00:57 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 444K4y27Bxz9v1sm;
 Wed, 20 Feb 2019 15:00:50 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=oJ1ysyAB; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id vsIyKQq7uP3j; Wed, 20 Feb 2019 15:00:50 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 444K4y0wDRz9tytY;
 Wed, 20 Feb 2019 15:00:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1550671250; bh=l2Kfp0ntAhfmzSV1LpY3r8+PYSArHohnOEgSuMVpmA4=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=oJ1ysyABl+p02mEI3bIVPajP7S6a2g/5eC0d5JxBoYEY1cTHUPDwYQvF0UTuN43xJ
 GU1rb55DKciQP5D8kbJokJkMGvbW2/MbisxQPa94h4vIJ6YljJjuHC0bDy2+c4l7tS
 4zO7BSxQedOlj+mEAecfq2hsPYkb6JLORWfhxR2k=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 7C1958B83A;
 Wed, 20 Feb 2019 15:00:51 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id GhqVACHw-eFX; Wed, 20 Feb 2019 15:00:51 +0100 (CET)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 371C78B812;
 Wed, 20 Feb 2019 15:00:51 +0100 (CET)
Subject: Re: [PATCH] powerpc: Move page table dump files in a dedicated
 subdirectory
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
References: <913780421c7b73d731bbbe04c215e29667f7c938.1550492751.git.christophe.leroy@c-s.fr>
 <87d0nm7f8l.fsf@concordia.ellerman.id.au>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <0f371616-0ab6-fe96-852a-323159c58572@c-s.fr>
Date: Wed, 20 Feb 2019 15:00:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <87d0nm7f8l.fsf@concordia.ellerman.id.au>
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



Le 20/02/2019 à 14:37, Michael Ellerman a écrit :
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
> 
>> This patch moves the files related to page table dump in a
>> dedicated subdirectory.
>>
>> The purpose is to clean a bit arch/powerpc/mm by regrouping
>> multiple files handling a dedicated function.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>>   arch/powerpc/Kconfig.debug                                   |  4 ----
>>   arch/powerpc/mm/Makefile                                     | 10 +---------
>>   arch/powerpc/mm/ptdump/Makefile                              |  9 +++++++++
>>   arch/powerpc/mm/{ => ptdump}/dump_bats.c                     |  0
>>   arch/powerpc/mm/{ => ptdump}/dump_hashpagetable.c            |  0
>>   arch/powerpc/mm/{ => ptdump}/dump_linuxpagetables-8xx.c      |  0
>>   arch/powerpc/mm/{ => ptdump}/dump_linuxpagetables-book3s64.c |  0
>>   arch/powerpc/mm/{ => ptdump}/dump_linuxpagetables-generic.c  |  0
>>   arch/powerpc/mm/{ => ptdump}/dump_linuxpagetables.c          |  0
>>   arch/powerpc/mm/{ => ptdump}/dump_linuxpagetables.h          |  0
>>   arch/powerpc/mm/{ => ptdump}/dump_sr.c                       |  0
>>   11 files changed, 10 insertions(+), 13 deletions(-)
>>   create mode 100644 arch/powerpc/mm/ptdump/Makefile
>>   rename arch/powerpc/mm/{ => ptdump}/dump_bats.c (100%)
>>   rename arch/powerpc/mm/{ => ptdump}/dump_hashpagetable.c (100%)
>>   rename arch/powerpc/mm/{ => ptdump}/dump_linuxpagetables-8xx.c (100%)
>>   rename arch/powerpc/mm/{ => ptdump}/dump_linuxpagetables-book3s64.c (100%)
>>   rename arch/powerpc/mm/{ => ptdump}/dump_linuxpagetables-generic.c (100%)
>>   rename arch/powerpc/mm/{ => ptdump}/dump_linuxpagetables.c (100%)
>>   rename arch/powerpc/mm/{ => ptdump}/dump_linuxpagetables.h (100%)
>>   rename arch/powerpc/mm/{ => ptdump}/dump_sr.c (100%)
> 
> I'd like to shorten the file names as well, now that they're namespaced
> in the ptdump directory, how about:
> 
>   arch/powerpc/Kconfig.debug                                             |  4 ----
>   arch/powerpc/mm/Makefile                                               | 10 +---------
>   arch/powerpc/mm/{dump_linuxpagetables-8xx.c => ptdump/8xx.c}           |  2 +-
>   arch/powerpc/mm/ptdump/Makefile                                        |  9 +++++++++
>   arch/powerpc/mm/{dump_bats.c => ptdump/bats.c}                         |  0
>   arch/powerpc/mm/{dump_linuxpagetables-book3s64.c => ptdump/book3s64.c} |  2 +-
>   arch/powerpc/mm/{dump_hashpagetable.c => ptdump/hashpagetable.c}       |  0
>   arch/powerpc/mm/{dump_linuxpagetables.c => ptdump/ptdump.c}            |  2 +-
>   arch/powerpc/mm/{dump_linuxpagetables.h => ptdump/ptdump.h}            |  0
>   arch/powerpc/mm/{dump_sr.c => ptdump/segment_regs.c}                   |  0
>   arch/powerpc/mm/{dump_linuxpagetables-generic.c => ptdump/shared.c}    |  2 +-

Yes good idea. Do you want a v2 or will you do it ?

Christophe

> 
> 
> cheers
> 
