Return-Path: <linuxppc-dev+bounces-20022-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AD05FDEE45
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Apr 2026 19:00:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g1lmK4hf9z2xlt;
	Fri, 24 Apr 2026 05:00:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776970849;
	cv=none; b=UzcgnXmbG7spOFygqerLday37IX+b569COjE8UuEIWzdzzSOSHPtBXNifdvv/2csHMPvjREYdlDmUFYWfngbkpc9Ziter6yK0XC7ZboPYCIiKCWlRJChhp7WKdq/Nlo42BB6yP7rZQhCozbG8q/S7jZq4+X5sjVb+Jx8jn8AwjuRVVxx6JU1cKyANHrfPFZILueSx2jFiQt7q1mxpF0IAwvRQv1hxb6kdK0InnHoLDAWcWFONPRzWKtVuriRF6JWtj/dT8MpuAko1fmXQxtLsPUZCNUKZyGnPR6N74z3RNyWnpJ8Q6QG+0WyCcpOFUfUA+6LyUwPLy9uNVUOpCfyLg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776970849; c=relaxed/relaxed;
	bh=53N7fO0BhUea08mB+8DrLWPHjhQijoaveu8NieCDE5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XmE3dlxG/bdb2zuzOb8FKcpqDWgwcoG/+VfnPyg4OklwCHG093citAwxHX7GsS35T7mOt2pdgzOdqLcBhJBA+87mBpPdFDwS3hMbr4o291o39fulNQCCXffPW8JD18ONnbI7xbnaF4yPVTgi+DDYBn/V/yGC3uRc2wtNwNIhBpNKSWNxN4uEq0/2vUHTN5EK4mRHgRHT6ItYLjPQFq2Adjge4GEDM9u8W2+gAjcs9jTMccaR60+UggOR1bJxuey3xPgoTJAfvOFZegTMm7eAu9dDFoq8g2BGNTzWZcg7QQPCXuleqeDdplkcqC8ZeZe4k9hcLiMN/3fe3sXdM27RwQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=JAXXtHHb; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=JAXXtHHb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g1lmJ6pPsz2xSB
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Apr 2026 05:00:48 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 0171A40DAA;
	Thu, 23 Apr 2026 19:00:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76723C2BCF4;
	Thu, 23 Apr 2026 19:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776970846;
	bh=ttpltMQhZGuUtpUXtuyxrd4NzolrST+hEhEzFm38PN8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JAXXtHHbpPfK5J2qgcvC0vshyq0zsDC6ZbCzgHkVg6BjWdvItjP+AdCNnFfvpFxog
	 XxxvegegcyfD+kjrsilRbowaYs21edmABok1uZBSoPp3MOx04cwKENVKPz/RiChszx
	 Gw5x5COXOAcV9Lj5mfi0GgkU//GVUJSROAeaXGcAO+k/z22cxLJzWPb4lHY7LjZ1pw
	 P6Sboxq2rOJvQHExMKdhTqxeJW+VG49igk6EVGKMxTWWSRjAw76WL7dWE7npf90Hn5
	 TAZ01soe6DIEGorbb1Il8Fp+soQGZR4w3QipthwM6OIzOqVBkRyV6CgcTQaH9eMQVw
	 t/r8CTx3NigTQ==
Date: Fri, 24 Apr 2026 04:00:44 +0900
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
Subject: Re: [PATCH v6 00/24] PCI: Convert all dynamic sysfs attributes to
 static
Message-ID: <20260423183940.GA3350984@rocinante>
References: <20260423172200.GA2271460@rocinante>
 <20260423182359.GA33696@bhelgaas>
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
In-Reply-To: <20260423182359.GA33696@bhelgaas>

Hello,

> >   Sashiko's feedback:
> >     - https://sashiko.dev/#/patchset/20260422161407.118748-1-kwilczynski%40kernel.org
> >     - https://sashiko.dev/#/patchset/20260416180107.777065-1-kwilczynski%40kernel.org
> >     - https://sashiko.dev/#/patchset/20260411080148.471335-1-kwilczynski%40kernel.org
> >     - https://sashiko.dev/#/patchset/20260410055040.39233-1-kwilczynski%40kernel.org
> 
> Thanks for all this work!  I think this will be a great step forward.
> I assume you've probably looked at the sashiko feedback and concluded
> that no changes are needed, e.g., the feedback is out of scope for
> this series?  Your thoughts there would help me out.

The only actionable feedback would be to update commit message of patch 18,
so that it mentions pci_stop_dev() rather than pci_stop_bus_device(),
something we can do later.

One could also drop #if guard from the struct pci_dev as added in the patch 9,
which is later removed completely anyway.  There is no ODR violation or ABI
break there.

We won't be fixing any more kernel lock-down issues at this time, and the
value of legacy I/O space size (the 0xffff) is something that was there
from 2005, so not something this series introduced or changed.

Using HAVE_PCI_MMAP and/or ARCH_GENERIC_PCI_MMAP_RESOURCE to stop the
resizable BAR resources from being included on platforms that do not
provide either, like Alpha, should not be a problem.

So, no.  No serious issues there.  But let me know if you want to change
something, so I can send next version if needed.

Thank you!

	Krzysztof

