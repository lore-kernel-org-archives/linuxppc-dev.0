Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9EB8DDDEC5
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Feb 2007 02:41:53 +1100 (EST)
Subject: Re: [linux-pm] [PATCH 02/12] powermac: support G5 CPU hotplug
From: Johannes Berg <johannes@sipsolutions.net>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17867.40281.175422.116673@cargo.ozlabs.ibm.com>
References: <20070207124536.963531000@sipsolutions.net>
	<20070207124610.392302000@sipsolutions.net>
	<1170940494.4385.51.camel@johannes.berg>
	<1170941321.4385.61.camel@johannes.berg>
	<17867.40281.175422.116673@cargo.ozlabs.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-LmFdauLa3tZI+xVHu6Mi"
Date: Fri, 09 Feb 2007 16:39:21 +0100
Message-Id: <1171035561.4520.10.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-pm@lists.osdl.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-LmFdauLa3tZI+xVHu6Mi
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2007-02-09 at 08:59 +1100, Paul Mackerras wrote:
> Johannes Berg writes:
>=20
> > +#ifdef CONFIG_CPU_HOTPLUG
> > +	/* if we have fake CPU hotplug just to support suspend to disk
> > +	 * and can't really turn off a CPU, it may be taking timer interrupts
> > +	 * even when it is dead. Avoid doing anything in that case so global
> > +	 * state is not modified for and by a CPU that doesn't really exist. =
*/
> > +	if (__get_cpu_var(cpu_state) =3D=3D CPU_DEAD)
> > +		return;
> > +#endif
>=20
> Are you sure this is necessary?  IIRC, the if (!cpu_is_offline(cpu)) a
> little bit further down is there to cope with this exact situation.

Yes, but we still do irq_enter() and as it happens with HZ=3D1000 we
almost always kick the CPU out while it's inbetween irq_enter() and
irq_exit().

You said:

> And cpu hotplug already works on G4 SMP powermacs, where we can't
> physically remove the cpu either - we just put it into sleep mode with
> interrupts disabled, which is what we would be doing on a G5 powermac
> also.

and then Benh said:

> I've always had doubts about wether SLEEP with EE off was legal and
> wouldn't actually still go out of sleep when getting an interrupt... In
> that case, at least on CPUs where the DEC acts "level" triggered, we
> need to at least reset the DEC to some sane value.

I probably should've mentioned that. I tried going into NAP with EE off
and that seemed to get me a busy loop where the CPU wasn't even napping
at all. I could have done something wrong, of course.

johannes

--=-LmFdauLa3tZI+xVHu6Mi
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBFzJWp/ETPhpq3jKURAg0xAJ9Kk6WxqmnWpc8cmfmjmRpM2ZpyigCgnb/f
nqwCKAj5rhDcdCEJEXN4vjo=
=vJhb
-----END PGP SIGNATURE-----

--=-LmFdauLa3tZI+xVHu6Mi--
