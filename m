Return-Path: <SRS0=vwdz=N7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC937C43441
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Nov 2018 07:09:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 942E420685
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Nov 2018 07:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HtPR6e1e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 942E420685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42zcJY2MX8zF3XQ
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Nov 2018 18:09:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="HtPR6e1e";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (helo)
 smtp.helo=out4-smtp.messagingengine.com (client-ip=66.111.4.28;
 helo=out4-smtp.messagingengine.com; envelope-from=ruscur@russell.cc;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.b="HtPR6e1e"; dkim-atps=neutral
X-Greylist: delayed 489 seconds by postgrey-1.36 at bilbo;
 Tue, 20 Nov 2018 18:06:59 AEDT
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42zcFv1Zc6zF3Kd
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Nov 2018 18:06:59 +1100 (AEDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id 7CB1322391;
 Tue, 20 Nov 2018 01:58:41 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Tue, 20 Nov 2018 01:58:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; bh=ydkfLYwLeSqsaDB4oU9fgO1O3Ewh4C7jb8HpFgYtz
 ME=; b=HtPR6e1eO1jEdByhcihBEEUi0v2XUUgo+iOTPphjWWvTUy0PQ6xqjLEfw
 UXQ4oyZ9B/EWpV3/qjyHHFlRHRHAqsNq8KOao91XyKli2boJiGaOjQvMypODokOE
 rqoFV9MSYdtjV8dge5NCkJjkEo01h31v5qraZeqksC5JY6QsjkxxLZoJb6gGYwkZ
 mvBv93tlIgq66cXy5MoQQSOlQrOcOpEAtuQEti8QZY0733AbayJT+GmzeUOfyDr4
 9CPNmfrfQbD6yQmLOe90pMeuSnI3NaGrMZrKwDr+SkpuIpmmqlxZf/gzPTg6+Q07
 /ehO23jfhILtfDtmzDS3CmBfQ4USg==
X-ME-Sender: <xms:nbDzW3VqA_F0HczKKUwGuJucVbGUFJWLrSfCHSL1CkFkFyUUOSQdWA>
X-ME-Proxy: <xmx:nbDzW_STDjU8JfASWu1M-MsC4sWB4oXM7NPwtunUrTa2LZKdVat0eg>
 <xmx:nbDzW1vsnrr9U1iwnhKdBXPtAX8epIk9WwAoKf59IB8Xy6DZiRFtNA>
 <xmx:nbDzW5GUaI2CsnaDBcEjUNunzli2_AC-eAhxGbiRNr2LWo2XTIr05w>
 <xmx:nbDzW-w9T_B7RJ_vuOq0y6xo56kneU3hWQQGNU7Nk7kiKGqQK0TtxA>
 <xmx:nbDzW71h9gnXovhdhGpDJV_DRXGYUqYrqos6ki8aiqLgsaQo_GyMfA>
 <xmx:obDzWzR4RtOB6PmM2qRXOeu_p0h46vXLzuDp59EgW3O-Qw3xcSPulQ>
Received: from crackle.ozlabs.ibm.com (unknown [122.99.82.10])
 by mail.messagingengine.com (Postfix) with ESMTPA id B6268102DD;
 Tue, 20 Nov 2018 01:58:34 -0500 (EST)
Message-ID: <54e863e23af0fbc5f83b663fe7d6c95f86024c3c.camel@russell.cc>
Subject: Re: [PATCH kernel] powerpc/powernv/eeh/npu: Fix uninitialized
 variables in opal_pci_eeh_freeze_status
From: Russell Currey <ruscur@russell.cc>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, Sam Bobroff
 <sbobroff@linux.ibm.com>,  Michael Ellerman <mpe@ellerman.id.au>
Date: Tue, 20 Nov 2018 17:59:02 +1100
In-Reply-To: <1c7660de-68fd-60b7-087d-b013479154e0@ozlabs.ru>
References: <20181119042517.45075-1-aik@ozlabs.ru>
 <877eh831id.fsf@concordia.ellerman.id.au>
 <20181120035123.GB9175@tungsten.ozlabs.ibm.com>
 <1c7660de-68fd-60b7-087d-b013479154e0@ozlabs.ru>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Alistair Popple <alistair@popple.id.au>, linuxppc-dev@lists.ozlabs.org,
 Piotr Jaroszynski <pjaroszynski@nvidia.com>,
 Oliver O'Halloran <oohall@gmail.com>, Reza Arbab <arbab@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 2018-11-20 at 17:55 +1100, Alexey Kardashevskiy wrote:
> 
> On 20/11/2018 14:51, Sam Bobroff wrote:
> > On Tue, Nov 20, 2018 at 01:51:06PM +1100, Michael Ellerman wrote:
> > > Alexey Kardashevskiy <aik@ozlabs.ru> writes:
> > > 
> > > > The current implementation of the OPAL_PCI_EEH_FREEZE_STATUS
> > > > call in
> > > > skiboot's NPU driver does not touch the pci_error_type
> > > > parameter so
> > > > it might have garbage but the powernv code analyzes it
> > > > nevertheless.
> > > > 
> > > > This initializes pcierr and fstate to zero in all call sites.
> > > > 
> > > > Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> > > > ---
> > > 
> > > Can we tag this with a Fixes? And seems like it should probably
> > > go to
> > > stable, or can we not trigger this path on older kernels?
> > > 
> > > cheers
> > 
> > Hmm, it's triggered by use on an NPU PE so that would be any kernel
> > that
> > can run on P8 or later (AFAIK).
> > 
> > It looks like the issue was present earlier, but the code was last
> > touched when it was moved, in...
> > 
> > 40ae5f693f6a ("powerpc/powernv: Drop PHB operation get_state()")
> > 
> > ... which was back in v4.1.
> 
> The original commit is
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8c41a7f3f7593fe57
> 
> 2013-06-20 13:21:09 +0800
> ===
> powerpc/eeh: I/O chip EEH state retrieval
> 
> The patch adds I/O chip backend to retrieve the state for the
> indicated PE. While the PE state is temperarily unavailable,
> the upper layer (powernv platform) should return default delay
> (1 second).
> ===
> 
> This was 3.10-rc5 (this is what that sha1's Makefile has).
> 
> But this was not the issue till skiboot decided not to zero these
> parameters so "Fixes:" should point to what?

It should still be that commit, it's perfectly reasonable (however
unlikely) that someone could be running a 3.10 kernel with a modern
skiboot.

> 
> 
> > Sam.
> > 
> > > > Without this, this happens:
> > > > 
> > > > pnv_eeh_get_phb_diag: Failure -7 getting PHB#6 diag-data
> > > > EEH: PHB#6 failure detected, location: N/A
> > > > CPU: 23 PID: 5939 Comm: qemu-system-ppc Not tainted 4.19.0-
> > > > le_f5a7bb7_aikATfstn1-p1 torvalds#106
> > > > Call Trace:
> > > > [c000003fea9df9c0] [c000000000a990ec] dump_stack+0xb0/0xf4
> > > > (unreliable)
> > > > [c000003fea9dfa00] [c000000000038480]
> > > > eeh_dev_check_failure+0x1f0/0x5f0
> > > > [c000003fea9dfaa0] [c0000000000a2768]
> > > > pnv_pci_read_config+0x128/0x160
> > > > [c000003fea9dfae0] [c0000000005d2b0c]
> > > > pci_bus_read_config_dword+0x9c/0xf0
> > > > [c000003fea9dfb40] [c0000000005df3d4] pci_save_state+0x64/0x250
> > > > [c000003fea9dfbc0] [c0000000005e0730]
> > > > pci_dev_save_and_disable+0x70/0xa0
> > > > [c000003fea9dfbf0] [c0000000005e4078]
> > > > pci_try_reset_function+0x48/0xc0
> > > > [c000003fea9dfc20] [c00800001cbc1b1c]
> > > > vfio_pci_ioctl+0x334/0xea0 [vfio_pci]
> > > > [c000003fea9dfcf0] [c00800001ca9046c]
> > > > vfio_device_fops_unl_ioctl+0x44/0x70 [vfio]
> > > > [c000003fea9dfd10] [c00000000039fd84] do_vfs_ioctl+0xd4/0xa00
> > > > [c000003fea9dfdb0] [c0000000003a07b4] ksys_ioctl+0x104/0x120
> > > > [c000003fea9dfe00] [c0000000003a07f8] sys_ioctl+0x28/0x80
> > > > [c000003fea9dfe20] [c00000000000b3a4] system_call+0x5c/0x70
> > > > EEH: Detected error on PHB#6
> > > > EEH: This PCI device has failed 1 times in the last hour and
> > > > will be permanently disabled after 5 fail
> > > > ures.
> > > > EEH: Notify device drivers to shutdown
> > > > EEH: Beginning: 'error_detected(IO frozen)'
> > > > EEH: PE#d (PCI 0006:00:00.0): not actionable (1,1,0)
> > > > EEH: PE#d (PCI 0006:00:00.1): not actionable (1,1,0)
> > > > EEH: PE#c (PCI 0006:00:01.0): Invoking vfio-pci-
> > > > >error_detected(IO frozen)
> > > > EEH: PE#c (PCI 0006:00:01.0): vfio-pci driver reports: 'can
> > > > recover'
> > > > EEH: PE#c (PCI 0006:00:01.1): Invoking vfio-pci-
> > > > >error_detected(IO frozen)
> > > > EEH: PE#c (PCI 0006:00:01.1): vfio-pci driver reports: 'can
> > > > recover'
> > > > EEH: PE#b (PCI 0006:00:02.0): Invoking vfio-pci-
> > > > >error_detected(IO frozen)
> > > > EEH: PE#b (PCI 0006:00:02.0): vfio-pci driver reports: 'can
> > > > recover'
> > > > EEH: PE#b (PCI 0006:00:02.1): Invoking vfio-pci-
> > > > >error_detected(IO frozen)
> > > > EEH: PE#b (PCI 0006:00:02.1): vfio-pci driver reports: 'can
> > > > recover'
> > > > EEH: Finished:'error_detected(IO frozen)' with aggregate
> > > > recovery state:'can recover'
> > > > EEH: Collect temporary log
> > > > pnv_pci_dump_phb_diag_data: Unrecognized ioType 0
> > > > EEH: Reset without hotplug activity
> > > > iommu: Removing device 0006:00:01.0 from group 4
> > > > iommu: Removing device 0006:00:01.1 from group 4
> > > > iommu: Removing device 0006:00:02.0 from group 4
> > > > iommu: Removing device 0006:00:02.1 from group 4
> > > > pnv_ioda_freeze_pe: Failure -7 freezing PHB#6-PE#0
> > > > pnv_eeh_restore_config: Can't reinit PCI dev 0x0 (-7)
> > > > pnv_eeh_restore_config: Can't reinit PCI dev 0x1 (-7)
> > > > pnv_eeh_restore_config: Can't reinit PCI dev 0x8 (-7)
> > > > pnv_eeh_restore_config: Can't reinit PCI dev 0x9 (-7)
> > > > pnv_eeh_restore_config: Can't reinit PCI dev 0x10 (-7)
> > > > pnv_eeh_restore_config: Can't reinit PCI dev 0x11 (-7)
> > > > pnv_eeh_restore_config: Can't reinit PCI dev 0x0 (-7)
> > > > pnv_eeh_restore_config: Can't reinit PCI dev 0x1 (-7)
> > > > pnv_eeh_restore_config: Can't reinit PCI dev 0x8 (-7)
> > > > pnv_eeh_restore_config: Can't reinit PCI dev 0x9 (-7)
> > > > pnv_eeh_restore_config: Can't reinit PCI dev 0x10 (-7)
> > > > pnv_eeh_restore_config: Can't reinit PCI dev 0x11 (-7)
> > > > EEH: Sleep 5s ahead of partial hotplug
> > > > pci 0004:04     : [PE# 00] Setting up window#0 0..3fffffff
> > > > pg=1000
> > > > pci 0004:05     : [PE# 18] Setting up window#0 0..3fffffff
> > > > pg=1000
> > > > pci 0004:06     : [PE# 30] Setting up window#0 0..3fffffff
> > > > pg=1000
> > > > pci 0006:00:00.0: [PE# 0d] Setting up window 0..3fffffff
> > > > pg=1000
> > > > pci 0006:00:01.0: [PE# 0c] Setting up window 0..3fffffff
> > > > pg=1000
> > > > pci 0006:00:02.0: [PE# 0b] Setting up window 0..3fffffff
> > > > pg=1000
> > > > EEH: Beginning: 'slot_reset'
> > > > EEH: PE#d (PCI 0006:00:00.0): not actionable (1,1,0)
> > > > EEH: PE#d (PCI 0006:00:00.1): not actionable (1,1,0)
> > > > EEH: Finished:'slot_reset' with aggregate recovery state:'none'
> > > > EEH: Notify device driver to resume
> > > > EEH: Beginning: 'resume'
> > > > EEH: PE#d (PCI 0006:00:00.0): not actionable (1,1,0)
> > > > EEH: PE#d (PCI 0006:00:00.1): not actionable (1,1,0)
> > > > EEH: Finished:'resume'
> > > > EEH: Recovery successful.
> > > > ---
> > > >  arch/powerpc/platforms/powernv/eeh-powernv.c | 8 ++++----
> > > >  arch/powerpc/platforms/powernv/pci-ioda.c    | 4 ++--
> > > >  arch/powerpc/platforms/powernv/pci.c         | 4 ++--
> > > >  3 files changed, 8 insertions(+), 8 deletions(-)
> > > > 
> > > > diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c
> > > > b/arch/powerpc/platforms/powernv/eeh-powernv.c
> > > > index abc0be7..f380789 100644
> > > > --- a/arch/powerpc/platforms/powernv/eeh-powernv.c
> > > > +++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
> > > > @@ -564,8 +564,8 @@ static void pnv_eeh_get_phb_diag(struct
> > > > eeh_pe *pe)
> > > >  static int pnv_eeh_get_phb_state(struct eeh_pe *pe)
> > > >  {
> > > >  	struct pnv_phb *phb = pe->phb->private_data;
> > > > -	u8 fstate;
> > > > -	__be16 pcierr;
> > > > +	u8 fstate = 0;
> > > > +	__be16 pcierr = 0;
> > > >  	s64 rc;
> > > >  	int result = 0;
> > > >  
> > > > @@ -603,8 +603,8 @@ static int pnv_eeh_get_phb_state(struct
> > > > eeh_pe *pe)
> > > >  static int pnv_eeh_get_pe_state(struct eeh_pe *pe)
> > > >  {
> > > >  	struct pnv_phb *phb = pe->phb->private_data;
> > > > -	u8 fstate;
> > > > -	__be16 pcierr;
> > > > +	u8 fstate = 0;
> > > > +	__be16 pcierr = 0;
> > > >  	s64 rc;
> > > >  	int result;
> > > >  
> > > > diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c
> > > > b/arch/powerpc/platforms/powernv/pci-ioda.c
> > > > index dd80744..72b5cc0 100644
> > > > --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> > > > +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> > > > @@ -604,8 +604,8 @@ static int pnv_ioda_unfreeze_pe(struct
> > > > pnv_phb *phb, int pe_no, int opt)
> > > >  static int pnv_ioda_get_pe_state(struct pnv_phb *phb, int
> > > > pe_no)
> > > >  {
> > > >  	struct pnv_ioda_pe *slave, *pe;
> > > > -	u8 fstate, state;
> > > > -	__be16 pcierr;
> > > > +	u8 fstate = 0, state;
> > > > +	__be16 pcierr = 0;
> > > >  	s64 rc;
> > > >  
> > > >  	/* Sanity check on PE number */
> > > > diff --git a/arch/powerpc/platforms/powernv/pci.c
> > > > b/arch/powerpc/platforms/powernv/pci.c
> > > > index 13aef23..db230a35 100644
> > > > --- a/arch/powerpc/platforms/powernv/pci.c
> > > > +++ b/arch/powerpc/platforms/powernv/pci.c
> > > > @@ -602,8 +602,8 @@ static void
> > > > pnv_pci_handle_eeh_config(struct pnv_phb *phb, u32 pe_no)
> > > >  static void pnv_pci_config_check_eeh(struct pci_dn *pdn)
> > > >  {
> > > >  	struct pnv_phb *phb = pdn->phb->private_data;
> > > > -	u8	fstate;
> > > > -	__be16	pcierr;
> > > > +	u8	fstate = 0;
> > > > +	__be16	pcierr = 0;
> > > >  	unsigned int pe_no;
> > > >  	s64	rc;
> > > >  
> > > > -- 
> > > > 2.17.1

