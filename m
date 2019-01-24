Return-Path: <SRS0=rclJ=QA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9FE1C282C3
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Jan 2019 03:15:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB5992184C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Jan 2019 03:14:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB5992184C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43lS293wQhzDqHm
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Jan 2019 14:14:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.191; helo=huawei.com;
 envelope-from=yuehaibing@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43lS0Q1Gn1zDq9y
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jan 2019 14:13:25 +1100 (AEDT)
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 96D199E39B34B9A1959B;
 Thu, 24 Jan 2019 11:13:21 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.408.0; Thu, 24 Jan 2019
 11:13:19 +0800
Subject: Re: [PATCH -next] usb: host: drop pointless static qualifier
To: Alan Stern <stern@rowland.harvard.edu>
References: <Pine.LNX.4.44L0.1901231107030.1564-100000@iolanthe.rowland.org>
From: YueHaibing <yuehaibing@huawei.com>
Message-ID: <d7fca6e4-2bfb-3c0c-97cc-2c1abcf117cf@huawei.com>
Date: Thu, 24 Jan 2019 11:13:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.44L0.1901231107030.1564-100000@iolanthe.rowland.org>
Content-Type: text/plain; charset="windows-1252"
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
Cc: geoff@infradead.org, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, paulus@samba.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 2019/1/24 0:09, Alan Stern wrote:
> On Wed, 23 Jan 2019, YueHaibing wrote:
> 
>> There is no need to have the 'dummy_mask' variable static since new
>> value always be assigned before use it.
>>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>  drivers/usb/host/ehci-ps3.c | 2 +-
>>  drivers/usb/host/ohci-ps3.c | 2 +-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/usb/host/ehci-ps3.c b/drivers/usb/host/ehci-ps3.c
>> index 454d8c6..91cee02 100644
>> --- a/drivers/usb/host/ehci-ps3.c
>> +++ b/drivers/usb/host/ehci-ps3.c
>> @@ -86,7 +86,7 @@ static int ps3_ehci_probe(struct ps3_system_bus_device *dev)
>>  	int result;
>>  	struct usb_hcd *hcd;
>>  	unsigned int virq;
>> -	static u64 dummy_mask;
>> +	u64 dummy_mask;
>>  
>>  	if (usb_disabled()) {
>>  		result = -ENODEV;
>> diff --git a/drivers/usb/host/ohci-ps3.c b/drivers/usb/host/ohci-ps3.c
>> index 395f9d3..a1c1bdf 100644
>> --- a/drivers/usb/host/ohci-ps3.c
>> +++ b/drivers/usb/host/ohci-ps3.c
>> @@ -69,7 +69,7 @@ static int ps3_ohci_probe(struct ps3_system_bus_device *dev)
>>  	int result;
>>  	struct usb_hcd *hcd;
>>  	unsigned int virq;
>> -	static u64 dummy_mask;
>> +	u64 dummy_mask;
>>  
>>  	if (usb_disabled()) {
>>  		result = -ENODEV;
> 
> No.  You need to read the code and understand how a variable is used
> before you decide to modify it.

Sorry, I misread the code, so just leave it as is.

> 
> In this case, a suitable approach would be to change the declaration 
> so that it says:
> 
> 	status u64 dummy_mask = DMA_BIT_MASK(32);
> 
> and remove the line that does the assignment dynamically.
> 
> Alan Stern
> 
> 
> .
> 

