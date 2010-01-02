Return-Path: <wg@grandegger.com>
Message-ID: <4B3F677D.4050804@grandegger.com>
Date: Sat, 02 Jan 2010 16:34:21 +0100
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH net-next 1/3] can: mscan: fix improper return if dlc <
	8 in start_xmit function
References: <1262420274-16586-1-git-send-email-wg@grandegger.com>	<1262420274-16586-2-git-send-email-wg@grandegger.com>
	<20100102133041.GB2239@pengutronix.de>
In-Reply-To: <20100102133041.GB2239@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Socketcan-core@lists.berlios.de, Netdev@vger.kernel.org,
	Devicetree-discuss@lists.ozlabs.org,
	Linuxppc-dev@lists.ozlabs.org, Wolfgang Grandegger <wg@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Wolfram Sang wrote:
> On Sat, Jan 02, 2010 at 09:17:52AM +0100, Wolfgang Grandegger wrote:
>> From: Wolfgang Grandegger <wg@denx.de>
>>
>> The start_xmit function of the MSCAN Driver did return improperly if
>> the CAN dlc check failed (skb not freed and invalid return code). This
>> patch adds a proper check of the frame lenght and data size and returns
>> now correctly. Furthermore, a typo has been fixed.
> 
> A few little things, but in general:
> 
> Acked-by: Wolfram Sang <w.sang@pengutronix.de>
> 
>> Signed-off-by: Wolfgang Grandegger <wg@denx.de>
>> ---
>>  drivers/net/can/mscan/mscan.c |   11 ++++++++---
>>  1 files changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/can/mscan/mscan.c b/drivers/net/can/mscan/mscan.c
>> index 07346f8..abdf5e8 100644
>> --- a/drivers/net/can/mscan/mscan.c
>> +++ b/drivers/net/can/mscan/mscan.c
>> @@ -4,7 +4,7 @@
>>   * Copyright (C) 2005-2006 Andrey Volkov <avolkov@varma-el.com>,
>>   *                         Varma Electronics Oy
>>   * Copyright (C) 2008-2009 Wolfgang Grandegger <wg@grandegger.com>
>> - * Copytight (C) 2008-2009 Pengutronix <kernel@pengutronix.de>
>> + * Copyright (C) 2008-2009 Pengutronix <kernel@pengutronix.de>
>>   *
>>   * This program is free software; you can redistribute it and/or modify
>>   * it under the terms of the version 2 of the GNU General Public License
>> @@ -177,8 +177,13 @@ static netdev_tx_t mscan_start_xmit(struct sk_buff *skb, struct net_device *dev)
>>  	int i, rtr, buf_id;
>>  	u32 can_id;
>>  
>> -	if (frame->can_dlc > 8)
>> -		return -EINVAL;
>> +	if (skb->len != sizeof(*frame) || frame->can_dlc > 8) {
>> +		dev_err(dev->dev.parent,
>> +			"Dropping non-conform paket: len %d, can_dlc %d\n",
> 
> s/paket/packet/
> 
>> +			skb->len, frame->can_dlc);
> 
> Also, shouldn't it rather be %u (sk_buff->len is unsigned int)?

Will fix both issue.

Wolfgang.
