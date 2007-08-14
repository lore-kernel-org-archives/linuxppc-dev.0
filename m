Return-Path: <afleming@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D7505DDEBD
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 15 Aug 2007 07:30:13 +1000 (EST)
In-Reply-To: <020101c7deb6$4168cd70$6f00a8c0@ESIDT>
References: <1187044669.10295.4.camel@server>	<3FE16C0A-892F-4481-999A-A699C0C70BF9@kernel.crashing.org>	<013b01c7de23$5baa7d70$6f00a8c0@ESIDT>
	<1B668DF2-9909-4D43-AAFF-3A2ADFA283B2@freescale.com>
	<46C1D553.4000201@freescale.com>
	<018801c7de93$43390e80$6f00a8c0@ESIDT>
	<46C1EDAA.3070402@freescale.com>
	<66FE71AE-6AF2-4A2F-91D0-6517B0702C13@freescale.com>
	<020101c7deb6$4168cd70$6f00a8c0@ESIDT>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <C7CBB1A9-C7F0-4673-87DE-0D655B6F2EBC@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: [PATCH] [UPDATED] tsec: Allow Ten Bit Interface to be configurable
Date: Tue, 14 Aug 2007 16:29:57 -0500
To: <joe.hamman@embeddedspecialties.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Aug 14, 2007, at 16:01, Joe Hamman wrote:

> Hi Andy,
>>
>> I still think it should just be a property of the ethernet node.  We
>> aren't describing the TBI, we're describing a setting for the
>> ethernet controller's register.
>>
>
> Like this?  Do we need to have one for each ethernet@xxxxxx?


Scott and I have been talking, and right now it seems like a better  
idea might be to have the TBI address get assigned dynamically, based  
on where PHYs aren't.

It's non-trivial to do (though not difficult), but this way we won't  
have to regret creating a bad interface.  You just need to look at  
the mdio bus, and find out which addresses responded.  Then you  
create a variable in the gfar_private structure to hold what it gets  
set to, and make sure that gfar_configure_serdes uses that value  
instead of the TBIPA constant.

Andy
