Return-Path: <SRS0=eC6l=QW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E123C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 08:23:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B8E621920
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 08:23:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="HDBvQ3lC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B8E621920
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4415qV10XlzDqdj
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 19:23:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="HDBvQ3lC"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4415nl3z77zDqd9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2019 19:21:31 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4415nf64syz9v06c;
 Fri, 15 Feb 2019 09:21:26 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=HDBvQ3lC; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id GP5lxgM4wh20; Fri, 15 Feb 2019 09:21:26 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4415nf4pyFz9v06N;
 Fri, 15 Feb 2019 09:21:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1550218886; bh=1G9Ns0UGJwdSJy3lK8mH6rG3q6ccb8+isAIwcboFFR8=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=HDBvQ3lCOVwZTz1OPukaZd2nLs4GfiMpimxWkFhW3aI87cfwV8IowszrZUZGccHYO
 +0BXPWZ/hR0fZKi9F7Fw3/mc7OO37d/7giUzEQRt33wtVZPTVmv0UywdHkIvP/bwCP
 Z14qjdUeD/3ak2Usi7N2sb/3aXKHFraJtOYjGz5M=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id A3C738B8BA;
 Fri, 15 Feb 2019 09:21:27 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id FOpHbLqgX8GZ; Fri, 15 Feb 2019 09:21:27 +0100 (CET)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 79A708B8B5;
 Fri, 15 Feb 2019 09:21:27 +0100 (CET)
Subject: Re: [PATCH] powerpc/ptrace: Add prototype for function pt_regs_check
To: Mathieu Malaterre <malat@debian.org>, Michael Ellerman <mpe@ellerman.id.au>
References: <20181208154624.6504-1-malat@debian.org>
 <CA+7wUswJy0z_+aytawQv6+1pOVvH2z8SfOz1sxziHtgjqZ1F9g@mail.gmail.com>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <e95cb3ea-019f-28b0-0af0-ad8c80b3106b@c-s.fr>
Date: Fri, 15 Feb 2019 09:21:27 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <CA+7wUswJy0z_+aytawQv6+1pOVvH2z8SfOz1sxziHtgjqZ1F9g@mail.gmail.com>
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
Cc: Paul Mackerras <paulus@samba.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Oleg Nesterov <oleg@redhat.com>,
 LKML <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 15/02/2019 à 09:11, Mathieu Malaterre a écrit :
> On Sat, Dec 8, 2018 at 4:46 PM Mathieu Malaterre <malat@debian.org> wrote:
>>
>> `pt_regs_check` is a dummy function, its purpose is to break the build
>> if struct pt_regs and struct user_pt_regs don't match.
>>
>> This function has no functionnal purpose, and will get eliminated at
>> link time or after init depending on CONFIG_LD_DEAD_CODE_DATA_ELIMINATION
>>
>> This commit adds a prototype to fix warning at W=1:
>>
>>    arch/powerpc/kernel/ptrace.c:3339:13: error: no previous prototype for ‘pt_regs_check’ [-Werror=missing-prototypes]
>>
>> Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> Signed-off-by: Mathieu Malaterre <malat@debian.org>
>> ---
>>   arch/powerpc/kernel/ptrace.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
>> index a398999d0770..341c0060b4c8 100644
>> --- a/arch/powerpc/kernel/ptrace.c
>> +++ b/arch/powerpc/kernel/ptrace.c
>> @@ -3338,6 +3338,10 @@ void do_syscall_trace_leave(struct pt_regs *regs)
>>          user_enter();
>>   }
>>
>> +void __init pt_regs_check(void);
>> +/* dummy function, its purpose is to break the build if struct pt_regs and
>> + * struct user_pt_regs don't match.
>> + */
> 
> Another trick which seems to work with GCC is:
> 
> -void __init pt_regs_check(void)
> +static inline void __init pt_regs_check(void)

Does this really work ? Did you test to ensure that the BUILD_BUG_ON 
still detect mismatch between struct pt_regs and struct user_pt_regs ?

Christophe

> 
>>   void __init pt_regs_check(void)
>>   {
>>          BUILD_BUG_ON(offsetof(struct pt_regs, gpr) !=
>> --
>> 2.19.2
>>
