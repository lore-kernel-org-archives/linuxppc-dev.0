Return-Path: <linuxppc-dev+bounces-19655-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CDECF3ED7B
	for <linuxppc-dev@archiver.kernel.org>; Sun, 12 Apr 2026 06:39:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ftgr535pMz2ydn;
	Sun, 12 Apr 2026 16:39:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775975973;
	cv=none; b=SBFjTGmKc8Yzw486PxINTzo1nxW0N5qHvkUKkp3M3uPbx1/VMbeYx+ZypScGIvsdsZY7eYeIJO7Lz/s2O3Nz/1aiw+DZ6VdZ9rGN7f/W1++MPK7mWQ965A7VhRs0BezfSJ7W7PtTgoEegwwBXBJ0qViPq7HXt0YrmbLZfWWRzjFoksdW74Gz7h2iveqwaJe3vyFEqODB7fuyPZWAj+nsnKjmz1Ezd6a9kh9zh1LhqRTsBVbUfpz20qgSrT6v+x21ULddyV1YVOatVr/EhpFUsRrcEChfwtNXE0XMK/FKC8+e2L8Z/k2MrQnQPoUn2hU9uvMWWPrdUTt6e8YO5RBk/A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775975973; c=relaxed/relaxed;
	bh=xrF+NAOJr5PHK1XhKKroJJAPe29WPLu85oOYz9G28l8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QR1gAQPpJYUR0/elO8vWWYgiLaBjl3rpNs6uiHv693l+wN+VSDgpD7qLsUcnH0VGga1bVLIdpYpNLvtOvJLKaCulOs1+OlOLIxJqcgmvId1m2puWdr8i/T+RkED6q1lVnc5EHYgKqvTbDjzB3yl2f+8IXOhCHV8QsAxYld6utG3hzDgfJopf7hdrsdgehjcjuUYUpiSv1xycQ10GuW+8TRz6Oj7nLKneLFW4C5SfTDIxBb/Xq7dwKVFoAcvsHLiDmmXf4jyJaamuGh9uq3uYy874YdSmmh8a8HTpct5Ua4e1dO484zTuO+2MLEBrRxpZ0b6sRWopbfVCWxI2tk4WLQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=fzDgUNaO; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=fzDgUNaO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ftgr45VFhz2yYJ
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Apr 2026 16:39:32 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id E843E60180;
	Sun, 12 Apr 2026 06:39:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D572C19424;
	Sun, 12 Apr 2026 06:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775975969;
	bh=6Gfvk1vJ2dWhGGDn2YFpAnYsydfbb+BI5a9oo2uq30E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fzDgUNaOpqjoITWmDRNxW4jtZPGtgJ7WfRkMr5BJ41p7XiNmc8SOh0oCq4J2j7rTo
	 NLoLDHRbHh0ni4t2ntideLvnua/072uDENzgIqhbS0RaxWVW55BtBmzAFmIzCUU3mn
	 IEPrzVC/2RLvIq8EEBIOw/UwRuls+qzyw9rP21KECkimIYAzCXeGf/29CFFOqIfk1q
	 toob/klVXFfK/YjkeEBJmZrGOZt05PUE1NRMqFqJoYl2gDzwZpzLhJgxzIBkZhe5H5
	 B6RiLd2mV6WsFlTWMuctrbIuLo4s3TxoPbGl0M1VhYnzWpa11NuiBKcFEjUq5504Ff
	 xDQ5Ux/em3l4w==
Date: Sun, 12 Apr 2026 15:39:27 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Magnus Lindholm <linmag7@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Bjorn Helgaas <helgaas@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
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
Subject: Re: [PATCH v4 00/24] PCI: Convert all dynamic sysfs attributes to
 static
Message-ID: <20260412063927.GB2085076@rocinante>
References: <20260411080148.471335-1-kwilczynski@kernel.org>
 <CA+=Fv5Q1tZQwnanw99NbvzT-QenfYz7vUdY02_TuPqHX32ZAiA@mail.gmail.com>
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
In-Reply-To: <CA+=Fv5Q1tZQwnanw99NbvzT-QenfYz7vUdY02_TuPqHX32ZAiA@mail.gmail.com>

Hello,

> > This series converts every dynamically allocated PCI sysfs attribute to
> > a static const definition.  After the full series, pci_sysfs_init() and
> > sysfs_initialized are gone, and every sysfs file is created by the
> > driver model at device_add() time.

[...]
> Applied the series on an Alpha UP2000+, built and booted
> successfully. PCI enumeration and device initialization looked
> normal, I saw no relevant sysfs/PCI warnings in dmesg, and PCI
> sysfs resource files for tested devices looked sane.
> 
> >From the Alpha side, this looks good to me.
> 
> Tested-by: Magnus Lindholm <linmag7@gmail.com>
> Acked-by: Magnus Lindholm <linmag7@gmail.com>

I appreciate you taking the time to test this.

Thank you!

	Krzysztof

