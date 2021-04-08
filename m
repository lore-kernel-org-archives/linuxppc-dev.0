Return-Path: <SRS0=7qm+=JF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2190C433B4
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Apr 2021 09:31:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE18F6101E
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Apr 2021 09:31:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE18F6101E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FGGGc2Hy3z3bw1
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Apr 2021 19:31:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.191; helo=szxga05-in.huawei.com;
 envelope-from=yukuai3@huawei.com; receiver=<UNKNOWN>)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FGGGB1tshz30Dc
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Apr 2021 19:30:37 +1000 (AEST)
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FGGCT3Dv4zyNgX;
 Thu,  8 Apr 2021 17:28:21 +0800 (CST)
Received: from [10.174.179.129] (10.174.179.129) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Thu, 8 Apr 2021 17:30:25 +0800
Subject: Re: [PATCH 1/2] powerpc: remove set but not used variable
 'force_printk_to_btext'
To: Christophe Leroy <christophe.leroy@csgroup.eu>, <mpe@ellerman.id.au>
References: <20210408011801.557004-1-yukuai3@huawei.com>
 <20210408011801.557004-2-yukuai3@huawei.com>
 <b7636590-42ef-e588-59e1-b0591243d619@csgroup.eu>
From: "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <9e3e5a40-ff90-9872-30a5-3a65232d5f0e@huawei.com>
Date: Thu, 8 Apr 2021 17:30:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <b7636590-42ef-e588-59e1-b0591243d619@csgroup.eu>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.129]
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 2021/04/08 13:01, Christophe Leroy wrote:
> 
> 
> Le 08/04/2021 à 03:18, Yu Kuai a écrit :
>> Fixes gcc '-Wunused-but-set-variable' warning:
>>
>> arch/powerpc/kernel/btext.c:49:12: error: 'force_printk_to_btext'
>> defined but not used.
> 
> You don't get this error as it is now.
> You will get this error only if you make it 'static', which is what you 
> did in your first patch based on the 'sparse' report.
> 
> When removing a non static variable, you should explain that you can 
> remove it after you have verifier that it is nowhere used, neither in 
> that file nor in any other one.

Hi,

I do use 'git grep force_printk_to_btext' to confirm that
'force_printk_to_btext' is not used anywhere. Maybe it's better to
metion it in commit message?

Thanks
Yu Kuai
> 
>>
>> It is never used, and so can be removed.
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   arch/powerpc/kernel/btext.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/arch/powerpc/kernel/btext.c b/arch/powerpc/kernel/btext.c
>> index 803c2a45b22a..359d0f4ca532 100644
>> --- a/arch/powerpc/kernel/btext.c
>> +++ b/arch/powerpc/kernel/btext.c
>> @@ -46,7 +46,6 @@ unsigned long disp_BAT[2] __initdata = {0, 0};
>>   static unsigned char vga_font[cmapsz];
>>   int boot_text_mapped __force_data = 0;
>> -int force_printk_to_btext = 0;
>>   extern void rmci_on(void);
>>   extern void rmci_off(void);
>>
> .
> 
