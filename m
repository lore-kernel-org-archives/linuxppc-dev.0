Return-Path: <B38951@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe004.messaging.microsoft.com [216.32.180.187])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 985952C031D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Aug 2012 12:25:35 +1000 (EST)
From: Jia Hongtao-B38951 <B38951@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: RE: [PATCH V10] powerpc/fsl-pci: Unify pci/pcie initialization code
Date: Fri, 31 Aug 2012 02:25:26 +0000
Message-ID: <412C8208B4A0464FA894C5F0C278CD5D01A745DC@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1346139848-28021-1-git-send-email-B38951@freescale.com>
 <0B7DF7C8-A3E9-4C9A-8734-B5ACEF52D258@kernel.crashing.org>
In-Reply-To: <0B7DF7C8-A3E9-4C9A-8734-B5ACEF52D258@kernel.crashing.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Li Yang-R58472 <r58472@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> Sent: Friday, August 31, 2012 12:54 AM
> To: Jia Hongtao-B38951
> Cc: linuxppc-dev@lists.ozlabs.org; Li Yang-R58472; Wood Scott-B07421
> Subject: Re: [PATCH V10] powerpc/fsl-pci: Unify pci/pcie initialization
> code
>=20
>=20
> On Aug 28, 2012, at 2:44 AM, Jia Hongtao wrote:
>=20
> > We unified the Freescale pci/pcie initialization by changing the
> > fsl_pci to a platform driver. In previous PCI code architecture the
> > initialization routine is called at board_setup_arch stage. Now the
> > initialization is done in probe function which is architectural
> > better. Also It's convenient for adding PM support for PCI controller
> in later patch.
> >
> > Now we registered pci controllers as platform devices. So we combine
> > two initialization code as one platform driver.
> >
> > Signed-off-by: Jia Hongtao <B38951@freescale.com>
> > Signed-off-by: Li Yang <leoli@freescale.com>
> > Signed-off-by: Chunhe Lan <Chunhe.Lan@freescale.com>
> > ---
> > Changes for V10:
> > * Just update comments for mpc85xx_cds_pci_assign_primary
>=20
> What do we have to say w/regards to Ben's comment about breaking of
> pci_fixup_final by moving to a platform driver?
>=20
> - k

If Ben mean the fixup order I have already gave some explanations as follow=
:

I have already done some investigations and the sequence of fixup
(including early, header, final) will not be changed in platform driver.

We register and init PCI controllers as platform devices at arch_initcall
stage and PCI scanning (pcibios_init) is at subsys_initcall stage in which
early and header fixup will be done in right sequence. The final fixup will
be start at rootfs_initcall stage which is later than early and header fixu=
p.

- Hongtao.
