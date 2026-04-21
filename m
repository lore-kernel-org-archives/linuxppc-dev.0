Return-Path: <linuxppc-dev+bounces-19912-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48EA4F94CA8
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Apr 2026 19:42:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g0Xn951DJz30WX;
	Wed, 22 Apr 2026 05:42:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776800541;
	cv=none; b=B5WyXUOHYOZEZKaWt4Yqg8OczrqmTAS5DpIL9M660lhCctSp8KQEIDnm8J+TE7LuqtQ9esw8V50/IWxuNmBEhKh9dalZY0UCIn+hBkaXFYHCEV/lSHlxfGsH8YpoRCl0pybPOKymu8/d3Qo0XtWPGxH+oJeK0WYoZCO/12ymQaq0cpfGbqqH978V7FE7l/d+bdViqIosb+UuVYUjpzz8xbbagNVooMWmygsckS7KU1gDh7FPS85meCSz4UwVOcfd4khvDeRMEyypCjyKjgmlK7lVA+29vDwk1rH5iZSIm/NcP2PlMnNdIjhMbxlOcGSZRQI+/LaULVCMXAA8w9HpXA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776800541; c=relaxed/relaxed;
	bh=JnGcUUKlrL/Lf9ZhzfvaHj0jBDYJxx3WhTbUzx9JodE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YQBOYKCgCcs0f7gGVTBqj6wqrFUt+Q+skhr5D8XxiqzK5Vg4AyebFEdHJY820L2Lz+ouBYG7XNrOK6iQd7nKFIna8g8iVYvARQrYnNbESc2/fgLaKaexGJq6MLAe6W1s7UzDY6J/KSyf586pQUCm7pSbsmrTDf4oQsqUn5ZrW3Mdvu4m6nL1V7jXOuu9ScCJMFMfKCmcY6OEgVLzz6DKCOqPOp70/Uh3269V/U6zR3Us7Oo9pHJCUvb8bt28e4K2L1Eqo1k2A8szIpHFxkdbWe1uMdm8KFCCYDQBhCIGlwUcfM2CJb/XKP0kO6QLXX1BJTivxqDCDw66XZqPYjquTw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=dU4ij2Q8; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=dU4ij2Q8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g0Xn83cmMz30WT
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2026 05:42:20 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id E2B7C60126;
	Tue, 21 Apr 2026 19:42:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59753C2BCB0;
	Tue, 21 Apr 2026 19:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776800537;
	bh=xmNghYGrPS7aPnR9Fe2A0c3Av//2yBrrb9EMpzvM8+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dU4ij2Q88BapDuHDIZ0EvWzRjerjWcRD2plESQJMgaZTUL0aIFNovwtrRqNKA3ugf
	 eoIcmU1bOv50WdUsaaNP4RpkU+LKK5kEJTTe2DNvcgSdGt5SWkyd07v0xkVULrgtQh
	 VneMWWQpMiFBgNFZuDu9d9Dm7Oge7EA7DIn9wZlJRv6q+LZrht9XX1tyreLccYsy8B
	 NshzYTdRpvYB6ofg6JEC5w46QE+PSjjITJKp84oIb/g67ElZfH1SjbqUo9ONqNzB2F
	 xgAKMogtdPQb6Pee/Xj7dZM+MRIkHtm74+T6YdA3KLJfs78MpSut4PvBzWMVsYvm3t
	 uvIhwa1wrf2IA==
Date: Wed, 22 Apr 2026 04:42:15 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Magnus Lindholm <linmag7@gmail.com>,
	Matt Turner <mattst88@gmail.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Christophe Leroy <chleroy@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Dexuan Cui <decui@microsoft.com>,
	Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>,
	Lukas Wunner <lukas@wunner.de>,
	Oliver O'Halloran <oohall@gmail.com>,
	Saurabh Singh Sengar <ssengar@microsoft.com>,
	Shuan He <heshuan@bytedance.com>,
	Srivatsa Bhat <srivatsabhat@microsoft.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	linux-pci@vger.kernel.org, linux-alpha@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v5 07/23] PCI/sysfs: Convert PCI resource files to static
 attributes
Message-ID: <20260421194215.GC1684602@rocinante>
References: <20260416180107.777065-1-kwilczynski@kernel.org>
 <20260416180107.777065-8-kwilczynski@kernel.org>
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
In-Reply-To: <20260416180107.777065-8-kwilczynski@kernel.org>

Hello,

> @@ -1685,14 +1700,14 @@ static ssize_t __resource_resize_store(struct device *dev, int n,
>  	pci_write_config_word(pdev, PCI_COMMAND,
>  			      cmd & ~PCI_COMMAND_MEMORY);
>  
> -	pci_remove_resource_files(pdev);
> +	sysfs_remove_groups(&pdev->dev.kobj, pci_dev_resource_attr_groups);
>  
>  	ret = pci_resize_resource(pdev, n, size, 0);
>  
>  	pci_assign_unassigned_bus_resources(bus);
>  
> -	if (pci_create_resource_files(pdev))
> -		pci_warn(pdev, "Failed to recreate resource files after BAR resizing\n");
> +	if (sysfs_create_groups(&pdev->dev.kobj, pci_dev_resource_attr_groups))
> +		pci_warn(pdev, "Failed to recreate resource groups after BAR resizing\n");
>  
>  	pci_write_config_word(pdev, PCI_COMMAND, cmd);
>  pm_put:

Moving __resource_resize_store() and everything else related to resizable
BAR resources behind the HAVE_PCI_MMAP and/or ARCH_GENERIC_PCI_MMAP_RESOURCE
check, where either is required for resizable BAR support, would stop this
from being included on architectures that offer no support for resizable
BARs.

Something for the next version.

Thank you,

	Krzysztof

