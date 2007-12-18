Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4ECFCDDF65
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Dec 2007 03:15:25 +1100 (EST)
Message-ID: <4767F216.3060408@freescale.com>
Date: Tue, 18 Dec 2007 10:15:18 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>, galak@kernel.crashing.org,
	linuxppc-dev@ozlabs.org
Subject: Re: [PATCH v2 2/3] mpc82xx: Embedded Planet EP8248E support
References: <20071212225429.GB19027@loki.buserror.net>
	<20071217035912.GB3262@localhost.localdomain>
	<47669335.4050405@freescale.com>
	<20071218005348.GC9489@localhost.localdomain>
In-Reply-To: <20071218005348.GC9489@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
> I mean, obviously the MDIO bus is accessed via some of the
> board-control registers.  What I'm questioning is whether it makes
> sense to have a distinct node to represent the mdio bus, or whether
> the phys should just hang straight of the bcsr node.

Ah, I see.  I think it does make sense, because it's a bus; if there 
were another bus-like thing on the bcsr, there'd be conflicts over what 
the children mean.

>>>> +	soc@f0000000 {
>>>> +		#address-cells = <1>;
>>>> +		#size-cells = <1>;
>>>> +		device_type = "soc";
>>> Ditch the device_type.
>> No, it's used by the bootwrapper.  I'll get rid of it if you want to 
>> write a find_node_by_compatible() function. :-)
> 
> Well, now that libfdt is merged, there is one :-p.

OK, it just needs exporting via ops.  I'll put it on my to-do list, but 
I don't think it should hold up board support patches.

-Scott
