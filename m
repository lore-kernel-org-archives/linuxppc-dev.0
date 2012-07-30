Return-Path: <B38951@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe005.messaging.microsoft.com [216.32.180.31])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A722D2C0088
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jul 2012 16:09:57 +1000 (EST)
From: Jia Hongtao-B38951 <B38951@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: RE: [PATCH 5/6] powerpc/fsl-pci: Add pci inbound/outbound PM support
Date: Mon, 30 Jul 2012 06:09:36 +0000
Message-ID: <412C8208B4A0464FA894C5F0C278CD5D01A29E98@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1343125210-16720-1-git-send-email-B38951@freescale.com>
 <1343125210-16720-5-git-send-email-B38951@freescale.com>
 <946C76FC-1F2E-4F09-919F-D5769D29E1A4@kernel.crashing.org>
In-Reply-To: <946C76FC-1F2E-4F09-919F-D5769D29E1A4@kernel.crashing.org>
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
> Sent: Friday, July 27, 2012 9:24 PM
> To: Jia Hongtao-B38951
> Cc: linuxppc-dev@lists.ozlabs.org; Wood Scott-B07421; Li Yang-R58472
> Subject: Re: [PATCH 5/6] powerpc/fsl-pci: Add pci inbound/outbound PM
> support
>=20
>=20
> On Jul 24, 2012, at 5:20 AM, Jia Hongtao wrote:
>=20
> > Power supply for PCI inbound/outbound window registers is off when
> system
> > go to deep-sleep state. We save the values of registers before suspend
> > and restore to registers after resume.
> >
> > Signed-off-by: Jiang Yutang <b14898@freescale.com>
> > Signed-off-by: Jia Hongtao <B38951@freescale.com>
> > Signed-off-by: Li Yang <leoli@freescale.com>
> > ---
> > arch/powerpc/include/asm/pci-bridge.h |    2 +-
> > arch/powerpc/sysdev/fsl_pci.c         |  121
> +++++++++++++++++++++++++++++++++
> > 2 files changed, 122 insertions(+), 1 deletions(-)
>=20
> Remind me why we need to save/restore PCI ATMUs, why not just re-parse
> the device tree to restore?
>=20
> - k

Save/restore is the more efficient way. Latency of sleep/wakeup is one of
most important features in power management.

-Hongtao.
