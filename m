Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DD08DDDECA
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 02:08:37 +1100 (EST)
Subject: Re: [PATCH 02/12] powermac: support G5 CPU hotplug
From: Johannes Berg <johannes@sipsolutions.net>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17875.55046.873365.575945@cargo.ozlabs.ibm.com>
References: <20070207124536.963531000@sipsolutions.net>
	<20070207124610.392302000@sipsolutions.net>
	<1170940494.4385.51.camel@johannes.berg>
	<1170973463.2620.373.camel@localhost.localdomain>
	<1171035382.4520.7.camel@johannes.berg>
	<1171293354.10344.6.camel@johannes.berg>
	<17875.55046.873365.575945@cargo.ozlabs.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-23w1eI5bxGkw6efWr0xa"
Date: Thu, 15 Feb 2007 16:08:28 +0100
Message-Id: <1171552108.5220.6.camel@johannes.berg>
Mime-Version: 1.0
Cc: linux-pm@lists.osdl.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-23w1eI5bxGkw6efWr0xa
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2007-02-15 at 14:44 +1100, Paul Mackerras wrote:

> > +_GLOBAL(power4_idle_irqs_softdisabled)
> > +	li	r6,1
> > +	b	0f
> >  _GLOBAL(power4_idle)
> > +	li	r6,0
> > +0:
> >  BEGIN_FTR_SECTION
> >  	blr
> >  END_FTR_SECTION_IFCLR(CPU_FTR_CAN_NAP)
> > @@ -35,8 +40,8 @@ END_FTR_SECTION_IFCLR(CPU_FTR_CAN_NAP)
> >  	rotldi	r0,r0,16
> >  	mtmsrd	r0,1			/* hard-disable interrupts */
> >  	li	r0,1
> > -	stb	r0,PACASOFTIRQEN(r13)	/* we'll hard-enable shortly */
> > -	stb	r0,PACAHARDIRQEN(r13)
> > +	stb	r0,PACAHARDIRQEN(r13)	/* we'll hard-enable shortly */
> > +	stb	r6,PACASOFTIRQEN(r13)	/* set softirqs enabled bit */
>=20
> Don't you have something backwards here?  If we come in through
> power4_idle_irqs_softdisabled, the name would indicate to me that we
> want to end up with paca->soft_enabled set to 0, not 1.

Umm, yes, looks like. I'll rewrite it. Interesting that it worked as I
had expected though (I actually put a printk into the timer interrupt!).

johannes

--=-23w1eI5bxGkw6efWr0xa
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBF1Hds/ETPhpq3jKURArhQAKCXNsmEFmHexmyDg76Z5/N5Fcr55QCdG41f
35Yjz/biIRlpYsAJNSlwoCA=
=2pzT
-----END PGP SIGNATURE-----

--=-23w1eI5bxGkw6efWr0xa--
