Return-Path: <marc.leeman@gmail.com>
Received: from lmailproxy04.edpnet.net (lmailproxy04.edpnet.net [212.71.1.197])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 22471DDF08
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Jun 2007 18:13:03 +1000 (EST)
Date: Fri, 15 Jun 2007 10:12:49 +0200
From: Marc Leeman <marc.leeman@gmail.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: 83xx GPIO/EXT int in arch/powerpc/
Message-ID: <20070615081249.GO2481@chiana.homelinux.org>
References: <C1F9584D-E778-4BE7-B11A-5505BA9B6F6C@freescale.com>
	<cbf493edec7259df199568389814dab6@kernel.crashing.org>
	<1181113438.31677.234.camel@localhost.localdomain>
	<3641c2a601dbccc9757fe9443d9330ca@kernel.crashing.org>
	<1181169093.31677.260.camel@localhost.localdomain>
	<d3c57096eec4553de180adab085d0145@kernel.crashing.org>
	<20070611162135.GS2591@chiana.homelinux.org>
	<894636D6-AC2E-4D28-8698-EB43C7354BB5@kernel.crashing.org>
	<20070612160628.GB2481@chiana.homelinux.org>
	<F8BCBDB1-B699-4353-8FD8-A8FA60380C6F@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CQDko/0aYvuiEzgn"
In-Reply-To: <F8BCBDB1-B699-4353-8FD8-A8FA60380C6F@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
Reply-To: Marc Leeman <marc.leeman@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--CQDko/0aYvuiEzgn
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Are you comparing 8245 on arch=3Dppc to 83xx on arch=3Dpowerpc or 83xx in=
 =20
> both cases?

No, I'm comparing ARCH=3Dppc and ARCH=3Dpowerpc, both on 8347E. The
comparison with a 8245 is due to the fact that this 83xx platform is a
follow up of the 8245 design.

With the 8245, we got almost a doubling of the effective processing of
data through the network by replacing the eepro100 driver with the e100
driver from intel. Since data transfer rate from the network on a 83xx
seems to be slower than the 8245/e100 combination, there might be some
driver work to do too to get the same improvement; but that's currently
just speculation on my part; I hope to have a look into that after the
summer.

> Hmm, we really need to put SVR in there as well (add that to the todo =20
> list).  Which 83xx is this?

MPC8347E

> Do you sense of how many calls you make to _hpi_set_hhwil & =20
> __hpi_read_hpid?

We're using a couple of GPIOs to toggle the first halfword and the
second halfword (running HPI 16-bit). Since we only have implemented
single beat accesses in the UPM, we also need to toggle between address
and data.

For every word, there are 4 similar calls; a DSP binary that is loaded
over HPI is around 400 kB, so in 500,000 order of magnitude per DSP
binary load.

During operation, HPI is used to get info from the DSPs @100-120 times per
second; just a couple of bytes though.

> I think I know why the ppc case was more efficient.

Wheee.

probably the ioremap and iounmap have something to do with it; in the
debugging version of the code, this was done for every GPIO access (cf.
supra) and there the slow down was from 3-4 secs to 1-2 mins.

> >Even after this change; the load of a streaming application was
> >something of 40% on ppc and 60% on powerpc.
>=20
> What's going on during the streaming?

Data is retreived from the network (UDP, TCP, mostly UDP/multicast
though) and partially decoded (converted to elementary stream). Data is
then transferred through an FPGA (over PCI) to a DSP with DMA (pushed
=66rom the 83xx processor). The data is mapped from userspace into kernel
in blocks of 4096kB to avoid copying.

The transfer of data is pretty straighforward:
  1. map user page into kernel
  2. grab dma channel
  3. init dma channel
  4. dma data out
  5. wait for interrupt

--=20
  greetz, marc
You'll be happy to know I have a plan.
	Crichton - Through the Looking Glass
chiana 2.6.18-4-ixp4xx #1 Tue Mar 27 18:01:56 BST 2007 GNU/Linux

--CQDko/0aYvuiEzgn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGckoBUQpj09NWLeERApQTAJ9HQgJUKVB9a4FwloJpBEoPuKi0KQCgro/c
RYL6Lqe9j+Il7et0ytIE4rs=
=Nnwi
-----END PGP SIGNATURE-----

--CQDko/0aYvuiEzgn--
