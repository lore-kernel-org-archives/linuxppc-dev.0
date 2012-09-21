Return-Path: <r58472@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe002.messaging.microsoft.com [213.199.154.205])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 144252C0086
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Sep 2012 13:50:56 +1000 (EST)
From: Li Yang-R58472 <r58472@freescale.com>
To: Jia Hongtao-B38951 <B38951@freescale.com>, Kumar Gala
 <galak@kernel.crashing.org>
Subject: RE: [PATCH][V4] powerpc/fsl-pci: Add pci inbound/outbound PM support
Date: Fri, 21 Sep 2012 03:50:46 +0000
Message-ID: <94F013E7935FF44C83EBE7784D62AD3F09432A5F@039-SN2MPN1-021.039d.mgd.msft.net>
References: <1347934234-18223-1-git-send-email-B38951@freescale.com>
 <86ADF4ED-B84C-4560-8781-D9FA4486D854@kernel.crashing.org>
 <412C8208B4A0464FA894C5F0C278CD5D01AAA35A@039-SN1MPN1-002.039d.mgd.msft.net>,
 <36119932-E4BF-4DF6-8D33-C9A832883272@kernel.crashing.org>
 <412C8208B4A0464FA894C5F0C278CD5D01AAA4E8@039-SN1MPN1-002.039d.mgd.msft.net>
 <8086D08B-62B7-4838-8DB6-0F6158DE581A@kernel.crashing.org>
 <412C8208B4A0464FA894C5F0C278CD5D01AB4A6F@039-SN1MPN1-004.039d.mgd.msft.net>
In-Reply-To: <412C8208B4A0464FA894C5F0C278CD5D01AB4A6F@039-SN1MPN1-004.039d.mgd.msft.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Jia Hongtao-B38951
> Sent: Friday, September 21, 2012 11:14 AM
> To: Kumar Gala
> Cc: linuxppc-dev@lists.ozlabs.org; Li Yang-R58472; Wood Scott-B07421
> Subject: RE: [PATCH][V4] powerpc/fsl-pci: Add pci inbound/outbound PM
> support
>=20
>=20
>=20
> > -----Original Message-----
> > From: Kumar Gala [mailto:galak@kernel.crashing.org]
> > Sent: Wednesday, September 19, 2012 11:49 PM
> > To: Jia Hongtao-B38951
> > Cc: linuxppc-dev@lists.ozlabs.org; Li Yang-R58472; Wood Scott-B07421
> > Subject: Re: [PATCH][V4] powerpc/fsl-pci: Add pci inbound/outbound PM
> > support
> >
> > >>> On Sep 17, 2012, at 9:10 PM, Jia Hongtao wrote:
> > >>>
> > >>>> Power supply for PCI inbound/outbound window registers is off
> > >>>> when system go to deep-sleep state. We save the values of
> > >>>> registers
> > before
> > >>>> suspend and restore to registers after resume.
> > >>>>
> > >>>> Signed-off-by: Jiang Yutang <b14898@freescale.com>
> > >>>> Signed-off-by: Jia Hongtao <B38951@freescale.com>
> > >>>> Signed-off-by: Li Yang <leoli@freescale.com>
> > >>>> ---
> > >>>> Changes for V4:
> > >>>> We just rebase the patch upon following patch:
> > >>>> powerpc/fsl-pci: Unify pci/pcie initialization code
> > >>>>
> > >>>> arch/powerpc/include/asm/pci-bridge.h |    2 +-
> > >>>> arch/powerpc/sysdev/fsl_pci.c         |  121
> > >>> +++++++++++++++++++++++++++++++++
> > >>>> 2 files changed, 122 insertions(+), 1 deletions(-)
> > >>>
> > >>> Did you ever compare this to just re-parsing device tree method?
> > >>>
> > >>> - k
> > >>
> > >> I tested the re-parsing way by using setup_pci_atmu() when resume.
> > >> And I found out that re-parsing will *change* outbound IO
> > >> translation address regitster.
> > >>
> > >> It seems that in the first bootup, after setup_atmu()
> > >> pcibios_setup_phb_resources() may update hose->io_resource, but
> > >> atmu is not updated according to the new hose->io_resource value.
> > >> In resume from sleep setup_atmu() will reset atmu according to the
> > >> new hose->io_resource value. So the setup_atmu() will cause
> > >> different result on outbound IO register between first bootup and
> > >> resume from sleep.
> > >>
> > >> So... There's a possibility that in the first bootup atmu is not
> > >> setup properly.
> > >
> > > [Are you seeing this happen in your testing?  If so its a bug we
> > > need
> > to look at fixing.]
> > >
> > > Yes, I see this in my testing.
> > > Also PCIe ethernet card works well after resuming from sleep in both
> > save/restore
> > > and re-parsing way. (Maybe PCIe ethernet card don't need outbound IO
> > resource)
> > > So, I guess the result of re-parsing (actually it's re-setup) is
> > > right
> > and ATMU is not setup
> > > properly at the first bootup.
> >
> > Are you seeing the following message - "PCI: I/O resource not set for
> > host bridge" ?
>=20
> No.
>=20
> >
> > Trying to understand why you'd hit the reassignment of io_resource.
> >
> > - k
> >
>=20
> I did some investigations and the conclusion is:
>=20
> io_resource.flags & IORESOURCE_IO are both positive but io_resource.start
> is 0 before pcibios_setup_phb_io_space() is done.
>=20
> The sequence of related process listed below:
> fsl_add_bridge() -> setup_pci_atmu()
> pcibios_init() -> pcibios_scan_phb() -> pcibios_setup_phb_io_space()
>=20
> Because fsl_add_bridge() must be finished before pcibios_init() so ATMU
> is set when io_resource.start is 0. That means outbound IO regs are not
> set.
>=20
> If system re-setup ATMU the io_resource.start has already updated so
> outbound IO regs are set.
>=20
> My question is:
> Is there any problem if outbound IO regs are not set in first bootup?

Please also provide the IO resource address range before and after the pci =
scan.  Then we can evaluate if the range is needed to be mapped via ATMU.

Leo
