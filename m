Return-Path: <linuxppc-dev+bounces-24526-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B965C44520
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 17:39:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3npG5kfHz2ySN;
	Tue, 21 Jul 2026 03:39:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784569190;
	cv=none; b=G5F1/oBRtkD9gRNqAMwiEUhZH96EjrkDX3hO2+octcNC2QyO1T523jI24UCaYGW1tErNvCsHkvjks8hti3hNUnOIOE6JoUX5x8CNCXeN8pmQOagVYvn3xNA13NSHTVb7lSlwiQdPbOenOuURLHdAm6z2VPEH7JlNBCDThT+SN7AnQOQguddvYPbAMregFKiCtwazgxdjYIl6/H5kRshboL/B9a0D+uspKMwuxmdUHc8CgQYEzTkvGPR5ial0pO9FvZJ3IHTjN62TvyWMk3jvwzaSeebsqLeCS2Jj62TXBEyRS3Xc7ln/vzSmx/vckOR1oMh06v+RD6iJAWgvD+N64w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784569190; c=relaxed/relaxed;
	bh=9zac4m6K4CX3w5ycD1s0NdEXKmOz41pEX/c0jr9HFFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ouesh4nCt1fmYiSbOdJq5GSgh+S5RsQZIY8rXvpY7MKzciFrsBLKPaS1LYybo/aiba+1FZwDDOINOONa6rOAlxS44OPlt8yKSkUf9LSvb7K9b17wV+DxxU1LcviXpsKI5kqsYBcmjksHOZQekbRX1LOZobEzosxG85b9aW2wEkiXNuvRD16fMTYT1PkJo5KamJOzuqYCKbkW1CJsCCFdJ0ozVnG00Rdl5jT8yhuqQEEk4gRkI2UNHbeuXUwR2MvEkXKC7esCYJdQT8m4glCbU9iiUTQ6ccu1wzhTRlkcoUL3nTItk1vj98BF9lcG6zql3Aq5qV9ftWAgs/nkwmazcA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZEb9PvNb; dkim-atps=neutral; spf=pass (client-ip=192.198.163.11; helo=mgamail.intel.com; envelope-from=dave.jiang@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZEb9PvNb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.11; helo=mgamail.intel.com; envelope-from=dave.jiang@intel.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 65 seconds by postgrey-1.37 at boromir; Tue, 21 Jul 2026 03:39:47 AEST
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3npC37hjz2xlZ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2026 03:39:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784569188; x=1816105188;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cw3/RS4mM1ejUEOQ9/ogBM7VjF6isqMeU8WvHbBz2lo=;
  b=ZEb9PvNbS6ElrXBDhLw+v2ehRuRJwf/pXEzC7zJBBLSf2xyVIYkRolKP
   vviDNTQgfIg8I6fKyUjcqOsDEMjhhSRhrFvsaao4IuzNghA0bXMlqFMTp
   my0BBPkmYf5s9FGhY2x55VJtDq57jaK9YoZQxpm6zKAkh+tw4LlPJPqGc
   xq9XS5pKduDvWhDOWrxdPgnAoo6wTi1tiF06dHBqil2vgVAmp/rsEE2Ts
   41jg1k5kqPCEcMc4RHpRkWnKmqVaynV+5Rr0qzh1qlo4Ad16ANgTqpQ06
   JJKIIdQV0f2+jxwrCGSy32VlB8DLkvWwunZARsiVEAeb6Y4aJIxMup3da
   A==;
X-CSE-ConnectionGUID: ySutQOG0RNm4VzdWJXBNMQ==
X-CSE-MsgGUID: 9NrCS2xXQ0u94d8HvdKAqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="95751369"
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="95751369"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 10:38:34 -0700
X-CSE-ConnectionGUID: 2tpFPn/NRe63YmCxGdjBcw==
X-CSE-MsgGUID: EXy7h36ORbicy3mIKxEexQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="253587895"
Received: from cooperst-gp83.amr.corp.intel.com (HELO [10.125.109.176]) ([10.125.109.176])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 10:38:31 -0700
Message-ID: <6ff8d646-61b1-496e-bdc0-f4a4011d1d58@intel.com>
Date: Mon, 20 Jul 2026 10:38:30 -0700
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
Subject: Re: [RFC] cxl: Device protocol AER injection
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
References: <20260717225700.3543801-1-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260717225700.3543801-1-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/17/26 3:57 PM, Terry Bowman wrote:
> This patch is intended to provide a method of testing the recently submitted
> cxl series "cxl: Enable CXL PCIe Port Protocol Error handling and logging" found
> here:
> 
> https://lore.kernel.org/linux-cxl/20260717222706.3540281-1-terry.bowman@amd.com/T/#md90ec1fdd1b374bf1e32e7736e2b3e34b328c701
> 
> The changes in this patch will allow CXL RAS protocol testing by injecting
> AER errors using AER EINJ. The RAS register block status is updated
> using a central function to augment RAS register block returned by
> to_ras_base(). This supports all CXL devices including Root Ports,
> Upstream Switch Ports, Downstream Switch Ports, Endpoints, and RCH
> Downstream Ports.
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
> +	help
> +	  Enable debugfs-based CXL protocol error injection. Writes to
> +	  /sys/kernel/debug/cxl/aer_einj_inject inject CXL RAS protocol
> +	  errors using the AER internal error inject interface.
> +
> +	  This is a debug/test facility. Say N for production kernels.
> +
> +	  If unsure say N.
> +
>  config CXL_ATL
>  	def_bool y
>  	depends on CXL_REGION
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index a55a4e409feda..91910d2bb5d39 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -182,6 +182,9 @@ static inline struct device *dport_to_host(struct cxl_dport *dport)
>  		return port->uport_dev;
>  	return &port->dev;
>  }
> +
> +extern struct dentry *cxl_debugfs;
> +
>  #ifdef CONFIG_CXL_RAS
>  void cxl_ras_init(void);
>  void cxl_ras_exit(void);
> @@ -244,4 +247,22 @@ int cxl_set_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
>  
>  resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
>  					   struct cxl_dport *dport);
> +
> +#ifdef CONFIG_CXL_PROTO_AER_EINJ
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
> +
>  #endif /* __CXL_CORE_H__ */
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index a76f3ee05cba8..79657e5fddaac 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -2501,7 +2501,7 @@ const struct bus_type cxl_bus_type = {
>  };
>  EXPORT_SYMBOL_NS_GPL(cxl_bus_type, "CXL");
>  
> -static struct dentry *cxl_debugfs;
> +struct dentry *cxl_debugfs;
>  
>  struct dentry *cxl_debugfs_create_dir(const char *dir)
>  {
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

Can this be moved to a header file? Prefer to not introduce #ifdef in the C source.

> +
> +static DEFINE_MUTEX(cxl_aer_einj_mutex);
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
> +{
> +	char sbdf[16], severity[4], topology[4] = "";
> +	unsigned int domain, bus, dev, fn;
> +	u32 aer_status, ras_status;
> +	struct cxl_dport *dport;
> +	char buf[128];
> +	int nargs;
> +	int ret;
> +
> +	if (!capable(CAP_SYS_ADMIN))
> +		return -EPERM;
> +
> +	if (count >= sizeof(buf)) {
> +		pr_err("cxl-einj: input too long (%zu bytes, max %zu)\n", count, sizeof(buf) - 1);
> +		return -EINVAL;
> +	}
> +
> +	if (copy_from_user(buf, ubuf, count)) {
> +		pr_err("cxl-einj: copy_from_user failed\n");
> +		return -EFAULT;
> +	}
> +	buf[count] = '\0';
> +
> +	nargs = sscanf(buf, "%15s %3s %x %x %3s", sbdf, severity,
> +		       &aer_status, &ras_status, topology);
> +	if (nargs < 4) {
> +		pr_err("cxl-einj: expected format: <SBDF> <UCE|CE> <aer_status> <ras_status>\n");
> +		return -EINVAL;
> +	}
> +
> +	if (nargs == 5 && strcmp(topology, "RCH") != 0)
> +		return -EINVAL;
> +
> +	if (strcmp(severity, "UCE") != 0 && strcmp(severity, "CE") != 0) {
> +		pr_err("cxl-einj: expected 'UCE' or 'CE', got '%s'\n", severity);
> +		return -EINVAL;
> +	}
> +
> +	if (sscanf(sbdf, "%x:%x:%x.%x", &domain, &bus, &dev, &fn) != 4) {
> +		pr_err("cxl-einj: invalid SBDF format '%s', expected DDDD:BB:DD.F\n", sbdf);
> +		return -EINVAL;
> +	}
> +
> +	struct pci_dev *pdev __free(pci_dev_put) =
> +		pci_get_domain_bus_and_slot(domain, bus, PCI_DEVFN(dev, fn));
> +	if (!pdev) {
> +		pr_err("cxl-einj: device %s not found\n", sbdf);
> +		return -ENODEV;
> +	}
> +
> +	guard(mutex)(cxl_aer_einj.lock);
> +	cxl_aer_einj.dev = NULL;
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
> +				       sizeof(cxl_aer_einj_usage) - 1);
> +}
> +
> +static const struct file_operations cxl_ras_error_fops = {
> +	.owner		= THIS_MODULE,
> +	.read		= cxl_aer_einj_read,
> +	.write		= cxl_aer_einj_write,
> +	.llseek		= default_llseek,
> +};
> +
> +static void cxl_ras_create_debugfs(struct dentry *dir)
> +{
> +	debugfs_create_file("aer_einj_inject", 0600, dir, NULL,
> +			    &cxl_ras_error_fops);
> +}
> +
> +static void __iomem *to_einj_ras_base(struct cxl_port *port, struct cxl_dport *dport)
> +{
> +	if (dport) {
> +		if (cxl_aer_einj.is_rch) {
> +			if (cxl_aer_einj.dev == dport->dport_dev) {
> +				cxl_aer_einj.dev = NULL;
> +				return (__force void __iomem *)cxl_aer_einj.ras_registers;
> +			}
> +		} else {
> +			if (cxl_aer_einj.dev == dport->dport_dev) {
> +				pci_dev_put(to_pci_dev(cxl_aer_einj.dev));
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

I think you can do something like below instead:

	if (IS_ENABLED(CONFIG_CXL_PROTO_AER_EINJ))

DJ

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
> +#endif
>  }
>  
>  void cxl_ras_exit(void)
>  {
>  	cxl_unregister_proto_err_work();
>  	cxl_cper_unregister_prot_err_work();
> +#if IS_ENABLED(CONFIG_CXL_PROTO_AER_EINJ)
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


