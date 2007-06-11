Return-Path: <marc.leeman@gmail.com>
Received: from lmailproxy03.edpnet.net (lmailproxy03.edpnet.net [212.71.1.196])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 557D2DDEDC
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Jun 2007 02:21:41 +1000 (EST)
Received: from chiana.homelinux.org (213.219.153.216.adsl.dyn.edpnet.net
	[213.219.153.216])
	by lmailproxy03.edpnet.net (8.13.1/8.13.1) with ESMTP id l5BGMJXg028357
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Jun 2007 18:22:19 +0200
Received: from marc by chiana.homelinux.org with local (Exim 4.63)
	(envelope-from <marc.leeman@gmail.com>) id 1Hxme7-0004MR-F6
	for linuxppc-dev@ozlabs.org; Mon, 11 Jun 2007 18:21:35 +0200
Date: Mon, 11 Jun 2007 18:21:35 +0200
From: Marc Leeman <marc.leeman@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: 83xx GPIO/EXT int in arch/powerpc/
Message-ID: <20070611162135.GS2591@chiana.homelinux.org>
References: <20070604095625.GF17456@chiana.homelinux.org>
	<4E25DA41-741E-40AC-9186-936FEEFE6B29@freescale.com>
	<20070604211740.GN17456@chiana.homelinux.org>
	<C1F9584D-E778-4BE7-B11A-5505BA9B6F6C@freescale.com>
	<cbf493edec7259df199568389814dab6@kernel.crashing.org>
	<1181113438.31677.234.camel@localhost.localdomain>
	<3641c2a601dbccc9757fe9443d9330ca@kernel.crashing.org>
	<1181169093.31677.260.camel@localhost.localdomain>
	<d3c57096eec4553de180adab085d0145@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BlkQeOBdElZ1aiuH"
In-Reply-To: <d3c57096eec4553de180adab085d0145@kernel.crashing.org>
Reply-To: Marc Leeman <marc.leeman@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--BlkQeOBdElZ1aiuH
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > Poor guy trying to figure out the right way to do
> > his stuff will run away screaming and go back hard coding his number in
> > his platform code before we are finished :-)
>=20
> Heh I hope not.

Hm, I guess I took the dirty way suggested by Benjamin and having a look
at the CDS Freescale platform by copying the following in my platform
file:

static void __init mpc83xx_svc2_pcibios_fixup(void)
{
	struct pci_dev *dev;

	if ((dev =3D pci_get_device(VENDOR_ID_ALTERA,
					DEVICE_ID_FPGA834XG1, NULL))) {
		dev->irq =3D 23;
		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, 23);
		pci_dev_put(dev);
	}

	/* Now map all the PCI irqs */
	dev =3D NULL;
	for_each_pci_dev(dev)
		pci_read_irq_line(dev);

}

I am planning to have another look at the proper (tm) way to fix it, by
experimenting with my dts file; but since I need to get a number of
boards released, it's a bit pushed backwards.


What is more disturbing though, is that a number of operations on the
powerpc arch seems significantly slower wrt the ppc arch.

ioremap and iounmap being the most important one: we are using a small
driver that uses one of the UPMs in combination with GPIOs for HPI (Host
Port Interface) for TI DSPs.

Where the loading of a DSP took only 3 seconds, it went up to over a
minute on powerpc (same driver code).

Changing the driver to ioremap and unmap 0xe2400000 only once at driver
initialisation and unloading (not really relevant on this embedded
system, shame on me) instead twice for every word greatly improves the
time (around one second). However, this optimisation has the same effect
on ppc too :-/

Running the same application with the same modules on ppc and powerpc
(transferring data from the network to an FPGA) has a 50% higher load on
powerpc. The transfer is done with mapping user pages into the kernel
and DMA'ing them over PCI. What all driver have in common is that there
are quite some writes/reads to the IMMR configuration.

Decreasing the read and writes to the LBC for HPI (0xe2400000) seems to
improve the overall load.

So my question would be if I need to specify a special section in the
dts file for some reason; next to the U-Boot configuration that sends
writes to this address through the UPMB?

If not, is there any other reason that might account for these
significant performance drops?

--=20
  greetz, marc
Aeryn, did I say or do anything to piss you off? I mean other than
caving in the side of your head?
	Crichton - Die Me, Dichotomy
chiana 2.6.18-4-ixp4xx #1 Tue Mar 27 18:01:56 BST 2007 GNU/Linux

--BlkQeOBdElZ1aiuH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGbXaOUQpj09NWLeERArnaAJsGbPTqFRxgAk2uiMykp59vBJZ34wCeKzhX
+cvzedDpPPaKeGGjRVox+sM=
=pBt5
-----END PGP SIGNATURE-----

--BlkQeOBdElZ1aiuH--
