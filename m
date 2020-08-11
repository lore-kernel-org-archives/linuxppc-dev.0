Return-Path: <SRS0=HEEy=BV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07749C433DF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Aug 2020 14:39:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC7CD204FD
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Aug 2020 14:39:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC7CD204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BQwSn5bVkzDqBW
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Aug 2020 00:39:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=csgroup.eu
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BQvlh6ZfxzDqQB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Aug 2020 00:06:53 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4BQvlX2VjCz9vCqh;
 Tue, 11 Aug 2020 16:06:48 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id uyiEbRNZdcYa; Tue, 11 Aug 2020 16:06:48 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4BQvlX0t4Fz9vCqm;
 Tue, 11 Aug 2020 16:06:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 8B6608BB80;
 Tue, 11 Aug 2020 16:06:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id LEGyWSBRNps0; Tue, 11 Aug 2020 16:06:49 +0200 (CEST)
Received: from [172.25.230.100] (po15451.idsi0.si.c-s.fr [172.25.230.100])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 3238A8BB86;
 Tue, 11 Aug 2020 16:06:49 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [RFC PATCH v1] power: don't manage floating point regs when no FPU
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
References: <95c00a811897f6d9176d30bf2ac92dab8c9c8e95.1596816789.git.christophe.leroy@csgroup.eu>
 <87o8nh9yjd.fsf@mpe.ellerman.id.au>
Message-ID: <da699207-b172-cf12-a04f-4444313e3e27@csgroup.eu>
Date: Tue, 11 Aug 2020 16:06:44 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <87o8nh9yjd.fsf@mpe.ellerman.id.au>
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



Le 11/08/2020 à 14:07, Michael Ellerman a écrit :
> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
>>   10 files changed, 44 insertions(+), 1 deletion(-)
> 
> In general this looks fine.
> 
> It's a bit #ifdef heavy. Maybe some of those can be cleaned up a bit
> with some wrapper inlines?

Looking at it once more, looks like more or less the same level of 
#ifdefs as things like CONFIG_ALTIVEC for instance. I can't really see 
much opportunities to clean it up.

> 
>> diff --git a/arch/powerpc/kernel/ptrace/ptrace-novsx.c b/arch/powerpc/kernel/ptrace/ptrace-novsx.c
>> index b2dc4e92d11a..8f87a11f3f8c 100644
>> --- a/arch/powerpc/kernel/ptrace/ptrace-novsx.c
>> +++ b/arch/powerpc/kernel/ptrace/ptrace-novsx.c
>> @@ -28,6 +29,9 @@ int fpr_get(struct task_struct *target, const struct user_regset *regset,
>>   
>>   	return user_regset_copyout(&pos, &count, &kbuf, &ubuf,
>>   				   &target->thread.fp_state, 0, -1);
>> +#else
>> +	return 0;
>> +#endif
> 
> Should we return -ENODEV/EIO here? Wonder if another arch can give us a clue.
> 

Looks like we have to do another way  ... another #ifdef ... in the 
definition of native_regsets[] in ptrace-view.c . And then we should be 
able to not build ptrace-novsx.c at all. Will try that.

Christophe
