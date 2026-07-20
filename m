Return-Path: <linuxppc-dev+bounces-24548-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C149EC44515
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 22:18:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3vzN111hz2xJR;
	Tue, 21 Jul 2026 08:18:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784585888;
	cv=none; b=DVoxrPWY+z8o8Izsm0zGrNKb4MDZfhH5g+4ImKlkCMwvEfABXwmfXCj/y4vEl6x85jZ9bzCnUoE+/1JP7zbFah5GHNdIMYMAiMMmvVJvpGc8VdPtUF5BEh4Oppqh1F4nFG1k4dzwxEH93Xrg473V1iIl0CqPYwYHsP3Lt9naNhkiA8oq9f/5/K0MIbx6bK8vsXoupuAbT2XCX5mj4z+kZo6ahi92LKMzsClybh7Y84MEw6Nb4oS6j5zMre2ymuFl0X+r8QFd7otLFthLO9IuifChqN9V7aKMevNZJv+H35u4/rga2fXUev/BYT6coQF2gNTRKVS1ysMZ0jv0b05Uqg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784585888; c=relaxed/relaxed;
	bh=ZO0XOLhLQ05uTbPelZ32rlrCQSLS39hO8fTRy/YI/Hs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LAZgwWdeLoKSmnTdnhdP7PWN3olJfgbyoC/HMCjEC5I46mf6lkx+pVQisYKhTiWSlx17YExZwrbinT4hFoL/MnwHyNRC+4lTJJL+iZ8WQsT8PAcIZxkExFL9bIOuxZa5/rL2Fka3nvZnMwE6qcb1e/lyASjQtYyHWJLv6ycimK/mWFRFsvguysoP2E967njmBaFZNq7K3Kly2FzkztXoDbTcAmqCMQ3v5Z4OJYSVvFUxDMoYwD3INk3I4fvXTeWyaikCWR9NOc9hR8QcsE5TacsQdxiRfvtjx+ZcZ9NfoHS7uIbCzjGrdDONqC4Hq9EZmuxHNN8qjKzWv7oxuAAXGg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fdBZa87+; dkim-atps=neutral; spf=pass (client-ip=192.198.163.9; helo=mgamail.intel.com; envelope-from=dave.jiang@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fdBZa87+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.9; helo=mgamail.intel.com; envelope-from=dave.jiang@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3vzJ5Rspz2xFc
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2026 08:18:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784585885; x=1816121885;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=piJCye+663SJPdUrzyC56NPwu7ZHIhzz+UfLbBqyqUc=;
  b=fdBZa87+SjtKBKh4AC18wEs2/qwGEE771R5C+9/Rp7ZRF0FZuO/Gvzks
   tU5/esO4YKe39LHdspf3PZzp6/s/lvEKcy2QiP/wAZbwFOs64NbtnQ0CT
   nr4jahKo/nqQZEcYTT7YrnFMexkfMZ8Jc6CYZKdweXqtsqAeN/IWkI2bw
   Kl9E+C2PzEpnfXbPx/jjY7EpuJv5dyvSHe//z/OGLnJmRePWBi3l35w/K
   V1T8riq2nlazp0JM2B/QuWw4tRpBAHfVM1iSC6FwZmIXjRaeX8MOBL9SP
   Mljm4tAfFWTDe9O6YbEZVGBxrlA40efPYwJIu0ff+Ipo+7sm6JfuQ7944
   g==;
X-CSE-ConnectionGUID: jnhgubrLStCCn/2oKTjGwQ==
X-CSE-MsgGUID: x+flM+wxRD20Wlj98goAUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="95829470"
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="95829470"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 15:15:12 -0700
X-CSE-ConnectionGUID: IPJQR+ENQPWu7HFmV6oHlQ==
X-CSE-MsgGUID: DQS5BRxVSWS9nTZJ/HpaJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="255799392"
Received: from cooperst-gp83.amr.corp.intel.com (HELO [10.125.109.176]) ([10.125.109.176])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 15:15:10 -0700
Message-ID: <bf7e8105-9c0b-4e80-a8b1-5df7873754c5@intel.com>
Date: Mon, 20 Jul 2026 15:15:09 -0700
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
Subject: Re: [PATCH v18 08/13] cxl/pci: Thread port and dport through RAS
 handling helpers
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
 <20260717222706.3540281-9-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260717222706.3540281-9-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/17/26 3:27 PM, Terry Bowman wrote:
> From: Dan Williams <djbw@kernel.org>
> 
> The callers of cxl_handle_ras() and cxl_handle_cor_ras() already hold
> a struct cxl_port * and struct cxl_dport * for the device being
> handled. Passing a generic struct device * requires is_cxl_memdev()
> to distinguish Endpoints from ports at trace emission time. Threading
> port and dport directly enables is_cxl_endpoint(port) and explicit
> dport/port branching for cleaner trace dispatch.
> 
> Refactor cxl_handle_ras() and cxl_handle_cor_ras() to accept struct
> cxl_port * and struct cxl_dport * directly. The CXL RAS trace event
> emission logic is split into three branches: Endpoint events are
> identified via is_cxl_endpoint(port) and emit with the memdev, dport
> events emit with dport->dport_dev, and Upstream Port events fall back
> to port->uport_dev.
> 
> Update cxl_handle_rdport_errors() in ras_rch.c and
> cxl_handle_proto_error() in ras.c to pass port and dport to the
> refactored functions.
> 
> RCH Downstream Port correctable trace events now report the dport
> device (dport->dport_dev) as a consequence of threading port and dport
> through the RAS helpers. The following trace event rework ("cxl: Add
> port and dport identifiers to CXL AER trace events") adds explicit
> memdev, port, dport, and host fields that provide full context for
> all device types.
> 
> Co-developed-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Dan Williams <djbw@kernel.org>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>


> 
> ---
> 
> Changes in v17 -> v18:
> - New patch.
> ---
>  drivers/cxl/core/core.h    | 12 ++++++++----
>  drivers/cxl/core/ras.c     | 29 +++++++++++++++--------------
>  drivers/cxl/core/ras_rch.c |  2 +-
>  3 files changed, 24 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 272634ff2615b..5ca1275fd8f35 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -185,10 +185,12 @@ static inline struct device *dport_to_host(struct cxl_dport *dport)
>  #ifdef CONFIG_CXL_RAS
>  void cxl_ras_init(void);
>  void cxl_ras_exit(void);
> -bool cxl_handle_ras(struct device *dev, void __iomem *ras_base);
> +bool cxl_handle_ras(struct cxl_port *port, struct cxl_dport *dport,
> +		    void __iomem *ras_base);
>  void cxl_do_recovery(struct pci_dev *pdev, struct cxl_port *port,
>  		     struct cxl_dport *dport);
> -void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base);
> +void cxl_handle_cor_ras(struct cxl_port *port, struct cxl_dport *dport,
> +			void __iomem *ras_base);
>  void cxl_dport_map_rch_aer(struct cxl_dport *dport);
>  void cxl_disable_rch_root_ints(struct cxl_dport *dport);
>  void cxl_handle_rdport_errors(struct pci_dev *pdev);
> @@ -197,13 +199,15 @@ void devm_cxl_dport_ras_setup(struct cxl_dport *dport);
>  #else
>  static inline void cxl_ras_init(void) { }
>  static inline void cxl_ras_exit(void) { }
> -static inline bool cxl_handle_ras(struct device *dev, void __iomem *ras_base)
> +static inline bool cxl_handle_ras(struct cxl_port *port, struct cxl_dport *dport,
> +				  void __iomem *ras_base)
>  {
>  	return false;
>  }
>  static inline void cxl_do_recovery(struct pci_dev *pdev, struct cxl_port *port,
>  				   struct cxl_dport *dport) { }
> -static inline void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base) { }
> +static inline void cxl_handle_cor_ras(struct cxl_port *port, struct cxl_dport *dport,
> +				      void __iomem *ras_base) { }
>  static inline void cxl_dport_map_rch_aer(struct cxl_dport *dport) { }
>  static inline void cxl_disable_rch_root_ints(struct cxl_dport *dport) { }
>  static inline void cxl_handle_rdport_errors(struct pci_dev *pdev) { }
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 9a142abcf4f8b..6f4a3c1b0bb85 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -232,7 +232,6 @@ void __iomem *to_ras_base(struct cxl_port *port, struct cxl_dport *dport)
>  
>  void cxl_do_recovery(struct pci_dev *pdev, struct cxl_port *port, struct cxl_dport *dport)
>  {
> -	struct device *dev = dport ? dport->dport_dev : port->uport_dev;
>  	void __iomem *ras_base = to_ras_base(port, dport);
>  
>  	if (!ras_base) {
> @@ -241,14 +240,14 @@ void cxl_do_recovery(struct pci_dev *pdev, struct cxl_port *port, struct cxl_dpo
>  		return;
>  	}
>  
> -	if (cxl_handle_ras(dev, ras_base))
> +	if (cxl_handle_ras(port, dport, ras_base))
>  		panic("CXL cachemem error");
>  
>  	dev_dbg(&pdev->dev,
>  		"CXL UCE signaled but no CXL RAS status bits set\n");
>  }
>  
> -void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base)
> +void cxl_handle_cor_ras(struct cxl_port *port, struct cxl_dport *dport, void __iomem *ras_base)
>  {
>  	u32 status;
>  	void __iomem *addr;
> @@ -260,10 +259,12 @@ void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base)
>  	status = readl(addr);
>  	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
>  		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
> -		if (is_cxl_memdev(dev))
> -			trace_cxl_aer_correctable_error(to_cxl_memdev(dev), status);
> +		if (is_cxl_endpoint(port))
> +			trace_cxl_aer_correctable_error(to_cxl_memdev(port->uport_dev), status);
> +		else if (dport)
> +			trace_cxl_port_aer_correctable_error(dport->dport_dev, status);
>  		else
> -			trace_cxl_port_aer_correctable_error(dev, status);
> +			trace_cxl_port_aer_correctable_error(port->uport_dev, status);
>  	}
>  }
>  
> @@ -288,7 +289,7 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
>   * Log the state of the RAS status registers and prepare them to log the
>   * next error status. Return 1 if reset needed.
>   */
> -bool cxl_handle_ras(struct device *dev, void __iomem *ras_base)
> +bool cxl_handle_ras(struct cxl_port *port, struct cxl_dport *dport, void __iomem *ras_base)
>  {
>  	u32 hl[CXL_HEADERLOG_TRACE_SIZE_U32] = {};
>  	void __iomem *addr;
> @@ -315,10 +316,12 @@ bool cxl_handle_ras(struct device *dev, void __iomem *ras_base)
>  	}
>  
>  	header_log_copy(ras_base, hl);
> -	if (is_cxl_memdev(dev))
> -		trace_cxl_aer_uncorrectable_error(to_cxl_memdev(dev), status, fe, hl);
> +	if (is_cxl_endpoint(port))
> +		trace_cxl_aer_uncorrectable_error(to_cxl_memdev(port->uport_dev), status, fe, hl);
> +	else if (dport)
> +		trace_cxl_port_aer_uncorrectable_error(dport->dport_dev, status, fe, hl);
>  	else
> -		trace_cxl_port_aer_uncorrectable_error(dev, status, fe, hl);
> +		trace_cxl_port_aer_uncorrectable_error(port->uport_dev, status, fe, hl);
>  
>  	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
>  
> @@ -351,7 +354,7 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>  		 * chance the situation is recoverable dump the status of the RAS
>  		 * capability registers and bounce the active state of the memdev.
>  		 */
> -		ue = cxl_handle_ras(port->uport_dev, to_ras_base(port, NULL));
> +		ue = cxl_handle_ras(port, NULL, to_ras_base(port, NULL));
>  	}
>  
>  	/*
> @@ -382,10 +385,8 @@ EXPORT_SYMBOL_NS_GPL(cxl_error_detected, "CXL");
>  static void cxl_handle_proto_error(struct pci_dev *pdev, struct cxl_port *port,
>  				   struct cxl_dport *dport, int severity)
>  {
> -	struct device *dev = dport ? dport->dport_dev : port->uport_dev;
> -
>  	if (severity == AER_CORRECTABLE)
> -		cxl_handle_cor_ras(dev, to_ras_base(port, dport));
> +		cxl_handle_cor_ras(port, dport, to_ras_base(port, dport));
>  	else
>  		cxl_do_recovery(pdev, port, dport);
>  }
> diff --git a/drivers/cxl/core/ras_rch.c b/drivers/cxl/core/ras_rch.c
> index f2d2fb83758b9..f4b98f2c11a1c 100644
> --- a/drivers/cxl/core/ras_rch.c
> +++ b/drivers/cxl/core/ras_rch.c
> @@ -118,7 +118,7 @@ void cxl_handle_rdport_errors(struct pci_dev *pdev)
>  
>  	pci_print_aer(pdev, severity, &aer_regs);
>  	if (severity == AER_CORRECTABLE)
> -		cxl_handle_cor_ras(&pdev->dev, to_ras_base(port, dport));
> +		cxl_handle_cor_ras(dport->port, dport, to_ras_base(port, dport));
>  	else
>  		cxl_do_recovery(pdev, dport->port, dport);
>  }


