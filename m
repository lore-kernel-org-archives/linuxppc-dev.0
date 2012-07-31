Return-Path: <B38951@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe005.messaging.microsoft.com [216.32.180.31])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5E3C32C007D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jul 2012 12:22:23 +1000 (EST)
From: Jia Hongtao-B38951 <B38951@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: RE: [PATCH V3 1/5] powerpc/fsl-pci: Unify pci/pcie initialization code
Date: Tue, 31 Jul 2012 02:22:06 +0000
Message-ID: <412C8208B4A0464FA894C5F0C278CD5D01A2A7BE@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1343305827-26734-1-git-send-email-B38951@freescale.com>
 <F5E29818-CC20-444E-A125-249E5E3BA365@kernel.crashing.org>
 <412C8208B4A0464FA894C5F0C278CD5D01A2883B@039-SN1MPN1-002.039d.mgd.msft.net>
 <73450B27-5496-499C-B7D1-13B797FE7650@kernel.crashing.org>
 <412C8208B4A0464FA894C5F0C278CD5D01A29FBA@039-SN1MPN1-002.039d.mgd.msft.net>
 <17090D6F-51B7-405E-B8BE-55454D256EB0@kernel.crashing.org>
In-Reply-To: <17090D6F-51B7-405E-B8BE-55454D256EB0@kernel.crashing.org>
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
> Sent: Monday, July 30, 2012 10:47 PM
> To: Jia Hongtao-B38951
> Cc: linuxppc-dev@lists.ozlabs.org; Wood Scott-B07421; Li Yang-R58472
> Subject: Re: [PATCH V3 1/5] powerpc/fsl-pci: Unify pci/pcie
> initialization code
>=20
>=20
> On Jul 30, 2012, at 3:07 AM, Jia Hongtao-B38951 wrote:
>=20
> >> -----Original Message-----
> >> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> >> Sent: Friday, July 27, 2012 8:47 PM
> >> To: Jia Hongtao-B38951
> >> Cc: linuxppc-dev@lists.ozlabs.org; Wood Scott-B07421; Li Yang-R58472
> >> Subject: Re: [PATCH V3 1/5] powerpc/fsl-pci: Unify pci/pcie
> >> initialization code
> >>
> >>
> >> On Jul 27, 2012, at 3:35 AM, Jia Hongtao-B38951 wrote:
> >>
> >>>
> >>>
> >>>> -----Original Message-----
> >>>> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> >>>> Sent: Friday, July 27, 2012 2:15 AM
> >>>> To: Jia Hongtao-B38951
> >>>> Cc: linuxppc-dev@lists.ozlabs.org; Wood Scott-B07421; Li Yang-R58472
> >>>> Subject: Re: [PATCH V3 1/5] powerpc/fsl-pci: Unify pci/pcie
> >>>> initialization code
> >>>>
> >>>>
> >>>> On Jul 26, 2012, at 7:30 AM, Jia Hongtao wrote:
> >>>>
> >>>>> We unified the Freescale pci/pcie initialization by changing the
> >>>> fsl_pci
> >>>>> to a platform driver. In previous PCI code architecture the
> >>>> initialization
> >>>>> routine is called at board_setup_arch stage. Now the initialization
> >> is
> >>>> done
> >>>>> in probe function which is architectural better. Also It's
> convenient
> >>>> for
> >>>>> adding PM support for PCI controller in later patch.
> >>>>>
> >>>>> One issue introduced by this architecture is the timing of
> >> swiotlb_init.
> >>>>> During PCI initialization the need of swiotlb is determined and
> this
> >>>> should
> >>>>> be done before swiotlb_init. So a new function to determine swiotlb
> >> by
> >>>>> parsing pci ranges is made. This function is called at
> >> board_setup_arch
> >>>>> stage which is earlier than swiotlb_init.
> >>>>>
> >>>>> Signed-off-by: Jia Hongtao <B38951@freescale.com>
> >>>>> Signed-off-by: Li Yang <leoli@freescale.com>
> >>>>> ---
> >>>>> Changed for V3:
> >>>>> - Rebase the patch set on the latest tree
> >>>>> - merge PCI unify and swiotlb patch into one
> >>>>>
> >>>>> arch/powerpc/sysdev/fsl_pci.c |  155
> >> ++++++++++++++++++++++++++++++++--
> >>>> -------
> >>>>> arch/powerpc/sysdev/fsl_pci.h |    9 +--
> >>>>> 2 files changed, 125 insertions(+), 39 deletions(-)
> >>>>
> >>>> I'd like the SWIOTLB refactoring as a separate patch.  Additionally,
> >> the
> >>>> order of patches should be as follows:
> >>>>
> >>>> 1. refactor PCI node parsing code
> >>>> 2. add pci_determine_swiotlb (should rename to
> >> fsl_pci_determine_swiotlb)
> >>>> 3. Determine primary bus by looking for ISA node
> >>>> 4. convert all boards over to fsl_pci_init
> >>>> 5. convert fsl pci to platform driver (edac and other fixes should
> be
> >>>> merged in here)
> >>>> 6. PM support
> >>>>
> >>>> - k
> >>>
> >>> Should I convert all boards over to fsl_pci_init first and then
> convert
> >> them
> >>> over to platform driver again or just convert them direct to platform
> >> driver?
> >>
> >> Yes do the fsl_pci_init conversion first.  The reason is we should NOT
> >> break functionality from one patch to another.
> >>
> >> - k
> >
> >
> > Actually, the functionality is not broken, other boards just use the
> old
> > Way to init pci controller and it still works.
>=20
> How do you figure?  The platform driver is going to get called on boards
> not yet converted.  So than you will get 2 different inits of PCI going
> on.
>=20
> - k

In Scott's patch set no platform driver used. fsl_pci_init is just a unifie=
d
routine function for all boards to call. Now other boards in which fsl_pci_=
init
is not called just use the old way to init.

-Hongtao.
