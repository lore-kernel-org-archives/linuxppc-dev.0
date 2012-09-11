Return-Path: <B38951@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe003.messaging.microsoft.com [213.199.154.206])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 105242C0078
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Sep 2012 14:49:54 +1000 (EST)
From: Jia Hongtao-B38951 <B38951@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: RE: [PATCH V10] powerpc/fsl-pci: Unify pci/pcie initialization code
Date: Tue, 11 Sep 2012 04:49:38 +0000
Message-ID: <412C8208B4A0464FA894C5F0C278CD5D01AA623F@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1346139848-28021-1-git-send-email-B38951@freescale.com>
 <0B7DF7C8-A3E9-4C9A-8734-B5ACEF52D258@kernel.crashing.org>,
 <412C8208B4A0464FA894C5F0C278CD5D01A745DC@039-SN1MPN1-003.039d.mgd.msft.net>
In-Reply-To: <412C8208B4A0464FA894C5F0C278CD5D01A745DC@039-SN1MPN1-003.039d.mgd.msft.net>
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

Hi Kumar,=0A=
=0A=
Do you or Ben has any comment on this?=0A=
Please let me know.=0A=
=0A=
Thanks.=0A=
=0A=
________________________________________=0A=
From: Jia Hongtao-B38951=0A=
Sent: Friday, August 31, 2012 10:25 AM=0A=
To: Kumar Gala=0A=
Cc: linuxppc-dev@lists.ozlabs.org; Li Yang-R58472; Wood Scott-B07421=0A=
Subject: RE: [PATCH V10] powerpc/fsl-pci: Unify pci/pcie initialization cod=
e=0A=
=0A=
> -----Original Message-----=0A=
> From: Kumar Gala [mailto:galak@kernel.crashing.org]=0A=
> Sent: Friday, August 31, 2012 12:54 AM=0A=
> To: Jia Hongtao-B38951=0A=
> Cc: linuxppc-dev@lists.ozlabs.org; Li Yang-R58472; Wood Scott-B07421=0A=
> Subject: Re: [PATCH V10] powerpc/fsl-pci: Unify pci/pcie initialization=
=0A=
> code=0A=
>=0A=
>=0A=
> On Aug 28, 2012, at 2:44 AM, Jia Hongtao wrote:=0A=
>=0A=
> > We unified the Freescale pci/pcie initialization by changing the=0A=
> > fsl_pci to a platform driver. In previous PCI code architecture the=0A=
> > initialization routine is called at board_setup_arch stage. Now the=0A=
> > initialization is done in probe function which is architectural=0A=
> > better. Also It's convenient for adding PM support for PCI controller=
=0A=
> in later patch.=0A=
> >=0A=
> > Now we registered pci controllers as platform devices. So we combine=0A=
> > two initialization code as one platform driver.=0A=
> >=0A=
> > Signed-off-by: Jia Hongtao <B38951@freescale.com>=0A=
> > Signed-off-by: Li Yang <leoli@freescale.com>=0A=
> > Signed-off-by: Chunhe Lan <Chunhe.Lan@freescale.com>=0A=
> > ---=0A=
> > Changes for V10:=0A=
> > * Just update comments for mpc85xx_cds_pci_assign_primary=0A=
>=0A=
> What do we have to say w/regards to Ben's comment about breaking of=0A=
> pci_fixup_final by moving to a platform driver?=0A=
>=0A=
> - k=0A=
=0A=
If Ben mean the fixup order I have already gave some explanations as follow=
:=0A=
=0A=
I have already done some investigations and the sequence of fixup=0A=
(including early, header, final) will not be changed in platform driver.=0A=
=0A=
We register and init PCI controllers as platform devices at arch_initcall=
=0A=
stage and PCI scanning (pcibios_init) is at subsys_initcall stage in which=
=0A=
early and header fixup will be done in right sequence. The final fixup will=
=0A=
be start at rootfs_initcall stage which is later than early and header fixu=
p.=0A=
=0A=
- Hongtao.=0A=
