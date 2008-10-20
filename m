Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1E931DDD04
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Oct 2008 09:55:24 +1100 (EST)
Subject: RE: Problems with PCI-E devices not being detected with switch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ayman El-Khashab <AymanE@tanisys.com>
In-Reply-To: <16691A8B34B5D9458EA3A1C37A11555A0137F832@tanisys-ex2.Tanisys.Local>
References: <16691A8B34B5D9458EA3A1C37A11555A0137F81E@tanisys-ex2.Tanisys.Local>
	<1224134422.8157.549.camel@pasglop>
	<16691A8B34B5D9458EA3A1C37A11555A0137F822@tanisys-ex2.Tanisys.Local>
	<1224202209.7654.36.camel@pasglop>
	<16691A8B34B5D9458EA3A1C37A11555A0137F829@tanisys-ex2.Tanisys.Local>
	<1224278340.7654.103.camel@pasglop>
	<16691A8B34B5D9458EA3A1C37A11555A0137F830@tanisys-ex2.Tanisys.Local>
	<1224539820.7654.173.camel@pasglop>
	<16691A8B34B5D9458EA3A1C37A11555A0137F832@tanisys-ex2.Tanisys.Local>
Content-Type: text/plain
Date: Tue, 21 Oct 2008 09:55:19 +1100
Message-Id: <1224543319.7654.180.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> The part that didn't look correct is this line (note the operators)
> 
>    ((buses >> 8) & 0xff) != <= bus->number) {
> 
>                Operators ^^ ^^

Ooohhh ... nice typo :-) The right one is <=, thanks for catching this !

> >From reading through the code and your textual description of what was
> supposed to be happening, I went ahead and changed it to ... 
> 
>  ((buses >> 8) & 0xff) !=  bus->number) {
> 
> And this is the code that generated the results from my previous
> message.

Yeah, that's enough to catch most of the problems incuding yours.

Cheers,
Ben.
