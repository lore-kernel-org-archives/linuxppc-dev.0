Return-Path: <SRS0=any3=BQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1698C433E0
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Aug 2020 12:09:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97AA122D70
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Aug 2020 12:09:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97AA122D70
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BMhbt3Vx5zDqll
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Aug 2020 18:34:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=csgroup.eu
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BMhWX3nDWzDqF7
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Aug 2020 18:30:16 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4BMhWR2RVVz9v0TL;
 Thu,  6 Aug 2020 10:30:11 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id tFMet-3MCDpc; Thu,  6 Aug 2020 10:30:11 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4BMhWR1h5Wz9v0TJ;
 Thu,  6 Aug 2020 10:30:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id A447B8B7FA;
 Thu,  6 Aug 2020 10:30:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id rPm5gnB6BF8Y; Thu,  6 Aug 2020 10:30:12 +0200 (CEST)
Received: from [172.25.230.102] (po15451.idsi0.si.c-s.fr [172.25.230.102])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 741AA8B7F9;
 Thu,  6 Aug 2020 10:30:12 +0200 (CEST)
Subject: Re: [PATCH v2] powerpc/uaccess: simplify the get_fs() set_fs() logic
To: Michael Ellerman <mpe@ellerman.id.au>,
 Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
References: <dd2876b808ea38eb7b7f760ecd6ce06096c61fb5.1580295551.git.christophe.leroy@c-s.fr>
 <87mu3nyh3w.fsf@mpe.ellerman.id.au>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <2d0b777d-f1aa-08a1-f287-47ac68efbd99@csgroup.eu>
Date: Thu, 6 Aug 2020 10:29:56 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <87mu3nyh3w.fsf@mpe.ellerman.id.au>
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



Le 25/07/2020 à 13:22, Michael Ellerman a écrit :
> Hi Christophe,
> 
> Unfortunately this would collide messily with "uaccess: remove
> segment_eq" in linux-next, so I'll ask you to do a respin based on that,
> some comments below.

Done, sent as v3, together with the 2 patchs from Linux next to get it 
build and boot.

> 
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>> On powerpc, we only have USER_DS and KERNEL_DS
>>
>> Today, this is managed as an 'unsigned long' data space limit
>> which is used to compare the passed address with, plus a bit
>> in the thread_info flags that is set whenever modifying the limit
>> to enable the verification in addr_limit_user_check()
>>
>> The limit is either the last address of user space when USER_DS is
>> set, and the last address of address space when KERNEL_DS is set.
>> In both cases, the limit is a compiletime constant.
>>
>> get_fs() returns the limit, which is part of thread_info struct
>> set_fs() updates the limit then set the TI_FSCHECK flag.
>> addr_limit_user_check() check the flag, and if it is set it checks
>> the limit is the user limit, then unsets the TI_FSCHECK flag.
>>
>> In addition, when the flag is set the syscall exit work is involved.
>> This exit work is heavy compared to normal syscall exit as it goes
>> through normal exception exit instead of the fast syscall exit.
>>
>> Rename this TI_FSCHECK flag to TIF_KERNEL_DS flag which tells whether
>> KERNEL_DS or USER_DS is set. Get mm_segment_t be redifined as a bool
>> struct that is either false (for USER_DS) or true (for KERNEL_DS).
>> When TIF_KERNEL_DS is set, the limit is ~0UL. Otherwise it is
>> TASK_SIZE_USER (resp TASK_SIZE_USER64 on PPC64). When KERNEL_DS is
>> set, there is no range to check. Define TI_FSCHECK as an alias to
>> TIF_KERNEL_DS.
> 
> I'd rather avoid the "DS" name any more than we have to. Maybe it means
> "data space" but that's not a very common term.

I thought it was a reference to the ds/fs/gs ... segment registers in 
the 8086 ?

> 
> The generic helper these days is called uaccess_kernel(), which returns
> true when uaccess routines are allowed to access the kernel.
> 
> So calling it TIF_UACCESS_KERNEL would work I think?

ok

> 
> The bool could be called uaccess_kernel.
> And END_OF_USER_DS could be USER_ADDR_MAX.

ok

> 
>> On exit, involve exit work when the bit is set, i.e. when KERNEL_DS
>> is set. addr_limit_user_check() will clear the bit and kill the
>> user process.
> 
> I guess this is safe. The check was added to make sure we never return
> to userspace with KERNEL_DS set, but using the actual TIF flag to
> determine the address limit should be equally safe, and avoid the
> overhead of the check in the good case.

That's the purpose indeed, yes.


christophe
