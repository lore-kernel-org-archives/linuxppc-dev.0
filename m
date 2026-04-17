Return-Path: <linuxppc-dev+bounces-19828-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CF4EF4368B
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Apr 2026 10:47:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fxs5N1Bs2z2xpt;
	Fri, 17 Apr 2026 20:47:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776422824;
	cv=none; b=LgCeyksV9xwRkxCr+eDEAoF0ITvqz8K3Csq0Vmzff+sCQ1MSGuHmsE4czDHgckCm63S+XOETxq5B8ouJFzg+/cCFH5DlBabwKcyMHkGkaU8kxaQcuN3Lzhe2dlRc/hkFynQ/gV9KPM/uQ/kes02yIZgptrCo9rmZlszB5KBN5NemW7JvS5D/xyRFkw4FULw6VGzFvaPUtU5odDxLFYbhr9PVc9edliRXz9QJO3kHcOhsY4vgxqUB8GQqJ0di8M9DVFk4TAOQhrTDdSEYJDd30urfN1I/FHJqTth7rWIfnP4CqOFDtzxBlo1icGlhJcI1rYzG32gO/IbAX3eFxDyoTA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776422824; c=relaxed/relaxed;
	bh=ztbBAGa9cGdwT9zurDvjS95TSD83mHmIevJt0J8MPrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JGnI8hlbmCBEF2Zn0havQEEnTn2RoLCDocBWlT4xE09xUjsi/Yv/TuR8MAEn1db3AvQhiMomP7MPRxwxaZX4UzEa1ga5ivWX9MBMGYwFvhF4y8HNThNQTkVi3Ga+CVYauDc5RU9ruX+UMiDkYXGjwEL72gGgzgdIxkMgUTEaL1udNef3X7AuGXWzDUzatWQAVs8wtqpItvhWBZASrbq4EnC84ooQ6V37F1QH+PEJ/Y1NPgyLbV2TEqSY0hAfbGfTSKbGr1i9BwGraJ134wtvbgASM2VgD3VvXPemJsbMNQJh5oIweTrCRDQmALEfuSyqplLtMmOGycjpOrxqhn3WMg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=CbioxR5P; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=CbioxR5P;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fxs5M3RWYz2xfX
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Apr 2026 20:47:03 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 0DC4B400F2;
	Fri, 17 Apr 2026 10:47:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84137C19425;
	Fri, 17 Apr 2026 10:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776422820;
	bh=UvXWZOvTnm0NWz5LK6R3oW+P9THcCFDgcoMJOmweRAM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CbioxR5P1H0eF61qBn8Ob0PRTqf0B9BgcBoGvCOTg04M2A//ev5+VYJo7I34HDr1H
	 NAkPEB0XOaKIyy+nIOG15M285LES5Qfix3M/58yNHhe1+tc41NPjmqLO9arGKANGMx
	 TnGh8Zhtryjc05fOxnUvgP7IJHyJmT/Ip8LUNrR1Zym8q7Dwh94aTst8QV8DJjuBil
	 s/O9rUjVMIBmptz4Wp9kl8vPH0LdfHMHgZPjdI21c6d/c7/O0clSYIV2zwRHPNXMAK
	 LBGq7LBW9Cl7W6WkopP7gKKrWocPs3G71Ak7YUDbxnciZZeDhyoXB6xBAvf7R268ZC
	 xK7xWNdsuTctA==
Date: Fri, 17 Apr 2026 19:46:58 +0900
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
Subject: Re: [PATCH v4 20/24] PCI: Add macros for legacy I/O and memory
 address space sizes
Message-ID: <20260417104658.GA1625998@rocinante>
References: <20260411080148.471335-1-kwilczynski@kernel.org>
 <20260411080148.471335-21-kwilczynski@kernel.org>
 <a73af6f4-9f9a-cff8-e00e-042dcf934708@linux.intel.com>
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
In-Reply-To: <a73af6f4-9f9a-cff8-e00e-042dcf934708@linux.intel.com>

Hello,

> > +/* PCI legacy I/O port and memory address space sizes. */
> > +#define PCI_LEGACY_IO_SIZE	(SZ_64K - 1)
> > +#define PCI_LEGACY_MEM_SIZE	SZ_1M
> > +
> >  extern unsigned int pci_flags;
> >  
> >  static inline void pci_set_flags(int flags) { pci_flags = flags; }
> > 
> 
> Shouldn't this also convert the use in pci-sysfs.c (which you now mixed 
> into the static attrs conversion patch)?

I took care of this in v5.

Thank you!

	Krzysztof

