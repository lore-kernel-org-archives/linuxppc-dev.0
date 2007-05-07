Return-Path: <afleming@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6FB76DDF23
	for <linuxppc-dev@ozlabs.org>; Tue,  8 May 2007 07:45:51 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l47Ljkrs011923
	for <linuxppc-dev@ozlabs.org>; Mon, 7 May 2007 14:45:47 -0700 (MST)
In-Reply-To: <20070507182957.GK26920@ld0162-tx32.am.freescale.net>
References: <20070507182957.GK26920@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <183F76F8-BC1B-4EB6-9C3A-4F0FFA7B3BB8@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: [PATCH 12/13] gianfar: Add flags for magic packet and MDIO.
Date: Mon, 7 May 2007 16:45:55 -0500
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> @@ -323,6 +326,10 @@ static int __init gfar_of_init(void)
>  		gfar_data.phy_id = *id;
>  		gfar_data.bus_id = res.start;
>
> +		if (res.start >= gfar_dev->resource[0].start &&
> +		    res.start < gfar_dev->resource[0].end)
> +			gfar_data.device_flags |= FSL_GIANFAR_DEV_HAS_MDIO;
> +


Hrm.  I don't think this is a good way to go.  The DEV* flags are all  
features right now, rather than configuration settings.  It seems  
like this is a stop-gap solution for until more robust detection of  
the ability to power down the interface.  I can understand that a  
full solution might be beyond the ambitions of this first set of  
patches, but I'd prefer if we didn't pollute gianfar's device flags  
space with a flag that we should aim at removing eventually.

Andy
