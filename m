Return-Path: <jonb@marel.is>
Received: from marel.marel.is (GW-NAT01-ISLNET.marel.is [213.213.131.1])
	by ozlabs.org (Postfix) with ESMTP id BB3982BF0E
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  6 Jan 2005 22:37:55 +1100 (EST)
In-Reply-To: <20050105175646.GC14485@gate.ebshome.net>
To: Eugene Surovegin <ebs@ebshome.net>
MIME-Version: 1.0
Message-ID: <OF4A31BCB9.4155B59E-ON00256F81.003A1A73-00256F81.003FE2D0@marel.is>
From: "=?iso-8859-1?Q?J=F3n_Benediktsson?=" <jonb@marel.is>
Date: Thu, 6 Jan 2005 11:37:36 +0000
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC5200 - problem with CF card
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Eugene Surovegin <ebs@ebshome.net> wrote on 05.01.2005 17:56:46:

> On Wed, Jan 05, 2005 at 02:49:42PM +0000, J?n Benediktsson wrote:
> > > I am working with a custom MPC5200 board which uses the built-in=20
> > > ATA/IDE controller for a compact flash card.=20
> > > The Linux kernel is Denx linux=5F2=5F4=5Fdevel.=20
>=20
> [snip]
>=20
> > > mpc5xxx=5Fide: Setting up IDE interface ide0...=20
> > > Probing IDE interface ide0...=20
> > > hda: SanDisk SDCFBI-1024, ATA DISK drive=20
> > > hdb: probing with STATUS(0x00) instead of ALTSTATUS(0x7f)=20
> > > ide0: unexpected interrupt, status=3D0x00, count=3D1=20
>=20
> I had similar problem with some CF cards (while other like in your=20
> case worked fine).
>=20
> Try disabling probing of the slave ide0 interface (hdb). I'm not=20
> familiar with MPC5xxx, but most likely you can modify mpc5xxx=5Fide or=20
> whatever code sets up access to your CF card.
>=20
> Find where an instance of ide=5Fhwif=5Ft is initialized for ide0 and add =

> something like:
>=20
>    /* Don't probe second drive */
>         hwif->drives[1].noprobe =3D 1;
>=20

Thank you.  It was indeed the probing for the second drive that was=20
causing the problem.
Adding hdb=3Dnoprobe to the kernel command line (bootargs) fixes the proble=
m=20
without kernel modifications.

Thanks again,
Jon
