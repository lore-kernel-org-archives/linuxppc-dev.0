Return-Path: <linuxppc-dev+bounces-24541-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59A3AC44520
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 21:04:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3tLg6Nc0z2yLY;
	Tue, 21 Jul 2026 07:04:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784581483;
	cv=none; b=eI0DkhPb+26DtHLtmWDK2epvZbntQnQVqBv2Ha8niOn7VeQAHbcl7Xc2BdXtDU39e4HwY62P4cjkKrX2oB/8x4bHDDxWwnCPWqA7/qZ+OuHDygytT//+0Je+lyfmxdn0on64i4N+hbcKsIB9njbQLQt05in6J8u2bzxb0PM8/EpM/JDIpoZZggFLf/rzXPhmtyT0Gm6sIdhW8tbkM7yiPmJ2Nt4zbTxUGl0C/pewNK6dmSEcx10E5ZCij12l8vhGTd5hInQiyMby/+eXq5A95Xg8oWwvfKY9GcKQ/IDVmJL+A5Xtozmi6vBDS5p0IaLcNSRQkEqUTbVObUQ64eP2KA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784581483; c=relaxed/relaxed;
	bh=0l7s4xDe2XE0xTtUH6CVsSi4uV8HYqvsHZBIVzCj4Ts=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gZnTG19Vc93JFuFYxMVQ8nq+sSncLBnz5XoHIHqmuX35pI+GCy5PmsFF09cpbbHzIgVrFOYxeKaQ9INsw9VoGajbKPHX3QC7ulBXWcZNR0v8Mo7EKKR51MnrvsWGyde1RNLNygC/++DAw2/Up6i6slJxBrtiZ6nn9gGF0D6rLiN+47hJABvaZhVz4vLMq4Dp+Q7GIX3Pziq7Q+0VIJUEcT5N1FF8jUnQ8pda7xqFvxxb6sYQwIveXieqYa9KHsQnlP5XYyZwo/OekDDNKpr5Z3/lODwV7ltiSYST5KGIiAXmJu9y3jE/RkMmJaFTPTa/DEtUXLJ60JVT07l176O7lg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iKt+B/7E; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=jic23@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iKt+B/7E;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=jic23@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3tLf3WkXz2yDs
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2026 07:04:42 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 040DA41FC2;
	Mon, 20 Jul 2026 21:04:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C28181F000E9;
	Mon, 20 Jul 2026 21:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784581478;
	bh=0l7s4xDe2XE0xTtUH6CVsSi4uV8HYqvsHZBIVzCj4Ts=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=iKt+B/7EzRrgLtdmbGFHZkb0l8GfJny1Di4Tba56PE8r118Ghjf0rZU0T/9HzN9CT
	 AFqDLbnW+OsxD1QnEF5IoKJjxokCU6X2YD9NSzFlo3lDbIGcefLgkj71sQiwUKS4Ob
	 SiG0cXCGr4uRQXg3Ocq/Fot5NlyVHttr5p+1SGpj2eWe6H91YvZ0wg6q8vu2EtkOYP
	 o82HB8eMdumRwHQ2INH63te9y6v9VBNdkhrwHANaOP0PJyk5roLVZKbOhkjw6R53Bm
	 FnBqjY7UyVS8kZUU79LHlZMeBqqxUIENNNU2R2djG2u/5KVWkr+KKvswEKrJxN0frZ
	 Uibh4vfqHYJSQ==
Date: Mon, 20 Jul 2026 22:04:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Terry Bowman <terry.bowman@amd.com>, Ashok Raj
 <ashok.raj@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <djbw@kernel.org>,
 "Dave Jiang" <dave.jiang@intel.com>, Ira Weiny <iweiny@kernel.org>, Len
 Brown <lenb@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Robert
 Richter <rrichter@amd.com>, <linux-acpi@vger.kernel.org>,
 <linux-cxl@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, "Alejandro Lucero" <alucerop@amd.com>,
 Alison Schofield <alison.schofield@intel.com>, Ankit Agrawal
 <ankita@nvidia.com>, Ard Biesheuvel <ardb@kernel.org>, "Ben Cheatham"
 <Benjamin.Cheatham@amd.com>, Borislav Petkov <bp@alien8.de>, "Breno Leitao"
 <leitao@debian.org>, Davidlohr Bueso <dave@stgolabs.net>, "Fabio M . De
 Francesco" <fabio.m.de.francesco@linux.intel.com>, Gregory Price
 <gourry@gourry.net>, Hanjun Guo <guohanjun@huawei.com>, Jonathan Corbet
 <corbet@lwn.net>, Kees Cook <kees@kernel.org>, Kuppuswamy Sathyanarayanan
 <sathyanarayanan.kuppuswamy@linux.intel.com>, Li Ming
 <ming.li@zohomail.com>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Mauro
 Carvalho Chehab <mchehab@kernel.org>, Oliver O'Halloran <oohall@gmail.com>,
 Shiju Jose <shiju.jose@huawei.com>, Shuah Khan <skhan@linuxfoundation.org>,
 Shuai Xue <xueshuai@linux.alibaba.com>, Smita Koralahalli
 <Smita.KoralahalliChannabasappa@amd.com>, Tony Luck <tony.luck@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [RFC] cxl: Device protocol AER injection
Message-ID: <20260720220430.30b7e3ef@jic23-huawei>
In-Reply-To: <20260717225700.3543801-1-terry.bowman@amd.com>
References: <20260717225700.3543801-1-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Jul 2026 17:57:00 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> This patch is intended to provide a method of testing the recently submitted
> cxl series "cxl: Enable CXL PCIe Port Protocol Error handling and logging" found
> here:
> 
> https://lore.kernel.org/linux-cxl/20260717222706.3540281-1-terry.bowman@amd.com/T/#md90ec1fdd1b374bf1e32e7736e2b3e34b328c701

Hi Terry,

https://lore.kernel.org/linux-cxl/20260717222706.3540281-1-terry.bowman@amd.com

Works fine.  Generally you can crop that end bit off the links.

> 
> The changes in this patch will allow CXL RAS protocol testing by injecting
> AER errors using AER EINJ. The RAS register block status is updated
> using a central function to augment RAS register block returned by
> to_ras_base(). This supports all CXL devices including Root Ports,
> Upstream Switch Ports, Downstream Switch Ports, Endpoints, and RCH
> Downstream Ports.

Why is this an RFC rather than a final proposal?  There should always
be something to give the reviewer that info in the patch description.
I'd actually be tempted to throw a cover letter in to have somewhere
out of the way to put that information.

Is it simply because it only makes sense once the other seris lands. 

> 
> Add debugfs-based CXL protocol error injection for testing CXL RAS
> error handling paths. Injects CXL RAS protocol errors using AER internal
> error inject interface via /sys/kernel/debug/cxl/aer_einj_inject.
> 
> RAS CXL status is set using to_ras_base() function override when kernel config
> CONFIG_CXL_PROTO_AER_EINJ is enabled.
> 
> Usage:
>   echo "DDDD:BB:DD.F [UCE|CE] AER_STATUS RAS_STATUS [RCH]" > \
>       /sys/kernel/debug/cxl/aer_einj_inject
> 
> Move struct aer_error_inj and aer_inject() to linux/aer.h so CXL
> can invoke AER injection directly. Export aer_inject() with
> EXPORT_SYMBOL_GPL.
> 
> Make cxl_debugfs non-static in port.c and declare it extern in
> core.h so the debugfs file can be created under the existing CXL
> debugfs root.
> 
> Co-developed-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
+CC Ashok,

Various thing inline.  Mostly this review is a bit superficial as I'd like
ideally to see a cleaner separation of this at level of files etc.

Thanks,

Jonathan
> ---
>  drivers/cxl/Kconfig           |  13 +++
>  drivers/cxl/core/core.h       |  21 ++++
>  drivers/cxl/core/port.c       |   2 +-
>  drivers/cxl/core/ras.c        | 208 ++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/ras_rch.c    |  12 ++
>  drivers/pci/pcie/aer_inject.c |  29 ++---
>  include/linux/aer.h           |  15 +++
>  7 files changed, 281 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index 80aeb0d556bd7..ef449228b2549 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -238,6 +238,19 @@ config CXL_RAS
>  	def_bool y
>  	depends on ACPI_APEI_GHES && PCIEAER && CXL_BUS
>  
> +config CXL_PROTO_AER_EINJ
> +	bool "CXL: RAS Protocol Error Injection using AER EINJ"
> +	depends on CXL_RAS
> +	depends on PCIEAER_INJECT

Do we think anyone who has CXL and PCIEAER_INJECT support will want
to carefully not build this?  I'm just wondering if we can avoid asking
the question and base the built or not on the combination of those.

> +	help
> +	  Enable debugfs-based CXL protocol error injection. Writes to
> +	  /sys/kernel/debug/cxl/aer_einj_inject inject CXL RAS protocol
> +	  errors using the AER internal error inject interface.
> +
> +	  This is a debug/test facility. Say N for production kernels.
> +
> +	  If unsure say N.

> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index a55a4e409feda..91910d2bb5d39 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
...

> @@ -244,4 +247,22 @@ int cxl_set_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
>  
>  resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
>  					   struct cxl_dport *dport);
> +
> +#ifdef CONFIG_CXL_PROTO_AER_EINJ

Do we need the ifdefs?  If the option isn't built none of this should get
used.  So small benefit.

> +
> +#define AER_REGISTER_SIZE 5
> +#define RAS_REGISTER_SIZE (CXL_RAS_CAPABILITY_LENGTH / sizeof(u32))
> +
> +struct cxl_aer_einj {
> +	int correctable;
> +	bool is_rch;
> +	struct mutex *lock;
> +	struct device *dev;
> +	u32 aer_registers[AER_REGISTER_SIZE];
> +	u32 ras_registers[RAS_REGISTER_SIZE];
> +};
> +
> +extern struct cxl_aer_einj cxl_aer_einj;
> +#endif

> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index d77208af41e03..d41deea899d30 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -3,6 +3,7 @@
>  
>  #include <linux/pci.h>
>  #include <linux/aer.h>
> +#include <linux/debugfs.h>
>  #include <cxl/event.h>
>  #include <cxlmem.h>
>  #include <cxlpci.h>
> @@ -117,6 +118,195 @@ static void cxl_cper_prot_err_work_fn(struct work_struct *work)
>  }
>  static DECLARE_WORK(cxl_cper_prot_err_work, cxl_cper_prot_err_work_fn);
>  
> +#if IS_ENABLED(CONFIG_CXL_PROTO_AER_EINJ)
> +

Unless very strong reasons for it, generally don't do #if stuff in c files.
Just have a separate c file for this.  Otherwise it hurts readability and
we tend to loose the clean separation over time.  A file makes that less
likely.


> +static DEFINE_MUTEX(cxl_aer_einj_mutex);

Needs a comment for what data it is protecting.

> +
> +struct cxl_aer_einj cxl_aer_einj = {
> +	.lock = &cxl_aer_einj_mutex,
> +};
> +
> +static const char cxl_aer_einj_usage[] =
> +	"ssss:bb:dd.f [UCE|CE] AER_STATUS RAS_STATUS [RCH]\n";
> +
> +static int cxl_aer_inject_error(struct pci_dev *pdev, bool correctable,
> +				u32 aer_status, u32 ras_status)
> +{
> +	/* RCD errors are signaled as internal errors on the associated RCEC */
> +	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END) {
> +		if (!pdev->rcec)
> +			return -ENODEV;
> +		pdev = pdev->rcec;
> +	}
> +
> +	struct aer_error_inj einj = {
> +		.bus = pdev->bus->number,
> +		.dev = PCI_SLOT(pdev->devfn),
> +		.fn = PCI_FUNC(pdev->devfn),
> +		.domain = pci_domain_nr(pdev->bus),
> +	};
> +	int ret;
> +	int aer_offset;
> +	int ras_offset;
> +
> +	if (correctable) {
> +		einj.cor_status = aer_status | PCI_ERR_COR_INTERNAL;
> +		aer_offset = PCI_ERR_COR_STATUS / sizeof(u32);
> +		ras_offset = CXL_RAS_CORRECTABLE_STATUS_OFFSET / sizeof(u32);

Given these are offsets into cxl_aer_einj.aer_registers / ras_registers
can we use sizeof(*cxl_aer_einj.aer_registers) etc

> +	} else {
> +		einj.uncor_status = aer_status | PCI_ERR_UNC_INTN;
> +		aer_offset = PCI_ERR_UNCOR_STATUS / sizeof(u32);
> +		ras_offset = CXL_RAS_UNCORRECTABLE_STATUS_OFFSET / sizeof(u32);
> +	}
> +
> +	cxl_aer_einj.correctable = correctable;
> +	cxl_aer_einj.aer_registers[aer_offset] = aer_status;
> +	cxl_aer_einj.ras_registers[ras_offset] = ras_status;
> +
> +	ret = aer_inject(&einj);
> +	if (ret) {
> +		pr_err("cxl-einj: aer_inject failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static ssize_t cxl_aer_einj_write(struct file *file,
> +				    const char __user *ubuf,
> +				    size_t count, loff_t *ppos)

Might as well wrap to 80 chars and save a line.

> +{

...

> +
> +	struct cxl_port *port __free(put_cxl_port) = find_cxl_port_by_dev(&pdev->dev, &dport);
> +	if (!port) {
> +		dev_err(&pdev->dev, "cxl-einj: Failed to find CXL Port.\n");
> +		return -ENODEV;
> +	}
> +
> +	if (!to_ras_base(port, dport)) {
> +		dev_err(&pdev->dev, "cxl-einj: RAS not initialized.\n");
> +		return -ENODEV;
> +	}
> +
> +	cxl_aer_einj.is_rch = (nargs == 5 && strcmp(topology, "RCH") == 0);
> +	if (!cxl_aer_einj.is_rch)
> +		pci_dev_get(pdev);
> +	cxl_aer_einj.dev = cxl_aer_einj.is_rch ? pdev->dev.parent : &pdev->dev;

	cxl_aer_einj.dev = cxl_aer_einj.is_rch ? pdev->dev.parent : pci_dev_get(&pdev->dev);

Or use an if else for both is_rch based choices.
Lazy me wonders.... Can we just grab a reference to the dev.parent for is_rch and
simplify the code?  We don't really need it I think but it is harmless.


> +	ret = cxl_aer_inject_error(pdev, strcmp(severity, "CE") == 0,
> +				   aer_status, ras_status);
> +	if (ret) {
> +		if (!cxl_aer_einj.is_rch)
> +			pci_dev_put(pdev);
> +		cxl_aer_einj.dev = NULL;
> +		pr_err("cxl-einj: injection failed for %s: %d\n", sbdf, ret);
> +		return ret;
> +	}
> +
> +	return count;
> +}
> +
> +static ssize_t cxl_aer_einj_read(struct file *file, char __user *ubuf,
> +				 size_t count, loff_t *ppos)
> +{
> +	return simple_read_from_buffer(ubuf, count, ppos,
> +				       cxl_aer_einj_usage,

Probably wrap this to push that up a line.

> +				       sizeof(cxl_aer_einj_usage) - 1);
> +}

> +
> +static void __iomem *to_einj_ras_base(struct cxl_port *port, struct cxl_dport *dport)
> +{
> +	if (dport) {
> +		if (cxl_aer_einj.is_rch) {
> +			if (cxl_aer_einj.dev == dport->dport_dev) {
> +				cxl_aer_einj.dev = NULL;
> +				return (__force void __iomem *)cxl_aer_einj.ras_registers;

Given the output of this is always force cast, maybe move that force up to the caller?

> +			}
> +		} else {
> +			if (cxl_aer_einj.dev == dport->dport_dev) {
> +				pci_dev_put(to_pci_dev(cxl_aer_einj.dev));

Not locally obvious why a thing called to_einj_ras_base should put anything it didn't
get.  I think this needs a restructure to more obviously be tidying up references
that were held over the queue. At very leads needs a comment.
/* Reference held from X no longer needed so drop */

> +				cxl_aer_einj.dev = NULL;
> +				return (__force void __iomem *)cxl_aer_einj.ras_registers;
> +			}
> +		}
> +	} else if (!cxl_aer_einj.is_rch) {
> +		struct device *dev = is_cxl_endpoint(port) ?
> +			port->uport_dev->parent : port->uport_dev;
> +
> +		if (dev_is_pci(dev) && cxl_aer_einj.dev == dev) {
> +			pci_dev_put(to_pci_dev(cxl_aer_einj.dev));
> +			cxl_aer_einj.dev = NULL;
> +			return (__force void __iomem *)cxl_aer_einj.ras_registers;
> +		}
> +	}
> +
> +	return NULL;
> +}
> +#endif
> +
>  static void cxl_unmask_proto_interrupts(struct device *dev)
>  {
>  	struct pci_dev *pdev;
> @@ -238,6 +428,14 @@ void __iomem *to_ras_base(struct cxl_port *port, struct cxl_dport *dport)
>  	if (!port)
>  		return NULL;
>  
> +#if IS_ENABLED(CONFIG_CXL_PROTO_AER_EINJ)

Wrap with
	if (IS_ENABLED()) to keep it visible to the compiler.

> +	if (cxl_aer_einj.dev) {
> +		void __iomem *einj = to_einj_ras_base(port, dport);
> +		if (einj)
> +			return einj;
> +	}
> +#endif
> +
>  	if (dport)
>  		return dport->regs.ras;
>  
> @@ -458,10 +656,20 @@ void cxl_ras_init(void)
>  	cxl_cper_register_prot_err_work(&cxl_cper_prot_err_work);
>  	cxl_register_proto_err_work(&cxl_proto_err_work,
>  				   cxl_proto_err_do_flush);
> +#if IS_ENABLED(CONFIG_CXL_PROTO_AER_EINJ)
> +	cxl_ras_create_debugfs(cxl_debugfs);
stub that in a header.

> +#endif
>  }
>  
>  void cxl_ras_exit(void)
>  {
>  	cxl_unregister_proto_err_work();
>  	cxl_cper_unregister_prot_err_work();
> +#if IS_ENABLED(CONFIG_CXL_PROTO_AER_EINJ)

As below.  Use 
	if (IS_ENABLED())

and keep everything visible.

> +	if (cxl_aer_einj.dev) {
> +		if (!cxl_aer_einj.is_rch)
> +			pci_dev_put(to_pci_dev(cxl_aer_einj.dev));
> +		cxl_aer_einj.dev = NULL;
> +	}
> +#endif
>  }
> diff --git a/drivers/cxl/core/ras_rch.c b/drivers/cxl/core/ras_rch.c
> index 14bb3bdb2d092..5071cf86e4a68 100644
> --- a/drivers/cxl/core/ras_rch.c
> +++ b/drivers/cxl/core/ras_rch.c
> @@ -110,6 +110,14 @@ void cxl_handle_rdport_errors(struct pci_dev *pdev)
>  	if (!dport)
>  		return;
>  
> +#if IS_ENABLED(CONFIG_CXL_PROTO_AER_EINJ)
> +	if (cxl_aer_einj.is_rch && cxl_aer_einj.dev) {
> +		severity = cxl_aer_einj.correctable ?
> +			AER_CORRECTABLE : AER_FATAL;
> +		goto handle_ras;
> +	}

Use instead
	if (IS_ENABLED(CONFIG_CXL_PROTO_AR_EINJ))

then compiler can see the code (but remove it) which means
you don't need the dance around the label below.

In general follow this pattern anyway rather than #if 
when you can.

> +#endif
> +
>  	if (!cxl_rch_get_aer_info(dport->regs.dport_aer, &aer_regs))
>  		return;
>  
> @@ -117,6 +125,10 @@ void cxl_handle_rdport_errors(struct pci_dev *pdev)
>  		return;
>  
>  	pci_print_aer(pdev, severity, &aer_regs);
> +
> +#if IS_ENABLED(CONFIG_CXL_PROTO_AER_EINJ)
> +handle_ras:
> +#endif
>  	if (severity == AER_CORRECTABLE)
>  		cxl_handle_cor_ras(dport->port, dport,
>  				   to_ras_base(port, dport), pdev->dsn);
> diff --git a/drivers/pci/pcie/aer_inject.c b/drivers/pci/pcie/aer_inject.c
> index 09bfc7194ef31..b313adef680ae 100644
> --- a/drivers/pci/pcie/aer_inject.c
> +++ b/drivers/pci/pcie/aer_inject.c
> @@ -14,6 +14,7 @@
>  
>  #define dev_fmt(fmt) "aer_inject: " fmt
>  
> +#include <linux/aer.h>
>  #include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/interrupt.h>
> @@ -31,19 +32,6 @@
>  static bool aer_mask_override;
>  module_param(aer_mask_override, bool, 0);
>  
> -struct aer_error_inj {
> -	u8 bus;
> -	u8 dev;
> -	u8 fn;
> -	u32 uncor_status;
> -	u32 cor_status;
> -	u32 header_log0;
> -	u32 header_log1;
> -	u32 header_log2;
> -	u32 header_log3;
> -	u32 domain;
> -};
> -
>  struct aer_error {
>  	struct list_head list;
>  	u32 domain;
> @@ -316,7 +304,7 @@ static int pci_bus_set_aer_ops(struct pci_bus *bus)
>  	return 0;
>  }
>  
> -static int aer_inject(struct aer_error_inj *einj)
> +int aer_inject(struct aer_error_inj *einj)
>  {
>  	struct aer_error *err, *rperr;
>  	struct aer_error *err_alloc = NULL, *rperr_alloc = NULL;
> @@ -332,10 +320,14 @@ static int aer_inject(struct aer_error_inj *einj)
>  	dev = pci_get_domain_bus_and_slot(einj->domain, einj->bus, devfn);
>  	if (!dev)
>  		return -ENODEV;
> -	rpdev = pcie_find_root_port(dev);
> -	/* If Root Port not found, try to find an RCEC */
> -	if (!rpdev)
> -		rpdev = dev->rcec;
> +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC) 

{ }
as the else is multiline (see coding standard)

Maybe need a comment for why it might be an RCEC for injection.
Is this an RCH specific path where there is nothing else to target?

> +		rpdev = dev;
> +	else {
> +		rpdev = pcie_find_root_port(dev);
> +		/* If Root Port not found, try to find an RCEC */
> +		if (!rpdev)
> +			rpdev = dev->rcec;
> +	}
>  	if (!rpdev) {
>  		pci_err(dev, "Neither Root Port nor RCEC found\n");
>  		ret = -ENODEV;
> @@ -482,6 +474,7 @@ static int aer_inject(struct aer_error_inj *einj)
>  	pci_dev_put(dev);
>  	return ret;
>  }
> +EXPORT_SYMBOL_GPL(aer_inject);
I wonder if we want to restrict this to specific modules?

One for Bjorn probably.

>  
>  static ssize_t aer_inject_write(struct file *filp, const char __user *ubuf,
>  				size_t usize, loff_t *off)
> diff --git a/include/linux/aer.h b/include/linux/aer.h
> index b3657b80564b9..65c22ba597657 100644
> --- a/include/linux/aer.h
> +++ b/include/linux/aer.h
> @@ -27,6 +27,21 @@
>  struct pci_dev;
>  struct work_struct;
>  
> +struct aer_error_inj {
> +	u8 bus;
> +	u8 dev;
> +	u8 fn;
> +	u32 uncor_status;
> +	u32 cor_status;
> +	u32 header_log0;
> +	u32 header_log1;
> +	u32 header_log2;
> +	u32 header_log3;
> +	u32 domain;
> +};
> +
> +int aer_inject(struct aer_error_inj *einj);
> +
>  struct pcie_tlp_log {
>  	union {
>  		u32 dw[PCIE_STD_MAX_TLP_HEADERLOG];


