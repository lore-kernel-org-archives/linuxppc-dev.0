Return-Path: <linuxppc-dev+bounces-19911-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9378F94CA7
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Apr 2026 18:43:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g0WTd4ll9z30Wd;
	Wed, 22 Apr 2026 04:43:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776797029;
	cv=none; b=R+vMuMSD6sHmu3MvwFW2/tQ46PObQ2nChvKOseAhetHlcuzMHfvjgTN1EXOpSoY79xs3Tc8gGNFrb+uy7v6VE69x7yal2PfIRlE2ORifo8j8FXiRsrsZTASzrxxi1l8PskwAuMcILt/mWuUD2M5stQce1JGcyFuiZX8a2dDBPCcz9ixUpht8hrnELabDCfKth/lQ98HY4eHGWM/8ctThgkIgdR+TG7KI/paLuDmXb2Z2NqlZ9+wqjDvS4PTU3X0JxHZZxkM9T1pHM9OomfJZSip4hHfbg997qlySX7CPH5RdMv/XNEYQ/x/+rpTOCOJwj+79uGc1GpVWNrpEAvly4A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776797029; c=relaxed/relaxed;
	bh=dafv+LxlgIEBCjf0rt5o7BeB8mB5Swbf2MnqaAmIlBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lzwW2LvVG+ChZwnfEHRzA+KqYeFyAM2p5t1Op+62PEfWSU3I4CF0TLRz6rXWE47ySTuXYMwD1eBekN3n02E/DynuCsImO9kXZKu0HQcECGCt7oUMx/s4TA7DekMX2kPyUdzv8HZYh5jufOITHFLhGrdEABw6ayH2ipFsW/1H0iXmz1eonY21Ha2GoMmzZR1CHx/KQs6FRrBnwZAjq1UMKri3TaED4XtNMqlBXjSarwbxtrLN5tJ50QkwM6vv1gDI/bxhnY8HuEubVlMdtoV9b9ywDIAEwi1lTcxCpgpFilLrrOvs0A3Y7YDjschYdqL46stF+q7LXaKEpCpdCW8lHw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=fJitTr6I; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=fJitTr6I;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g0WTd0570z30Wb
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2026 04:43:48 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 1C8AE60172;
	Tue, 21 Apr 2026 18:43:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69228C2BCB0;
	Tue, 21 Apr 2026 18:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776797025;
	bh=BFCiiwYB2BfaBR4mT2g9t7Kw8VFChQxWQ4H/FZPW50M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fJitTr6ITExrD8mrJxI4gAOrG22qGPHzGF3Q98prdiK9OcWdRTzFPi2Z4y355oNbp
	 M2V6HDlHOM4FTXgdbd5mpp5ypWI7taXeUErXVwTYUGbZyAWwrK5mQi2YPoPMiSbHkD
	 6HAzLufn/FlvD1QDS0rIeYUCA+MLi7lzgsdsFe8kMqF4D0zwy82Tz6fILBvxXa54eN
	 WWmY1oXBcGAxIa4330SI+9lEKMadaxKm1CJd3wzwR80jgllgbMxEEyAd5vw5WwuIMq
	 dpQ531CS5BsdnUWYzAZk/h+xHZbc5JAh5x/JWPr7CayOcQkhkFqy9fJ7YvOUo1q/nl
	 5FTO+oqknr1Sg==
Date: Wed, 22 Apr 2026 03:43:43 +0900
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
Subject: Re: [PATCH v5 13/23] alpha/PCI: Use PCI resource accessor macros
Message-ID: <20260421184343.GB1684602@rocinante>
References: <20260416180107.777065-1-kwilczynski@kernel.org>
 <20260416180107.777065-14-kwilczynski@kernel.org>
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
In-Reply-To: <20260416180107.777065-14-kwilczynski@kernel.org>

Hello,

> Replace direct pdev->resource[] accesses with pci_resource_n(),
> and pdev->resource[].flags accesses with pci_resource_flags().

Will update the commit message when sending next version, as the
pci_resource_flags() was replaced with the new helpers.

> Also, replace open-coded res->flags type checks with new
> pci_resource_is_mem() and pci_resource_start() helpers.

Thank you!

	Krzysztof

