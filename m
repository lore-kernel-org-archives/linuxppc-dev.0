Return-Path: <dargaud@lpsc.in2p3.fr>
Received: from lpsc-mail.in2p3.fr (lpsc-mail.in2p3.fr [134.158.40.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B33CFB6F77
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  8 Jul 2011 17:26:52 +1000 (EST)
Received: from lpsc0174x.localnet (lpsc0174x.in2p3.fr [134.158.40.174])
	by lpsc-mail.in2p3.fr (8.13.1/8.13.1/In2p3) with ESMTP id
	p687QlOk008540
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Jul 2011 09:26:47 +0200
From: Guillaume Dargaud <dargaud@lpsc.in2p3.fr>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: Analysing a kernel panic
Date: Fri, 8 Jul 2011 09:26:47 +0200
References: <201107051619.50548.dargaud@lpsc.in2p3.fr>
	<1310079493.14501.313.camel@pasglop>
In-Reply-To: <1310079493.14501.313.camel@pasglop>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201107080926.47588.dargaud@lpsc.in2p3.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> What is "Xad." ? (btw, coding style FAIL !)

That's the struct I use to access the control registers of the hardware.
About the coding style, don't worry it's never going to make it into mainstream as there's only one piece of that 
hardware ever built ! (which is also why I didn't respect things like allowing multiple devices, please don't nail me to 
the cross for that). And it's only my 2nd real Linux driver...

> Are you trying to write to HW registers using a structure like that
> without using the appropriate MMIO register accessors ?
> In that case, your accesses may happen our of order since you don't have
> memory barriers (among other potential problems).

Yes. I discovered the out() functions afterwards. But I insert asm(eieio) to avoid 'out of order' problems.
 
> The crash looks like you aren't properly clearing the interrupt
> condition on the HW, it remains asserted, tho it shouldn't overflow like
> that, something seems wrong with your PIC.

Is there some constraints I should tell the electronics guys ? Should the interrupt be raised for less than some max 
duration ? It's on a raising signal, so I don't see why that should be an issue.

> What HW is this ? What PIC ? It looks like the interrupt source isn't
> masked on the PIC itself while it's being handled or something...

The hardware is a heavily modified Xilinx ML405 derivative.
The PIC is a XPS_INTC (in VHDL)
-- 
Guillaume Dargaud
http://www.gdargaud.net/Antarctica/
