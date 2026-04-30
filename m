Return-Path: <linuxppc-dev+bounces-20319-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FD8DFF887E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Apr 2026 02:51:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g5dwk5k7Qz2xPL;
	Thu, 30 Apr 2026 12:51:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777517494;
	cv=none; b=ZRlrjZc23bJXw/pK55Ez7IpXeTJRfo295zCtt5NKqYFzImxEeM8m8j+HTSb5IO3mTJHl4RCJHX0BmL6NzWLbM6VMuWVKlO4N+47g8w6zxX7BeXvQEwcQSbd21jr49ikQZtyQHB/Moh6hmWuPDK/EmFxjKdQYMZfb+FVxutEXAPf2ewIiRTpNaREEEQ9wy61bkqUTxCXMnfJpL2isXuR5uDsQvTO+/AHiBIC0o/56Thgb4k2+FCi19dt9sPadY8kBkh+jKhrlBxh7ZU+IanV4X3V407e94/dozVNXbzA15OKRR0RpflPXqGeiK0GCABG7ku/cpfLDRlhaneADxXhCtw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777517494; c=relaxed/relaxed;
	bh=vs3QgR/36UraTHgOSUPimusPl4TvoR2T95acP7XtxRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yyfp1onUaMcZzZLPL/ULVa/L+66cFbrKXliUZs8RlfkOSEr/wyxRlQCFKx4m8CmrVErexO31k4paOXu/oY01xtMpljSDd3zHiE6dxXijaE7kjLd1IAwKcVAQ1tAjbSGC7hZK9+rnPrE26mU82XhfbGaBWRgvtvkZHEbBh4HRDQWPYVrd9msoQBMnJA0oo6P2cnkEx9btlq2DPXbJ43hFeZHz8N/2o/D2JkTTUW5nm/MQVSJ/ulZXFmGpUzSjzqFQmHP3dMKj3Yw0HYfp5g+XXXNssnTWTcBa/l8EBdSrwEt9ufa1cGTyU4So6/PWO7tjXuTF2zc/pvyVGBrID3HeJg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=DnDKlg3e; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=DnDKlg3e;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g5dwk0mwPz2xNT
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2026 12:51:34 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 0164561119;
	Thu, 30 Apr 2026 02:51:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E6B0C19425;
	Thu, 30 Apr 2026 02:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777517490;
	bh=rIRCNcazwtx/16LQtiNpVTsW/tJ6F6VdllcASy+OcwI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DnDKlg3eXCjhTyZNnSikiqYO9CladC/9RYhcZIUp/WOWJx2QSjoyXMiDS0IvVFmMu
	 RAYvV/p/0ssidiphG7YgFpHqMlnFY9TIMqyJ0u+lMmGkHzrJp8w1OdfBaBXE8UMRu4
	 FmpwK5HVtlqHFrsXS3bFv0yTh9ZyBguA/GIGuj9Sppeo1PFvETXF0jwp9wIpU6LtmV
	 UOb0vka5BrX2x2lQkpSMWXqk5BVBIX/U8K5S3zVjKa9jCpagkkT0KhUV861EX9Wsks
	 NlkMZ3RbQ7pdRPGhwESVDf38PBSM6lH0xpuaCbagRrVEREGO8oCJ4GQF4lkiQFcq8w
	 +ctrgendZ886w==
Date: Thu, 30 Apr 2026 11:51:28 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Magnus Lindholm <linmag7@gmail.com>, Matt Turner <mattst88@gmail.com>, 
	Richard Henderson <richard.henderson@linaro.org>, Christophe Leroy <chleroy@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Dexuan Cui <decui@microsoft.com>, 
	Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>, Lukas Wunner <lukas@wunner.de>, 
	Oliver O'Halloran <oohall@gmail.com>, Saurabh Singh Sengar <ssengar@microsoft.com>, 
	Shuan He <heshuan@bytedance.com>, Srivatsa Bhat <srivatsabhat@microsoft.com>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v6 24/24] PCI/sysfs: Limit BAR resize attribute scope to
 platforms with PCI mmap
Message-ID: <20260430020648.GA3923076@rocinante>
References: <20260422161407.118748-25-kwilczynski@kernel.org>
 <20260429204932.GA318462@bhelgaas>
 <20260429212749.GB3724801@rocinante>
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
In-Reply-To: <20260429212749.GB3724801@rocinante>

Hello,

> The only platform without these aforementioned defines is Alpha, which is
> conventional PCI only and cannot have ReBAR.  So this guard removes dead
> sysfs code on platforms where it can never be executed.

Having a closer look:

  resource_resize_attr_is_visible()
    pci_rebar_get_current_size()      <- returns -ENOTSUPP, so is_visible callback returns 0
      pci_rebar_find_pos()
        pos = pdev->rebar_cap         <- set to 0 on a conventional PCI
        if (!pos)
          return -ENOTSUPP            <- no ReBAR support

The pdev->rebar_cap is set during PCI enumeration:

  pci_init_capabilities()
    pci_rebar_init()
      pdev->rebar_cap = pci_find_ext_capability()
        pci_find_next_ext_capability()
          if (dev->cfg_size <= PCI_CFG_SPACE_SIZE)
            return 0;                 <- dev->cfg_size set to 256 here for conventional PCI

The PCI_CFG_SPACE_SIZE is 256 here.

When the platform has support for PCI Express, the dev->cfg_size is then
set to 4096.  On an architecture that supports conventional PCI only (such
as Alpha), the pdev->rebar_cap will be set to 0, the is_visible callback
will then return 0, and the resize sysfs attribute is never created, as
such, the __resource_resize_store() callback will never be executed.

To make the connetion here to the #ifdef guards:

For the pci_rebar_get_current_size() to return >= 0, the device needs
PCI Express and extended configuration space support.  As of today,
every architecture with PCI Express support defines HAVE_PCI_MMAP or
ARCH_GENERIC_PCI_MMAP_RESOURCE.

I hope the reasoning here works.

Thank you!

	Krzysztof

