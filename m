Return-Path: <linuxppc-dev+bounces-19569-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87816F44846
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Apr 2026 12:05:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fsb8c0ybyz2yZ6;
	Fri, 10 Apr 2026 22:05:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775822704;
	cv=none; b=NW5pngip3fkMnZailJMn1kAT6jvGnPaGa1BbtrFPpqfJzFrddd7O3ZxUCUZ5FSlVYn8sGFrGo3Z5R7sbevDiAhZ9Q/0XKYwfKll037VlTnv9QGU1AEQ4fxpotgvkWtcOCpsit7deny0Ei4sFujWYitzh2U6604rJP5hBlFhwls5NgMJ7g/vhN8gA7sesSq91f9Rv/brypUKeuVAorlvRiDQH15wSoXwED+Yoa4NPrREU92c3o8GNLvlXKAHc2uOURTEw1TBwxwMMuboMltZED9g5Sw/ifnh7u/FEgsFUbtC1ORSozU0O9+UVEs4TI0968YdOre1D5PjuoOBxltbaVw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775822704; c=relaxed/relaxed;
	bh=BtDZ2ui0rJ/DbeJGW+P3llJnQoPAEuVzN99p6Oq9AwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AZmg7BCeaBu0UlErF8BgNHb/hw0a6m2HWjtnboH6wPy4M4vbgQ/dpGkp5AlPxHqKIwc5ar6ynUCdwmvzgBiGk6Ht1bktZ3vbeLNlBmyxPKroZZ56cpj3WX6Zeh7ihoIPLbCqAQgtD+0TmAKhPbqnGfEHYkQeWR24ByLa52KS0uTIXU7V53KFtIooFLnkIcqMwkZlAyGQPZUMsR2xx9qYMBrIPlz3exLp//xDJNnhAwI/4EINs9Zekt6kaaFIhoGJNGbx4g8tC+DOYH06ej5PovOFZEgLZGVFcV3252fJRAy9ZDHcKrjXuXGi7cqXigCuT3Dm6cA/SHmA0Z4LQUYrhQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=F+N6pl49; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=F+N6pl49;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fsb8Z71kpz2xLt
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2026 22:05:02 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 54BB16091C;
	Fri, 10 Apr 2026 12:05:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE7C9C19421;
	Fri, 10 Apr 2026 12:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775822700;
	bh=g4mf8jIyz2Yyw0wByKD90nIRoBjbahgRzYirW2U5NPc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F+N6pl49rZtSUtIekcaWHqJh0s8QPcIJClDtbMJCck0OPociCN/nvqJ+ZJXS0Ztc9
	 fbSU/X4dCcxznxYYCwW8Z+bFFX4MxROerDt7mlN0CSkcYaMgVvNiCuM+kxRNEsfrnb
	 XJoJF/N970ODaAsQjtyzo6dLqn5HFQsBl539kH5B6zkaAK70ZWH1f8hMv7okcs3jIr
	 bJ+L+Jz3FTIf8v/r9xDj9yecFJ/L/2rwwRyyQTc5mbf0YdtGl0S3zQEMIXi79tpHv1
	 OLYcHl1kdFl/g8UzYRSDUNc3OJhaZH6U8g4qz5CRM0vceard8FuNYV+CpRrCCL/FMz
	 xW06SPmUTOIlA==
Date: Fri, 10 Apr 2026 21:04:58 +0900
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
Subject: Re: [PATCH 19/20] PCI/sysfs: Convert legacy I/O and memory
 attributes to static definitions
Message-ID: <20260410120458.GA1775649@rocinante>
References: <20260410055040.39233-1-kwilczynski@kernel.org>
 <20260410055040.39233-20-kwilczynski@kernel.org>
 <13001ba0-35fb-f38d-5764-3c95fc3eb074@linux.intel.com>
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
In-Reply-To: <13001ba0-35fb-f38d-5764-3c95fc3eb074@linux.intel.com>

Hello,

> > +static const struct bin_attribute pci_legacy_mem_sparse_attr = {
> > +	.attr = { .name = "legacy_mem_sparse", .mode = 0600 },
> > +	.size = 0x100000 << 5,
> 
> I suggest naming these legacy literals with defines. At least the mem one 
> could also use SZ_1M:
> 
> #define PCI_LEGACY_MEM_SIZE	SZ_1M

Sounds good.  Will do.

Thank you!

	Krzysztof

