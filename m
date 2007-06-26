Return-Path: <timur@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 746DCDDE04
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2007 01:59:02 +1000 (EST)
Message-ID: <468137BD.2040406@freescale.com>
Date: Tue, 26 Jun 2007 10:58:53 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: fix MAC address entries for 83xx, 85xx, and
	86xx device trees
References: <11825407952085-git-send-email-timur@freescale.com>
	<70d005ce549921cc56481fe0b26faaa4@kernel.crashing.org>
	<467FDA2C.8020607@freescale.com>
	<05ae4090f00e42580b7dcbf0619cc0b7@kernel.crashing.org>
	<467FE6E5.1070403@freescale.com>
	<b50d825c36a92dc2e16f486455e0623d@kernel.crashing.org>
	<46812F19.1070302@freescale.com>
	<f7b7186d108fee941496ea15fd902474@kernel.crashing.org>
In-Reply-To: <f7b7186d108fee941496ea15fd902474@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool wrote:

> It is not safe since you might happen upon a network device without
> "mac-address" property (since the device hasn't been used at boot in
> a real OF, or the firmware knows no mac address at all, etc.) and no
> "local-mac-address" either -- but it _does_ have an "address", and
> it can have an "address" with the correct semantics, not the broken
> stuff.
> 
> It's not very likely for this happens, sure :-)

Maybe we're using different definitions of "safe" here.  When I said the code was "safe", 
I meant that it if U-Boot puts the MAC address into the 'address' property only, 
of_get_mac_address() will safely detect that and use the address:

	pp = of_find_property(np, "address", NULL);
	if (pp && (pp->length == 6) && is_valid_ether_addr(pp->value))
		return pp->value;

It checks if the property exists, that it's 6 bytes long, and that it is a valid MAC 
address.  AFAIK, no version of U-Boot and no DTS file, past or present, will confuse this 
code.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
