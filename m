Return-Path: <linuxppc-dev+bounces-24558-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C62BCC44515
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 23:17:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3xJG0wYnz2yWK;
	Tue, 21 Jul 2026 09:17:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784589470;
	cv=none; b=NuVKR84DxzRzvgNR47sq9P+Qyf/YsWEjnVVFUKCWvyB/j32LaqF/vteNG38UWCz6BPxZgsNeFhtsy+ExqiMOlSQpsZXWoT/pNhYyy9mgI9qmWefxtt/e+2xOpLzRhmp7bXOig0jel9JZlP916HSH+Frf1mp9FAbhJ6j25mbmWyPGSLouEc3TwdaZfHL9nXpDPvBgs41y3+KLo2k6/NjybfzzNvHPE/Fg/RvJsElQFrKDYK2HfyUhirk8kR9iOQovaX3j5CM2ycwKPQj677dLKu+GzAr5UFkG3Rda+TpFwTX44dkuugsabYMpzlIDTSNo5VGs7lTrd4xyEjbvAlx0zg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784589470; c=relaxed/relaxed;
	bh=3XCLYK0QohuRCjujR60Iq/Ht3BdWK1ezj3XOJ6GgNV8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QObQSFZrezIFv77ing1XPaH28IHept9qdRN/FBljBS7ZC3cYRorDMXOdtsO3anHLf/1vkjF9f8ELzK6Ogb+cBJFUkTLXpLCtRZgFkXVhcCR+VcQK16EEXhvukQW71kS7skgKoDUivpoGUchoZomraH+qCk9SArt7Wq/9JxF3UsucDRKB5XZyXKjjfC5T4908dohoyIfn031uHszQpJyHRQcDSumrhlOBoU6o/KL/aRpq+SeYG7lfHJbzLX4TuNzYKoqX+l7DGUkI+4E/IMMW187wUpmCuELNWbcHkPznsXhaWqapR3PwbttqIqT2Wc/mA2H5QoYaAi0iOJJhlxYe6A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hf8UuIZq; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=jic23@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hf8UuIZq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=jic23@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3xJF2FQvz2yT0
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2026 09:17:49 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 26941435A2;
	Mon, 20 Jul 2026 23:17:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B43111F000E9;
	Mon, 20 Jul 2026 23:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784589467;
	bh=3XCLYK0QohuRCjujR60Iq/Ht3BdWK1ezj3XOJ6GgNV8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hf8UuIZqwcqiLSJ1FGcCiXru+vX6T0gOX+VgIgvLKpxG0mvG0crCOjMz3xaWqgd6I
	 bRQBXFGI8u/xxIxQzh7dYv9i8z1w0B8b5mGd9wecqqzobaoww6Y5dujSRWCfbAE4F0
	 YazPucp6M9/5wDZvgzs8zlDfLCX/u2x8mQPryVrMcYD2UPxzeUJPak2RQJVmRKDGYs
	 WkWG1S2sg8CmYyBG6I1w97cpdQd0OAtecWyKV/w8E7lQ+Faq5Cm2Mi5JFwgkQ9lPSH
	 4OgL5nvbom05gGugr7nwXyS+TlOIn3xD5ABY6U8yUpHVqQN2x2WJ6OYtgLD3QI1YNM
	 zDIDrOlWXmazQ==
Date: Tue, 21 Jul 2026 00:17:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Terry Bowman <terry.bowman@amd.com>
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
Subject: Re: [PATCH v18 08/13] cxl/pci: Thread port and dport through RAS
 handling helpers
Message-ID: <20260721001737.143d17e7@jic23-huawei>
In-Reply-To: <20260717222706.3540281-9-terry.bowman@amd.com>
References: <20260717222706.3540281-1-terry.bowman@amd.com>
	<20260717222706.3540281-9-terry.bowman@amd.com>
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

On Fri, 17 Jul 2026 17:27:01 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> From: Dan Williams <djbw@kernel.org>
> 
> The callers of cxl_handle_ras() and cxl_handle_cor_ras() already hold
> a struct cxl_port * and struct cxl_dport * for the device being
> handled.

It seems unlikely that all have both of them given you have handling
in the code for dport == NULL.  Perhaps reword.

> Passing a generic struct device * requires is_cxl_memdev()
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

Definitely no need to say which files they are in. If we care we can
look at the patch.

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


