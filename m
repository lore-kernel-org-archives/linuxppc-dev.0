Return-Path: <linuxppc-dev+bounces-6717-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22103C021B8
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Mar 2025 23:22:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z6sCv5Ss9z30Kg;
	Wed,  5 Mar 2025 10:22:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=139.178.84.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741130555;
	cv=none; b=LjkSbHLXise7xxxuonV5/mUOdAuM5JI6/KFsRs2I6UmYWWUhMqrLVYmqAn1pA3XHCenYCWW5nRoJwB74Dk3yJKEJ/pevbLr6Jhh96Pib7OISJ7FgwxmWOrKfmy0b8p2Z2l1jbOVeJySHzMRbRhmfLdnP1Hf6kTN+tC8mHzHwCSYg7GhXxQP/obzNI2ipnhioG5LwIWWG/BHWAFS7OmSwKOIV9acqR4tYKKA2dOgTIZ2ZnaLZHOOLJT3x8WIcF3PjNKkglMrqAEQhk9xkL9bCdtuRRPl0e13z1S/crqdUBhqbu9iILHBhJXY0kA9Ts7v4xXSvMgReV+d8QrON7cOqHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741130555; c=relaxed/relaxed;
	bh=hx/3h9ISwJhZvNorTGSlGjIIt6i3ltvEbkF5D20+mMA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=YIaj5xuvbyUq3rtA8D4yXsSI8EYlS/+etePvhoBt+My/LwyP9qNltXXJBVDD5d8qctNDPMefSw/iSykF/lFlUnXINWRcWm30bB/aJvXNOko/6c97sgxc6DQyyYwioQAwadEjH0D/+uwfbwheMIuwEwRzvRUhgxgTlbz9viHmZyNsjas5SPx7PG/iRAkZ3/BCZW1w8jWUkT0hhfDmS15scKH5EjAP0C8k80GjU2FBe0Q8oVeU0i8F54P9lRpqZS3L7xeTzXaDzDQomFS4hdYmOXlut4Y6m/2EPLcGzfy3H2Uf1CWgBjrpaMC7B/IerRqYQpAr2n8vB5kl3QWVnclJuQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=gDzGSlEt; dkim-atps=neutral; spf=pass (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=gDzGSlEt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z6sCt66HJz309v
	for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Mar 2025 10:22:34 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 2B5B85C630E;
	Tue,  4 Mar 2025 23:20:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86C02C4CEE9;
	Tue,  4 Mar 2025 23:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741130551;
	bh=iiljtkG5DqNiUtL+acfsxJ6Pgz3aTmOCDfPZ887+nAo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=gDzGSlEtb1YmIF4xksZ5KICBIE6jiYVJbX5zLBu6WeXSOzYETPbtl7pBlJT94TlJp
	 98429J1ufEerB9D5zlpi6FyT613n+XxiYpuLllRSd6Jc/Fs3vfixEBUwYjWesBxY9l
	 a8K/h4srMoPKUHE9zTyXl8ONAwuSY8OSQAC0Jh4COIA+1fe9FAyJfmIwAcBvTux2cM
	 t8d271Al1ktDKdM37p0xzAi2nHQW6mnONPflu+pwknzHC8p2CFcPRyN45RMbwDrxz7
	 uEeead0R9x5Cn7B8qN/mT3rCK2rHn1d/hHI82+wJb4MyIJEfLchmiyu7N5SKM/LKqF
	 9p3hjY0T3KyUA==
Date: Tue, 4 Mar 2025 17:22:30 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bijie Xu <bijie.xu@corigine.com>
Cc: oohall@gmail.com, mahesh@linux.ibm.com, bhelgaas@google.com,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jon Pan-Doh <pandoh@google.com>,
	Karolina Stolarek <karolina.stolarek@oracle.com>
Subject: Re: [PATCH] PCI/AER: Add kernel.aer_print_skip_mask to control aer
 log
Message-ID: <20250304232230.GA264709@bhelgaas>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250108075703.410961-1-bijie.xu@corigine.com>

[+cc Jon, Karolina]

On Wed, Jan 08, 2025 at 03:57:03PM +0800, Bijie Xu wrote:
> Sometimes certain PCIE devices installed on some servers occasionally
> produce large number of AER correctable error logs, which is quite
> annoying. Add this sysctl parameter kernel.aer_print_skip_mask to
> skip printing AER errors of certain severity.
> 
> The AER severity can be 0(NONFATAL), 1(FATAL), 2(CORRECTABLE). The 3
> low bits of the mask are used to skip these 3 severities. Set bit 0
> can skip printing NONFATAL AER errors, and set bit 1 can skip printing
> FATAL AER errors, set bit 2 can skip printing CORRECTABLE AER errors.
> And multiple bits can be set to skip multiple severities.

This is definitely annoying, actually MORE than annoying in some
cases.

I'm hoping the correctable error rate-limiting work can reduce the
annoyance to an tolerable level:

  https://lore.kernel.org/r/20250214023543.992372-1-pandoh@google.com

Can you take a look at this and see if it's going the right direction
for you, or if it needs extensions to do what you need?

> Signed-off-by: Bijie Xu <bijie.xu@corigine.com>
> ---
>  drivers/pci/pcie/aer.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 80c5ba8d8296..b46973526bcf 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -698,6 +698,7 @@ static void __aer_print_error(struct pci_dev *dev,
>  	pci_dev_aer_stats_incr(dev, info);
>  }
>  
> +unsigned int aer_print_skip_mask __read_mostly;
>  void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
>  {
>  	int layer, agent;
> @@ -710,6 +711,9 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
>  		goto out;
>  	}
>  
> +	if ((1 << info->severity) & aer_print_skip_mask)
> +		goto out;
> +
>  	layer = AER_GET_LAYER_ERROR(info->severity, info->status);
>  	agent = AER_GET_AGENT(info->severity, info->status);
>  
> @@ -1596,3 +1600,22 @@ int __init pcie_aer_init(void)
>  		return -ENXIO;
>  	return pcie_port_service_register(&aerdriver);
>  }
> +
> +static const struct ctl_table aer_print_skip_mask_sysctls[] = {
> +	{
> +		.procname       = "aer_print_skip_mask",
> +		.data           = &aer_print_skip_mask,
> +		.maxlen         = sizeof(unsigned int),
> +		.mode           = 0644,
> +		.proc_handler   = &proc_douintvec,
> +	},
> +	{}
> +};
> +
> +static int __init aer_print_skip_mask_sysctl_init(void)
> +{
> +	register_sysctl_init("kernel", aer_print_skip_mask_sysctls);
> +	return 0;
> +}
> +
> +late_initcall(aer_print_skip_mask_sysctl_init);
> -- 
> 2.25.1
> 

