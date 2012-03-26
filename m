Return-Path: <B38951@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe002.messaging.microsoft.com [213.199.154.205])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A5130B6EEA
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Mar 2012 17:14:23 +1100 (EST)
From: Jia Hongtao-B38951 <B38951@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>, "<shuo.liu@freesacle.com>"
 <shuo.liu@freesacle.com>
Subject: RE: [PATCH] powerpc/85xx: Add machine check handler to fix PCIe
 erratum on mpc85xx
Date: Mon, 26 Mar 2012 06:14:10 +0000
Message-ID: <412C8208B4A0464FA894C5F0C278CD5D019CFB20@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1328861387-31390-1-git-send-email-shuo.liu@freesacle.com>
 <5A2DE148-B029-4FF0-A49B-29172F234874@kernel.crashing.org>
In-Reply-To: <5A2DE148-B029-4FF0-A49B-29172F234874@kernel.crashing.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "soniccat.liu@gmail.com" <soniccat.liu@gmail.com>,
 Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Zang Roy-R61911 <r61911@freescale.com>,
 Zhao Chenhui-B35336 <B35336@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: linuxppc-dev-bounces+b38951=3Dfreescale.com@lists.ozlabs.org
> [mailto:linuxppc-dev-bounces+b38951=3Dfreescale.com@lists.ozlabs.org] On
> Behalf Of Kumar Gala
> Sent: Saturday, March 17, 2012 5:04 AM
> To: <shuo.liu@freesacle.com>
> Cc: Zhao Chenhui-B35336; Liu Shuo-B35362; Zang Roy-R61911; Liu Shuo-
> B35362; Wood Scott-B07421; linuxppc-dev@lists.ozlabs.org
> Subject: Re: [PATCH] powerpc/85xx: Add machine check handler to fix PCIe
> erratum on mpc85xx
>=20
>=20
> On Feb 10, 2012, at 2:09 AM, <shuo.liu@freesacle.com>
> <shuo.liu@freesacle.com> wrote:
>=20
> > From: Liu Shuo <shuo.liu@freescale.com>
> >
> > A PCIe erratum of mpc85xx may causes a core hang when a link of PCIe
> > goes down. when the link goes down, Non-posted transactions issued
> > via the ATMU requiring completion result in an instruction stall.
> > At the same time a machine-check exception is generated to the core
> > to allow further processing by the handler. We implements the handler
> > which skips the instruction caused the stall.
> >
> > Signed-off-by: Zhao Chenhui <b35336@freescale.com>
> > Signed-off-by: Li Yang <leoli@freescale.com>
> > Signed-off-by: Liu Shuo <b35362@freescale.com>
> > ---
> > arch/powerpc/kernel/cpu_setup_fsl_booke.S |    2 +-
> > arch/powerpc/kernel/traps.c               |    3 ++
> > arch/powerpc/sysdev/fsl_pci.c             |   36
> +++++++++++++++++++++++++++++
> > arch/powerpc/sysdev/fsl_pci.h             |    6 +++++
> > 4 files changed, 46 insertions(+), 1 deletions(-)
>=20
> Should we have a check to make sure the hose is for PCIe and not PCI?
>=20
> - k

Due to errata spec pcie check is necessary.
I will send a new version of this patch to solve this problem soon.

Thanks.

Btw, from now on I will follow this patch instead of Liu Shuo.
- Jia Hongtao.
