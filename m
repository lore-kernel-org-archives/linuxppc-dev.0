Return-Path: <linuxppc-dev+bounces-16697-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33F3DEE6B46
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Feb 2026 18:41:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f72xM43FTz30FP;
	Sat, 07 Feb 2026 05:41:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:4f8:fff3:b8::112"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770403303;
	cv=none; b=opgfdKzgVx0adoCGFFBAMdJ+g7aKZ3p50OtDJSl3v6+Y4lIhTvIf09KE62cS+D246BdJa4sN6hu0mZ5u8qXO/gZ7/zJ76ZKrYmxQ+sL3nfdWnU2HuJPFp1TbhLctbI+xDZMY1TnaeXaHQnXL47OgI0PSr0QRK5FKINckCCMxwztX34oUCZcoZMeIF6Teobcw0+EzsOmU3206Uu9HKdT0T0uM96B9cDKjkKwy2fyqblQmoQCOnLehTOx5rCNTGAKTur2I0qcBI0OHMLycdsrfGt9aWA54eyoz8tXJgaU53FbnICCsrTiW07/YvocM0AzjkIOyeBadY4v1x8RXkqTy3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770403303; c=relaxed/relaxed;
	bh=olpzSYNZ14XlLZXB8TEqRSt5VCQJjkswosd7/BfjpQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GfiWpXz1cEebCFkgO6JIGER1+hT6qPQcGG6JIvHNsefhWw1XI+KX9qIBg44f0DOKI33+eojQtk74KcHYVdsX1XnXiOxtUI2k/w5hxBanr+DXkkUlU1jhhErjd90bjLR3tai6BSJVAjIl0L4rZDi6v3AA0ZdTyeBGbooXeCvG42B7TmngXxlvCr3BjHZkcCkZ/VQp7XCoTyLl+JM/lchSqiU79pGOGFVaA7W8lPQZsYK0bj+DY8gRqUDu1xkBSaiOGd3jU0/bqRh24Hf5bBIULs2pv4dSZ3FaikeoFfuf628E/L0MIKAz6IH7RsQ2W33H4qZHkpIKNYpV15ITPKd60A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass (client-ip=2a01:4f8:fff3:b8::112; helo=bmailout3.hostsharing.net; envelope-from=foo00@h08.hostsharing.net; receiver=lists.ozlabs.org) smtp.helo=bmailout3.hostsharing.net
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.helo=bmailout3.hostsharing.net (client-ip=2a01:4f8:fff3:b8::112; helo=bmailout3.hostsharing.net; envelope-from=foo00@h08.hostsharing.net; receiver=lists.ozlabs.org)
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:fff3:b8::112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f72xK3F19z2xpg
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 07 Feb 2026 05:41:38 +1100 (AEDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id ACA912C03E87;
	Fri,  6 Feb 2026 19:41:33 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 89013473B; Fri,  6 Feb 2026 19:41:33 +0100 (CET)
Date: Fri, 6 Feb 2026 19:41:33 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Breno Leitao <leitao@debian.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, kbusch@kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	dcostantino@meta.com, rneu@meta.com, kernel-team@meta.com,
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH] PCI/AER: Add option to panic on unrecoverable errors
Message-ID: <aYY13T00wmo-toap@wunner.de>
References: <20260206-pci-v1-1-85160f02d956@debian.org>
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
In-Reply-To: <20260206-pci-v1-1-85160f02d956@debian.org>

On Fri, Feb 06, 2026 at 10:23:11AM -0800, Breno Leitao wrote:
> When a device lacks an error_detected callback, AER recovery fails and
> the device is left in a disconnected state. This can mask serious
> hardware issues during development and testing.
> 
> Add a module parameter 'aer_unrecoverable_fatal' that panics the kernel
> instead, making such failures immediately visible. The parameter
> defaults to false to preserve existing behavior.

There's a parallel effort by Terry Bowman (+cc) to introduce a
PCI_ERS_RESULT_PANIC return value for error handling:

https://lore.kernel.org/all/20260203025244.3093805-4-terry.bowman@amd.com/

Please consider using that as the basis for your needs.

Thanks,

Lukas

