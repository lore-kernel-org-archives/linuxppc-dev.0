Return-Path: <afleming@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 663E5DDF04
	for <linuxppc-dev@ozlabs.org>; Tue,  8 May 2007 07:25:44 +1000 (EST)
In-Reply-To: <463F83FC.6080807@freescale.com>
References: <20070507182957.GK26920@ld0162-tx32.am.freescale.net>
	<20F58AAE-A35D-4BEC-9597-A882567BA5B4@kernel.crashing.org>
	<463F83FC.6080807@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <1C79B879-58E1-4274-BB90-A6D39FC852C8@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: [PATCH 12/13] gianfar: Add flags for magic packet and MDIO.
Date: Mon, 7 May 2007 16:25:43 -0500
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


On May 7, 2007, at 14:54, Scott Wood wrote:

> Kumar Gala wrote:
>>
>> On May 7, 2007, at 1:29 PM, Scott Wood wrote:
>>
>>> The magic packet flag indicates that the hardware has this
>>> capability.  The MDIO flag indicates that this device's
>>> registers contain active MDIO registers, and thus this
>>> device should not be put to sleep.
>>
>>
>> Can you explain the MDIO part further, do you mean its the tsec that
>> has the MDIO registers in its address space or that its actively   
>> using
>> MDIO for something?
>
> TSEC1 contains the MDIO registers for both TSEC1 and TSEC2.  Thus,  
> TSEC1
> cannot be put to sleep if TSEC2 is active (plus, the phy timer would
> have to be deactivated).  For now, the simple approach of never  
> sleeping
> TSEC1 is used.


The PHY timer is part of the PHY Lib.  The PHY Lib has infrastructure  
to support suspend/resume.  Any thoughts on using that?  More in an  
another email.
