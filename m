Return-Path: <afleming@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 60678DDEEF
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Mar 2007 10:52:15 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l29NqBDY017234
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Mar 2007 16:52:12 -0700 (MST)
In-Reply-To: <20070308210759.59738f6d.kim.phillips@freescale.com>
References: <20070308210759.59738f6d.kim.phillips@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <8390CEA8-EF4E-4D38-BB3F-4245188ACF68@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: [RFC] (re)describing the PHY interface property
Date: Fri, 9 Mar 2007 17:52:10 -0600
To: Kim Phillips <kim.phillips@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 8, 2007, at 21:07, Kim Phillips wrote:

> we need to fix the interface property of the PHY nodes in the device
> trees.  currently, we see things such as:
>
> 	interface = <6>; //ENET_1000_GMII
>
> in mpc836x_mds.dts, which is bad because the speed and interface type
> are conjoined.  I found a spec proposal based on response to a similar
> matter on this list:
>
> 	http://playground.sun.com/1275/proposals/Closed/Accepted/378-it.txt
>
> So do we go with proposal #378, and add the interface type to the  
> end of
> its comma-separated list, like this:
>
> 	supported-network-type = "ethernet,1000,,full,gmii";


While I don't object to the supported/chosen IEEE addition, your  
proposal is to modify it into a realm I'm not convinced it was meant  
to address.  The properties described in their proposal all clearly  
relate to the connection between the PHY device and the actual medium  
through which the signal propagates.

The issue at hand is the connection between the PHY and the MAC,  
which is quite different.  Mostly because we do not currently have  
any code that cares about the transceiver, but the network won't work  
if the interface is not configured properly.



>
> or forget about proposal #378, and do something like:
>
> 	max-speed = <d#1000>;
> 	interface-type = "gmii";


I'm ok with this.  I'm not sure you even need the "-type" at the end.

Andy
