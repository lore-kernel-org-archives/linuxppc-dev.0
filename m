Return-Path: <tnt@246tNt.com>
Received: from outmx007.isp.belgacom.be (outmx007.isp.belgacom.be
	[195.238.5.234])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A277BDDE0C
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Jan 2007 09:37:52 +1100 (EST)
Received: from outmx007.isp.belgacom.be (localhost [127.0.0.1])
	by outmx007.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id l07MbbYQ020321
	for <linuxppc-dev@ozlabs.org>; Sun, 7 Jan 2007 23:37:40 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <45A175B3.4010506@246tNt.com>
Date: Sun, 07 Jan 2007 23:35:31 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Matt Sealey <matt@genesi-usa.com>
Subject: Re: [PATCH] Probe Efika platform before CHRP.
References: <17799.34168.811328.653008@cargo.ozlabs.ibm.com>		<1166528379.19254.69.camel@localhost.localdomain>		<4587D338.7060906@246tNt.com>		<1166538553.25827.99.camel@pmac.infradead.org>		<1166558300.19254.71.camel@localhost.localdomain>		<1167773388.22068.443.camel@pmac.infradead.org>		<1167773863.6165.82.camel@localhost.localdomain>		<1167775493.3660.23.camel@shinybook.infradead.org>		<528646bc0701021504k88682bl765fad4c100bd40e@mail.gmail.com>		<45A01416.6080401@genesi-usa.com>	<528646bc0701061423o270df3dfj9d27d5572840ec79@mail.gmail.com>	<45A1535C.1080007@genesi-usa.com>	<f0c5df8b1d2bcc1abcd04894e0210cc1@kernel.crashing.org>
	<45A16FF1.5000401@genesi-usa.com>
In-Reply-To: <45A16FF1.5000401@genesi-usa.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: bbrv@genesi-usa.com, Linux PPC DEV <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>, David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


The very fact of matching device to driver by their
"name/type/compatible" list
is just the way it's done/specified in OF. Unless I'm deeply mistaken
(could always
happen, nobody's perfect heh) ...

The mpc5200b-psc-i2s and mpc5200-psc-i2s are in fact different device
... they
have different register set (compare both datasheet, you'll notice small
difference).
They just happen to be handled by the same driver and that driver
handles those
difference internally because they're small ...

So back to ethernet since you seem to like it ;) If fsl produce a new
chip (let's call
it mpc5321) , either it has _exactly_ the same interface (not a single
difference),
they you could call it mpc52xx in your device tree. Sure it looks weird but
sorry we can't predict the future and draft things for chips that don't
exist yet ...
If it's different, (even slighty, like it handles frame >2048 for
example), then
just give it a new name and add it as supported by the same driver. If
that's the
5321 entry that matched, then allow frames >2048.

>From what I've saw, if they can't even keep the same register set
between two
revision of the same controller, I doubt they will between chips. The I2C
controller is a good example, it's almost all the same between several
fsl chip,
except for the clocking selection. So as I see it, the I2C driver would have
several "compatible" match, for each different variation of the core. How
you name those instance is not really important as long as there is no
possible
conflicts.


You're proposing (if I understood correctly), that we first match the device
to a driver by using the normal name/type/compatible list but with very
broad names like "fsl-ethernet", then look at the SVR to know if it's in
fact
this driver we need to load (two fsl chip could have completly different
ethernet
cores) and also using SVR decide what "quirk" we need to apply.
Note I'm not even commenting yet, I first need to be sure of what you're
saying,
but the SVR thing will already not work if you're not in a SoC context ...


Regards,

    Sylvain


Matt Sealey wrote:
> Why is it so funny? I'd love to be enlightened rather than just plain
> insulted about it.
>
> I don't think any of that can be taken into account by simply giving things
> *names* and then having a 3-week discussion and committee hearing about how
> someone gave it a DIFFERENT name. It is even more strange to me, that nobody
> HAS a standard name for the devices on the MPC5200B, yet we are arguing
> about what would look nicer in the Linux source code?
>
> Small example:
>
> mpc5200b-fec, mpc5200-fec, mpc52xx-fec doesn't tell you anything, and
> then with the 5500 or 5120 or something, you then have worked out you
> named your original devices wrong, and now need to make it compatible
> with those? Do you switch features on and off based on a string comparison?
> What if a certain chip revision has a bug you need to work around (there
> are plenty in the original MPC5200!), is that meant to be encoded in the
> "compatible" property too, somehow? Or would you check the SVR too? If
> you would check that, why not use this as the basis of the support for
> that driver? For a PCI device, you are given basically a 32-bit UID for
> each device, which is attached to a unique domain, host, bus, device
> and function number. You manage well here without giving it names.
>
> An Intel processor might return a string for CPUID - mine says it's a
> "Intel(R) Pentium(R) M 1.70GHz". That string is absolutely useless in
> determining it's compatibility. It's just a name. It may as well say
> "Fight Famine In Rwanda" for all the good it does.
>
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
>
>   
