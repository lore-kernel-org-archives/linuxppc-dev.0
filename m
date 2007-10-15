Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 182FFDDF9E
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 06:53:16 +1000 (EST)
Message-ID: <4713D150.2020806@freescale.com>
Date: Mon, 15 Oct 2007 15:45:04 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 2/2] i2c: Add devtree-aware iic support for PPC4xx
References: <200710151529.11485.sr@denx.de>	
	<20071015163216.GA8127@gate.ebshome.net>	
	<fa686aa40710150957s74693835g257b376adfdb4e90@mail.gmail.com>	
	<20071015185340.GB4474@loki.buserror.net>	
	<fa686aa40710151213r670bea49i63fa5f5402aa150d@mail.gmail.com>	
	<4713BE5E.3030406@freescale.com>	
	<fa686aa40710151248y5e921a4fmbb0a3e0b7c9a2ca5@mail.gmail.com>	
	<4713C57F.7060509@freescale.com>
	<fa686aa40710151326m789046aaq60ba002e180d4e14@mail.gmail.com>
In-Reply-To: <fa686aa40710151326m789046aaq60ba002e180d4e14@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Jean Delvare <khali@linux-fr.org>, linuxppc-dev@ozlabs.org,
	Stefan Roese <sr@denx.de>, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
> On 10/15/07, Scott Wood <scottwood@freescale.com> wrote:
>> Don't Do That(tm).  If you use this mechanism, and an adapter node
>> doesn't have a bus number, then it doesn't get to pre-register devices,
>> but instead must use i2c_new_device.
> 
> Even that doesn't work.  For example if a PCI device is probed which
> registers an i2c bus; there needs to be a mechanism for the i2c layer
> to know that an id is already spoken for, so once again there needs to
> be a mechanism to map easily from id to device (or lack thereof).

As long as all statically-assigned buses have their devices passed to 
i2c_register_board_info by platform code before the PCI device is 
probed, the i2c layer will hand out bus numbers that don't conflict.

> Where user == system integrator or firmware engineer.  ie. boards with
> no-populate options which affect the numbering; changes to match the
> silkscreening on the chassis when a common board is used by multiple
> systems.  It's a conceivable scenario.  (Again; this is more relevant
> to eth and serial devices than i2c).

Sure, but I guess I don't see the problem with such a person editing the 
label property.  The label property also gives more freedom in terms of 
which characters can be used in the description.

Aliases could still be used when there's a higher level abstraction 
related to purpose, not identification.

-Scott
