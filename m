Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 009EADDE08
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Jan 2007 09:37:01 +1100 (EST)
Subject: Re: [PATCH] Probe Efika platform before CHRP.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Matt Sealey <matt@genesi-usa.com>
In-Reply-To: <45A16FF1.5000401@genesi-usa.com>
References: <17799.34168.811328.653008@cargo.ozlabs.ibm.com>
	<1166528379.19254.69.camel@localhost.localdomain>
	<4587D338.7060906@246tNt.com>
	<1166538553.25827.99.camel@pmac.infradead.org>
	<1166558300.19254.71.camel@localhost.localdomain>
	<1167773388.22068.443.camel@pmac.infradead.org>
	<1167773863.6165.82.camel@localhost.localdomain>
	<1167775493.3660.23.camel@shinybook.infradead.org>
	<528646bc0701021504k88682bl765fad4c100bd40e@mail.gmail.com>
	<45A01416.6080401@genesi-usa.com>
	<528646bc0701061423o270df3dfj9d27d5572840ec79@mail.gmail.com>
	<45A1535C.1080007@genesi-usa.com>
	<f0c5df8b1d2bcc1abcd04894e0210cc1@kernel.crashing.org>
	<45A16FF1.5000401@genesi-usa.com>
Content-Type: text/plain
Date: Mon, 08 Jan 2007 09:35:29 +1100
Message-Id: <1168209329.22458.72.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>, bbrv@genesi-usa.com,
	David Woodhouse <dwmw2@infradead.org>,
	Linux PPC DEV <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2007-01-07 at 22:10 +0000, Matt Sealey wrote:

> mpc5200b-fec, mpc5200-fec, mpc52xx-fec doesn't tell you anything.

It does. It tells you exactly what you need. It tells you that you are
dealing, from the more precise to the more generic:

 - It's the implementation of the FEC cell in the mpc5200b
 - It's the implementation of the FEC cell in an mpc5200
 - it's the implementation of the FEC cell in a mpc52xx family chip

In addition, it really only tells you that it's compatible with those.
If we were to have 5500 or 5120, we could just say they are compatible
with mpc52xx. It doesn't matter, it's an arbitrary name chosen to
represent this cell because it wasn't given us a better name by the
constructor. The coutner example is IBM EMAC which has a proper name ...
EMAC :-). "FEC" is too generic, freescale calls "FEC" anything that
looks remotely like an ethernet controller, so we needed somethign more
precise.

>  and
> then with the 5500 or 5120 or something, you then have worked out you
> named your original devices wrong, and now need to make it compatible
> with those?

If they are compatible, they are compatible. In which case, there is
nothing wrong in having:

mpc5500-fec\0mpc52xx-fec in the "compatible" property. A bit clumsy
maybe but not wrong.

>  Do you switch features on and off based on a string comparison?

Yes, when the string is well defined. An example is the processor types
passed down via AT_PLATFORM to glibc and/or gcc. A string is much better
than a number, because at least, it's somewhat self-explanatory.

> What if a certain chip revision has a bug you need to work around (there
> are plenty in the original MPC5200!), is that meant to be encoded in the
> "compatible" property too, somehow?

Yes, it should tell you precisely what chip you are talking about,
again, from the more specific to the more generic. Of course, it's good
to have a more complete information there, thus a "model" property will
do no harm (could contain a part number if it's in the SoC bus), that
sort of thing in case there is some ambiguity that wasn't foreseen when
defining the initial binding, but most of the time, it can be avoided.

>  Or would you check the SVR too?

Best to avoid. Beside, SVR is completely specific to a given vendor.

>  If
> you would check that, why not use this as the basis of the support for
> that driver? 

Because the SVR represent the whole chip, every single part/cell in it.
We are specifically interested about a specific cell. In many cases,
they aren't any significant differences between implementations that
would require driver changes for every SVR out there.

Or take the case I gave in another email of Axon. the 4xx coreconnect
bits start to be used on non-4xx CPUs as part of a southbridge.... if we
had used some SVR-like thingy or even a PVR, suddenly, our entire
identification scheme stops working because those exact same cells are
no longer tied to a given CPU at all, they are in a south bridge !

> For a PCI device, you are given basically a 32-bit UID for
> each device, which is attached to a unique domain, host, bus, device
> and function number. You manage well here without giving it names.
> 
> An Intel processor might return a string for CPUID - mine says it's a
> "Intel(R) Pentium(R) M 1.70GHz". That string is absolutely useless in
> determining it's compatibility. It's just a name. It may as well say
> "Fight Famine In Rwanda" for all the good it does.

We don't care, we do care however what family of processor it is, which
version of the instruction set it adheres to, and that -is- generally
expressed by a string. In addition, we have implementation specific
"features" that don't necessarily need to be represented in there. And
in case we have to deal with a really specific bug, we -also- want
things like part number or mask revision etc...  But we don't use that
all the time, only for specific quirks.
 
> I think there are better ways and better places to encode certain
> properties of the system as a whole (as the system is a lot more than
> just that single chip) than having a bunch of strings in a property
> which claim that it is compatible with something else, strictly defined
> naming conventions and so on across chip ranges. Although we are talking
> here mostly about two boards with the same chip basically - Lite5200
> and Efika, there may be more boards with similar hardware supported,
> extra hardware supported, new chips which look very much like the 5200
> but have slightly different or bugfixed operation (and here is my point)
> which I do not think you can encode in names and compatibile names.

You logic escapes me.

Ben.
