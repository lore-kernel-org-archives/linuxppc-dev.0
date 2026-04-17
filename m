Return-Path: <linuxppc-dev+bounces-19829-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8408AF4368E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Apr 2026 10:48:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fxs6Z1WDhz2xpt;
	Fri, 17 Apr 2026 20:48:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776422886;
	cv=none; b=f23+PYMHrnoe77Mac+vynR9Y1C+iOJjcCUcJbhopSHL14uGOrePx//mFvHTzTFZ7ua5obo5V0s03Fiv3vWrlBKTFH28RP1kKBTUudIjIMUO57GyIJN9dfdNQoT0JUWCpDLF7HZmCKVHyVu8dTKoBHsNok0K7HDu2exm4/fw3tqs7loWc8fSjXP3v3CPlsvsFZYs5RNV81yxwhsw3LNHqwDSY79jVoHKl85YUMShCfRZc1y5buzLAGBlCPoAOkpJdQyBW78to34p8+YfnWrNq/8EUnOSwr/I1jluZuJjS0kvrVicKPyoWNLvVUv4ftzOTh1A3fCU4UvUrMEgxUGrKRg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776422886; c=relaxed/relaxed;
	bh=TTZgOv9bC3QMPJe6xVX2L0ZqWviJ+G4vmmHDUzq4oc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bGMdNOFADHH1Y4tvwHK5sKCVFxAkwaZ00sdasGTmIxQqth8uiSymSBFLZhMvs7L+FSggSYNWIf7K0PXrCSb+RuTOg5dtev6xJqytxgALL6QescSZCl3fpgS5xlsBZLIR6GEB8me2k10zfbskp4aHjc3qdy/t0D2tfFTPMC2Ojpt7/rl0d/X7bk5Qmckb77RkSPaOnQdxAi77XkSY7Yf5i984qggQWaAAZCYHdJOJPoXmLQJBwwM9dLtMExawhqVkw1QXJoxWbW5xePB52xVieS0PnbTW00ixj/Ov7yDhN0v7r8GllgpRhT4txbJy0o9mmo1sujfE5MzG2i6BkiI7Qw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=MMra/N/C; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=MMra/N/C;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fxs6Y46csz2xfX
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Apr 2026 20:48:05 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id D571D44544;
	Fri, 17 Apr 2026 10:48:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DCA6C2BCF5;
	Fri, 17 Apr 2026 10:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776422883;
	bh=oxr6eE6Obo6lF5D8WNr7OZWHz+CUrPikD4kF6XrOpmk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MMra/N/CRaay6MuBJEKTzbjwp4QFtwHyhlyzls4H1s7tTZ0WjwDXSsYEXbsiDYs/5
	 bvK7GPmttjJ6bHbn/IBRHmLZxI0Q5EEmXRqL4lK/a5unV4P9nck5DMS68ySGAjMgBy
	 NX0oN3EycSD6w8qsVZAHmy70ASZ4by6UgfYs7fU8tlqoTMZvmld/GQKS6dwohAHeqd
	 OJq9QdxPWtPGBA8rSX5h8D3a8Vao1y6HoS3Jh9sXkkoVNnRsoLZdRtONPJreu+SDu5
	 3vRv5oRarX4kqoVLP/Fl7LE4QiBHtDZXeaCjCOvPAuFTVNv+IcAaC9KFaGasbx94BB
	 gAmAcs0s9ChHA==
Date: Fri, 17 Apr 2026 19:48:01 +0900
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
Subject: Re: [PATCH v4 13/24] alpha/PCI: Use PCI resource accessor macros
Message-ID: <20260417104801.GB1625998@rocinante>
References: <20260411080148.471335-1-kwilczynski@kernel.org>
 <20260411080148.471335-14-kwilczynski@kernel.org>
 <5c4f32d1-0648-31d1-d7c0-661ccec4f8bc@linux.intel.com>
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
In-Reply-To: <5c4f32d1-0648-31d1-d7c0-661ccec4f8bc@linux.intel.com>

Hello,

> > @@ -181,7 +181,7 @@ static int pci_create_attr(struct pci_dev *pdev, int num)
> >  	suffix = "";	/* Assume bwx machine, normal resourceN files. */
> >  	nlen1 = 10;
> >  
> > -	if (pdev->resource[num].flags & IORESOURCE_MEM) {
> > +	if (pci_resource_flags(pdev, num) & IORESOURCE_MEM) {
> 
> This could have used the new helper but since this code is going away 
> anyway in a later patch it doesn't matter,
> 
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Taken care of in v5.

Thank you!

	Krzysztof

