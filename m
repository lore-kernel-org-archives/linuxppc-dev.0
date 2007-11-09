Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 25890DDF00
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Nov 2007 03:03:49 +1100 (EST)
Message-ID: <473484CB.1010604@freescale.com>
Date: Fri, 09 Nov 2007 10:03:23 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Sergej Stepanov <Sergej.Stepanov@ids.de>
Subject: Re: [PATCH] using mii-bitbang on different processor ports	-	update
	the booting-without-of.txt-file
References: <1194339117.3467.8.camel@p60635-ste.ids.de>	
	<20071106184649.GA5283@loki.buserror.net>	
	<1194442844.3571.14.camel@p60635-ste.ids.de>	
	<47336F9D.8060405@freescale.com>
	<1194608283.8755.10.camel@p60635-ste.ids.de>
In-Reply-To: <1194608283.8755.10.camel@p60635-ste.ids.de>
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
>> We also need to change the reference to port C in fsl,mdio-pin and 
>> fsl,mdc-pin.
> Do you mean this:
>    Currently defined compatibles:
>    fsl,pq1-fec-mdio (reg is same as first resource of FEC device)
> -> fsl,cpm2-mdio-bitbang (reg is port C registers)
> 
>    Properties for fsl,cpm2-mdio-bitbang:
> -> fsl,mdio-pin : pin of port C controlling mdio data
> -> fsl,mdc-pin : pin of port C controlling mdio clock

Yes.

> Right. But i thought it would be related to the example,
> and than the reader gets the short comment about I/O ports.

No, the example is the example, and the spec is the spec. :-)

> Or the other variant would be:
> --------------------
>    iv) MDIO
> 
>    Currently defined compatibles:
>    fsl,pq1-fec-mdio (reg is same as first resource of FEC device)
>    fsl,cpm2-mdio-bitbang (reg is the I/O port register block(s))
> 
>    Properties for fsl,cpm2-mdio-bitbang:
>    The first reg resource is the I/O port register block on which MDIO
>    resides.  The second reg resource is the I/O port register block on
>    which MDC resides.  If there is only one reg resource, it is used for
>    both MDIO and MDC.
>    fsl,mdio-pin : pin of chosen port for controlling mdio data
>    fsl,mdc-pin : pin of chosen port for controlling mdio clock

Looks good.  We can eliminate the parenthetical for 
fsl,cpm2-mdio-bitbang because reg is now explained below.

-Scott
