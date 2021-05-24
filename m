Return-Path: <SRS0=afix=KT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C45C47080
	for <linuxppc-dev@archiver.kernel.org>; Mon, 24 May 2021 01:40:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0DAE61028
	for <linuxppc-dev@archiver.kernel.org>; Mon, 24 May 2021 01:40:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0DAE61028
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FpKfn2lpdz307j
	for <linuxppc-dev@archiver.kernel.org>; Mon, 24 May 2021 11:40:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.32; helo=szxga06-in.huawei.com;
 envelope-from=thunder.leizhen@huawei.com; receiver=<UNKNOWN>)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FpKfN4vmmz2xfl
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 May 2021 11:40:25 +1000 (AEST)
Received: from dggems704-chm.china.huawei.com (unknown [172.30.72.58])
 by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FpKbX1L5dzmZJt;
 Mon, 24 May 2021 09:38:00 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggems704-chm.china.huawei.com (10.3.19.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 24 May 2021 09:40:19 +0800
Received: from [127.0.0.1] (10.174.177.72) by dggpemm500006.china.huawei.com
 (7.185.36.236) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 24 May
 2021 09:40:18 +0800
Subject: Re: [PATCH 1/1] powerpc/ps3: Fix error return code in
 ps3_register_devices()
To: Geoff Levand <geoff@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
References: <20210518065853.7590-1-thunder.leizhen@huawei.com>
 <87tumxioki.fsf@mpe.ellerman.id.au>
 <71764790-4be0-d177-37fc-a2d91d47a0da@infradead.org>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <4ba8b7d8-0bd1-a40c-51a9-9447956ca12c@huawei.com>
Date: Mon, 24 May 2021 09:40:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <71764790-4be0-d177-37fc-a2d91d47a0da@infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500006.china.huawei.com (7.185.36.236)
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 2021/5/24 4:15, Geoff Levand wrote:
> Hi,
> 
> On 5/20/21 5:20 AM, Michael Ellerman wrote:
>> Zhen Lei <thunder.leizhen@huawei.com> writes:
>>> When call ps3_start_probe_thread() failed, further initialization should
>>> be stopped and the returned error code should be propagated.
> ...
>>> --- a/arch/powerpc/platforms/ps3/device-init.c
>>>  
>>>  	result = ps3_start_probe_thread(PS3_BUS_TYPE_STORAGE);
>>> +	if (result < 0)
>>> +		return result;
>>
>> If you bail out here you skip:
>>
>>>  	ps3_register_vuart_devices();
>>
>> Which I suspect means there will be no console output?
>>
>> Presumably the system won't boot if the probe thread fails, but it might
>> at least print an oops, whereas if we return we might get nothing at
>> all. Though I'm just guessing, I don't know this code that well.
> 
> That probe is for the storage devices (PS3_BUS_TYPE_STORAGE).
> 
> There are cases where the system is usable even if the storage
> devices are not available, for example, when using an NFS root
> filesystem.
> 
> ps3_start_probe_thread was made to be quite verbose on error
> to make up for it's return value not being checked.

So should we delete the local variable 'result' and ignore the return value?
- result = ps3_start_probe_thread(PS3_BUS_TYPE_STORAGE);
- (void)ps3_start_probe_thread(PS3_BUS_TYPE_STORAGE);

> 
>> Anyway please leave this code alone unless you're willing to test your
>> changes, or at least provide a more thorough justification for them.
> 
> Agreed, this change should not be merged.
> 
> -Geoff
> 
> .
> 

