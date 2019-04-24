Return-Path: <SRS0=+N6N=S2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D2BC10F03
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 01:50:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 589DF21773
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 01:50:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 589DF21773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44pjtZ0l9DzDqTD
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 11:49:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.35; helo=huawei.com; envelope-from=yuehaibing@huawei.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44pjrw2FglzDqT5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 11:48:30 +1000 (AEST)
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 3DC2D241662F0C6BE04A;
 Wed, 24 Apr 2019 09:48:25 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Wed, 24 Apr 2019
 09:48:21 +0800
Subject: Re: [PATCH] powerpc/pseries: Use correct event modifier in
 rtas_parse_epow_errlog()
To: Russell Currey <ruscur@russell.cc>, <paulus@samba.org>,
 <mpe@ellerman.id.au>, <mahesh@linux.vnet.ibm.com>, <npiggin@gmail.com>,
 <ganeshgr@linux.ibm.com>, <anton@samba.org>
References: <20190423143533.26952-1-yuehaibing@huawei.com>
 <1b208e33c4f51630e2a336e95f25509fe7286e34.camel@russell.cc>
From: YueHaibing <yuehaibing@huawei.com>
Message-ID: <9b540ba8-9711-f4a2-b4bc-d35a05fd3dda@huawei.com>
Date: Wed, 24 Apr 2019 09:48:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <1b208e33c4f51630e2a336e95f25509fe7286e34.camel@russell.cc>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 2019/4/24 9:29, Russell Currey wrote:
> On Tue, 2019-04-23 at 22:35 +0800, Yue Haibing wrote:
>> From: YueHaibing <yuehaibing@huawei.com>
>>
>> rtas_parse_epow_errlog() should pass 'modifier' to
>> handle_system_shutdown, because event modifier only use
>> bottom 4 bits.
>>
>> Fixes: 55fc0c561742 ("powerpc/pseries: Parse and handle EPOW
>> interrupts")
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> 
> Hello,
> 
> This fails to compile.
> 
> arch/powerpc/platforms/pseries/ras.c: In function
> 'rtas_parse_epow_errlog':
> arch/powerpc/platforms/pseries/ras.c:288:26: error: 'event_modifier'
> undeclared (first use in this function); did you mean 'modifier'?
>    handle_system_shutdown(event_modifier);
>                           ^~~~~~~~~~~~~~
>                           modifier

Yes, this should be 'modifier'

> 
> So yes, I assume you meant "modifier" instead of "event_modifier" as
> mentioned in your commit message.  Did you compile this before sending?

I am very sorry for this, this is not my compiled version,
I forgot to check again before sending.

> 
> (found by snowpatch)
> 
> - Russell
> 
> 
> .
> 

