Return-Path: <B08248@freescale.com>
Received: from CH1EHSOBE016.bigfish.com (ch1ehsobe006.messaging.microsoft.com
	[216.32.181.186]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2AA43B6F75
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Jul 2011 03:41:26 +1000 (EST)
From: Yoder Stuart-B08248 <B08248@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>, Tabi Timur-B04825
	<B04825@freescale.com>
Subject: RE: RFC: top level compatibles for virtual platforms
Date: Mon, 11 Jul 2011 17:41:20 +0000
Message-ID: <9F6FE96B71CF29479FF1CDC8046E150316FBA5@039-SN1MPN1-003.039d.mgd.msft.net>
References: <9F6FE96B71CF29479FF1CDC8046E150316EAB6@039-SN1MPN1-003.039d.mgd.msft.net>
	<CAOZdJXVp5LHqYEMoqpnKEkuWyuE6kwU+Z9VwUYLPcz-+h_gqfw@mail.gmail.com>
	<9F6FE96B71CF29479FF1CDC8046E150316F97F@039-SN1MPN1-003.039d.mgd.msft.net>
	<4E1B1AAB.8010301@freescale.com>
	<20110711112418.4db9f41e@schlenkerla.am.freescale.net>
In-Reply-To: <20110711112418.4db9f41e@schlenkerla.am.freescale.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Gala Kumar-B11780 <B11780@freescale.com>, Alexander Graf <agraf@suse.de>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Wood Scott-B07421
> Sent: Monday, July 11, 2011 11:24 AM
> To: Tabi Timur-B04825
> Cc: Yoder Stuart-B08248; Grant Likely; Benjamin Herrenschmidt; Gala Kumar=
-B11780; Wood Scott-
> B07421; Alexander Graf; linuxppc-dev@ozlabs.org
> Subject: Re: RFC: top level compatibles for virtual platforms
>=20
> On Mon, 11 Jul 2011 10:45:47 -0500
> Timur Tabi <timur@freescale.com> wrote:
>=20
> > >> Also, if these are KVM creations, shouldn't there be a "kvm" in the
> > >> compatible string somewhere?
> > >
> > > There is nothing KVM specific about these platforms.  Any hypervisor
> > > could create a similar virtual machine.
> >
> > True, but I think we're on a slippery slope, here.  Virtualization
> > allows us to create "virtual platforms" that are not well defined.
> > Linux requires a unique compatible string for each platform.
>=20
> The device tree is supposed to describe the hardware (virtual or otherwis=
e), not just supply
> what Linux wants.  Perhaps there simply shouldn't be a toplevel compatibl=
e if there's nothing
> appropriate to describe there -- and fix whatever issues Linux has with t=
hat.

But there is a concept in Linux of a platform 'machine':

define_machine(p4080_ds) {
        .name                   =3D "P4080 DS",
        .probe                  =3D p4080_ds_probe,
        .setup_arch             =3D corenet_ds_setup_arch,
        .init_IRQ               =3D corenet_ds_pic_init,
#ifdef CONFIG_PCI
        .pcibios_fixup_bus      =3D fsl_pcibios_fixup_bus,
#endif
        .get_irq                =3D mpic_get_coreint_irq,
        .restart                =3D fsl_rstcr_restart,
        .calibrate_decr         =3D generic_calibrate_decr,
        .progress               =3D udbg_progress,
};

Right now p4080_ds_probe needs something to match on to determine
whether this is the machine type.   How would it work if=20
there was no top level compatible to match on?   Some=20
platforms (e.g. e500v2-type) need mpc85xx_ds_pic_init(),
others need corenet_ds_pic_init().  We need a way to
select the machine.

Stuart
