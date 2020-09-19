Return-Path: <SRS0=LfhS=C4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D40AEC43464
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Sep 2020 02:50:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3CC72075E
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Sep 2020 02:50:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3CC72075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BtZvd4jXxzDqGv
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Sep 2020 12:50:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.35; helo=huawei.com;
 envelope-from=yangyingliang@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BtZsV1Vk7zDqtp
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Sep 2020 12:48:53 +1000 (AEST)
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id A6AA161F0C41473CEDEE;
 Sat, 19 Sep 2020 10:48:44 +0800 (CST)
Received: from [10.174.176.211] (10.174.176.211) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Sat, 19 Sep 2020 10:48:42 +0800
Subject: Re: [PATCH -next] tty: hvc: fix link error with
 CONFIG_SERIAL_CORE_CONSOLE=n
To: Greg KH <gregkh@linuxfoundation.org>
References: <20200918092030.3855438-1-yangyingliang@huawei.com>
 <20200918111708.GC2242974@kroah.com>
From: Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <6100a6e7-641f-7e9b-b4a3-3834320d1bb1@huawei.com>
Date: Sat, 19 Sep 2020 10:48:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200918111708.GC2242974@kroah.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.176.211]
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


On 2020/9/18 19:17, Greg KH wrote:
> On Fri, Sep 18, 2020 at 05:20:30PM +0800, Yang Yingliang wrote:
>> Fix the link error by selecting SERIAL_CORE_CONSOLE.
>>
>> aarch64-linux-gnu-ld: drivers/tty/hvc/hvc_dcc.o: in function `dcc_early_write':
>> hvc_dcc.c:(.text+0x164): undefined reference to `uart_console_write'
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>> ---
>>   drivers/tty/hvc/Kconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/tty/hvc/Kconfig b/drivers/tty/hvc/Kconfig
>> index d1b27b0522a3..8d60e0ff67b4 100644
>> --- a/drivers/tty/hvc/Kconfig
>> +++ b/drivers/tty/hvc/Kconfig
>> @@ -81,6 +81,7 @@ config HVC_DCC
>>   	bool "ARM JTAG DCC console"
>>   	depends on ARM || ARM64
>>   	select HVC_DRIVER
>> +	select SERIAL_CORE_CONSOLE
>>   	help
>>   	  This console uses the JTAG DCC on ARM to create a console under the HVC
>>   	  driver. This console is used through a JTAG only on ARM. If you don't have
>> -- 
>> 2.25.1
>>
> Same question here, what caused this problem to happen?
Fixes: d1a1af2cdf19 ("hvc: dcc: Add earlycon support")
>
> thanks,
>
> greg k-h
> .
