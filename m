Return-Path: <krafft@de.ibm.com>
Received: from mtagate6.uk.ibm.com (mtagate6.uk.ibm.com [195.212.29.139])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate6.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 88D05DE003
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 14:30:32 +1100 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate6.uk.ibm.com (8.13.8/8.13.8) with ESMTP id l0P3URKx208928
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 03:30:27 GMT
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
	[9.149.37.216])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v8.2) with
	ESMTP id l0P3URQK1536180
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 03:30:27 GMT
Received: from d06av04.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av04.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l0P3UQPB007530
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 03:30:27 GMT
Date: Thu, 25 Jan 2007 14:30:56 +1100
From: Christian Krafft <krafft@de.ibm.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [patch 0/1] next updated version, fixed cleanup and some minors
Message-ID: <20070125143056.47cbd5d2@localhost>
In-Reply-To: <DA5708FC-F9AB-4782-A48D-40B26990A24F@kernel.crashing.org>
References: <20061218163846.337fed65@localhost> <45882913.2000609@acm.org>
	<20061220154517.6341fce6@localhost>
	<200612210111.28186.arnd@arndb.de>
	<20070125104540.65a1f557@localhost>
	<DA5708FC-F9AB-4782-A48D-40B26990A24F@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: krafft@de.ibm.com, openipmi-developer@lists.sourceforge.net,
	Paul Mackerras <paulus@samba.org>, Arnd Bergmann <arnd@arndb.de>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 25 Jan 2007 01:24:01 +0100
Segher Boessenkool <segher@kernel.crashing.org> wrote:

> > This patch adds support for of_platform_driver to the ipmi_si module.
> > When loading the module, the driver will be registered to of_platform.
> > The driver will be probed for all devices with the type ipmi. It's =20
> > supporting
> > devices with compatible settings ipmi-kcs, ipmi-smic and ipmi-bt.
> > Only ipmi-kcs could be tested.
>=20
> I'm still saying that because of this, and because they might
> never be used and as such be unnecessary baggage, you shouldn't
> add SMIC and BT support.

Well, i left it in because there is no baggage except the few bytes in the =
match array.
This way the driver gets loaded if there is such a device.
It looks better to me to add generic support for these devices,
instead of adding code every time a specific device becomes available.
But actually I don't care too much.=20
So if you have another argument than the few bytes baggage, I'll remove it.

>=20
> > Signed-off-by: Christian Krafft <krafft@de.ibm.com>
> > Acked-by: Heiko J Schick <schihei@de.ibm.com>
>=20
> >  #define DEFAULT_REGSPACING	1
> > +#define DEFAULT_REGSIZE		DEFAULT_REGSPACING
>=20
> Just #define it as 1 I'd say.  Esp. for KCS interfaces, it can't
> ever be anything else there.

fixed

>=20
> > +	if (regsize && proplen!=3D4) {
>=20
> Whitespace problem (a few times in this file).

fixed

>=20
> > +	info->si_type		=3D (enum si_type) match->data;
>=20
> Do you need the cast here?  Oh I suppose you do, why else
> did you add it (and it teaches the world as a whole once
> again that enums in C are bloody useless almost always).

yep, I also feel sorry for that.

>=20
> > +static int __devexit ipmi_of_remove(struct of_device *dev)
> > +{
> > +	/* should call
> > +	 * cleanup_one_si(dev->dev.driver_data); */
> > +	return 0;
> > +}
>=20
> While I know this isn't really your problem, no one who
> isn't touching the IPMI code will ever fix it, so...  nudge
> nudge, wink wink.

fixed, 2.6.20 will contain the forward declaration,=20
so the cleanup code can be called there.

>=20
> > (void *)(unsigned long) SI_KCS
>=20
> Yes I do hate enums.

Why ?

>=20
> > +	.name		=3D "ipmi",
>=20
> Shouldn't this name be "ipmi-kcs" etc.?  Just asking :-)

You just wanna confuse me, right ?

>=20
> Cheers,
>=20
>=20
> Segher
>=20


See my next mail for patch.

--=20
Mit freundlichen Gr=FCssen,
kind regards,

Christian Krafft
IBM Systems & Technology Group,=20
Linux Kernel Development
IT Specialist
