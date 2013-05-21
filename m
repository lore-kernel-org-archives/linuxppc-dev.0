Return-Path: <B38951@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe005.messaging.microsoft.com [65.55.88.15])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7B2542C00EF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 May 2013 12:07:29 +1000 (EST)
From: Jia Hongtao-B38951 <B38951@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "galak@kernel.crashing.org" <galak@kernel.crashing.org>
Subject: RE: [PATCH 2/2 V8] powerpc/85xx: Add machine check handler to fix
 PCIe erratum on mpc85xx
Date: Tue, 21 May 2013 02:07:52 +0000
Message-ID: <412C8208B4A0464FA894C5F0C278CD5D01C83675@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1367126408-12997-1-git-send-email-hongtao.jia@freescale.com>
 <1367126408-12997-2-git-send-email-hongtao.jia@freescale.com>
 <1367514224.24411.10@snotra>
 <412C8208B4A0464FA894C5F0C278CD5D01C5BCAA@039-SN1MPN1-002.039d.mgd.msft.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Li Yang-R58472 <r58472@freescale.com>,
 Jia Hongtao-B38951 <B38951@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben and Kumar,

I'm really appreciate if you could help me to review this patches
for these patches were pending nearly a month.

Thanks.
-Hongtao

> -----Original Message-----
> From: Jia Hongtao-B38951
> Sent: Monday, May 13, 2013 2:20 PM
> To: 'Benjamin Herrenschmidt'
> Cc: linuxppc-dev@lists.ozlabs.org; galak@kernel.crashing.org; Wood Scott-
> B07421; Li Yang-R58472; Jia Hongtao-B38951
> Subject: RE: [PATCH 2/2 V8] powerpc/85xx: Add machine check handler to
> fix PCIe erratum on mpc85xx
>=20
> Hi Ben,
>=20
> These four patches have been reviewed for a long time
> and look good to Scott Wood.
> It seems Kumar have no enough time for further review.
> Could you please help me to review them?
>=20
> http://patchwork.ozlabs.org/patch/233211/
> http://patchwork.ozlabs.org/patch/235276/
> http://patchwork.ozlabs.org/patch/240238/
> http://patchwork.ozlabs.org/patch/240239/
>=20
> Thanks.
> -Hongtao
>=20
> > -----Original Message-----
> > From: Jia Hongtao-B38951
> > Sent: Friday, May 10, 2013 12:01 PM
> > To: galak@kernel.crashing.org
> > Cc: linuxppc-dev@lists.ozlabs.org; Li Yang-R58472; Jia Hongtao-B38951
> > Subject: RE: [PATCH 2/2 V8] powerpc/85xx: Add machine check handler to
> > fix PCIe erratum on mpc85xx
> >
> > > > -----Original Message-----
> > > > From: Wood Scott-B07421
> > > > Sent: Friday, May 03, 2013 1:04 AM
> > > > To: Jia Hongtao-B38951
> > > > Cc: linuxppc-dev@lists.ozlabs.org; galak@kernel.crashing.org; Wood
> > > > Scott- B07421; segher@kernel.crashing.org; Li Yang-R58472; Jia
> > > > Hongtao-B38951
> > > > Subject: Re: [PATCH 2/2 V8] powerpc/85xx: Add machine check handler
> > > > to fix PCIe erratum on mpc85xx
> > > >
> > > > On 04/28/2013 12:20:08 AM, Jia Hongtao wrote:
> > > > > A PCIe erratum of mpc85xx may causes a core hang when a link of
> > > > > PCIe goes down. when the link goes down, Non-posted transactions
> > > > > issued via the ATMU requiring completion result in an instruction
> > stall.
> > > > > At the same time a machine-check exception is generated to the
> > > > > core to allow further processing by the handler. We implements
> the
> > > > > handler which skips the instruction caused the stall.
> > > > >
> > > > > This patch depends on patch:
> > > > > powerpc/85xx: Add platform_device declaration to fsl_pci.h
> > > > >
> > > > > Signed-off-by: Zhao Chenhui <b35336@freescale.com>
> > > > > Signed-off-by: Li Yang <leoli@freescale.com>
> > > > > Signed-off-by: Liu Shuo <soniccat.liu@gmail.com>
> > > > > Signed-off-by: Jia Hongtao <hongtao.jia@freescale.com>
> > > > > ---
> > > > > V8:
> > > > > * Add A variant load instruction emulation.
> > > >
> > > > ACK
> > > >
> > > > -Scott
> > >
> > > Thanks for the review.
> > >
> > > Hi Kumar,
> > >
> > > Could you please review these MSI and PCI hang errata patches?
> > > http://patchwork.ozlabs.org/patch/233211/
> > > http://patchwork.ozlabs.org/patch/235276/
> > > http://patchwork.ozlabs.org/patch/240238/
> > > http://patchwork.ozlabs.org/patch/240239/ (This patch)
> > >
> > > Thanks.
> > > -Hongtao
> >
> > Hi Kumar,
> >
> > I'm really appreciated if you have time to review these patches?
> >
> > Thanks.
> > -Hongtao
