Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9D5D7DDE1F
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Nov 2007 07:23:01 +1100 (EST)
Message-ID: <47336F9D.8060405@freescale.com>
Date: Thu, 08 Nov 2007 14:20:45 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Sergej Stepanov <Sergej.Stepanov@ids.de>
Subject: Re: [PATCH] using mii-bitbang on different processor ports -	update
	the booting-without-of.txt-file
References: <1194339117.3467.8.camel@p60635-ste.ids.de>	
	<20071106184649.GA5283@loki.buserror.net>
	<1194442844.3571.14.camel@p60635-ste.ids.de>
In-Reply-To: <1194442844.3571.14.camel@p60635-ste.ids.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, jgarzik@pobox.com, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sergej Stepanov wrote:
> If both mdio and mdc controlling pins are on the same processor port,
> one resource should be used.
> Otherwise, two resources are used: the 1-st - mdio, the 2-nd - mdc.

How about:
The first reg resource is the I/O port register block on which MDIO 
resides.  The second reg resource is the I/O port register block on 
which MDC resides.  If there is only one reg resource, it is used for 
both MDIO and MDC.

We also need to change the reference to port C in fsl,mdio-pin and 
fsl,mdc-pin.

-Scott
