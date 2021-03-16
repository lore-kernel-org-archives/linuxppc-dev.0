Return-Path: <SRS0=5tyt=IO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26DDEC433DB
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Mar 2021 02:04:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39F9364FCA
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Mar 2021 02:04:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39F9364FCA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DzxSG4fg0z30HJ
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Mar 2021 13:04:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.32; helo=szxga06-in.huawei.com;
 envelope-from=heying24@huawei.com; receiver=<UNKNOWN>)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DzxRt3Jl5z2yjH
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Mar 2021 13:04:23 +1100 (AEDT)
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DzxPx0JzszkZMC;
 Tue, 16 Mar 2021 10:02:45 +0800 (CST)
Received: from [10.67.110.136] (10.67.110.136) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Tue, 16 Mar 2021 10:04:09 +0800
Subject: Re: [PATCH] powerpc: Fix missing prototype problems for
 "arch/powerpc/kernel/setup_64.c"
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, <mpe@ellerman.id.au>,
 <benh@kernel.crashing.org>, <paulus@samba.org>, <npiggin@gmail.com>,
 <dja@axtens.net>, <akpm@linux-foundation.org>, <rppt@kernel.org>,
 <aneesh.kumar@linux.ibm.com>
References: <20210315120444.215905-1-heying24@huawei.com>
 <6eb1925c-a3a1-f062-29da-3a7fa946505c@csgroup.eu>
 <ddd03e30-9e54-66cd-8917-6f620557b795@huawei.com>
 <c6af9455-9a04-c93e-ac7c-3c7d6a56953a@kaod.org>
 <fe0638cc-28be-2e5c-9e94-ab3ff7666164@csgroup.eu>
 <eb78b1b0-03f9-2b20-02a7-74dbeea81493@kaod.org>
From: "heying (H)" <heying24@huawei.com>
Message-ID: <8abc9f24-4e63-f694-ba6b-56da801b45ed@huawei.com>
Date: Tue, 16 Mar 2021 10:04:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <eb78b1b0-03f9-2b20-02a7-74dbeea81493@kaod.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.136]
X-CFilter-Loop: Reflected
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
Cc: johnny.chenyi@huawei.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Dear Cédric Le Goater and Christophe Leroy,

Thanks for all your suggestions! I'll pick them in my patch and resent 
it soon.


Thanks again.


在 2021/3/15 21:14, Cédric Le Goater 写道:
> On 3/15/21 2:01 PM, Christophe Leroy wrote:
>>
>> Le 15/03/2021 à 13:57, Cédric Le Goater a écrit :
>>> On 3/15/21 1:48 PM, heying (H) wrote:
>>>> 在 2021/3/15 20:17, Christophe Leroy 写道:
>>>>> You subject doesn't match the content of the patch.
>>>> OK. I'll adapt that.
>>>>> Le 15/03/2021 à 13:04, He Ying a écrit :
>>>>>> The variables 'uaccess_fulsh' and 'entry_flush' are not referenced
>>>>>> outside the file. So define them as static to avoid the warnings.
>>>>>>
>>>>>> And add a prototype for the function 'panic_smp_self_stop' for the
>>>>>> same purpose.
>>>>>>
>>>>>> Sparse also warns that 'rfi_flush' should be static. However, it's
>>>>>> referenced outside the file.
>>>>> To clear that warning, you have to include asm/security_features.h, rfi_flush is declared there.
>>>> Do you mean that I should include this header in arch/powerpc/kernel/setup_64.c?
>>> yes.
>>>
>>>>>> The warnings about the file reported by sparse are as follows:
>>>>>> arch/powerpc/kernel/setup_64.c:422:6: warning: symbol 'panic_smp_self_stop' was not declared. Should it be static?
>>>>>> arch/powerpc/kernel/setup_64.c:951:6: warning: symbol 'rfi_flush' was not declared. Should it be static?
>>>>>> arch/powerpc/kernel/setup_64.c:952:6: warning: symbol 'entry_flush' was not declared. Should it be static?
>>>>>> arch/powerpc/kernel/setup_64.c:953:6: warning: symbol 'uaccess_flush' was not declared. Should it be static?
>>>>>>
>>>>>> Reported-by: Hulk Robot <hulkci@huawei.com>
>>>>>> Signed-off-by: He Ying <heying24@huawei.com>
>>>>>> ---
>>>>>>     arch/powerpc/kernel/setup_64.c | 6 ++++--
>>>>>>     1 file changed, 4 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
>>>>>> index 560ed8b975e7..603aacd8527b 100644
>>>>>> --- a/arch/powerpc/kernel/setup_64.c
>>>>>> +++ b/arch/powerpc/kernel/setup_64.c
>>>>>> @@ -71,6 +71,8 @@
>>>>>>       #include "setup.h"
>>>>>>     +extern void panic_smp_self_stop(void);
>>>>>> +
>>>>> For function prototypes 'extern' is unneeded and deprecated.
>>>>>
>>>>> And function prototypes should go in an header file.
>>>>>
>>>>> panic_smp_self_stop() is called from kernel/panic.c , it should be declared in one of the generic linux header files I think.
>>>> Yes, you're right. But I have no idea which header it should be declared in. May I have your suggestions?
>>> arch/powerpc/include/asm/bug.h looks like a good place.
>> Why declaring it in a powerpc header ?
>>
>> It's a weak function defined in core part of kernel (kernel/panic.c).
>>
>> I think it should go in a common header, just like for instance arch_thaw_secondary_cpus_begin()
> Indeed. include/linux/smp.h is a better place for a common routine.
>
> C.
>
> .
