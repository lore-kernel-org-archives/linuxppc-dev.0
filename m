Return-Path: <B32579@freescale.com>
Received: from TX2EHSOBE007.bigfish.com (tx2ehsobe004.messaging.microsoft.com
	[65.55.88.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 05F4CB71CE
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 20 May 2011 15:03:37 +1000 (EST)
From: Kushwaha Prabhakar-B32579 <B32579@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: RE: [PATCH] powerpc/85xx: Save and restore pcie ATMU windows for PM
Date: Fri, 20 May 2011 05:01:21 +0000
Message-ID: <071A08F2C6A57E4E94D980ECA553F8741D9670@039-SN1MPN1-005.039d.mgd.msft.net>
References: <1303972729-32242-1-git-send-email-prabhakar@freescale.com>
	<3A8FAEED-7BD9-4776-85A9-560D07417BA8@kernel.crashing.org>
	<071A08F2C6A57E4E94D980ECA553F8741D5C33@039-SN1MPN1-005.039d.mgd.msft.net>
	<EFA5CCD8-07AE-4AD3-A067-4E79F61B3886@kernel.crashing.org>
	<071A08F2C6A57E4E94D980ECA553F8741D8D46@039-SN1MPN1-005.039d.mgd.msft.net>
	<0CF50C76-D9D0-4966-87B9-CD4EDF6ABC07@kernel.crashing.org>
In-Reply-To: <0CF50C76-D9D0-4966-87B9-CD4EDF6ABC07@kernel.crashing.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "meet2prabhu@gmail.com" <meet2prabhu@gmail.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	Jiang Yutang-B14898 <B14898@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> Sent: Friday, May 20, 2011 10:19 AM
> To: Kushwaha Prabhakar-B32579
> Cc: linuxppc-dev@lists.ozlabs.org; meet2prabhu@gmail.com; Jiang Yutang-
> B14898
> Subject: Re: [PATCH] powerpc/85xx: Save and restore pcie ATMU windows for
> PM
>=20
>=20
> On May 19, 2011, at 11:41 PM, Kushwaha Prabhakar-B32579 wrote:
>=20
> >
> >
> >> -----Original Message-----
> >> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> >> Sent: Thursday, May 19, 2011 6:53 PM
> >> To: Kushwaha Prabhakar-B32579
> >> Cc: linuxppc-dev@lists.ozlabs.org; meet2prabhu@gmail.com; Jiang
> >> Yutang-
> >> B14898
> >> Subject: Re: [PATCH] powerpc/85xx: Save and restore pcie ATMU windows
> >> for PM
> >>
> >>
> >> On May 19, 2011, at 6:22 AM, Kushwaha Prabhakar-B32579 wrote:
> >>
> >>> Hi Kumar,
> >>> Please find my answer in-lined
> >>>
> >>>> -----Original Message-----
> >>>> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> >>>> Sent: Thursday, May 19, 2011 12:00 PM
> >>>> To: Kushwaha Prabhakar-B32579
> >>>> Cc: linuxppc-dev@lists.ozlabs.org; meet2prabhu@gmail.com; Jiang
> >>>> Yutang-
> >>>> B14898
> >>>> Subject: Re: [PATCH] powerpc/85xx: Save and restore pcie ATMU
> >>>> windows for PM
> >>>>
> >>>>
> >>>> On Apr 28, 2011, at 1:38 AM, Prabhakar Kushwaha wrote:
> >>>>
> >>>>> D3-cold state indicates removal of the clock and power. however
> >>>>> auxiliary (AUX) Power may remain available even after the main
> >>>>> power
> >>>> rails are powered down.
> >>>>>
> >>>>> wakeup from D3-cold state requires full context restore. Other
> >>>>> things are taken care in pci-driver except ATMUs.
> >>>>> ATMU windows needs to be saved and restored during suspend and
> >> resume.
> >>>>>
> >>>>> Signed-off-by: Jiang Yutang <b14898@freescale.com>
> >>>>> Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
> >>>>> ---
> >>>>> Based upon
> >>>>> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.g
> >>>>> it
> >>>>> (b
> >>>>> ranch master)
> >>>>>
> >>>>> arch/powerpc/sysdev/fsl_pci.c |  116
> >>>> +++++++++++++++++++++++++++++++++++++++++
> >>>>> arch/powerpc/sysdev/fsl_pci.h |    7 ++-
> >>>>> 2 files changed, 121 insertions(+), 2 deletions(-)
> >>>>
> >>>> Is this patch for when we are a host or agent?
> >>>
> >>> This patch is independent of host or agent. It is for supporting D3
> >> cold state for P1022.
> >>> These functions are called during System level suspend and resume.
> >>>
> >>> --Prabhakar
> >>
> >> I'm trying to figure out why this is limited to P1022.
> >
> > Till now, No SOC was supporting D3 cold state. First time P1022
> supporting it.
> > Note:  D3 cold state =3D=3D PCIe block Power down
> >
>=20
> I'm wondering a few things:
>=20
> 1. Is there any reason not to do this for ALL FSL PCIe SoCs?

Yes, I am agree with you. It can be done.=20
But as only P1022 SOC supporting it. There is no use of handling it.=20

> 2. why do bother saving state, we don't we re-parse the .dts and
> reconfigure ATMUs that way?

I also thought of this case. But Agent use case scenario forbid me to do th=
is.=20
As ATMU's are programmed by host depending upon different use case . And th=
is information is never stored in the dts.

--Prabhakar



=20
