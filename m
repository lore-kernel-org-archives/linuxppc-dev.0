Return-Path: <linuxppc-dev+bounces-20489-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8231FCD3427
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 May 2026 22:01:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g9CCS0KCxz2xGQ;
	Wed, 06 May 2026 08:01:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778018500;
	cv=none; b=VMaiAnpFPhcBfa6B5qsf3sw7zdFmoKLs/kcV6a5a8sgzt2qUVNYuy42TMkbyikJOyWYX3aeEHSAge7RD/nUDeZNa606kGYHnrQscRxoRQ7BcCEhJ3n4ONxIQ9+rXZa5vYNiuHgJBAR47QPn0qk7lSDyplBsF//nFkB4eHmRGGl13z4suiA9sGCSTKDZ1DRUp2880A8VXczIdAjSKf9752UQm2iv4eF+uvUucGnhx10OWsqlU569a1icjEIgHa+GiUbhL9zeggNPH/L0DQERwt9QwEJvhbRUagO50CzW68A8Rnhuoe/j6iM79SECPJOl1Egpc1tHp+U7d1chB5qJdcg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778018500; c=relaxed/relaxed;
	bh=OalTprnUl4h3ueME6joBxjRTYKWUVqjHowjawRJC1jw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=BTTHgSfajoeb4JELFxPWauhY6Bu1YS+4hjE7Vl4twYzdIye3ggY+vTvB3DK8gaNyejnQFaT65pr9m6sAHUE02U58/pazFVzq/bEd0kqQd9ydFpphUZMMIk98FjmfO+rDtkVV8Bj5+MAhBowDGgeD6k0ixZvguW1QUeuRXbtLsnIUu1BFESIJVQBPrDkNrrL5qmj3ZRZ6a8/qpB9tZ1X2Mdg2deGfMO3fRSN9aHU8uQwsgm4joLIQ+18fKpJ4YNHs3ZASxlx4D0c1DsL11eZezX4zIrxd98USYHLF9DmYbHv53ZqlT1YmhOh6jhYfsXjlp1lBHXXJNjA7mX+idoMQUw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Rbn9wVta; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Rbn9wVta;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g9CCR1XRJz2xBb
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 May 2026 08:01:39 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 087BB43EED;
	Tue,  5 May 2026 22:01:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC37EC2BCB4;
	Tue,  5 May 2026 22:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778018496;
	bh=yoBr7Mc6YP4qh9ut6jZz/k1ucywWcKVN90W+9f643uc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Rbn9wVta9ZpFa3gloLjf8OG00h+Ic96IkFvu93L7ctXC5FF0RpGCZNidThuaa0rr/
	 rGNBNcVlkxEg1LlmiGrwBAKKF9F9uesOligMCEm/cWzo3itw0T9Xm1zGueC/sIMpN7
	 WmVIeDdKPxbjtKzMJKHZB4xMeCBlFz2ujFMq2maXFousSJk7P/aiA5W1csqtcB6cDL
	 Gj3A4KNfTeNT5MhOBJTydLrEsaR5ffZSMGoJCYHg1+AALROdw80fqX7F6wA4GZPUzZ
	 /IfWC+F7NFP4PxAIZeMdhyVFKE2iOVwVvvo2o/xmF0yjit1v+LBSkudPvlywbvnI3M
	 6P+YZQKv97dlg==
Date: Tue, 5 May 2026 17:01:35 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
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
Subject: Re: [PATCH v6 24/24] PCI/sysfs: Limit BAR resize attribute scope to
 platforms with PCI mmap
Message-ID: <20260505220135.GA752411@bhelgaas>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260430020648.GA3923076@rocinante>

On Thu, Apr 30, 2026 at 11:51:28AM +0900, Krzysztof Wilczyński wrote:
> Hello,
> 
> > The only platform without these aforementioned defines is Alpha, which is
> > conventional PCI only and cannot have ReBAR.  So this guard removes dead
> > sysfs code on platforms where it can never be executed.
> 
> Having a closer look:
> 
>   resource_resize_attr_is_visible()
>     pci_rebar_get_current_size()      <- returns -ENOTSUPP, so is_visible callback returns 0
>       pci_rebar_find_pos()
>         pos = pdev->rebar_cap         <- set to 0 on a conventional PCI
>         if (!pos)
>           return -ENOTSUPP            <- no ReBAR support
> 
> The pdev->rebar_cap is set during PCI enumeration:
> 
>   pci_init_capabilities()
>     pci_rebar_init()
>       pdev->rebar_cap = pci_find_ext_capability()
>         pci_find_next_ext_capability()
>           if (dev->cfg_size <= PCI_CFG_SPACE_SIZE)
>             return 0;                 <- dev->cfg_size set to 256 here for conventional PCI
> 
> The PCI_CFG_SPACE_SIZE is 256 here.
> 
> When the platform has support for PCI Express, the dev->cfg_size is then
> set to 4096.  On an architecture that supports conventional PCI only (such
> as Alpha), the pdev->rebar_cap will be set to 0, the is_visible callback
> will then return 0, and the resize sysfs attribute is never created, as
> such, the __resource_resize_store() callback will never be executed.
> 
> To make the connetion here to the #ifdef guards:
> 
> For the pci_rebar_get_current_size() to return >= 0, the device needs
> PCI Express and extended configuration space support.  As of today,
> every architecture with PCI Express support defines HAVE_PCI_MMAP or
> ARCH_GENERIC_PCI_MMAP_RESOURCE.
> 
> I hope the reasoning here works.

We're talking about this #ifdef:

  +#if defined(HAVE_PCI_MMAP) || defined(ARCH_GENERIC_PCI_MMAP_RESOURCE)
   static ssize_t __resource_resize_show(struct device *dev, int n, char *buf)
   ...
  +#endif

I follow the reasoning now but by next week I won't, so I think it
requires too much background knowledge.  Future changes involving
HAVE_PCI_MMAP or ARCH_GENERIC_PCI_MMAP_RESOURCE could easily break
this.

IIUC it's basically doing what "#ifdef CONFIG_PCI_REBAR" or even
"#ifdef CONFIG_PCI_EXPRESS" would do, if we had such a thing.

How terrible would it be if we just accepted this dead code on Alpha?

