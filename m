Return-Path: <linuxppc-dev+bounces-19564-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2DCCF44842
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Apr 2026 11:27:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fsZK42X1Pz2yZ6;
	Fri, 10 Apr 2026 21:27:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775820440;
	cv=none; b=YzQ7Wm0cM/5Q9MYsoCdWM1OOSH1LclA/1VO9meBz+EVfhbny5a/z+jJ4PDonkuzPGsiUcVgmtjqgWZbF4L/R8O/UO5b3/XOVNv5hQxAITiIQqB8IKhBTAAQSMfgq1QhhWwy4QSEph4KIkhlK4lk5zCdVdPl7IJ2hwrCgeMfkDjt6JR3fKx6iqfd9cBrrMYlvhUNs9YCOTx+JlRSfd4VZbveZsU6qHd+Ln6020aGCZuYvOcCNz9Tm23xmPHRqDqkEMmh2MxCABbqryiYtkw9RzXAITmS4yP621KsCm92LorguvINBXnEdWG0k2pdflNlOS2JvSL/x38un/B0mQlofbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775820440; c=relaxed/relaxed;
	bh=0ZVKsqv+5qtMdGcJHiFFvWRp4e2aeYFFhOxWJTFHaHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ro/0TWImkg9mBQYeLiZAYvC5jrGDIeA8f+qFiFrX/00Jflu59xtPyqTwzo3VqsbJiiCgJ2Lyma1YXrrNGoxBP0EBI4A6fOaZWNWhR64tKp8p/ZrPEf4w4uz+NhTO44k9EZot5SQKInuSXAUY39NZY85f+d2HcfF4qPN2iwTquojcCFeHoje/+YWDT7QFgFaaAFy+q2aIauiFCU5YXwA1vLc+1IXu5Y6E1Ir6yjf8zK6M3igykC2xRS5KZy0BaXIJDkH4kc+xbK+Y4Og+NKi0RU6m7yenULTunQ3Ut8uWkLmMM9nQwfrJPDEfJLEHnlHGAsTMnqOlEsPNPrsnJI9dqA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=PysyFQl6; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=PysyFQl6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fsZK33lqCz2xT6
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2026 21:27:19 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 2F07D6024D;
	Fri, 10 Apr 2026 11:27:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EB18C19421;
	Fri, 10 Apr 2026 11:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775820431;
	bh=1su7Hk+2MPUWstIkBAykmSdSjnEsIRdA/siC5BZw4x0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PysyFQl6cHHK121wyAz9FjAkUHXRBYYV0l8JL1w0Gb3CrDtM52JIADeYXSy+RQj90
	 Rb/QLPZTrzyCHpZpi94xhrHAMOOVLE9rvMBQryCpadewXyqKFsDh/XybTPr4riFcYM
	 nYY+Q5cJDURPt+QOYNqDRYm85T+qux6XCyHhsFcTZH83F9yfxGVA1e+cNapPmnasqD
	 qRgemNPh5xlNYZehbYiW4cWaNj43FUqgxa92TiIK5ZRPEklq5HcGupxDe8+zrOHP8G
	 qHs3LHYYSm66jU2NtITeLSEd9oucxEHQp3zhnAqNqGK/AQ+slZFYKeKB+wrfJ37oBZ
	 2uHS+pp7Hhd2w==
Date: Fri, 10 Apr 2026 20:27:09 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Bjorn Helgaas <helgaas@kernel.org>,
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
	linux-pci@vger.kernel.org, linux-alpha@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 12/20] alpha/PCI: Use PCI resource accessor macros
Message-ID: <20260410112709.GB1756033@rocinante>
References: <20260410055040.39233-1-kwilczynski@kernel.org>
 <20260410055040.39233-13-kwilczynski@kernel.org>
 <f36a3096-4a9c-93f7-48cb-e6f4c60fdb93@linux.intel.com>
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
In-Reply-To: <f36a3096-4a9c-93f7-48cb-e6f4c60fdb93@linux.intel.com>

Hello,

> > -	if (pdev->resource[num].flags & IORESOURCE_MEM) {
> > +	if (pci_resource_flags(pdev, num) & IORESOURCE_MEM) {
> 
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> 
> I started wonder though if we'd want to add pci_resource_is_mem/io() 
> shortcuts for these, as it's largely what
> 
>     git grep pci_resource_flags
> 
> results contain.

I see what you mean...  We can introduce such helpers here, and be the first
users within the PCI tree, that is, before someone will do a tree-wide or some
more granular update eventually.

Should I do it?  Thoughts?

Thank you!

	Krzysztof

