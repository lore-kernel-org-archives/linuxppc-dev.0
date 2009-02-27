Return-Path: <mike@it-loops.com>
Received: from lvps87-230-0-242.dedicated.hosteurope.de
	(lvps87-230-0-242.dedicated.hosteurope.de [87.230.0.242])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "plesk", Issuer "plesk" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id DCE85DDD01
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Feb 2009 05:39:49 +1100 (EST)
Message-Id: <A3092716-D25B-409A-B422-AE2F6E7AADA1@it-loops.com>
From: Michael Guntsche <mike@it-loops.com>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <F79A1F44-A17D-483B-9FC9-D5C4D6AEBE6C@it-loops.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: PHY not found after migration of gianfar driver to an
	of_platform_driver
Date: Fri, 27 Feb 2009 19:39:39 +0100
References: <D5EBE54F-FD6D-4973-8835-33541ADCBABD@it-loops.com>
	<F79A1F44-A17D-483B-9FC9-D5C4D6AEBE6C@it-loops.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ok, I made some progress but still no fix for it.

The code fails in bus_find_device

if (match(dev, data)

returns false. Data in this case is mdio@24520.00 or .01 depending on  
the nic but the only mdio device that exists is mdio@24520.1f which is  
not the phy.
If I boot with 2.6.28.3 I see the following under

/sys/devices/platform:
fsl-gianfar.0
fsl-gianfar.1
fsl-gianfar_mdio.14
	24520:00
	24520:01

So the old code finds the PHYs and puts them in the sys-tree. With the  
new code I do not have these entries any longer. I think the reason is  
because the init code went from fsl_soc.c to the driver code, is this  
correct?
If yes I need to figure out why the mdio@24520.00 and 01 PHYs are not  
probed/detected correctly. As always I am very grateful for some  
input, hints help here. :)

Kind regards,
Michael
