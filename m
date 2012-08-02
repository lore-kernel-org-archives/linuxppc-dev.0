Return-Path: <B38951@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe005.messaging.microsoft.com [213.199.154.208])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4446D2C0091
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Aug 2012 21:35:25 +1000 (EST)
From: Jia Hongtao-B38951 <B38951@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: RE: [PATCH 5/6] powerpc/fsl-pci: Add pci inbound/outbound PM support
Date: Thu, 2 Aug 2012 11:35:15 +0000
Message-ID: <412C8208B4A0464FA894C5F0C278CD5D01A3462B@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1343125210-16720-1-git-send-email-B38951@freescale.com>
 <1343125210-16720-5-git-send-email-B38951@freescale.com>
 <946C76FC-1F2E-4F09-919F-D5769D29E1A4@kernel.crashing.org>
 <412C8208B4A0464FA894C5F0C278CD5D01A29E98@039-SN1MPN1-002.039d.mgd.msft.net>
 <BAB2AC7D-90D8-473A-83A0-59BD6F730E62@kernel.crashing.org>
In-Reply-To: <BAB2AC7D-90D8-473A-83A0-59BD6F730E62@kernel.crashing.org>
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
> Sent: Tuesday, July 31, 2012 9:37 PM
> To: Jia Hongtao-B38951
> Cc: linuxppc-dev@lists.ozlabs.org; Wood Scott-B07421; Li Yang-R58472
> Subject: Re: [PATCH 5/6] powerpc/fsl-pci: Add pci inbound/outbound PM
> support
>=20
>=20
> On Jul 30, 2012, at 1:09 AM, Jia Hongtao-B38951 wrote:
>=20
> >> -----Original Message-----
> >> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> >> Sent: Friday, July 27, 2012 9:24 PM
> >> To: Jia Hongtao-B38951
> >> Cc: linuxppc-dev@lists.ozlabs.org; Wood Scott-B07421; Li Yang-R58472
> >> Subject: Re: [PATCH 5/6] powerpc/fsl-pci: Add pci inbound/outbound PM
> >> support
> >>
> >>
> >> On Jul 24, 2012, at 5:20 AM, Jia Hongtao wrote:
> >>
> >>> Power supply for PCI inbound/outbound window registers is off when
> >> system
> >>> go to deep-sleep state. We save the values of registers before
> suspend
> >>> and restore to registers after resume.
> >>>
> >>> Signed-off-by: Jiang Yutang <b14898@freescale.com>
> >>> Signed-off-by: Jia Hongtao <B38951@freescale.com>
> >>> Signed-off-by: Li Yang <leoli@freescale.com>
> >>> ---
> >>> arch/powerpc/include/asm/pci-bridge.h |    2 +-
> >>> arch/powerpc/sysdev/fsl_pci.c         |  121
> >> +++++++++++++++++++++++++++++++++
> >>> 2 files changed, 122 insertions(+), 1 deletions(-)
> >>
> >> Remind me why we need to save/restore PCI ATMUs, why not just re-parse
> >> the device tree to restore?
> >>
> >> - k
> >
> > Save/restore is the more efficient way. Latency of sleep/wakeup is one
> of
> > most important features in power management.
> >
> > -Hongtao.
>=20
> I don't think the time it takes to run through setup_pci_atmu() is that
> long compared to fsl_pci_resume().
>=20
> Also, don't you need to setup PCICCSRBAR and do setup_pci_cmd() on resume=
?
>=20
> - k

I will investigate on this and send the patch later.

-Hongtao.
