Return-Path: <linuxppc-dev+bounces-24536-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6E61C44515
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 20:29:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3sZM2368z2yLY;
	Tue, 21 Jul 2026 06:29:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784579387;
	cv=none; b=FE2LV5OArR/ABnGJ81mf3V3tWTzzBXXdJQeckdjhPJGUnDw9PhdsGiYSnF7ETGIPTIMz6Iqb545UPdNSZdyaeM+lozv3miMvzCMkWYGJOqQNzO+UHhPWNO0IL3fg6yV/6okCR3arztHiAR/oBgrUF1NuyTmygMkDstuAu/jLZztgZQmolNrGQEeGifRuiT1ItNBDTUP1JUkSfLbF2sgr9wxiPRCY9nEBaEWN+l4DKgGsSWE+5e9CMnRRaB+4dwaI4XUG0dqwHxanPXOj6s1sbycwHH4BttENdBPf6Gfr6hiiDgj3CmvI2jyhMfGRSCxZCOCtDDjxChWw00Qn/LgSdA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784579387; c=relaxed/relaxed;
	bh=DAO8ibmm3jkFxvYpKQRzVXPi44I5ISejI9H0wwufaFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hNRYrtEm2upKa4aAmhEUkM5tYVxp7p+ZrYu/W7mkFxgsYxldp9BFOYlZpRKPGJfoM/oQmrUkzvb+SgXiz+1YLzCQ/ntrlXIO8/8A5EG6UtBc+XCBiGoJcf1hwWqAjkqY3FHzq6n4oqz6rCVrV6Tbhdgh2qZ2y+qWNWRQAqbQa2wXnZM4wPfFCP8QuDRvbpZJKuKlHtP+w9z9YMw8qsezKM7X7sqvwGHjNPZn4OgxFWgdewqjwx/xO4x8vdztQHQqGsZYM+n0bJZQC09f4hBsFVm5T5AVEUDEdW5/KYcHNQbZcib8pL/ND4X0Xe23FIXYSgU5zL50pToXdOAUj5lpKg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=C8xmhwzq; dkim-atps=neutral; spf=pass (client-ip=192.198.163.18; helo=mgamail.intel.com; envelope-from=dave.jiang@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=C8xmhwzq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.18; helo=mgamail.intel.com; envelope-from=dave.jiang@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3sZK5fH4z2yDs
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2026 06:29:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784579386; x=1816115386;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GkYPR6w/ANLIRXxF0gi8rrHaU1IBipm+HzJ7CEJrOBU=;
  b=C8xmhwzqba9fpS3sMjU/CKoV/Qj6S4LcnVYnX25LgB2mSriepN36wBzo
   uQ0d1ke2/GLy5AV/95d3ww4FY4gDOPrR2HMYMlP6lD838M2is0ra+LmrQ
   mydaGp4hFs13lPDcqROyMLig1k0wj+7IDzUqynUGmj4PaZQdDvWL8lQwo
   S9vqjnpJYJSCN1MRWOtyDxjN+s94wtaORo/vA1p/4mnU6uUf5nBS5zIuw
   V8qey6aBUhavtSK0/Bt2jHOC0enFqm5X8rUwqJPhVqMIpXnjlLa0h1cy6
   0/xAb9HkgZAp4T53X3c/ya2MT3bcvKpbIcHr0+LH9unSiaRupfhj0pEe6
   Q==;
X-CSE-ConnectionGUID: hclNwrV6T3akqhOofbiVUw==
X-CSE-MsgGUID: /x325bBxS2y4fF2RcYdNxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="84299677"
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="84299677"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 13:29:42 -0700
X-CSE-ConnectionGUID: Xg/nzcFwQzKO8KiUo76fZg==
X-CSE-MsgGUID: h/QTwgL9RBaM7G2f1Du82g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="258197552"
Received: from cooperst-gp83.amr.corp.intel.com (HELO [10.125.109.176]) ([10.125.109.176])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 13:29:40 -0700
Message-ID: <d1d37be6-6c0b-4e96-89b3-bebcea012e66@intel.com>
Date: Mon, 20 Jul 2026 13:29:38 -0700
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 05/13] PCI/AER: Introduce AER-CXL protocol error kfifo
To: Terry Bowman <terry.bowman@amd.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>,
 Jonathan Cameron <jic23@kernel.org>, Len Brown <lenb@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Robert Richter <rrichter@amd.com>
Cc: linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Alejandro Lucero <alucerop@amd.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Ankit Agrawal <ankita@nvidia.com>, Ard Biesheuvel <ardb@kernel.org>,
 Ben Cheatham <Benjamin.Cheatham@amd.com>, Borislav Petkov <bp@alien8.de>,
 Breno Leitao <leitao@debian.org>, Davidlohr Bueso <dave@stgolabs.net>,
 "Fabio M . De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Gregory Price <gourry@gourry.net>, Hanjun Guo <guohanjun@huawei.com>,
 Jonathan Corbet <corbet@lwn.net>, Kees Cook <kees@kernel.org>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Li Ming <ming.li@zohomail.com>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Oliver O'Halloran <oohall@gmail.com>, Shiju Jose <shiju.jose@huawei.com>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Shuai Xue <xueshuai@linux.alibaba.com>,
 Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
 Tony Luck <tony.luck@intel.com>, Vishal Verma <vishal.l.verma@intel.com>
References: <20260717222706.3540281-1-terry.bowman@amd.com>
 <20260717222706.3540281-6-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260717222706.3540281-6-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/17/26 3:26 PM, Terry Bowman wrote:
> CXL VH RAS handling requires a path for the AER driver to hand off
> CXL protocol errors to cxl_core for logging and recovery before PCIe
> AER recovery tears down the device. Add
> drivers/pci/pcie/aer_cxl_vh.c to implement this handoff via a kfifo-backed
> work item.
> 
> Introduce is_aer_internal_error() to identify CXL protocol errors
> from AER internal error status bits across both correctable and
> uncorrectable severities.
> 
> Introduce is_cxl_error() to gate the VH kfifo path.
> 
> Introduce struct cxl_proto_err_work_data to carry the error source
> PCI device and severity through the kfifo. Encapsulate the kfifo,
> per-producer spinlock, registration rwsem, and work pointer in struct
> cxl_proto_err_kfifo. Initialize the embedded kfifo via INIT_KFIFO()
> from a subsys_initcall so its metadata is populated before any
> producer or consumer runs.
> 
> Introduce cxl_forward_error() to enqueue a CXL protocol error. A
> reference is taken on the PCI device; the consumer releases it via
> for_each_cxl_proto_err(). On enqueue failure the reference is
> released immediately, the error is dropped, and the consumer is
> scheduled to drain existing entries. A subsequent patch wires
> cxl_forward_error() into handle_error_source() where correctable and
> uncorrectable status clearing is left to pci_aer_handle_error().
> 
> Introduce cxl_proto_err_flush() to synchronously wait for the
> consumer worker to drain the kfifo. A subsequent patch wires this
> into handle_error_source() for UCE events so the CXL plane completes
> error handling and panic policy before pci_aer_handle_error() drives
> PCIe recovery.
> 
> Introduce cxl_register_proto_err_work() and
> cxl_unregister_proto_err_work() for cxl_core to register and
> deregister its work handler. On unregistration, pending kfifo entries
> are drained and their pdev references released before
> cancel_work_sync() runs. Export these and for_each_cxl_proto_err()
> via EXPORT_SYMBOL_FOR_MODULES restricted to cxl_core.
> 
> Protect the work pointer with a rwsem to correctly serialize
> registration, deregistration, enqueue, and dequeue against concurrent
> AER IRQ threads. Serialize concurrent kfifo writers with a spinlock.
> 
> Add MAINTAINERS entries for aer_cxl_vh.c and aer_cxl_rch.c under
> the CXL entry so CXL maintainers are CC'd on changes to the AER-CXL
> bridging code.
> 
> Co-developed-by: Dan Williams <djbw@kernel.org>
> Signed-off-by: Dan Williams <djbw@kernel.org>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> 
> ---
> 
> Changes in v17->v18:
> - Remove correctable status clear from cxl_forward_error(); the AER core
>   clears all status bits via pci_aer_handle_error() info->status writeback
> - Schedule consumer on kfifo overflow so existing entries can be drained
> 
> Changes in v16->v17:
> - Reword "kfifo semaphore" to "kfifo spinlock" to match fifo_lock.
> - Defer the handle_error_source() is_cxl_error() switch to the patch that
>   registers the kfifo consumer to keep each commit bisect-safe.
> - Rename rwsema to rwsem
> - Change CPER exports to use EXPORT_SYMBOL_FOR_MODULES.
> - Add work cancel function.
> - Replace kfifo_put() with kfifo_in_spinlocked() for multiple producers
> - Add fifo_lock spinlock for concurrent producer serialisation
> - Initialize the embedded kfifo with INIT_KFIFO() in a subsys_initcall so
>   kfifo->mask, ->esize and ->data are set before first use.
> - Clear PCI_ERR_COR_STATUS in cxl_forward_error() after enqueue so the
>   device is acked for correctable events even when the consumer drops the
>   event. Uncorrectable status is left for cxl_do_recovery() to clear after
>   recovery completes, mirroring the AER core convention.
> - WARN on double-registration in cxl_register_proto_err_work() to make an
>   unintended second consumer visible at runtime.
> - Add direct rwsem.h, cleanup.h and workqueue.h includes for symbols used
>   in aer_cxl_vh.c
> - Add MAINTAINERS entries for drivers/pci/pcie/aer_cxl_*.c
> - Update message
> ---
>  MAINTAINERS                   |   2 +
>  drivers/pci/pcie/Makefile     |   1 +
>  drivers/pci/pcie/aer.c        |  10 --
>  drivers/pci/pcie/aer_cxl_vh.c | 221 ++++++++++++++++++++++++++++++++++
>  drivers/pci/pcie/portdrv.h    |   6 +
>  include/linux/aer.h           |  24 ++++
>  6 files changed, 254 insertions(+), 10 deletions(-)
>  create mode 100644 drivers/pci/pcie/aer_cxl_vh.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 806bd2d80d153..39007aa90b20f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6526,6 +6526,8 @@ S:	Maintained
>  F:	Documentation/driver-api/cxl
>  F:	Documentation/userspace-api/fwctl/fwctl-cxl.rst
>  F:	drivers/cxl/
> +F:	drivers/pci/pcie/aer_cxl_rch.c
> +F:	drivers/pci/pcie/aer_cxl_vh.c
>  F:	include/cxl/
>  F:	include/uapi/linux/cxl_mem.h
>  F:	tools/testing/cxl/
> diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
> index b0b43a18c304b..62d3d3c69a5df 100644
> --- a/drivers/pci/pcie/Makefile
> +++ b/drivers/pci/pcie/Makefile
> @@ -9,6 +9,7 @@ obj-$(CONFIG_PCIEPORTBUS)	+= pcieportdrv.o bwctrl.o
>  obj-y				+= aspm.o
>  obj-$(CONFIG_PCIEAER)		+= aer.o err.o tlp.o
>  obj-$(CONFIG_CXL_RAS)		+= aer_cxl_rch.o
> +obj-$(CONFIG_CXL_RAS)		+= aer_cxl_vh.o
>  obj-$(CONFIG_PCIEAER_INJECT)	+= aer_inject.o
>  obj-$(CONFIG_PCIE_PME)		+= pme.o
>  obj-$(CONFIG_PCIE_DPC)		+= dpc.o
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index c4fd9c0b2a548..c5bce25df51cb 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1150,16 +1150,6 @@ void pci_aer_unmask_internal_errors(struct pci_dev *dev)
>   */
>  EXPORT_SYMBOL_FOR_MODULES(pci_aer_unmask_internal_errors, "cxl_core");
>  
> -#ifdef CONFIG_CXL_RAS
> -bool is_aer_internal_error(struct aer_err_info *info)
> -{
> -	if (info->severity == AER_CORRECTABLE)
> -		return info->status & PCI_ERR_COR_INTERNAL;
> -
> -	return info->status & PCI_ERR_UNC_INTN;
> -}
> -#endif
> -
>  /**
>   * pci_aer_handle_error - handle logging error into an event log
>   * @dev: pointer to pci_dev data structure of error source device
> diff --git a/drivers/pci/pcie/aer_cxl_vh.c b/drivers/pci/pcie/aer_cxl_vh.c
> new file mode 100644
> index 0000000000000..93bed07936100
> --- /dev/null
> +++ b/drivers/pci/pcie/aer_cxl_vh.c
> @@ -0,0 +1,221 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright(c) 2026 AMD Corporation. All rights reserved. */
> +
> +#include <linux/aer.h>
> +#include <linux/atomic.h>
> +#include <linux/cleanup.h>
> +#include <linux/init.h>
> +#include <linux/kfifo.h>
> +#include <linux/rwsem.h>
> +#include <linux/wait_bit.h>
> +#include <linux/workqueue.h>
> +#include "../pci.h"
> +#include "portdrv.h"
> +
> +#define CXL_ERROR_SOURCES_MAX          128
> +
> +struct cxl_proto_err_kfifo {
> +	struct work_struct *work;
> +	void (*flush)(void);
> +	struct rw_semaphore rwsem;
> +	spinlock_t fifo_lock;
> +	atomic_t flush_inflight;
> +	DECLARE_KFIFO(fifo, struct cxl_proto_err_work_data,
> +		      CXL_ERROR_SOURCES_MAX);
> +};
> +
> +static struct cxl_proto_err_kfifo cxl_proto_err_kfifo = {
> +	.rwsem = __RWSEM_INITIALIZER(cxl_proto_err_kfifo.rwsem),
> +	.fifo_lock = __SPIN_LOCK_UNLOCKED(cxl_proto_err_kfifo.fifo_lock),
> +};
> +
> +static int __init cxl_proto_err_kfifo_init(void)
> +{
> +	INIT_KFIFO(cxl_proto_err_kfifo.fifo);
> +	return 0;
> +}
> +subsys_initcall(cxl_proto_err_kfifo_init);
> +
> +bool is_aer_internal_error(struct aer_err_info *info)
> +{
> +	if (info->severity == AER_CORRECTABLE)
> +		return info->status & PCI_ERR_COR_INTERNAL;
> +
> +	return info->status & PCI_ERR_UNC_INTN;
> +}
> +
> +bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info)
> +{
> +	if (!info || !info->is_cxl)
> +		return false;
> +
> +	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT)
> +		return false;
> +
> +	return is_aer_internal_error(info);
> +}
> +
> +/**
> + * cxl_forward_error - Forward a CXL protocol error to the CXL subsystem via kfifo
> + * @pdev: PCI device that reported the AER error
> + * @info: AER error info containing severity and status
> + *
> + * Producer side of the AER-CXL kfifo. Enqueues a CXL protocol error work
> + * item and schedules the consumer workqueue. Takes a reference on @pdev
> + * that the consumer releases after handling.
> + *
> + * Return: true if the caller must flush the kfifo before AER recovery,
> + * false if no CXL error handling was initiated due to early return on
> + * error.
> + */
> +bool cxl_forward_error(struct pci_dev *pdev, struct aer_err_info *info)
> +{
> +	struct cxl_proto_err_work_data wd = {
> +		.severity = info->severity,
> +		.pdev = pdev,
> +	};
> +
> +	guard(rwsem_read)(&cxl_proto_err_kfifo.rwsem);
> +
> +	if (!cxl_proto_err_kfifo.work) {
> +		dev_err_ratelimited(&pdev->dev, "AER-CXL kfifo reader not registered\n");
> +		return false;
> +	}
> +
> +	/*
> +	 * Reference discipline: the AER caller (handle_error_source())
> +	 * holds a ref on @pdev for the duration of this call and releases
> +	 * it on return. Take a fresh ref here so the pdev stays live while
> +	 * queued in the kfifo; the consumer (for_each_cxl_proto_err())
> +	 * drops that ref after handling. On enqueue failure below, drop
> +	 * the ref we just took to avoid a leak.
> +	 */
> +	pci_dev_get(pdev);
> +
> +	/* Serialize concurrent kfifo writers: multiple AER threaded IRQs */
> +	if (!kfifo_in_spinlocked(&cxl_proto_err_kfifo.fifo, &wd, 1,
> +				 &cxl_proto_err_kfifo.fifo_lock)) {
> +		/* Dropped; no panic - UCE unconfirmed without RAS read */
> +		dev_err_ratelimited(&pdev->dev, "AER-CXL kfifo add failed\n");
> +		pci_dev_put(pdev);
> +		schedule_work(cxl_proto_err_kfifo.work);
> +		return true;
> +	}
> +
> +	schedule_work(cxl_proto_err_kfifo.work);
> +	return true;
> +}
> +
> +void cxl_register_proto_err_work(struct work_struct *work,
> +				void (*flush)(void))
> +{
> +	guard(rwsem_write)(&cxl_proto_err_kfifo.rwsem);
> +
> +	/*
> +	 * Warn on double-registration to surface driver bugs (e.g. missing
> +	 * cxl_unregister_proto_err_work() on module exit)
> +	 */
> +	if (WARN(cxl_proto_err_kfifo.work,
> +		 "AER-CXL kfifo consumer already registered\n"))
> +		return;
> +	cxl_proto_err_kfifo.work = work;
> +	cxl_proto_err_kfifo.flush = flush;
> +}
> +EXPORT_SYMBOL_FOR_MODULES(cxl_register_proto_err_work, "cxl_core");
> +
> +static struct work_struct *cancel_cxl_proto_err(void)
> +{
> +	struct work_struct *work;
> +	struct cxl_proto_err_work_data wd;
> +
> +	guard(rwsem_write)(&cxl_proto_err_kfifo.rwsem);
> +	work = cxl_proto_err_kfifo.work;
> +	cxl_proto_err_kfifo.work = NULL;
> +	cxl_proto_err_kfifo.flush = NULL;
> +
> +	/* rwsem_write excludes all producers; fifo_lock not needed */
> +	while (kfifo_get(&cxl_proto_err_kfifo.fifo, &wd)) {
> +		dev_err_ratelimited(&wd.pdev->dev,
> +				    "AER-CXL error report canceled\n");
> +		pci_dev_put(wd.pdev);
> +	}
> +	return work;
> +}
> +
> +void cxl_unregister_proto_err_work(void)
> +{
> +	struct work_struct *work;
> +
> +	lockdep_assert_not_held(&cxl_proto_err_kfifo.rwsem);
> +
> +	work = cancel_cxl_proto_err();
> +
> +	/* Wait for any in-flight cxl_proto_err_flush() calls to complete */
> +	wait_var_event(&cxl_proto_err_kfifo.flush_inflight,
> +		       atomic_read(&cxl_proto_err_kfifo.flush_inflight) == 0);
> +
> +	if (work)
> +		cancel_work_sync(work);
> +}
> +EXPORT_SYMBOL_FOR_MODULES(cxl_unregister_proto_err_work, "cxl_core");
> +
> +/**
> + * for_each_cxl_proto_err - Call a function for each kfifo work item
> + *
> + * Single-consumer invariant: this function is only called from
> + * cxl_proto_err_work_fn() via a single DECLARE_WORK.
> + *
> + * Holds rwsem_read internally; fn() must not call cxl_register_proto_err_work()
> + * or cxl_unregister_proto_err_work().
> + */
> +void for_each_cxl_proto_err(struct cxl_proto_err_work_data *wd,
> +			    cxl_proto_err_fn_t fn)
> +{
> +	guard(rwsem_read)(&cxl_proto_err_kfifo.rwsem);
> +	while (kfifo_get(&cxl_proto_err_kfifo.fifo, wd)) {
> +		fn(wd);
> +		pci_dev_put(wd->pdev);
> +	}
> +}
> +EXPORT_SYMBOL_FOR_MODULES(for_each_cxl_proto_err, "cxl_core");
> +
> +/**
> + * cxl_proto_err_flush - drain pending AER-CXL kfifo work synchronously
> + *
> + * Wait for the consumer worker to finish processing all entries
> + * currently in the kfifo. Used by handle_error_source() for UCE so
> + * the CXL plane can read CXL RAS, apply panic policy, and clear CXL
> + * state before pci_aer_handle_error() drives PCIe recovery.
> + *
> + * Snapshots the flush callback under rwsem_read and releases the rwsem
> + * before calling it.  This avoids holding rwsem_read across flush_work(),
> + * which would deadlock via the rwsem HANDOFF mechanism when a concurrent
> + * rwsem_write waiter (cxl_unregister_proto_err_work) blocks new readers
> + * including the worker's for_each_cxl_proto_err() rwsem_read acquisition.
> + *
> + * The flush_inflight counter prevents cxl_core module unload while a
> + * flush is in progress outside the rwsem. The counter is incremented
> + * under rwsem_read (mutually exclusive with the rwsem_write in
> + * cancel_cxl_proto_err() that NULLs the flush pointer) and decremented
> + * after the flush completes. cxl_unregister_proto_err_work() waits for
> + * the counter to reach zero before proceeding with cancel_work_sync().
> + *
> + * For correctable events the consumer can run asynchronously; AER
> + * does not need to call this helper for AER_CORRECTABLE.
> + */
> +void cxl_proto_err_flush(void)
> +{
> +	void (*flush)(void);
> +
> +	scoped_guard(rwsem_read, &cxl_proto_err_kfifo.rwsem) {
> +		flush = cxl_proto_err_kfifo.flush;
> +		if (flush)
> +			atomic_inc(&cxl_proto_err_kfifo.flush_inflight);
> +	}
> +
> +	if (flush) {
> +		flush();
> +		if (atomic_dec_and_test(&cxl_proto_err_kfifo.flush_inflight))
> +			wake_up_var(&cxl_proto_err_kfifo.flush_inflight);
> +	}
> +}
> diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
> index cc58bf2f2c844..fd203010877bf 100644
> --- a/drivers/pci/pcie/portdrv.h
> +++ b/drivers/pci/pcie/portdrv.h
> @@ -130,9 +130,15 @@ struct aer_err_info;
>  bool is_aer_internal_error(struct aer_err_info *info);
>  void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info);
>  void cxl_rch_enable_rcec(struct pci_dev *rcec);
> +bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info);
> +bool cxl_forward_error(struct pci_dev *pdev, struct aer_err_info *info);
> +void cxl_proto_err_flush(void);
>  #else
>  static inline bool is_aer_internal_error(struct aer_err_info *info) { return false; }
>  static inline void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info) { }
>  static inline void cxl_rch_enable_rcec(struct pci_dev *rcec) { }
> +static inline bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info) { return false; }
> +static inline bool cxl_forward_error(struct pci_dev *pdev, struct aer_err_info *info) { return false; }
> +static inline void cxl_proto_err_flush(void) { }
>  #endif /* CONFIG_CXL_RAS */
>  #endif /* _PORTDRV_H_ */
> diff --git a/include/linux/aer.h b/include/linux/aer.h
> index df0f5c382286f..8eba3192e2d15 100644
> --- a/include/linux/aer.h
> +++ b/include/linux/aer.h
> @@ -25,6 +25,7 @@
>  #define PCIE_STD_MAX_TLP_HEADERLOG	(PCIE_STD_NUM_TLP_HEADERLOG + 10)
>  
>  struct pci_dev;
> +struct work_struct;
>  
>  struct pcie_tlp_log {
>  	union {
> @@ -66,6 +67,29 @@ static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
>  static inline void pci_aer_unmask_internal_errors(struct pci_dev *dev) { }
>  #endif
>  
> +#ifdef CONFIG_CXL_RAS
> +/**
> + * struct cxl_proto_err_work_data - Error information used in CXL error handling
> + * @pdev: PCI device detecting the error
> + * @severity: AER severity
> + */
> +struct cxl_proto_err_work_data {
> +	struct pci_dev *pdev;
> +	int severity;
> +};
> +
> +/**
> + * Callback for processing a CXL protocol error from the AER-CXL kfifo.
> + */
> +typedef void (*cxl_proto_err_fn_t)(struct cxl_proto_err_work_data *wd);
> +
> +void cxl_register_proto_err_work(struct work_struct *work,
> +				void (*flush)(void));
> +void for_each_cxl_proto_err(struct cxl_proto_err_work_data *wd,
> +			    cxl_proto_err_fn_t fn);
> +void cxl_unregister_proto_err_work(void);
> +#endif
> +
>  void pci_print_aer(struct pci_dev *dev, int aer_severity,
>  		    struct aer_capability_regs *aer);
>  int cper_severity_to_aer(int cper_severity);


