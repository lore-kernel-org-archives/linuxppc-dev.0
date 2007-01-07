Return-Path: <matt@genesi-usa.com>
Received: from mail.genesi-usa.com (mithrandir.softwarenexus.net
	[66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 54DFDDDDF4
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Jan 2007 09:11:05 +1100 (EST)
Message-ID: <45A16FF1.5000401@genesi-usa.com>
Date: Sun, 07 Jan 2007 22:10:57 +0000
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Probe Efika platform before CHRP.
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
In-Reply-To: <f0c5df8b1d2bcc1abcd04894e0210cc1@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: David Woodhouse <dwmw2@infradead.org>, bbrv@genesi-usa.com,
	Paul Mackerras <paulus@samba.org>, Linux PPC DEV <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



Why is it so funny? I'd love to be enlightened rather than just plain
insulted about it.

I don't think any of that can be taken into account by simply giving things
*names* and then having a 3-week discussion and committee hearing about how
someone gave it a DIFFERENT name. It is even more strange to me, that nobody
HAS a standard name for the devices on the MPC5200B, yet we are arguing
about what would look nicer in the Linux source code?

Small example:

mpc5200b-fec, mpc5200-fec, mpc52xx-fec doesn't tell you anything, and
then with the 5500 or 5120 or something, you then have worked out you
named your original devices wrong, and now need to make it compatible
with those? Do you switch features on and off based on a string comparison?
What if a certain chip revision has a bug you need to work around (there
are plenty in the original MPC5200!), is that meant to be encoded in the
"compatible" property too, somehow? Or would you check the SVR too? If
you would check that, why not use this as the basis of the support for
that driver? For a PCI device, you are given basically a 32-bit UID for
each device, which is attached to a unique domain, host, bus, device
and function number. You manage well here without giving it names.

An Intel processor might return a string for CPUID - mine says it's a
"Intel(R) Pentium(R) M 1.70GHz". That string is absolutely useless in
determining it's compatibility. It's just a name. It may as well say
"Fight Famine In Rwanda" for all the good it does.

I think there are better ways and better places to encode certain
properties of the system as a whole (as the system is a lot more than
just that single chip) than having a bunch of strings in a property
which claim that it is compatible with something else, strictly defined
naming conventions and so on across chip ranges. Although we are talking
here mostly about two boards with the same chip basically - Lite5200
and Efika, there may be more boards with similar hardware supported,
extra hardware supported, new chips which look very much like the 5200
but have slightly different or bugfixed operation (and here is my point)
which I do not think you can encode in names and compatibile names.

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations

Segher Boessenkool wrote:
>> (especially a C-based one, OpenBIOS
>> is 90% Forth which is a terrible lock-in)
> 
>> Isn't the e300 PVR and e300 SVR, or any other device identifier on the
>> chip, a much better differentiator for drivers, than a named 
>> compatibility
>> flag?
> 
> Only 7 days into the new year, and already we get some great
> entries for best-joke-of-2007!  Too bad they're factually
> incorrect.
> 
> 
> Segher
> 
