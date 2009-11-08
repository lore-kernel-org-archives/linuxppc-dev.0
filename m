Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 8226DB7067
	for <linuxppc-dev@ozlabs.org>; Sun,  8 Nov 2009 18:55:45 +1100 (EST)
Date: Sun, 8 Nov 2009 18:55:39 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [patch 09/16] powerpc: Replace old style lock initializer
Message-Id: <20091108185539.8d09017e.sfr@canb.auug.org.au>
In-Reply-To: <1257548144.13611.267.camel@pasglop>
References: <20091106223547.784916750@linutronix.de>
	<20091106223806.762624109@linutronix.de>
	<1257548144.13611.267.camel@pasglop>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Sun__8_Nov_2009_18_55_39_+1100_PvVKoR9/uoxSce0J"
Cc: Peter Zijlstra <peterz@infradead.org>, linuxppc-dev@ozlabs.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Sun__8_Nov_2009_18_55_39_+1100_PvVKoR9/uoxSce0J
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ben,

On Sat, 07 Nov 2009 09:55:44 +1100 Benjamin Herrenschmidt <benh@kernel.cras=
hing.org> wrote:
>
> Looks reasonable. But iseries can be a bitch, so we do need to test it
> on monday.

It should be safe as the spinlocks cannot be access until after the
following ppc_md pointer initialisations are done (and all this happens
before the secondary CPUs are started).

But, you are right that there is nothing like actually testing with
iSeries. :-)

> >  void __init hpte_init_iSeries(void)
> >  {
> > +	int i;
> > +
> > +	for (i =3D 0; i < ARRAY_SIZE(iSeries_hlocks); i++)
> > +		spin_lock_init(&iSeries_hlocks[i]);
> > +
> >  	ppc_md.hpte_invalidate	=3D iSeries_hpte_invalidate;
> >  	ppc_md.hpte_updatepp	=3D iSeries_hpte_updatepp;
> >  	ppc_md.hpte_updateboltedpp =3D iSeries_hpte_updateboltedpp;

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sun__8_Nov_2009_18_55_39_+1100_PvVKoR9/uoxSce0J
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkr2eXsACgkQjjKRsyhoI8yplQCePqhkhwE9kOsv222YOeuSMTT+
v6QAn0aivxcGS4awyXn6SI2G1PYtfuZt
=kxrY
-----END PGP SIGNATURE-----

--Signature=_Sun__8_Nov_2009_18_55_39_+1100_PvVKoR9/uoxSce0J--
