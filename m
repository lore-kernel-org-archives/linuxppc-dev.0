Return-Path: <B38951@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe005.messaging.microsoft.com [216.32.180.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3A94C2C00AE
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Sep 2012 12:59:07 +1000 (EST)
From: Jia Hongtao-B38951 <B38951@freescale.com>
To: Jia Hongtao-B38951 <B38951@freescale.com>, Kumar Gala
 <galak@kernel.crashing.org>
Subject: RE: [PATCH][V4] powerpc/fsl-pci: Add pci inbound/outbound PM support
Date: Thu, 27 Sep 2012 02:58:46 +0000
Message-ID: <412C8208B4A0464FA894C5F0C278CD5D01AC2B34@039-SN1MPN1-004.039d.mgd.msft.net>
References: <1347934234-18223-1-git-send-email-B38951@freescale.com>
 <86ADF4ED-B84C-4560-8781-D9FA4486D854@kernel.crashing.org>
 <412C8208B4A0464FA894C5F0C278CD5D01AAA35A@039-SN1MPN1-002.039d.mgd.msft.net>,
 <36119932-E4BF-4DF6-8D33-C9A832883272@kernel.crashing.org>
 <412C8208B4A0464FA894C5F0C278CD5D01AAA4E8@039-SN1MPN1-002.039d.mgd.msft.net>
 <8086D08B-62B7-4838-8DB6-0F6158DE581A@kernel.crashing.org>
 <412C8208B4A0464FA894C5F0C278CD5D01AB4A6F@039-SN1MPN1-004.039d.mgd.msft.net>
 <94F013E7935FF44C83EBE7784D62AD3F09432A5F@039-SN2MPN1-021.039d.mgd.msft.net>
 <412C8208B4A0464FA894C5F0C278CD5D01AB6AE7@039-SN1MPN1-004.039d.mgd.msft.net>
 <95B12FA1-EC53-4632-8DFB-64109668BA9C@kernel.crashing.org>
 <412C8208B4A0464FA894C5F0C278CD5D01AB8317@039-SN1MPN1-004.039d.mgd.msft.net>
In-Reply-To: <412C8208B4A0464FA894C5F0C278CD5D01AB8317@039-SN1MPN1-004.039d.mgd.msft.net>
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
> From: Linuxppc-dev [mailto:linuxppc-dev-
> bounces+b38951=3Dfreescale.com@lists.ozlabs.org] On Behalf Of Jia Hongtao=
-
> B38951
> Sent: Monday, September 24, 2012 10:47 AM
> To: Kumar Gala
> Cc: Wood Scott-B07421; linuxppc-dev@lists.ozlabs.org; Li Yang-R58472
> Subject: RE: [PATCH][V4] powerpc/fsl-pci: Add pci inbound/outbound PM
> support
>=20
>=20
>=20
> > -----Original Message-----
> > From: Kumar Gala [mailto:galak@kernel.crashing.org]
> > Sent: Friday, September 21, 2012 9:16 PM
> > To: Jia Hongtao-B38951
> > Cc: Li Yang-R58472; linuxppc-dev@lists.ozlabs.org; Wood Scott-B07421
> > Subject: Re: [PATCH][V4] powerpc/fsl-pci: Add pci inbound/outbound PM
> > support
> >
> > >>>>>>>
> > >>>>>>> On Sep 17, 2012, at 9:10 PM, Jia Hongtao wrote:
> > >>>>>>>
> > >>>>>>>> Power supply for PCI inbound/outbound window registers is off
> > >>>>>>>> when system go to deep-sleep state. We save the values of
> > >>>>>>>> registers
> > >>>> before
> > >>>>>>>> suspend and restore to registers after resume.
> > >>>>>>>>
> > >>>>>>>> Signed-off-by: Jiang Yutang <b14898@freescale.com>
> > >>>>>>>> Signed-off-by: Jia Hongtao <B38951@freescale.com>
> > >>>>>>>> Signed-off-by: Li Yang <leoli@freescale.com>
> > >>>>>>>> ---
> > >>>>>>>> Changes for V4:
> > >>>>>>>> We just rebase the patch upon following patch:
> > >>>>>>>> powerpc/fsl-pci: Unify pci/pcie initialization code
> > >>>>>>>>
> > >>>>>>>> arch/powerpc/include/asm/pci-bridge.h |    2 +-
> > >>>>>>>> arch/powerpc/sysdev/fsl_pci.c         |  121
> > >>>>>>> +++++++++++++++++++++++++++++++++
> > >>>>>>>> 2 files changed, 122 insertions(+), 1 deletions(-)
> > >>>>>>>
> > >>>>>>> Did you ever compare this to just re-parsing device tree method=
?
> > >>>>>>>
> > >>>>>>> - k
> > >>>>>>
> > >>>>>> I tested the re-parsing way by using setup_pci_atmu() when
> resume.
> > >>>>>> And I found out that re-parsing will *change* outbound IO
> > >>>>>> translation address regitster.
> > >>>>>>
> > >>>>>> It seems that in the first bootup, after setup_atmu()
> > >>>>>> pcibios_setup_phb_resources() may update hose->io_resource, but
> > >>>>>> atmu is not updated according to the new hose->io_resource value=
.
> > >>>>>> In resume from sleep setup_atmu() will reset atmu according to
> > >>>>>> the new hose->io_resource value. So the setup_atmu() will cause
> > >>>>>> different result on outbound IO register between first bootup
> > >>>>>> and resume from sleep.
> > >>>>>>
> > >>>>>> So... There's a possibility that in the first bootup atmu is
> > >>>>>> not setup properly.
> > >>>>>
> > >>>>> [Are you seeing this happen in your testing?  If so its a bug we
> > >>>>> need
> > >>>> to look at fixing.]
> > >>>>>
> > >>>>> Yes, I see this in my testing.
> > >>>>> Also PCIe ethernet card works well after resuming from sleep in
> > >>>>> both
> > >>>> save/restore
> > >>>>> and re-parsing way. (Maybe PCIe ethernet card don't need
> > >>>>> outbound IO
> > >>>> resource)
> > >>>>> So, I guess the result of re-parsing (actually it's re-setup) is
> > >>>>> right
> > >>>> and ATMU is not setup
> > >>>>> properly at the first bootup.
> > >>>>
> > >>>> Are you seeing the following message - "PCI: I/O resource not set
> > >>>> for host bridge" ?
> > >>>
> > >>> No.
> > >>>
> > >>>>
> > >>>> Trying to understand why you'd hit the reassignment of io_resource=
.
> > >>>>
> > >>>> - k
> > >>>>
> > >>>
> > >>> I did some investigations and the conclusion is:
> > >>>
> > >>> io_resource.flags & IORESOURCE_IO are both positive but
> > >>> io_resource.start is 0 before pcibios_setup_phb_io_space() is done.
> > >>>
> > >>> The sequence of related process listed below:
> > >>> fsl_add_bridge() -> setup_pci_atmu()
> > >>> pcibios_init() -> pcibios_scan_phb() ->
> > >>> pcibios_setup_phb_io_space()
> > >>>
> > >>> Because fsl_add_bridge() must be finished before pcibios_init() so
> > >>> ATMU is set when io_resource.start is 0. That means outbound IO
> > >>> regs are not set.
> > >>>
> > >>> If system re-setup ATMU the io_resource.start has already updated
> > >>> so outbound IO regs are set.
> > >>>
> > >>> My question is:
> > >>> Is there any problem if outbound IO regs are not set in first
> bootup?
> >
> > Yes, it means that IO transactions would not work.
>=20
> I agree.
>=20
> >
> > >> Please also provide the IO resource address range before and after
> > >> the pci scan.  Then we can evaluate if the range is needed to be
> > >> mapped
> > via
> > >> ATMU.
> > >>
> > >> Leo
> > >
> > > Since potar is set by out_be32(&pci->pow[j].potar, (hose-
> > >io_resource.start >> 12);  I provide the result of
> > >hose->io_resource.start >> 12 as follows:
> > >
> > > pcie@ffe09000:
> > > before pci scan: io_resource.start >> 12: 0 after pci scan :
> > > io_resource.start >> 12: ff7ed
> > >
> > > pcie@ffe0a000:
> > > before pci scan: io_resource.start >> 12: 0 after pci scan :
> > > io_resource.start >> 12: ff7db
> > >
> > > pcie@ffe0b000:
> > > before pci scan: io_resource.start >> 12: 0 after pci scan :
> > > io_resource.start >> 12: ff7c9
> > >
> > > Note that I tested on P1022DS.
> > >
> > > - Hongtao.
> >
> > 1. What's the device tree nodes for PCIe look like?
> > 2. Can you get the pr_debug() in setup_pci_atmu() to print and report
> > results (as well as full boot log)
>=20
> Please refer to the attached file.
> In the log file I also print the device tree.
>=20
> - Hongtao.
>=20
> >
> > However, I think the change of the io_resource.start is normal and
> > correct behavior.
> >
> > - k
> >
>=20

Hi Kumar,
I have already sent the log.
Do you have any comment on it?

Thanks.
- Hongtao.
