Return-Path: <Sergej.Stepanov@ids.de>
Received: from ares.ids.de (ares.ids.de [213.144.29.131])
	by ozlabs.org (Postfix) with ESMTP id C555ADDE07
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Nov 2007 22:38:06 +1100 (EST)
Received: from ares.ids.de (ares.ids.de [127.0.0.1])
	by ares.ids.de (PGP Universal) with ESMTP id 74DAFF491A9
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Nov 2007 12:38:03 +0100 (CET)
Subject: Re: [PATCH] using mii-bitbang on different processor ports
	-	update the booting-without-of.txt-file
From: Sergej Stepanov <Sergej.Stepanov@ids.de>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <47336F9D.8060405@freescale.com>
References: <1194339117.3467.8.camel@p60635-ste.ids.de>
	<20071106184649.GA5283@loki.buserror.net>
	<1194442844.3571.14.camel@p60635-ste.ids.de>
	<47336F9D.8060405@freescale.com>
Date: Fri, 09 Nov 2007 12:38:03 +0100
Message-Id: <1194608283.8755.10.camel@p60635-ste.ids.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@ozlabs.org, jgarzik@pobox.com, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Am Donnerstag, den 08.11.2007, 14:20 -0600 schrieb Scott Wood: 
> Sergej Stepanov wrote:
> > If both mdio and mdc controlling pins are on the same processor port,
> > one resource should be used.
> > Otherwise, two resources are used: the 1-st - mdio, the 2-nd - mdc.
> 
> How about:
> The first reg resource is the I/O port register block on which MDIO 
> resides.  The second reg resource is the I/O port register block on 
> which MDC resides.  If there is only one reg resource, it is used for 
> both MDIO and MDC.
> 
Ok.

> We also need to change the reference to port C in fsl,mdio-pin and 
> fsl,mdc-pin.
Do you mean this:
   Currently defined compatibles:
   fsl,pq1-fec-mdio (reg is same as first resource of FEC device)
-> fsl,cpm2-mdio-bitbang (reg is port C registers)

   Properties for fsl,cpm2-mdio-bitbang:
-> fsl,mdio-pin : pin of port C controlling mdio data
-> fsl,mdc-pin : pin of port C controlling mdio clock

Right. But i thought it would be related to the example,
and than the reader gets the short comment about I/O ports.

Or the other variant would be:
--------------------
   iv) MDIO

   Currently defined compatibles:
   fsl,pq1-fec-mdio (reg is same as first resource of FEC device)
   fsl,cpm2-mdio-bitbang (reg is the I/O port register block(s))

   Properties for fsl,cpm2-mdio-bitbang:
   The first reg resource is the I/O port register block on which MDIO
   resides.  The second reg resource is the I/O port register block on
   which MDC resides.  If there is only one reg resource, it is used for
   both MDIO and MDC.
   fsl,mdio-pin : pin of chosen port for controlling mdio data
   fsl,mdc-pin : pin of chosen port for controlling mdio clock

   Example:
	mdio@10d40 {
	device_type = "mdio";
	compatible = "fsl,mpc8272ads-mdio-bitbang",
        	     "fsl,mpc8272-mdio-bitbang",
       		     "fsl,cpm2-mdio-bitbang";
	reg = <10d40 14>;
	#address-cells = <1>;
	#size-cells = <0>;
	fsl,mdio-pin = <12>;
	fsl,mdc-pin = <13>;
	};
-----------------

Regards
Sergej.
