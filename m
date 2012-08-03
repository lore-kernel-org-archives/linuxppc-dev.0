Return-Path: <B38951@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe003.messaging.microsoft.com [216.32.180.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3E6812C0095
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Aug 2012 13:39:36 +1000 (EST)
From: Jia Hongtao-B38951 <B38951@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: RE: [PATCH V4 3/3] powerpc/fsl-pci: Unify pci/pcie initialization code
Date: Fri, 3 Aug 2012 03:39:28 +0000
Message-ID: <412C8208B4A0464FA894C5F0C278CD5D01A35A2F@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1343907741-20589-1-git-send-email-B38951@freescale.com>
 <1343907741-20589-4-git-send-email-B38951@freescale.com>
 <A4B0DB85-7B49-4748-8B94-0E1F1B7B663A@kernel.crashing.org>
In-Reply-To: <A4B0DB85-7B49-4748-8B94-0E1F1B7B663A@kernel.crashing.org>
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
> Sent: Thursday, August 02, 2012 8:24 PM
> To: Jia Hongtao-B38951
> Cc: linuxppc-dev@lists.ozlabs.org; Wood Scott-B07421; Li Yang-R58472
> Subject: Re: [PATCH V4 3/3] powerpc/fsl-pci: Unify pci/pcie
> initialization code
>=20
>=20
> On Aug 2, 2012, at 6:42 AM, Jia Hongtao wrote:
>=20
> > We unified the Freescale pci/pcie initialization by changing the
> fsl_pci
> > to a platform driver. In previous PCI code architecture the
> initialization
> > routine is called at board_setup_arch stage. Now the initialization is
> done
> > in probe function which is architectural better. Also It's convenient
> for
> > adding PM support for PCI controller in later patch.
> >
> > Now we registered pci controllers as platform devices. So we combine
> two
> > initialization code as one platform driver.
> >
> > Signed-off-by: Jia Hongtao <B38951@freescale.com>
> > Signed-off-by: Li Yang <leoli@freescale.com>
> > Signed-off-by: Chunhe Lan <Chunhe.Lan@freescale.com>
> > ---
> > arch/powerpc/platforms/85xx/mpc85xx_ds.c |   32 ++--------
> > arch/powerpc/sysdev/fsl_pci.c            |  102 ++++++++++++++++++-----
> ------
> > arch/powerpc/sysdev/fsl_pci.h            |    6 +-
> > drivers/edac/mpc85xx_edac.c              |   43 ++++---------
> > 4 files changed, 83 insertions(+), 100 deletions(-)
>=20
> You need to convert all boards to use fsl_pci_init before this patch.
> Otherwise we'll end up with PCI getting initialized twice on boards.
>=20
> - k

If we covert all boards with platform driver in this patch PCI will
be initialized only once without converting all boards to use
fsl_pci_init first.=20

If we convert all boards to use fsl_pci_init before this patch and
convert them to use platform driver again after this patch. Then
between this patch and next pci will be initialized twice too.

So I think convert all boards in this patch is the key not convert
all boards to use fsl_pci_init first before this patch.

-Hongtao.
