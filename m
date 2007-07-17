Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [208.123.74.7])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D7594DDEE2
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 08:27:22 +1000 (EST)
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Add StorCenter DTS first draft. 
In-Reply-To: Your message of "Tue, 17 Jul 2007 16:57:27 +0200."
	<630B6BC9-389F-4F5C-AE8F-9C3131C4543E@kernel.crashing.org>
References: <E1IAnwC-0003Xm-6U@jdl.com>
	<630B6BC9-389F-4F5C-AE8F-9C3131C4543E@kernel.crashing.org>
Date: Tue, 17 Jul 2007 17:27:18 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1IAvVm-0005yQ-LO@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day Segher Boessenkool mumbled:
> > +/ {
> > +	model = "StorCenter";
> 
> If you can find a real model number, put it in here, instead.

Yep, "StorCenter" is it.  No model numer/name beyond that.

> > +	compatible = "storcenter";
> 
> Needs a manufacturer name in there.

Right.  Will use:
	compatible = "iomega,storcenter"

> > +		PowerPC,603e {			/* Really 8241 */
> 
> So say "PowerPC,8241@0", or "PowerPC,e300@0" (or whatever
> the CPU core in there is), or simply "cpu@0", following
> the generic naming recommended practice.

Well, its the 8241 SoC with a 603e core...  (This is
the same phrase currently being used on the Kurobox.)
I'll use:

	PowerPC,8241@0 }


> > +			bus-frequency = <0>;
> 
> Is this filled in anywhere?  Please document that, if so.

Right.  boot{loader,wrapper}

> > +	soc10x {
> 
> Bad name.  Where is the binding for this?  I don't think
> I saw it before.

It's what is being used, again, by the Kurobox.  I understand
that doesn't make it "right", just precedented by now.

How about "soc8241@80000000" instead?

That would be similar to:
        soc8641@f8000000 {
and
       soc8272@f0000000 {

> > +		store-gathering = <0>; /* 0 == off, !0 == on */
> 
> Don't define this as "!0", but as "1".

OK.

> > +		i2c@fdf03000 {
> > +			device_type = "i2c";
> 
> No device_type, there is no I2C binding.

Right.

> > +			compatible = "fsl-i2c";
> 
> Needs to be more specific.

Hmmm...  Not sure what to use here then.  There are many
existing examples using "fsl-i2c" already.  Granted, we've
established that they could be wrong...  Should this be
more like this?:

    compatible = "fsl,mpc8241-i2c", "fsl-i2c";

> > +		mpic: pic@fdf40000 {
> 
> interrupt-controller@fdf40000

OK.

> > +		pci@fe800000 {
> > +			clock-frequency = <d# 100000000>; /* Hz */
> 
> 100MHz PCI?  Interesting.

Good point. 66666666 seems more likely...


Thanks for the review and help here!

jdl
