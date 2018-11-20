Return-Path: <SRS0=vwdz=N7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED34BC43441
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Nov 2018 02:52:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51F3320870
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Nov 2018 02:52:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51F3320870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42zVcl6jQbzF3Vn
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Nov 2018 13:52:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42zVZp5BbfzF3F7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Nov 2018 13:51:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42zVZm0Btmz9s3Z;
 Tue, 20 Nov 2018 13:51:10 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH kernel] powerpc/powernv/eeh/npu: Fix uninitialized
 variables in opal_pci_eeh_freeze_status
In-Reply-To: <20181119042517.45075-1-aik@ozlabs.ru>
References: <20181119042517.45075-1-aik@ozlabs.ru>
Date: Tue, 20 Nov 2018 13:51:06 +1100
Message-ID: <877eh831id.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alistair Popple <alistair@popple.id.au>, Sam Bobroff <sbobroff@linux.ibm.com>,
 Piotr Jaroszynski <pjaroszynski@nvidia.com>,
 Oliver O'Halloran <oohall@gmail.com>, Reza Arbab <arbab@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Alexey Kardashevskiy <aik@ozlabs.ru> writes:

> The current implementation of the OPAL_PCI_EEH_FREEZE_STATUS call in
> skiboot's NPU driver does not touch the pci_error_type parameter so
> it might have garbage but the powernv code analyzes it nevertheless.
>
> This initializes pcierr and fstate to zero in all call sites.
>
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---

Can we tag this with a Fixes? And seems like it should probably go to
stable, or can we not trigger this path on older kernels?

cheers

> Without this, this happens:
>
> pnv_eeh_get_phb_diag: Failure -7 getting PHB#6 diag-data
> EEH: PHB#6 failure detected, location: N/A
> CPU: 23 PID: 5939 Comm: qemu-system-ppc Not tainted 4.19.0-le_f5a7bb7_aikATfstn1-p1 torvalds#106
> Call Trace:
> [c000003fea9df9c0] [c000000000a990ec] dump_stack+0xb0/0xf4 (unreliable)
> [c000003fea9dfa00] [c000000000038480] eeh_dev_check_failure+0x1f0/0x5f0
> [c000003fea9dfaa0] [c0000000000a2768] pnv_pci_read_config+0x128/0x160
> [c000003fea9dfae0] [c0000000005d2b0c] pci_bus_read_config_dword+0x9c/0xf0
> [c000003fea9dfb40] [c0000000005df3d4] pci_save_state+0x64/0x250
> [c000003fea9dfbc0] [c0000000005e0730] pci_dev_save_and_disable+0x70/0xa0
> [c000003fea9dfbf0] [c0000000005e4078] pci_try_reset_function+0x48/0xc0
> [c000003fea9dfc20] [c00800001cbc1b1c] vfio_pci_ioctl+0x334/0xea0 [vfio_pci]
> [c000003fea9dfcf0] [c00800001ca9046c] vfio_device_fops_unl_ioctl+0x44/0x70 [vfio]
> [c000003fea9dfd10] [c00000000039fd84] do_vfs_ioctl+0xd4/0xa00
> [c000003fea9dfdb0] [c0000000003a07b4] ksys_ioctl+0x104/0x120
> [c000003fea9dfe00] [c0000000003a07f8] sys_ioctl+0x28/0x80
> [c000003fea9dfe20] [c00000000000b3a4] system_call+0x5c/0x70
> EEH: Detected error on PHB#6
> EEH: This PCI device has failed 1 times in the last hour and will be permanently disabled after 5 fail
> ures.
> EEH: Notify device drivers to shutdown
> EEH: Beginning: 'error_detected(IO frozen)'
> EEH: PE#d (PCI 0006:00:00.0): not actionable (1,1,0)
> EEH: PE#d (PCI 0006:00:00.1): not actionable (1,1,0)
> EEH: PE#c (PCI 0006:00:01.0): Invoking vfio-pci->error_detected(IO frozen)
> EEH: PE#c (PCI 0006:00:01.0): vfio-pci driver reports: 'can recover'
> EEH: PE#c (PCI 0006:00:01.1): Invoking vfio-pci->error_detected(IO frozen)
> EEH: PE#c (PCI 0006:00:01.1): vfio-pci driver reports: 'can recover'
> EEH: PE#b (PCI 0006:00:02.0): Invoking vfio-pci->error_detected(IO frozen)
> EEH: PE#b (PCI 0006:00:02.0): vfio-pci driver reports: 'can recover'
> EEH: PE#b (PCI 0006:00:02.1): Invoking vfio-pci->error_detected(IO frozen)
> EEH: PE#b (PCI 0006:00:02.1): vfio-pci driver reports: 'can recover'
> EEH: Finished:'error_detected(IO frozen)' with aggregate recovery state:'can recover'
> EEH: Collect temporary log
> pnv_pci_dump_phb_diag_data: Unrecognized ioType 0
> EEH: Reset without hotplug activity
> iommu: Removing device 0006:00:01.0 from group 4
> iommu: Removing device 0006:00:01.1 from group 4
> iommu: Removing device 0006:00:02.0 from group 4
> iommu: Removing device 0006:00:02.1 from group 4
> pnv_ioda_freeze_pe: Failure -7 freezing PHB#6-PE#0
> pnv_eeh_restore_config: Can't reinit PCI dev 0x0 (-7)
> pnv_eeh_restore_config: Can't reinit PCI dev 0x1 (-7)
> pnv_eeh_restore_config: Can't reinit PCI dev 0x8 (-7)
> pnv_eeh_restore_config: Can't reinit PCI dev 0x9 (-7)
> pnv_eeh_restore_config: Can't reinit PCI dev 0x10 (-7)
> pnv_eeh_restore_config: Can't reinit PCI dev 0x11 (-7)
> pnv_eeh_restore_config: Can't reinit PCI dev 0x0 (-7)
> pnv_eeh_restore_config: Can't reinit PCI dev 0x1 (-7)
> pnv_eeh_restore_config: Can't reinit PCI dev 0x8 (-7)
> pnv_eeh_restore_config: Can't reinit PCI dev 0x9 (-7)
> pnv_eeh_restore_config: Can't reinit PCI dev 0x10 (-7)
> pnv_eeh_restore_config: Can't reinit PCI dev 0x11 (-7)
> EEH: Sleep 5s ahead of partial hotplug
> pci 0004:04     : [PE# 00] Setting up window#0 0..3fffffff pg=1000
> pci 0004:05     : [PE# 18] Setting up window#0 0..3fffffff pg=1000
> pci 0004:06     : [PE# 30] Setting up window#0 0..3fffffff pg=1000
> pci 0006:00:00.0: [PE# 0d] Setting up window 0..3fffffff pg=1000
> pci 0006:00:01.0: [PE# 0c] Setting up window 0..3fffffff pg=1000
> pci 0006:00:02.0: [PE# 0b] Setting up window 0..3fffffff pg=1000
> EEH: Beginning: 'slot_reset'
> EEH: PE#d (PCI 0006:00:00.0): not actionable (1,1,0)
> EEH: PE#d (PCI 0006:00:00.1): not actionable (1,1,0)
> EEH: Finished:'slot_reset' with aggregate recovery state:'none'
> EEH: Notify device driver to resume
> EEH: Beginning: 'resume'
> EEH: PE#d (PCI 0006:00:00.0): not actionable (1,1,0)
> EEH: PE#d (PCI 0006:00:00.1): not actionable (1,1,0)
> EEH: Finished:'resume'
> EEH: Recovery successful.
> ---
>  arch/powerpc/platforms/powernv/eeh-powernv.c | 8 ++++----
>  arch/powerpc/platforms/powernv/pci-ioda.c    | 4 ++--
>  arch/powerpc/platforms/powernv/pci.c         | 4 ++--
>  3 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
> index abc0be7..f380789 100644
> --- a/arch/powerpc/platforms/powernv/eeh-powernv.c
> +++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
> @@ -564,8 +564,8 @@ static void pnv_eeh_get_phb_diag(struct eeh_pe *pe)
>  static int pnv_eeh_get_phb_state(struct eeh_pe *pe)
>  {
>  	struct pnv_phb *phb = pe->phb->private_data;
> -	u8 fstate;
> -	__be16 pcierr;
> +	u8 fstate = 0;
> +	__be16 pcierr = 0;
>  	s64 rc;
>  	int result = 0;
>  
> @@ -603,8 +603,8 @@ static int pnv_eeh_get_phb_state(struct eeh_pe *pe)
>  static int pnv_eeh_get_pe_state(struct eeh_pe *pe)
>  {
>  	struct pnv_phb *phb = pe->phb->private_data;
> -	u8 fstate;
> -	__be16 pcierr;
> +	u8 fstate = 0;
> +	__be16 pcierr = 0;
>  	s64 rc;
>  	int result;
>  
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index dd80744..72b5cc0 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -604,8 +604,8 @@ static int pnv_ioda_unfreeze_pe(struct pnv_phb *phb, int pe_no, int opt)
>  static int pnv_ioda_get_pe_state(struct pnv_phb *phb, int pe_no)
>  {
>  	struct pnv_ioda_pe *slave, *pe;
> -	u8 fstate, state;
> -	__be16 pcierr;
> +	u8 fstate = 0, state;
> +	__be16 pcierr = 0;
>  	s64 rc;
>  
>  	/* Sanity check on PE number */
> diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
> index 13aef23..db230a35 100644
> --- a/arch/powerpc/platforms/powernv/pci.c
> +++ b/arch/powerpc/platforms/powernv/pci.c
> @@ -602,8 +602,8 @@ static void pnv_pci_handle_eeh_config(struct pnv_phb *phb, u32 pe_no)
>  static void pnv_pci_config_check_eeh(struct pci_dn *pdn)
>  {
>  	struct pnv_phb *phb = pdn->phb->private_data;
> -	u8	fstate;
> -	__be16	pcierr;
> +	u8	fstate = 0;
> +	__be16	pcierr = 0;
>  	unsigned int pe_no;
>  	s64	rc;
>  
> -- 
> 2.17.1
