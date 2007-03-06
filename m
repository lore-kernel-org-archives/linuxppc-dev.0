Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 5AE5BDDF13
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Mar 2007 12:57:51 +1100 (EST)
Date: Tue, 6 Mar 2007 12:57:43 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [PATCH 4/6] [POWERPC] allow pSeries to build without CONFIG_PCI
Message-Id: <20070306125743.69f1481f.sfr@canb.auug.org.au>
In-Reply-To: <Pine.LNX.4.62.0703051004390.18075@pademelon.sonytel.be>
References: <20070304165839.4d2bf50b.sfr@canb.auug.org.au>
	<200703041507.06307.arnd@arndb.de>
	<1173033826.8184.68.camel@localhost.localdomain>
	<200703041959.46872.arnd@arndb.de>
	<1173085328.8184.70.camel@localhost.localdomain>
	<Pine.LNX.4.62.0703051004390.18075@pademelon.sonytel.be>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__6_Mar_2007_12_57_43_+1100__JNtbgXG52Em0Ilg"
Cc: paulus@samba.org, Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__6_Mar_2007_12_57_43_+1100__JNtbgXG52Em0Ilg
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Mon, 5 Mar 2007 10:06:06 +0100 (CET) Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com> wrote:
>
> On Mon, 5 Mar 2007, Benjamin Herrenschmidt wrote:
> > On Sun, 2007-03-04 at 19:59 +0100, Arnd Bergmann wrote:
> > > On Sunday 04 March 2007, Benjamin Herrenschmidt wrote:
> > > > On Sun, 2007-03-04 at 15:07 +0100, Arnd Bergmann wrote:
> > > > > On Sunday 04 March 2007 07:04:44 Stephen Rothwell wrote:
> > > > > >  config PCI
> > > > > >         bool "PCI support" if 40x || CPM2 || PPC_83xx || PPC_85xx || PPC_86xx \
> > > > > > -               || PPC_MPC52xx || (EMBEDDED && PPC_ISERIES) || MPC7448HPC2 || PPC_PS3
> > > > > > +               || PPC_MPC52xx || (EMBEDDED &&  (PPC_PSERIES || PPC_ISERIES)) \
> > > > > > +               || MPC7448HPC2 || PPC_PS3
> > > > >
> > > > I dislike the giant conditional though.
> > >
> > > How about changing it to
> > >
> > > config PCI_ENABLE
> > > 	bool
> >
> > Call it PCI_CAPABLE rather...
>
> And I guess PS3 can be removed from the list, as we don't use fake PCI anymore.

The list above is really the list of platforms on which the person compiling the kernel get a choice about having PCI support.  Whether PCI is enabled or not by default is decided by the (unquoted) following lines:

        default y if !40x && !CPM2 && !8xx && !APUS && !PPC_83xx \
                && !PPC_85xx && !PPC_86xx
        default PCI_PERMEDIA if !4xx && !CPM2 && !8xx && APUS
        default PCI_QSPAN if !4xx && !CPM2 && 8xx

Which is a whole different can of worms :-)

So if PS3 doesn't use PCI at all then it should be removed from the above list and
	default n if PPC_PS3
should be added ..

Let me try to do a patch on top of the current set.
--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__6_Mar_2007_12_57_43_+1100__JNtbgXG52Em0Ilg
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFF7MqdFdBgD/zoJvwRAuFyAJ0dQlpBOQipiETYVMUPUu3sxhr6RACfTxwp
cAKmD4rEZjjUz9H1xqU+KPw=
=Vpbm
-----END PGP SIGNATURE-----

--Signature=_Tue__6_Mar_2007_12_57_43_+1100__JNtbgXG52Em0Ilg--
