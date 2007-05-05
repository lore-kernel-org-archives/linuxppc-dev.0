Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id F223EDDEE2
	for <linuxppc-dev@ozlabs.org>; Sun,  6 May 2007 07:41:26 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id
	l45Lc8Ld027677
	for <linuxppc-dev@ozlabs.org>; Sat, 5 May 2007 17:38:08 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l45LfOW9173094
	for <linuxppc-dev@ozlabs.org>; Sat, 5 May 2007 15:41:24 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l45LfN2p032151
	for <linuxppc-dev@ozlabs.org>; Sat, 5 May 2007 15:41:23 -0600
Subject: Re: [PATCH v2 6/7] Holly DTS
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <76e38f13b63a2cf4c793299e73671db5@kernel.crashing.org>
References: <1178381611.3393.25.camel@zod.rchland.ibm.com>
	<1178382006.3393.37.camel@zod.rchland.ibm.com>
	<e1d22829fe3f12509018791541073706@kernel.crashing.org>
	<1178388746.3393.47.camel@zod.rchland.ibm.com>
	<76e38f13b63a2cf4c793299e73671db5@kernel.crashing.org>
Content-Type: text/plain
Date: Sat, 05 May 2007 16:36:12 -0500
Message-Id: <1178400972.3393.64.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2007-05-05 at 22:44 +0200, Segher Boessenkool wrote:
> >>> +/ {
> >>> +	model = "ppc750-tsi109";
> >>
> >> "model" should be something really specific; typically
> >> a (unique!) model number.  This means you can't use the
> >> same device tree for Holly and Hickory (but there are
> >> more reasons for that; see below).
> >>
> >>> +	compatible = "ppc750-tsi";
> >>
> >> The needs to be more specific as well; "ibm,holly"
> >> or something.
> >
> > Why?  Holly and Hickory share the same memory map and devices.  The 
> > only
> > thing that differs from what I can tell is the actual CPU itself.
> 
> And the model number I suspect.
> 
> "ppc750-tsi" really isn't good enough as a "compatible"
> property, there are many many more boards with some 750
> and some TSI bridge.

Ok.  It really doesn't matter one way or another to me, since it's
something I'm defining anyway.  "ibm,holly" and/or "ibm,hickory" or
"ibm,ppc750-tsi" would likely work.

Actually, I might muck around with the PVR in the bootwrapper and poke
the correct model and compatible nodes in there.  That might work out
well enough.

> >>> +  	tsi109@c0000000 {
> >>> +		device_type = "tsi-bridge";
> >>
> >> Don't put a "device_type" here, it is useless
> >> (and undefined).  There are more like this, but
> >> perhaps Linux (wrongly) probes on "device_type"
> >> for those, so the kernel would need updating
> >> first.
> >
> > It's not useless.  The TSI code probes by device_type all over the
> > place.  Do you have an example of how to probe for something like this
> > without using device_type?
> 
> Sure: use "compatible" instead.
> 
> This problem is all over the place, don't worry
> about it too much.  It would be good if new ports
> could stop adding to the madness though ;-)

For now, I'm inclined to leave it as is to minimize the amount of things
needed to actually get Holly merged.  However, I'll start looking at
doing it via compatible shortly.  Hopefully someone will be able to test
out the mpc7448hpc2 board as I go to make sure things are breaking
there.

> >>> +	  	MPIC: pic@7400 {
> >>> +			built-in;
> >>
> >> Why say this for MPIC only, not for most other nodes?
> >> What binding defines "built-in", anyway?
> >
> > http://playground.sun.com/1275/bindings/chrp/chrp1_8a.ps
> 
> But this isn't a CHRP compatible board, that binding
> doesn't apply.

I'm not pretending it is.  You just asked which binding defined it and I
was proud of myself for actually finding one ;).

It doesn't actually do anything in this case, so it can be removed.

josh
