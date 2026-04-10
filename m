Return-Path: <linuxppc-dev+bounces-19568-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44C99F44845
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Apr 2026 11:55:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fsZxt6kwfz2yZ6;
	Fri, 10 Apr 2026 21:55:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775822146;
	cv=none; b=PTdq++ZkyVVthaQtTAp8RP/849yXG32dWhuTDv7Pn9uKyXogbZMLAI6AlyIy4fFNFweKGhwyD/arcsT4yXRRgE269WasrOxxGnHI2e1eI4LnvFE1UEqHOyC0eUK5BvsWcG1ITYHWJDEoAJpaRNdkN06HXDOwc7W5YbOSE4GWeOERdjYhWhyQ0xwRZ8ArKIyj6lm+sOD7flWomN/wh/SiOYyZANRqWARLdekAJ8jaPAVR8XCD/SwqeoiFQf1xdt0Wt1uZcjnZqjjweDX8GyHwXKINmUessydLwtu5g50kwWbs2+hd6BCharM8qO2ZhU7gb0jX5guS6u2xqpaP6HIbdw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775822146; c=relaxed/relaxed;
	bh=nMMUZMuHhldIesVCYOyhb7NbP1AkLb2PK1QuyLYsnEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UVFCkDndrkJztOjKtKQ/mlb6zMuQfckAcgMSDSpFOlXxR3zAng2/m7O97D8WMBWda54bKYaU0XLtO6lm7iBRUaxDchRJeO/SOAop6kdD+FNDA9eeyxq/BxwNL+hVb8i9WEqZWwmab+n0aY+VHg8NaIsiUxJtB4Q/MXtBdIN5sSTHPqAoaigXX4/SWNJrHAzrk0tsWulLafEmMWvpZdeNZKvKbQAwMUtiCgK/PY3HsC7sTzgWu4HxcRUGrKyHwJy6vlf+FdfFXJCO3rt3M4VDskHXvRTAtB5pnm2UJLTSTxchfIbeG8scl1rKNmJl2KUWYaXIUSRbs8PxLvr+MRIcCw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Lb/ZmOTV; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Lb/ZmOTV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fsZxt0zVyz2xLt
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2026 21:55:46 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id B07716111A;
	Fri, 10 Apr 2026 11:55:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08420C19421;
	Fri, 10 Apr 2026 11:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775822143;
	bh=mdpaoKvaXfKLinXjUDc/IbjJOXSHqFvXpOvUOnu9NX8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lb/ZmOTV/EI6r89sYKM9ULJyJetsrcgzEuFMg/9jkdKVHDvnAJGfhz6XABBV42pDE
	 tuDb+vDldQsgNNwYLOcZrBTikPs+k+KF+a7tGZuf4JesL90OlRBkKnyY9ttXH7PRhF
	 KMyZZBGUe7CHTFHem+Axjaq2pR3+kzKnCTPcWTdbknpkbY9bpWLqpkgQ//cSi7z7dW
	 JM9Z8kVYEjhEG/YrGw6zPJvyp3StfSjwyeG0Kz/ApB6/aG5lYpqf47YpvGvGF4AG1v
	 aj/jBzvtsjynVD3A0L6z5orp4L3dsfkgbRa0IwgajGiEEx72Ab5cFsooy/inKLAk6Q
	 sRx53daBp+a7Q==
Date: Fri, 10 Apr 2026 20:55:41 +0900
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
Subject: Re: [PATCH 13/20] alpha/PCI: Clean up __pci_mmap_fits()
Message-ID: <20260410115541.GA1770099@rocinante>
References: <20260410055040.39233-1-kwilczynski@kernel.org>
 <20260410055040.39233-14-kwilczynski@kernel.org>
 <66eb23bf-1995-363f-78e6-f5a397a063a2@linux.intel.com>
 <20260410112132.GA1756033@rocinante>
 <f6c036e1-9145-e784-8a37-2486fc72978e@linux.intel.com>
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
In-Reply-To: <f6c036e1-9145-e784-8a37-2486fc72978e@linux.intel.com>

Hello,

> > > This looks like entirely separate two changes to me which just happen 
> > > within the same context.
> > 
> > True.  I could split this into two separate patches.  However, the early
> > return is so trivial, that I decided to keep it here, in lieu of that the
> > linked patch did, too.
> > 
> > Thoughts?
> 
> It's not just adding the early return that would go to the first patch but 
> you also need to rearrange the len for that. Effectively, the change is 
> split in half, each becoming cleaner and more focused (both diff and the 
> changelog text).
> 
> As is I'm left on the borderline, while I can see it's "correct" after 
> splitting those changes inside my head, I also know it could have been 
> done better. I'd easily given rev-by for both if they'd have been done 
> individually, saved the time writing these emails about it, and 
> effectively "forgotten" the patches (including upcoming versions of the 
> series).

A simple "yes, please split" would suffice. :)  For future reference.

Thank you!

	Krzysztof

