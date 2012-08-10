Return-Path: <B38951@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe002.messaging.microsoft.com [216.32.180.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7493C2C00A3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Aug 2012 12:17:56 +1000 (EST)
From: Jia Hongtao-B38951 <B38951@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>, Li Yang-R58472
 <r58472@freescale.com>
Subject: RE: [PATCH 5/6] powerpc/fsl-pci: Add pci inbound/outbound PM support
Date: Fri, 10 Aug 2012 02:17:45 +0000
Message-ID: <412C8208B4A0464FA894C5F0C278CD5D01A52403@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1343125210-16720-1-git-send-email-B38951@freescale.com>
 <1343125210-16720-5-git-send-email-B38951@freescale.com>
 <946C76FC-1F2E-4F09-919F-D5769D29E1A4@kernel.crashing.org>
 <412C8208B4A0464FA894C5F0C278CD5D01A29E98@039-SN1MPN1-002.039d.mgd.msft.net>
 <BAB2AC7D-90D8-473A-83A0-59BD6F730E62@kernel.crashing.org>
 <412C8208B4A0464FA894C5F0C278CD5D01A48CF7@039-SN1MPN1-002.039d.mgd.msft.net>
 <50213597.5080600@freescale.com>
 <412C8208B4A0464FA894C5F0C278CD5D01A51933@039-SN1MPN1-002.039d.mgd.msft.net>
 <1C95474C-B59D-4635-8FA9-B76165E177CD@kernel.crashing.org>
 <412C8208B4A0464FA894C5F0C278CD5D01A51DA2@039-SN1MPN1-002.039d.mgd.msft.net>
 <CADRPPNRT3i-cmAtTmCzi4Rt6ohPpvk1U0vNHZZQqbCGeCJ5Cag@mail.gmail.com>
 <90115399-5F52-44AC-99F7-86738AABDA66@kernel.crashing.org>
In-Reply-To: <90115399-5F52-44AC-99F7-86738AABDA66@kernel.crashing.org>
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
> Sent: Thursday, August 09, 2012 9:08 PM
> To: Li Yang-R58472
> Cc: Jia Hongtao-B38951; Wood Scott-B07421; linuxppc-dev@lists.ozlabs.org;
> Li Yang-R58472
> Subject: Re: [PATCH 5/6] powerpc/fsl-pci: Add pci inbound/outbound PM
> support
>=20
>=20
> On Aug 9, 2012, at 12:05 AM, Li Yang wrote:
>=20
> > On Thu, Aug 9, 2012 at 10:52 AM, Jia Hongtao-B38951
> > <B38951@freescale.com> wrote:
> >>
> >>
> >>> -----Original Message-----
> >>> From: Linuxppc-dev [mailto:linuxppc-dev-
> >>> bounces+b38951=3Dfreescale.com@lists.ozlabs.org] On Behalf Of Kumar
> >>> bounces+Gala
> >>> Sent: Wednesday, August 08, 2012 8:47 PM
> >>> To: Jia Hongtao-B38951
> >>> Cc: Wood Scott-B07421; linuxppc-dev@lists.ozlabs.org; Li Yang-R58472
> >>> Subject: Re: [PATCH 5/6] powerpc/fsl-pci: Add pci inbound/outbound
> >>> PM support
> >>>
> >>>>>>>>>
> >>>>>>>>> On Jul 24, 2012, at 5:20 AM, Jia Hongtao wrote:
> >>>>>>>>>
> >>>>>>>>>> Power supply for PCI inbound/outbound window registers is off
> >>>>>>>>>> when
> >>>>>>>>> system
> >>>>>>>>>> go to deep-sleep state. We save the values of registers
> >>>>>>>>>> before suspend and restore to registers after resume.
> >>>>>>>>>>
> >>>>>>>>>> Signed-off-by: Jiang Yutang <b14898@freescale.com>
> >>>>>>>>>> Signed-off-by: Jia Hongtao <B38951@freescale.com>
> >>>>>>>>>> Signed-off-by: Li Yang <leoli@freescale.com>
> >>>>>>>>>> ---
> >>>>>>>>>> arch/powerpc/include/asm/pci-bridge.h |    2 +-
> >>>>>>>>>> arch/powerpc/sysdev/fsl_pci.c         |  121
> >>>>>>>>> +++++++++++++++++++++++++++++++++
> >>>>>>>>>> 2 files changed, 122 insertions(+), 1 deletions(-)
> >>>>>>>>>
> >>>>>>>>> Remind me why we need to save/restore PCI ATMUs, why not just
> >>>>>>>>> re-parse the device tree to restore?
> >>>>>>>>>
> >>>>>>>>> - k
> >>>>>>>>
> >>>>>>>> Save/restore is the more efficient way. Latency of sleep/wakeup
> >>>>>>>> is one of most important features in power management.
> >>>>>>>>
> >>>>>>>> -Hongtao.
> >>>>>>>
> >>>>>>> I don't think the time it takes to run through setup_pci_atmu()
> >>>>>>> is that long compared to fsl_pci_resume().
> >>>>>>>
> >>>>>>> Also, don't you need to setup PCICCSRBAR and do setup_pci_cmd()
> >>>>>>> on
> >>>>> resume?
> >>>>>>>
> >>>>>>> - k
> >>>>>>
> >>>>>> Hi Kumar,
> >>>>>> I did some tests on P1022DS and found out that PCI_CMD and
> >>>>>> PCICSRBAR is not lost when system in deep sleep. We don't need to
> save it.
> >>>>>
> >>>>> How does the PCI code know you're entering deep sleep and not
> >>> hibernation?
> >>>>>
> >>>>> -Scott
> >>>>
> >>>> When system come back from hibernation PCI will be initialized again=
.
> >>>> So no need to save PCI_CMD and PEXCSRBAR.
> >>>>
> >>>> -Hongtao.
> >>>>
> >>>
> >>> What do you mean PCI will be initialized again?  What code path are
> >>> you talking about that would set PCI_CMD & PEXCSRBAR?
> >>>
> >>> - k
> >>
> >>
> >> In hibernation mode:
> >>
> >> When system come back from hibernation kernel will start up again.
> >> Before loading hibernation image PCI initialization has already done.
> >> Some other hardware also re-init again.
> >
> > In current Linux implementation, restoring from hibernation image is
> > using late initcall.  By that time, all the platform devices are
> > already initialized like a fresh boot.
> >
> > - Leo
>=20
> I ask against, what specific code path (I'd like a call trace) would
> cause PCI_CMD and PEXCSRBAR to be set in the wakeup case?
>=20
> - k

The code path is the same as a fresh boot:
fsl_add_bridge()
	-> setup_pci_cmd() [PCI_CMD is set]
	-> setup_pci_atmu() [PEXCSRBAR is set]

- Hongtao.
