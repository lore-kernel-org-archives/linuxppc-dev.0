Return-Path: <linuxppc-dev+bounces-24540-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10422C44515
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 20:44:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3svk5BGZz2ySN;
	Tue, 21 Jul 2026 06:44:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784580290;
	cv=none; b=dHNd3a1IAV7EMWQWgIYNmZNF0rCNf8bJ9t4jY2T+j4ZobUWHKbuk1tGryrtcIH2dGbpDUjusWd8XTjjyLQ/DJzLD0gVTDN61d2mPQ7/KeAOAePglL/lPW3t03PQAwGQS70eXNEaEwds8VxvKCXkXvC4pt+Hwhu3fI7bkG1q/gifSmvKNudf5ygXJrtUmBI+XZxF33FOit4p2A9QpTywGVMEvuHyQia0MzOh7Z7iNCHyypv4k8J9tqQOwI7To3EGS+1wXLj+WdPDec6YkFE77Uv1RXbfJUAkNXuRrzMhdPW2EVPICh6pUq6uO2w0c9/u9M84L5bCccf5I1cZeuKSPpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784580290; c=relaxed/relaxed;
	bh=YtXa5bSp3UxxFDFDIm1AGrGESxbb68MIJ+7gS4rhVfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NaJpmqp75UZizJwmFkGqvSRDyOhOX5Rj2RAUdZpEXMB95C9WNo812oPTlJLBrNUszXQq5s7G9zJdgd2tzfyIBsmtdmrYkUBK6aiLn4up+OPQ/yKXsDAQEmjRYbOW2cGpfJtoSL4LvRADwyJ9uTLatT90o90apwk/ZLsEgXwLztbOTeF7+j4NcipsuPEEvlcHOt8G/RCtCYZGaihq26u4f66ypCRIUoBXNsQZ6Y3wTq7zGm1r5q8NVG3XMJs3cFa0NEJVw7FuoHUfZw/29BdlvJ5JKwtSD6jtKHi8J+KmbBBRJr9NQtpUwALcrOwVV6djwQVxRl26C7J5RtShmgLubA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NP99HVXW; dkim-atps=neutral; spf=pass (client-ip=192.198.163.16; helo=mgamail.intel.com; envelope-from=dave.jiang@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NP99HVXW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.16; helo=mgamail.intel.com; envelope-from=dave.jiang@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3svg22VCz2yDs
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2026 06:44:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784580288; x=1816116288;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=48LUYu3+dwRNRpxUJvSLHUb7eQRMGs/+2EVQUk+XH6E=;
  b=NP99HVXW/8a5pYy8/WzlfMsqyXVTXUlLA1pAejLCzyKcvZUd4mJgtrFx
   ZZRos5QcInBFg06R6kX4BFEjoeaxxZ1NgCb+HIFQXjW80LXuYll6BWUaM
   XWUVTEjV1xoFlAIIGdEz+fzJ8Q2IsSyQ723srUxApW0NC7vWPkEEpzZEp
   wm6L7T7gyYGlAA67SLhdI6xykIQgD7zecho/yuUArfhuwtXSbA5VNKnP3
   HJ73E950Caa4e3/o6lAJQKIyFivZu6Wd4mUWkO+cHlSxh136+PzYwto99
   pfmQzj/GMuMhPdb+3bYrDJoZ0AwPfkKUTNDTdJ7l81vQh9tEJBXky2llh
   A==;
X-CSE-ConnectionGUID: VGbCnszOQOaq9iRG2/xTsg==
X-CSE-MsgGUID: G35ssa1+TYuxX8dNPM208g==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="72706298"
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="72706298"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 13:44:41 -0700
X-CSE-ConnectionGUID: sZ0c/kp5SVSVU36BSXkceQ==
X-CSE-MsgGUID: Ar1N46iRRK2VyzM8ljO0ZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="295770262"
Received: from cooperst-gp83.amr.corp.intel.com (HELO [10.125.109.176]) ([10.125.109.176])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 13:44:38 -0700
Message-ID: <744e0269-dbf9-4adb-8604-f2667931d36a@intel.com>
Date: Mon, 20 Jul 2026 13:44:37 -0700
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
Subject: Re: [PATCH v18 06/13] PCI: Establish common CXL Port protocol error
 flow
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
 <20260717222706.3540281-7-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260717222706.3540281-7-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/17/26 3:26 PM, Terry Bowman wrote:
> Add CXL protocol error dispatch in handle_error_source() using
> is_cxl_error() and cxl_forward_error() to route errors through the
> AER-CXL kfifo. Expand is_cxl_error() from Endpoint-only to include
> Root Port, Upstream Port, and Downstream Port device types. The
> producer and consumer go live in the same commit to avoid silently
> dropping CXL errors during bisect.
> 
> For uncorrectable events, call cxl_proto_err_flush() to ensure CXL RAS
> registers are read, panic policy is applied, and CXL state is cleared
> before pci_aer_handle_error() drives PCIe recovery. Without the flush,
> AER recovery can tear down drivers and unmap the CXL RAS iomaps while
> the kfifo consumer is still reading them. Correctable events do not
> need the flush and run asynchronously. RCH kfifo support is added in
> the following patch ("PCI/CXL: Add RCH support to CXL handlers").
> 
> Add cxl_handle_proto_error() to dispatch correctable and uncorrectable
> errors through the CXL RAS helpers. Add cxl_do_recovery() to coordinate
> uncorrectable recovery. Panic when a UCE is confirmed by a successful
> CXL RAS status register read. If the RAS registers cannot be read the
> UCE cannot be confirmed and panic is not triggered. Gate error handling
> on the port driver being bound to avoid processing errors on disabled
> devices.
> 
> The kfifo consumer holds guard(device)(&port->dev) and checks
> port->dev.driver before accessing RAS registers, serializing against
> driver unbind and devm iomap teardown. For UCE, cxl_proto_err_flush()
> runs the worker synchronously before AER recovery, ensuring the device
> is present during RAS register access.
> 
> Add to_ras_base() to centralize RAS base lookup: dport->regs.ras for
> Root/Downstream Ports, port->regs.ras for Upstream Ports and Endpoints.
> Use to_ras_base() to access the CXL devices' RAS registers as it will
> provide an avenue to inject status simulation during testing.
> 
> Add CXL RAS logging in cxl_handle_cor_ras() and cxl_handle_ras(). The
> existing cxl_cor_error_detected() and cxl_error_detected() AER
> callbacks remain for all Endpoints and are reworked to use
> find_cxl_port_by_uport() and to_ras_base(), with UCE now triggering
> panic unconditionally. These callbacks are further updated in the
> following patch ("PCI/CXL: Add RCH support to CXL handlers").
> 
> Fix a pre-existing race for cxlds between cxl_handle_rdport_errors() and
> cxl_memdev_shutdown() by holding a cxlmd device scoped_guard() around
> the rdport call. Release the lock before taking the Port lock to avoid
> the lock inversion.
> 
> Co-developed-by: Dan Williams <djbw@kernel.org>
> Signed-off-by: Dan Williams <djbw@kernel.org>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> 
> ---
> 
> Changes in v17->v18:
> - Fix pre-existing race: hold memdev device lock around
>   cxl_handle_rdport_errors(), release before port lock
> - Fix handle_error_source() to call pci_aer_handle_error() unconditionally
>   so AER handling always runs after cxl_forward_error()
> - Add cxl_proto_err_flush() call for CXL UCE to drain kfifo before AER
>   recovery tears down the device
> - Fix NULL dereference of dport->dport_dev in cxl_handle_cor_ras() and
>   cxl_handle_ras() for UPSTREAM/ENDPOINT port types: use dport->dport_dev
>   when dport is non-NULL, else fall back to port->uport_dev
> - Remove duplicate pcie_clear_device_status() call from
>   cxl_handle_proto_error() CE path; pci_aer_handle_error() already clears it
> - Clarify panic policy: panic only on confirmed UCE via RAS status read
> - Document kfifo consumer serialization against driver unbind via
>   guard(device)(&port->dev) and port->dev.driver check
> 
> Changes in v16->v17:
> - get_cxl_port() -> find_cxl_port_by_dev()
> - Simplified find_cxl_port_by_dev()
> - Replace and remove cxl_serial_number() w/ pci_get_dsn()
> - cxl_get_ras_base() -> to_ras_base()
> - Drop dependency on PCI_ERS_RESULT_PANIC; cxl_do_recovery() panics
>   directly. (PANIC enum patch dropped from series.)
> - Clarify panic semantics: panic on any uncorrectable CXL RAS error, not
>   only AER-FATAL severities.
> - Add is_cxl_error() switch in handle_error_source() here, paired with the
>   kfifo consumer registration, to keep each commit bisect-safe.
> - Drop pcie_aer_is_native() guard in cxl_do_recovery() (always native).
> - Swap order with the "Limit" patch for bisectability w/ cxl_ras_exit()
> - Reword for "any uncorrectable" CXL RAS error panics.
> - Restore log messages for port-not-found and port-unbound cases.
> - Whitespace cleanup (Jonathan)
> - Update to get_cxl_port() documentation (Terry)
> - Fix __cxl_proto_err_work_fn() to return 0 for transient errors.
> - Drop !port check in cxl_do_recovery(), caller already validated
> - Fix kerneldoc @pdev -> @dev in find_cxl_port_by_dev()
> - Fix missing space in pr_err_ratelimited()
> - Made pcie_clear_device_status() and pci_aer_clear_fatal_status()
>   EXPORT_SYMBOL_FOR_MODULES("cxl_core") (Dan)
> - Move find_cxl_port_by_dport() and find_cxl_port_by_uport()
>   de-staticisation and core.h declarations from the rename patch to
>   here, where the first cross-file callers in find_cxl_port_by_dev()
>   land.
> 
> Changes in v15->v16:
> - get_ras_base(), initialize dport to NULL (Jonathan)
> - Remove guard(device)(&cxlmd->dev) (Jonathan)
> - Fix dev_warns() (Jonathan)
> - Remove comment in cxl_port_error_detected() (Dan)
> - Update switch-case brackets to follow clang-format (Dan)
> - Add PCI_EXP_TYPE_RC_END for cxl_get_ras_base() (Terry)
> - Add NULL port check in cxl_serial_number() (Terry)
> 
> Changes in v14->v15:
> - Update commit message and title. Added Bjorn's ack.
> - Move CE and UCE handling logic here
> 
> Changes in v13->v14:
> - Add Dave Jiang's review-by
> - Update commit message & headline (Bjorn)
> - Refactor cxl_port_error_detected()/cxl_port_cor_error_detected() to
>   one line (Jonathan)
> - Remove cxl_walk_port() (Dan)
> - Remove cxl_pci_drv_bound(). Check for 'is_cxl' parent port is
>   sufficient (Dan)
> - Remove device_lock_if()
> - Combined CE and UCE here (Terry)
> 
> Changes in v12->v13:
> - Move get_pci_cxl_host_dev() and cxl_handle_proto_error() to Dequeue
>   patch (Terry)
> - Remove EP case in cxl_get_ras_base(), not used. (Terry)
> - Remove check for dport->dport_dev (Dave)
> - Remove whitespace (Terry)
> 
> Changes in v11->v12:
> - Add call to cxl_pci_drv_bound() in cxl_handle_proto_error() and
>   pci_to_cxl_dev()
> - Change cxl_error_detected() -> cxl_cor_error_detected()
> - Remove NULL variable assignments
> - Replace bus_find_device() with find_cxl_port_by_uport() for upstream
>   port searches.
> 
> Changes in v10->v11:
> - None
> ---
>  drivers/cxl/core/core.h       |   7 ++
>  drivers/cxl/core/port.c       |   6 +-
>  drivers/cxl/core/ras.c        | 223 +++++++++++++++++++++++++++-------
>  drivers/pci/pci.h             |   1 -
>  drivers/pci/pcie/aer.c        |  13 ++
>  drivers/pci/pcie/aer_cxl_vh.c |  16 ++-
>  6 files changed, 220 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 23fe40ddf4c6b..7c70bea06c2db 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -186,6 +186,8 @@ static inline struct device *dport_to_host(struct cxl_dport *dport)
>  void cxl_ras_init(void);
>  void cxl_ras_exit(void);
>  bool cxl_handle_ras(struct device *dev, void __iomem *ras_base);
> +void cxl_do_recovery(struct pci_dev *pdev, struct cxl_port *port,
> +		     struct cxl_dport *dport);
>  void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base);
>  void cxl_dport_map_rch_aer(struct cxl_dport *dport);
>  void cxl_disable_rch_root_ints(struct cxl_dport *dport);
> @@ -198,6 +200,8 @@ static inline bool cxl_handle_ras(struct device *dev, void __iomem *ras_base)
>  {
>  	return false;
>  }
> +static inline void cxl_do_recovery(struct pci_dev *pdev, struct cxl_port *port,
> +				   struct cxl_dport *dport) { }
>  static inline void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base) { }
>  static inline void cxl_dport_map_rch_aer(struct cxl_dport *dport) { }
>  static inline void cxl_disable_rch_root_ints(struct cxl_dport *dport) { }
> @@ -206,6 +210,9 @@ static inline void devm_cxl_dport_ras_setup(struct cxl_dport *dport) { }
>  #endif /* CONFIG_CXL_RAS */
>  
>  int cxl_gpf_port_setup(struct cxl_dport *dport);
> +struct cxl_port *find_cxl_port_by_dport(struct device *dport_dev,
> +					struct cxl_dport **dport);
> +struct cxl_port *find_cxl_port_by_uport(struct device *uport_dev);
>  
>  struct cxl_hdm;
>  int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index cadb51f70f854..a76f3ee05cba8 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1400,8 +1400,8 @@ static struct cxl_port *__find_cxl_port_by_dport(struct cxl_find_port_ctx *ctx)
>   * Return a 'struct cxl_port' with an elevated reference if found. Use
>   * __free(put_cxl_port) to release.
>   */
> -static struct cxl_port *find_cxl_port_by_dport(struct device *dport_dev,
> -					       struct cxl_dport **dport)
> +struct cxl_port *find_cxl_port_by_dport(struct device *dport_dev,
> +					struct cxl_dport **dport)
>  {
>  	struct cxl_find_port_ctx ctx = {
>  		.dport_dev = dport_dev,
> @@ -1596,7 +1596,7 @@ static int match_port_by_uport(struct device *dev, const void *data)
>   * Function takes a device reference on the port device. Caller should do a
>   * put_device() when done.
>   */
> -static struct cxl_port *find_cxl_port_by_uport(struct device *uport_dev)
> +struct cxl_port *find_cxl_port_by_uport(struct device *uport_dev)
>  {
>  	struct device *dev;
>  
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 135f1997e6f4f..b190e69c2d415 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -77,6 +77,36 @@ static int match_memdev_by_parent(struct device *dev, const void *uport)
>  	return 0;
>  }
>  
> +
> +/**
> + * find_cxl_port_by_dev - Use @dev as hint to do a _by_dport or _by_uport lookup
> + * @dev: generic device that may either be a companion of port or target dport
> + * @dport: output parameter; set to the matched dport for dport-class
> + * lookups (Root Port, Downstream Port), NULL otherwise.
> + *
> + * Return a 'struct cxl_port' with an elevated reference if found. Use
> + * __free(put_cxl_port) to release.
> + */
> +static struct cxl_port *find_cxl_port_by_dev(struct device *dev, struct cxl_dport **dport)
> +{
> +	if (dport)
> +		*dport = NULL;
> +	if (!dev_is_pci(dev))
> +		return NULL;
> +
> +	switch (pci_pcie_type(to_pci_dev(dev))) {
> +	case PCI_EXP_TYPE_ROOT_PORT:
> +	case PCI_EXP_TYPE_DOWNSTREAM:
> +		return find_cxl_port_by_dport(dev, dport);
> +	case PCI_EXP_TYPE_UPSTREAM:
> +	case PCI_EXP_TYPE_ENDPOINT:
> +	case PCI_EXP_TYPE_RC_END:
> +		return find_cxl_port_by_uport(dev);
> +	}
> +
> +	return NULL;
> +}
> +
>  void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data *data)
>  {
>  	unsigned int devfn = PCI_DEVFN(data->prot_err.agent_addr.device,
> @@ -132,16 +162,6 @@ static void cxl_cper_prot_err_work_fn(struct work_struct *work)
>  }
>  static DECLARE_WORK(cxl_cper_prot_err_work, cxl_cper_prot_err_work_fn);
>  
> -void cxl_ras_init(void)
> -{
> -	cxl_cper_register_prot_err_work(&cxl_cper_prot_err_work);
> -}
> -
> -void cxl_ras_exit(void)
> -{
> -	cxl_cper_unregister_prot_err_work();
> -}
> -
>  static void cxl_dport_map_ras(struct cxl_dport *dport)
>  {
>  	struct cxl_register_map *map = &dport->reg_map;
> @@ -198,10 +218,39 @@ void devm_cxl_port_ras_setup(struct cxl_port *port)
>  }
>  EXPORT_SYMBOL_NS_GPL(devm_cxl_port_ras_setup, "CXL");
>  
> +static void __iomem *to_ras_base(struct cxl_port *port, struct cxl_dport *dport)
> +{
> +	if (!port)
> +		return NULL;
> +
> +	if (dport)
> +		return dport->regs.ras;
> +
> +	return port->regs.ras;
> +}
> +
> +void cxl_do_recovery(struct pci_dev *pdev, struct cxl_port *port, struct cxl_dport *dport)
> +{
> +	struct device *dev = dport ? dport->dport_dev : port->uport_dev;
> +	void __iomem *ras_base = to_ras_base(port, dport);
> +
> +	if (!ras_base) {
> +		dev_err(&pdev->dev,
> +			"CXL UCE signaled but RAS registers not mapped\n");
> +		return;
> +	}
> +
> +	if (cxl_handle_ras(dev, ras_base))
> +		panic("CXL cachemem error");
> +
> +	dev_dbg(&pdev->dev,
> +		"CXL UCE signaled but no CXL RAS status bits set\n");
> +}
> +
>  void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base)
>  {
> -	void __iomem *addr;
>  	u32 status;
> +	void __iomem *addr;
>  
>  	if (!ras_base)
>  		return;
> @@ -210,7 +259,10 @@ void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base)
>  	status = readl(addr);
>  	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
>  		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
> -		trace_cxl_aer_correctable_error(to_cxl_memdev(dev), status);
> +		if (is_cxl_memdev(dev))
> +			trace_cxl_aer_correctable_error(to_cxl_memdev(dev), status);
> +		else
> +			trace_cxl_port_aer_correctable_error(dev, status);
>  	}
>  }
>  
> @@ -262,7 +314,11 @@ bool cxl_handle_ras(struct device *dev, void __iomem *ras_base)
>  	}
>  
>  	header_log_copy(ras_base, hl);
> -	trace_cxl_aer_uncorrectable_error(to_cxl_memdev(dev), status, fe, hl);
> +	if (is_cxl_memdev(dev))
> +		trace_cxl_aer_uncorrectable_error(to_cxl_memdev(dev), status, fe, hl);
> +	else
> +		trace_cxl_port_aer_uncorrectable_error(dev, status, fe, hl);
> +
>  	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
>  
>  	return true;
> @@ -270,22 +326,32 @@ bool cxl_handle_ras(struct device *dev, void __iomem *ras_base)
>  
>  void cxl_cor_error_detected(struct pci_dev *pdev)
>  {
> -	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> -	struct cxl_memdev *cxlmd = cxlds->cxlmd;
> -	struct device *dev = &cxlds->cxlmd->dev;
> +	guard(device)(&pdev->dev);
> +	if (!pdev->dev.driver)
> +		return;
> +
> +	struct cxl_port *port __free(put_cxl_port) = find_cxl_port_by_uport(&pdev->dev);
> +	if (!port)
> +		return;
> +
> +	if (is_cxl_restricted(pdev)) {
> +		struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> +		struct cxl_memdev *cxlmd = cxlds->cxlmd;
>  
> -	scoped_guard(device, dev) {
> -		if (!dev->driver) {
> +		scoped_guard(device, &cxlmd->dev) {
> +			cxl_handle_rdport_errors(cxlds);
> +		}
> +	}
> +
> +	scoped_guard(device, &port->dev) {
> +		if (!port->dev.driver) {
>  			dev_warn(&pdev->dev,
> -				 "%s: memdev disabled, abort error handling\n",
> -				 dev_name(dev));
> +				 "%s: port disabled, abort error handling\n",
> +				 dev_name(&port->dev));
>  			return;
>  		}
>  
> -		if (cxlds->rcd)
> -			cxl_handle_rdport_errors(cxlds);
> -
> -		cxl_handle_cor_ras(&cxlds->cxlmd->dev, cxlmd->endpoint->regs.ras);
> +		cxl_handle_cor_ras(port->uport_dev, to_ras_base(port, NULL));
>  	}
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, "CXL");
> @@ -293,42 +359,53 @@ EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, "CXL");
>  pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>  				    pci_channel_state_t state)
>  {
> -	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> -	struct cxl_memdev *cxlmd = cxlds->cxlmd;
> -	struct device *dev = &cxlmd->dev;
> -	bool ue;
> +	struct cxl_port *port __free(put_cxl_port) = find_cxl_port_by_uport(&pdev->dev);
> +	bool ue = false;
>  
> -	scoped_guard(device, dev) {
> -		if (!dev->driver) {
> +	if (!port)
> +		return PCI_ERS_RESULT_DISCONNECT;
> +
> +	if (is_cxl_restricted(pdev)) {
> +		struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> +		struct cxl_memdev *cxlmd = cxlds->cxlmd;
> +
> +		scoped_guard(device, &cxlmd->dev) {
> +			cxl_handle_rdport_errors(cxlds);
> +		}
> +	}
> +
> +	scoped_guard(device, &port->dev) {
> +		if (!port->dev.driver) {
>  			dev_warn(&pdev->dev,
> -				 "%s: memdev disabled, abort error handling\n",
> -				 dev_name(dev));
> +				 "%s: port disabled, abort error handling\n",
> +				 dev_name(&port->dev));
>  			return PCI_ERS_RESULT_DISCONNECT;
>  		}
>  
> -		if (cxlds->rcd)
> -			cxl_handle_rdport_errors(cxlds);
>  		/*
>  		 * A frozen channel indicates an impending reset which is fatal to
>  		 * CXL.mem operation, and will likely crash the system. On the off
>  		 * chance the situation is recoverable dump the status of the RAS
>  		 * capability registers and bounce the active state of the memdev.
>  		 */
> -		ue = cxl_handle_ras(&cxlds->cxlmd->dev, cxlmd->endpoint->regs.ras);
> +		ue = cxl_handle_ras(port->uport_dev, to_ras_base(port, NULL));
>  	}
>  
> +	/*
> +	 * CXL.mem UCE means cache coherency is lost. Continuing risks
> +	 * silent data corruption across interleaved HDM regions.
> +	 */
> +	if (ue)
> +		panic("CXL cachemem error");
> +
>  	switch (state) {
>  	case pci_channel_io_normal:
> -		if (ue) {
> -			device_release_driver(dev);
> -			return PCI_ERS_RESULT_NEED_RESET;
> -		}
>  		return PCI_ERS_RESULT_CAN_RECOVER;
>  	case pci_channel_io_frozen:
>  		dev_warn(&pdev->dev,
>  			 "%s: frozen state error detected, disable CXL.mem\n",
> -			 dev_name(dev));
> -		device_release_driver(dev);
> +			 dev_name(port->uport_dev));
> +		device_release_driver(port->uport_dev);
>  		return PCI_ERS_RESULT_NEED_RESET;
>  	case pci_channel_io_perm_failure:
>  		dev_warn(&pdev->dev,
> @@ -338,3 +415,67 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>  	return PCI_ERS_RESULT_NEED_RESET;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_error_detected, "CXL");
> +
> +static void cxl_handle_proto_error(struct pci_dev *pdev, struct cxl_port *port,
> +				   struct cxl_dport *dport, int severity)
> +{
> +	struct device *dev = dport ? dport->dport_dev : port->uport_dev;
> +
> +	if (severity == AER_CORRECTABLE)
> +		cxl_handle_cor_ras(dev, to_ras_base(port, dport));
> +	else
> +		cxl_do_recovery(pdev, port, dport);
> +}
> +
> +static void __cxl_proto_err_work_fn(struct cxl_proto_err_work_data *wd)
> +{
> +	struct cxl_port *port __free(put_cxl_port) = find_cxl_port_by_dev(&wd->pdev->dev, NULL);
> +	if (!port) {
> +		dev_err_ratelimited(&wd->pdev->dev,
> +				    "Failed to find parent port device in CXL topology\n");
> +		return;
> +	}
> +	guard(device)(&port->dev);
> +	if (!port->dev.driver) {
> +		dev_err_ratelimited(&port->dev,
> +				    "Port device is unbound, abort error handling\n");
> +		return;
> +	}
> +
> +	struct cxl_dport *dport = cxl_find_dport_by_dev(port, &wd->pdev->dev);
> +	if (!dport && (pci_pcie_type(wd->pdev) == PCI_EXP_TYPE_ROOT_PORT ||
> +		       pci_pcie_type(wd->pdev) == PCI_EXP_TYPE_DOWNSTREAM)) {
> +		dev_err_ratelimited(&wd->pdev->dev,
> +				    "Failed to find dport device in CXL topology\n");
> +		return;
> +	}
> +
> +	cxl_handle_proto_error(wd->pdev, port, dport, wd->severity);
> +}
> +
> +static void cxl_proto_err_work_fn(struct work_struct *work)
> +{
> +	struct cxl_proto_err_work_data wd;
> +
> +	for_each_cxl_proto_err(&wd, __cxl_proto_err_work_fn);
> +}
> +
> +static DECLARE_WORK(cxl_proto_err_work, cxl_proto_err_work_fn);
> +
> +static void cxl_proto_err_do_flush(void)
> +{
> +	flush_work(&cxl_proto_err_work);
> +}
> +
> +void cxl_ras_init(void)
> +{
> +	cxl_cper_register_prot_err_work(&cxl_cper_prot_err_work);
> +	cxl_register_proto_err_work(&cxl_proto_err_work,
> +				   cxl_proto_err_do_flush);
> +}
> +
> +void cxl_ras_exit(void)
> +{
> +	cxl_unregister_proto_err_work();
> +	cxl_cper_unregister_prot_err_work();
> +}
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 4469e1a77f3c1..a83e2aef75912 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -1296,7 +1296,6 @@ void pci_restore_aer_state(struct pci_dev *dev);
>  static inline void pci_no_aer(void) { }
>  static inline void pci_aer_init(struct pci_dev *d) { }
>  static inline void pci_aer_exit(struct pci_dev *d) { }
> -static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
>  static inline int pci_aer_clear_status(struct pci_dev *dev) { return -EINVAL; }
>  static inline int pci_aer_raw_clear_status(struct pci_dev *dev) { return -EINVAL; }
>  static inline void pci_save_aer_state(struct pci_dev *dev) { }
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index c5bce25df51cb..2d9d40528e709 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1185,7 +1185,20 @@ static void pci_aer_handle_error(struct pci_dev *dev, struct aer_err_info *info)
>  
>  static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
>  {
> +	bool cxl_pending = false;
> +
>  	cxl_rch_handle_error(dev, info);
> +
> +	if (is_cxl_error(dev, info))
> +		cxl_pending |= cxl_forward_error(dev, info);
> +
> +	/*
> +	 * Wait for UCE CXL work to complete before AER recovery
> +	 * tears down the device. CE can run asynchronously.
> +	 */
> +	if (cxl_pending && info->severity != AER_CORRECTABLE)
> +		cxl_proto_err_flush();
> +
>  	pci_aer_handle_error(dev, info);
>  	pci_dev_put(dev);
>  }
> diff --git a/drivers/pci/pcie/aer_cxl_vh.c b/drivers/pci/pcie/aer_cxl_vh.c
> index 93bed07936100..ecf47bba0c9d4 100644
> --- a/drivers/pci/pcie/aer_cxl_vh.c
> +++ b/drivers/pci/pcie/aer_cxl_vh.c
> @@ -49,8 +49,22 @@ bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info)
>  	if (!info || !info->is_cxl)
>  		return false;
>  
> -	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT)
> +	/*
> +	 * RC_END (Restricted CXL Device) is not included here because RC_END
> +	 * reports errors on behalf of upstream RCH Downstream Port and thus
> +	 * requires a unique discovery detailed in CXL4.0 spec (12.2.1.1).
> +	 * The RCH device error discovery and RC_END forwarding flow begins
> +	 * in cxl_rch_handle_error().
> +	 */
> +	switch (pci_pcie_type(pdev)) {
> +	case PCI_EXP_TYPE_ENDPOINT:
> +	case PCI_EXP_TYPE_ROOT_PORT:
> +	case PCI_EXP_TYPE_UPSTREAM:
> +	case PCI_EXP_TYPE_DOWNSTREAM:
> +		break;
> +	default:
>  		return false;
> +	}
>  
>  	return is_aer_internal_error(info);
>  }


