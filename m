Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 28017DDF13
	for <linuxppc-dev@ozlabs.org>; Tue,  8 May 2007 09:12:41 +1000 (EST)
In-Reply-To: <183F76F8-BC1B-4EB6-9C3A-4F0FFA7B3BB8@freescale.com>
References: <20070507182957.GK26920@ld0162-tx32.am.freescale.net>
	<183F76F8-BC1B-4EB6-9C3A-4F0FFA7B3BB8@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <86B7A813-A7EC-4A26-A528-7741284D0371@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 12/13] gianfar: Add flags for magic packet and MDIO.
Date: Mon, 7 May 2007 18:11:45 -0500
To: Andy Fleming <afleming@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 7, 2007, at 4:45 PM, Andy Fleming wrote:

>
>> @@ -323,6 +326,10 @@ static int __init gfar_of_init(void)
>>  		gfar_data.phy_id = *id;
>>  		gfar_data.bus_id = res.start;
>>
>> +		if (res.start >= gfar_dev->resource[0].start &&
>> +		    res.start < gfar_dev->resource[0].end)
>> +			gfar_data.device_flags |= FSL_GIANFAR_DEV_HAS_MDIO;
>> +
>
>
> Hrm.  I don't think this is a good way to go.  The DEV* flags are all
> features right now, rather than configuration settings.  It seems
> like this is a stop-gap solution for until more robust detection of
> the ability to power down the interface.  I can understand that a
> full solution might be beyond the ambitions of this first set of
> patches, but I'd prefer if we didn't pollute gianfar's device flags
> space with a flag that we should aim at removing eventually.

I don't follow why this isn't a feature of TSEC1 on the parts and why  
we don't put this into the device tree as a property.

- k
