Return-Path: <josejx@gentoo.org>
Received: from alnrmhc12.comcast.net (alnrmhc12.comcast.net [206.18.177.52])
	by ozlabs.org (Postfix) with ESMTP id 7E830DE017
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Oct 2007 13:38:46 +1100 (EST)
Message-ID: <472546BF.4010102@gentoo.org>
Date: Sun, 28 Oct 2007 22:34:39 -0400
From: Joseph Jezak <josejx@gentoo.org>
MIME-Version: 1.0
To: Dmitry Torokhov <dtor@insightbb.com>
Subject: Re: [PATCH] Prevent appletouch message log spam on 17" PB
References: <20071028235319.GB16301@woodpecker.gentoo.org>
	<200710282221.26241.dtor@insightbb.com>
In-Reply-To: <200710282221.26241.dtor@insightbb.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Berg <johannes@sipsolutions.net>, linuxppc-dev@ozlabs.org,
	Joseph Jezak <josejx@woodpecker.gentoo.org>, valderman@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dmitry Torokhov wrote:
> Hi Joseph,
> 
> On Sunday 28 October 2007 19:53, Joseph Jezak wrote:
>> Perhaps this was a debugging message?  In any case, this printk
>> causes lots of message log spam on my PB G4 1.67" (PowerBook5,9).
>>
>> This removes the printk.
>>
> 
> I don't think we want do delete this message outright, we just need
> to make sure we don't go through size detection when we re-initialize
> the device. After all it is unlikely that touchpad will change its
> size :)
> 
> BTW, could you tell me what product ID your touchpad has?
> 
>> Signed-off by: Joseph Jezak <josejx@gentoo.org>
>> ---
>>
>> diff --git a/drivers/input/mouse/appletouch.c b/drivers/input/mouse/appletouch.c
>> index f132702..6c47641 100644
>> --- a/drivers/input/mouse/appletouch.c
>> +++ b/drivers/input/mouse/appletouch.c
>> @@ -433,7 +433,6 @@ static void atp_complete(struct urb* urb)
>>  		for (i = (atp_is_geyser_2(dev)?15:16); i < ATP_XSENSORS; i++) {
>>  			if (!dev->xy_cur[i]) continue;
>>  
>> -			printk("appletouch: 17\" model detected.\n");
>>  			if(atp_is_geyser_2(dev))
>>  				input_set_abs_params(dev->input, ABS_X, 0,
>>  						     (20 - 1) *
>>
> 

Sure, that's probably better.  My touchpad is an 0x0214.

-Joe
