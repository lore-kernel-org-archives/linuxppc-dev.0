Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 38BAEB6EDE
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 12 Aug 2009 19:56:21 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8A52DDDD01
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Aug 2009 19:56:20 +1000 (EST)
Subject: Re: Problem with PCIe -> PCI bridge on MPC8377E-RDB
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "B.J. Buchalter" <bj@mhlabs.com>
In-Reply-To: <2D2EDFA8-E51F-4A2D-BEB7-8F9258518DA1@mhlabs.com>
References: <4D3BDC67-986A-482D-BB3F-497F64C68531@mhlabs.com>
	<9E566D12-1A26-41BC-BB71-27D4CCE54E20@kernel.crashing.org>
	<2D2EDFA8-E51F-4A2D-BEB7-8F9258518DA1@mhlabs.com>
Content-Type: text/plain
Date: Wed, 12 Aug 2009 19:56:05 +1000
Message-Id: <1250070965.3587.1.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2009-08-11 at 23:25 -0400, B.J. Buchalter wrote:

> I don't know the model of the board off the top of my head.
> 
> I do know that it uses the Texas Instruments XIO2000A/XIO2200 PCI  
> Express-to-PCI Bridge (rev 03), with the TSB82AA2 OHCI Link behind the  
> bridge.
> 
> The same board definitely works as expected in a Mac Pro.

I've had problems on embedded 4xx with some of those guys. I think
there's a problem with the TI bridge, either it needs more time to
settle after reset or it doesn't cope with a second reset by the kernel
after the FW reset ,I don't remember... but there's definitely something
fishy with that bridge or something a bit too "tight" on spec we do on
both FSL and 44x that doesn't please that bridge.

Cheers,
Ben.

> In doing some Google searches about this, I have seen the TI part  
> listed in the PCI configuration of folks running linux (though  
> probably on Intel) and apparently having no problems with the busses  
> behind the bridge being enumerated.
> 
> I am guessing that the problem is related the the PCIe root complex on  
> the 8377, but I am just guessing.
> 
> Is PCIe known to work on the MPC837x?
> 
> Thanks!
> 
> B.J. Buchalter
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
