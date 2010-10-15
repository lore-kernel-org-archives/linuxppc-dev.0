Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH v2] pseries: don't override CONFIG_PPC_PSERIES_DEBUG
From: Michael Ellerman <michael@ellerman.id.au>
To: linasvepstas@gmail.com
In-Reply-To: <AANLkTinEzRpREFzDVhPS5ynqjYydHOs9iW5NM6W9Tf9A@mail.gmail.com>
References: <1287103733-7121-1-git-send-email-nacc@us.ibm.com>
	<AANLkTinEzRpREFzDVhPS5ynqjYydHOs9iW5NM6W9Tf9A@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-vYaJGuEvRic0IbmPneyK"
Date: Fri, 15 Oct 2010 15:01:44 +1100
Message-ID: <1287115304.5278.3.camel@concordia>
Mime-Version: 1.0
Cc: Frans Pop <elendil@planet.nl>, linux-kernel@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
	Brian King <brking@linux.vnet.ibm.com>,
	Nishanth Aravamudan <nacc@us.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-vYaJGuEvRic0IbmPneyK
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2010-10-14 at 20:54 -0500, Linas Vepstas wrote:
> On 14 October 2010 19:48, Nishanth Aravamudan <nacc@us.ibm.com> wrote:
> > eeh and pci_dlpar #undef DEBUG, but I think they were added before the
> > ability to control this from Kconfig. It's really annoying to only get
> > some of the debug messages from these files. Leave the lpar.c #undef
> > alone as it produces so much output as to make the kernel unusable.
> > Update the Kconfig text to indicate this particular quirk :)
> >
> > Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
>=20
> OK, ignore my last email.
>=20
> Acked by: Linas Vepstas <linasvepstas@gmail.com>

I guess I'll ack it too seeing I added PPC_PSERIES_DEBUG:

Acked-by: Michael Ellerman <michael@ellerman.id.au>

> > --- a/arch/powerpc/platforms/pseries/Kconfig
> > +++ b/arch/powerpc/platforms/pseries/Kconfig
> > @@ -47,6 +47,12 @@ config LPARCFG
> >  config PPC_PSERIES_DEBUG
> >        depends on PPC_PSERIES && PPC_EARLY_DEBUG
> >        bool "Enable extra debug logging in platforms/pseries"
> > +        help
> > +         Say Y here if you want the pseries core to produce a bunch of
> > +         debug messages to the system log. Select this if you are havi=
ng a
> > +         problem with the pseries core and want to see more of what is
> > +         going on. This does not enable debugging in lpar.c, which mus=
t
> > +         be manually done due to its verbosity.
> >        default y
>=20
> Umm, I see "default y" and you are not changing this but ... default y
> ?? Really?

Yes, default y if early debug is enabled. Unlike DEBUG_KERNEL,
PPC_EARLY_DEBUG is a pretty good indication that you are doing some
kernel development - because you have to choose exactly which platform
you're working on.

> Also, I am guessing that the lpar spam is due only to a handful of printk=
's,
> while most of the rest will be infrequent.  Just knock out the
> high-frequency ones...

No they're all related to the HPTE code, so you basically don't want any
of them enabled unless you're debugging that, and most people aren't.

cheers


--=-vYaJGuEvRic0IbmPneyK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAky30iUACgkQdSjSd0sB4dL+DgCfR+HAWiu5JX9bj+MmeI6209Wc
OT4AoMnuNyDQkgC+tfHskbr0cbwBiHyn
=fKtT
-----END PGP SIGNATURE-----

--=-vYaJGuEvRic0IbmPneyK--
