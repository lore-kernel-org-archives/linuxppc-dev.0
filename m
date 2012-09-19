Return-Path: <B38951@freescale.com>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe005.messaging.microsoft.com [213.199.154.143])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E2E142C007C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Sep 2012 17:10:19 +1000 (EST)
From: Jia Hongtao-B38951 <B38951@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: RE: [PATCH][V4] powerpc/fsl-pci: Add pci inbound/outbound PM support
Date: Wed, 19 Sep 2012 07:10:07 +0000
Message-ID: <412C8208B4A0464FA894C5F0C278CD5D01AAA35A@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1347934234-18223-1-git-send-email-B38951@freescale.com>
 <86ADF4ED-B84C-4560-8781-D9FA4486D854@kernel.crashing.org>
In-Reply-To: <86ADF4ED-B84C-4560-8781-D9FA4486D854@kernel.crashing.org>
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
> Sent: Tuesday, September 18, 2012 1:04 PM
> To: Jia Hongtao-B38951
> Cc: linuxppc-dev@lists.ozlabs.org; Li Yang-R58472; Wood Scott-B07421
> Subject: Re: [PATCH][V4] powerpc/fsl-pci: Add pci inbound/outbound PM
> support
>=20
>=20
> On Sep 17, 2012, at 9:10 PM, Jia Hongtao wrote:
>=20
> > Power supply for PCI inbound/outbound window registers is off when
> > system go to deep-sleep state. We save the values of registers before
> > suspend and restore to registers after resume.
> >
> > Signed-off-by: Jiang Yutang <b14898@freescale.com>
> > Signed-off-by: Jia Hongtao <B38951@freescale.com>
> > Signed-off-by: Li Yang <leoli@freescale.com>
> > ---
> > Changes for V4:
> > We just rebase the patch upon following patch:
> > powerpc/fsl-pci: Unify pci/pcie initialization code
> >
> > arch/powerpc/include/asm/pci-bridge.h |    2 +-
> > arch/powerpc/sysdev/fsl_pci.c         |  121
> +++++++++++++++++++++++++++++++++
> > 2 files changed, 122 insertions(+), 1 deletions(-)
>=20
> Did you ever compare this to just re-parsing device tree method?
>=20
> - k

I tested the re-parsing way by using setup_pci_atmu() when resume.
And I found out that re-parsing will *change* outbound IO translation
address regitster.

It seems that in the first bootup, after setup_atmu()
pcibios_setup_phb_resources() may update hose->io_resource, but atmu
is not updated according to the new hose->io_resource value.
In resume from sleep setup_atmu() will reset atmu according to the
new hose->io_resource value. So the setup_atmu() will cause different
result on outbound IO register between first bootup and resume from
sleep.

So... There's a possibility that in the first bootup atmu is not setup
properly.

Anyway, if setup_pci_atmu() at resume is functionally right then re-parsing
is a good way for PM. I also test the latency of re-parsing and save/restor=
e,
both way are acceptable.


- Hongtao.
