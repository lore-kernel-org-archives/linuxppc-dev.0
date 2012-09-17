Return-Path: <B38951@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A67E62C0082
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Sep 2012 12:12:16 +1000 (EST)
From: Jia Hongtao-B38951 <B38951@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: RE: [PATCH V10] powerpc/fsl-pci: Unify pci/pcie initialization code
Date: Mon, 17 Sep 2012 02:12:09 +0000
Message-ID: <412C8208B4A0464FA894C5F0C278CD5D01AA88E5@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1346139848-28021-1-git-send-email-B38951@freescale.com>
 <A3F539F8-4264-4823-97F1-AA6E028799B5@kernel.crashing.org>
In-Reply-To: <A3F539F8-4264-4823-97F1-AA6E028799B5@kernel.crashing.org>
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
> Sent: Thursday, September 13, 2012 4:20 AM
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
> >
> > arch/powerpc/platforms/85xx/common.c       |   10 +++
> > arch/powerpc/platforms/85xx/corenet_ds.c   |   34 ++--------
> > arch/powerpc/platforms/85xx/ge_imp3a.c     |   62 ++++++-----------
> > arch/powerpc/platforms/85xx/mpc8536_ds.c   |   36 +---------
> > arch/powerpc/platforms/85xx/mpc85xx_ads.c  |   11 +--
> > arch/powerpc/platforms/85xx/mpc85xx_cds.c  |   44 +++++++++----
> > arch/powerpc/platforms/85xx/mpc85xx_ds.c   |   14 ++--
> > arch/powerpc/platforms/85xx/mpc85xx_mds.c  |   40 ++---------
> > arch/powerpc/platforms/85xx/mpc85xx_rdb.c  |   30 +++-----
> > arch/powerpc/platforms/85xx/p1010rdb.c     |   14 +---
> > arch/powerpc/platforms/85xx/p1022_ds.c     |   36 +---------
> > arch/powerpc/platforms/85xx/p1022_rdk.c    |   36 +---------
> > arch/powerpc/platforms/85xx/p1023_rds.c    |    9 +--
> > arch/powerpc/platforms/85xx/p2041_rdb.c    |    2 +-
> > arch/powerpc/platforms/85xx/p3041_ds.c     |    2 +-
> > arch/powerpc/platforms/85xx/p4080_ds.c     |    2 +-
> > arch/powerpc/platforms/85xx/p5020_ds.c     |    2 +-
> > arch/powerpc/platforms/85xx/p5040_ds.c     |    2 +-
> > arch/powerpc/platforms/85xx/qemu_e500.c    |    4 +-
> > arch/powerpc/platforms/85xx/sbc8548.c      |   21 +-----
> > arch/powerpc/platforms/85xx/socrates.c     |   11 +---
> > arch/powerpc/platforms/85xx/stx_gp3.c      |   13 +---
> > arch/powerpc/platforms/85xx/tqm85xx.c      |   21 +-----
> > arch/powerpc/platforms/85xx/xes_mpc85xx.c  |   56 ++-------------
> > arch/powerpc/platforms/86xx/gef_ppc9a.c    |   12 +--
> > arch/powerpc/platforms/86xx/gef_sbc310.c   |   13 +---
> > arch/powerpc/platforms/86xx/gef_sbc610.c   |   12 +--
> > arch/powerpc/platforms/86xx/mpc8610_hpcd.c |   21 ++----
> > arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |   42 ++----------
> > arch/powerpc/platforms/86xx/sbc8641d.c     |   14 +---
> > arch/powerpc/sysdev/fsl_pci.c              |  102 +++++++++++++++++----
> -------
> > arch/powerpc/sysdev/fsl_pci.h              |   15 +++-
> > drivers/edac/mpc85xx_edac.c                |   43 +++---------
> > 33 files changed, 249 insertions(+), 537 deletions(-)
>=20
> applied to next
>=20
> - k

Thanks.
I will sent PM patch for PCI soon.

- Hongtao.
