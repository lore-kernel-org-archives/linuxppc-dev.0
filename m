Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 4563FDDE18
	for <linuxppc-dev@ozlabs.org>; Tue, 12 May 2009 16:03:57 +1000 (EST)
Date: Tue, 12 May 2009 16:03:52 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Nick Piggin <npiggin@suse.de>
Subject: Re: Next May 11 : BUG during scsi initialization
Message-Id: <20090512160352.4a97d2f4.sfr@canb.auug.org.au>
In-Reply-To: <20090512055918.GF32535@wotan.suse.de>
References: <20090511161442.3e9d9cb9.sfr@canb.auug.org.au>
	<4A081002.4050802@in.ibm.com>
	<20090511115233.GB8112@parisc-linux.org>
	<4A081437.7000409@in.ibm.com>
	<20090511122135.GC8112@parisc-linux.org>
	<20090512045716.GC32535@wotan.suse.de>
	<20090512155613.881fa2ec.sfr@canb.auug.org.au>
	<20090512055918.GF32535@wotan.suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__12_May_2009_16_03_52_+1000_BjGw3j+YibEzOCeC"
Cc: linux-scsi <linux-scsi@vger.kernel.org>, Matthew Wilcox <matthew@wil.cx>,
	linuxppc-dev@ozlabs.org, Pekka Enberg <penberg@cs.helsinki.fi>,
	linux-next@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__12_May_2009_16_03_52_+1000_BjGw3j+YibEzOCeC
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 12 May 2009 07:59:18 +0200 Nick Piggin <npiggin@suse.de> wrote:
>
> On Tue, May 12, 2009 at 03:56:13PM +1000, Stephen Rothwell wrote:
> > Hi Nick,
> >=20
> > On Tue, 12 May 2009 06:57:16 +0200 Nick Piggin <npiggin@suse.de> wrote:
> > >
> > > Hmm, I think (hope) your problems were fixed with the recent memory
> > > coruption bug fix for SLQB. (if not, let me know)
> > >=20
> > > This one possibly looks like a problem with remote memory allocation
> > > or memory hotplug or something like that. I'll do a bit of code
> > > review....
> >=20
> > These are -next kernels which include the two fixes you posted recently
> > (I am pretty sure).
>=20
> Yes they should do.
>=20
>=20
> >  I am also getting the network failures that Sachin
> > is seeing on several of my machines here.  The previously reported
> > problems have gone away.
>=20
> This one is a SCSI failure... was there also a network one reported?
> At any rate, I'm fairly sure this is a problem with SLQB, so it could
> easily happen in any early driver setup.

This is what I have been getting for the last few days:

calling  .ibmveth_module_init+0x0/0x80 @ 1
Unable to handle kernel paging request for data at address 0x22640004002d310
Faulting instruction address: 0xc000000000038840
cpu 0x0: Vector: 300 (Data Access) at [c0000000be67ef50]
    pc: c000000000038840: .memcpy+0x240/0x280
    lr: c0000000002a7860: .__nla_put+0x30/0x50
    sp: c0000000be67f1d0
   msr: 8000000000009032
   dar: 22640004002d310
 dsisr: 40000000
  current =3D 0xc0000000be67a000
  paca    =3D 0xc000000000913280
    pid   =3D 1, comm =3D swapper
enter ? for help
[link register   ] c0000000002a7860 .__nla_put+0x30/0x50
[c0000000be67f1d0] c0000000002a7850 .__nla_put+0x20/0x50 (unreliable)
[c0000000be67f260] c0000000002a7bb8 .nla_put+0x48/0x60
[c0000000be67f2e0] c0000000004a50b0 .rtnl_fill_ifinfo+0x320/0x740
[c0000000be67f3e0] c0000000004a586c .rtmsg_ifinfo+0x7c/0x110
[c0000000be67f480] c0000000004a59f0 .rtnetlink_event+0xf0/0x110
[c0000000be67f500] c00000000008a848 .notifier_call_chain+0x78/0x100
[c0000000be67f5a0] c0000000004964b8 .call_netdevice_notifiers+0x28/0x40
[c0000000be67f620] c000000000497a40 .register_netdevice+0x340/0x400
[c0000000be67f700] c000000000497b58 .register_netdev+0x58/0x80
[c0000000be67f790] c000000000574b4c .ibmveth_probe+0x2ec/0x400
[c0000000be67f8a0] c0000000000248b0 .vio_bus_probe+0xa0/0xb0
[c0000000be67f930] c000000000328b30 .driver_probe_device+0xf0/0x210
[c0000000be67f9d0] c000000000328d28 .__driver_attach+0xd8/0xe0
[c0000000be67fa60] c000000000327c78 .bus_for_each_dev+0x98/0xf0
[c0000000be67fb10] c000000000328898 .driver_attach+0x28/0x40
[c0000000be67fb90] c00000000032849c .bus_add_driver+0xdc/0x2d0
[c0000000be67fc30] c000000000329314 .driver_register+0x84/0x1d0
[c0000000be67fcd0] c0000000000247f0 .vio_register_driver+0x40/0x60
[c0000000be67fd60] c00000000077c5ac .ibmveth_module_init+0x5c/0x80
[c0000000be67fde0] c00000000000901c .do_one_initcall+0x6c/0x1e0
[c0000000be67fee0] c00000000074ed1c .kernel_init+0x1fc/0x280
[c0000000be67ff90] c00000000002a4c0 .kernel_thread+0x54/0x70

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__12_May_2009_16_03_52_+1000_BjGw3j+YibEzOCeC
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkoJEUgACgkQjjKRsyhoI8wVCwCghETX7ACUF5FVPfgkyLmvMfvz
+scAn1PxZrwx/m37pMxysYx076/PlsEn
=AIw9
-----END PGP SIGNATURE-----

--Signature=_Tue__12_May_2009_16_03_52_+1000_BjGw3j+YibEzOCeC--
