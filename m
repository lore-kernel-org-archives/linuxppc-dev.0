Return-Path: <linuxppc-dev+bounces-25966-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74AE6C5DF7D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Aug 2026 22:33:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hPkxd3cvXz2xfq;
	Wed, 19 Aug 2026 08:33:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787092405;
	cv=none; b=bwiWniKtdJbvluDEIXNt3CQyFKr7XVPCyB9vPIS8TW5YYjO9s6B+4MyMrlC3EVHIofwlJSGgLLxabYRVARqxZGyd3Tu30Mivi+sg1p5tlsDI5fQbKWDr3fatSDjRpO/5J0kIZhK19iXRNH6U2iN0gqvly36wOxd0UlB4sDxXwJganTbg0TIMGFHuiIfbi3nn9YpDmj6VSupeRdShrFbWWKH4HlTDMwXOWVdGOAHmJw276LhWNWzDI/amNaoiTJuI0HCRWWEWQpptkRzUMJQ8LzTbVicKKrqITJn2+FHyO/T8Ma9hCDTGN7qQI79EH615gpaxyDTTyRi6c3gUgVH6qg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787092405; c=relaxed/relaxed;
	bh=VzIoIlZm6E4Py29G+xr1f5KcVWWzvZl6UCHZeZxLjCw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=X7f6eDeKZmQjlXXQqTdNzeUBqOu6YzgYCu3RZHWkug0hjJTe4csIXmN7UpSnqLvQG6UXhWHLljNxkn1xLxNepe4JejiCDuMbmLp9RtEvitylM7GUS/bgfVadB0K6zjbWcN6EVhoN/slh4NtBLHgnWMzO8vCNcdVz4Bh5fFWlONWISPRfTkKuikvUOXncKWBwFVvii63qXcX4f9j3PkB+EEXsF4PHmxawAvVozN6NBo4wgxd0+VAOUXgA1moXw9xRsJVwAEZ8YBWuZqLVlA2O03c8+eQchWsbeE1znp0YIwHteHWhSD0d9m9dZVTqoWF5TGW59Q/w/GDJUJw/WVM6tA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GDKv/9ep; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GDKv/9ep;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hPkxc4Yx8z2xWt
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Aug 2026 08:33:24 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D0BDF43DA7;
	Tue, 18 Aug 2026 22:33:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86F6A1F000E9;
	Tue, 18 Aug 2026 22:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787092401;
	bh=VzIoIlZm6E4Py29G+xr1f5KcVWWzvZl6UCHZeZxLjCw=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=GDKv/9epMcQOnQr52iagRqKynBMi0oAe8yVGSpPK0pK5VDvwy2wAnz1+TJ+wM3USF
	 23JCrHcc6MGakkTC6ZG7+kTFeRyeIHjywRR/arR8K41O5cmuOAMSyDnjWq8jdi+qwO
	 JNI8a2wPBXzkhkMXB8ziutbCfDCqpx0d1VmeGbvKiUDLF9vwMf9dLIYZvhdT9SrnoI
	 lMbeLRIiWac59fwhuQjR72AG04y1NLWN9lLmu7DWkJZ/L4EbrAMg8qQcmMmDaQCyts
	 bHbQELngutqF6dhbhRYS1Drg9Ze6poXcNBQ4K3HrjTr8jyIxxazSCYEcVyyUsoykXm
	 etG89O6ffadgg==
Date: Tue, 18 Aug 2026 17:33:20 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, Yury Murashka <yurypm@arista.com>,
	Matthew W Carlis <mattc@purestorage.com>,
	Zhenzhong Duan <zhenzhong.duan@intel.com>,
	Qingshun Wang <qingshun.wang@linux.intel.com>,
	Yicong Yang <yang.yicong@picoheart.com>, dio.sun@enflame-tech.com,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	Terry Bowman <terry.bowman@amd.com>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Arjun Govindjee <agovindjee@purestorage.com>,
	Ashish Karkare <ashishk@purestorage.com>,
	Jasjeet Rangi <jrangi@purestorage.com>,
	Meeta Saggi <msaggi@purestorage.com>, rhan@purestorage.com,
	sconnor@purestorage.com, an.luo@enflame-tech.com,
	fernando.hu@enflame-tech.com, bill.wu@enflame-tech.com,
	xin.wang@enflame-tech.com
Subject: Re: [PATCH] PCI/AER: Fix ratelimit and log level of Advisory
 Non-Fatal Errors
Message-ID: <20260818223320.GA754605@bhelgaas>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <120da0565eac0157ffd913423c7cfa66e985ff59.1786800931.git.lukas@wunner.de>

On Sat, Aug 15, 2026 at 03:47:10PM +0200, Lukas Wunner wrote:
> When Advisory Non-Fatal Errors are reported, the Uncorrectable Error bits
> should be reported using the same ratelimit counter and log level as the
> accompanying Correctable Error.
> 
> This is done correctly when they are handled natively in aer_print_error()
> but it is not done correctly when they are handled in Firmware First mode
> in pci_print_aer().
> 
> Fix it.
> 
> Fixes: 21963e6e4e04 ("PCI/AER: Support Advisory Non-Fatal Errors")
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---
> The offending commit is the top-most one on pci/aer (queued for v7.3-rc1).
> This fix could either be folded into or applied on top of it.

Folded in, thanks!

>  drivers/pci/pcie/aer.c | 27 +++++++++++++++++++++------
>  1 file changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 2a380bb..dd2aa5d 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1028,13 +1028,15 @@ int cper_severity_to_aer(int cper_severity)
>  EXPORT_SYMBOL_GPL(cper_severity_to_aer);
>  #endif
>  
> -void pci_print_aer(struct pci_dev *dev, int aer_severity,
> -		   struct aer_capability_regs *aer)
> +static void __pci_print_aer(struct pci_dev *dev, int aer_severity,
> +			    struct aer_capability_regs *aer,
> +			    bool ratelimit_print, const char *level)
>  {
>  	const char *bus_type, *sev;
>  	int tlp_header_valid = 0;
>  	u32 status, mask;
>  	struct aer_err_info info = {
> +		.level = level,
>  		.severity = aer_severity,
>  		.first_error = PCI_ERR_CAP_FEP(aer->cap_control),
>  	};
> @@ -1043,12 +1045,10 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
>  		status = aer->cor_status;
>  		mask = aer->cor_mask;
>  		sev = "cor";
> -		info.level = KERN_WARNING;
>  	} else {
>  		status = aer->uncor_status;
>  		mask = aer->uncor_mask;
>  		sev = "uncor";
> -		info.level = KERN_ERR;
>  		tlp_header_valid = tlp_header_logged(status & ~mask,
>  						     aer->cap_control);
>  	}
> @@ -1067,7 +1067,7 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
>  	 * For Advisory Non-Fatal Errors, record statistics and tracing
>  	 * even if ratelimited
>  	 */
> -	if (!aer_ratelimit(dev, info.severity))
> +	if (!ratelimit_print)
>  		goto anfe;
>  
>  	aer_printk(info.level, dev,
> @@ -1094,10 +1094,25 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
>  		if (anfe_status) {
>  			aer->uncor_status = anfe_status;
>  			aer->uncor_mask = 0;
> -			pci_print_aer(dev, AER_NONFATAL, aer);
> +			__pci_print_aer(dev, AER_NONFATAL, aer,
> +					ratelimit_print, level);
>  		}
>  	}
>  }
> +
> +void pci_print_aer(struct pci_dev *dev, int aer_severity,
> +		   struct aer_capability_regs *aer)
> +{
> +	/*
> +	 * Precalculate ratelimit counter and log level so that Advisory
> +	 * Non-Fatal Errors are treated like the accompanying Correctable Error
> +	 */
> +	bool ratelimit_print = aer_ratelimit(dev, aer_severity);
> +	const char *level = aer_severity == AER_CORRECTABLE ? KERN_WARNING
> +							    : KERN_ERR;
> +
> +	__pci_print_aer(dev, aer_severity, aer, ratelimit_print, level);
> +}
>  EXPORT_SYMBOL_GPL(pci_print_aer);
>  
>  /**
> 
> base-commit: 21963e6e4e0425b12d3128eea5a5104a3bc909c4
> -- 
> 2.53.0
> 

