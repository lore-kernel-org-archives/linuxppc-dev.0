Return-Path: <linuxppc-dev+bounces-19614-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39A2CF459FC
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Apr 2026 18:18:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fslS16V0pz2yjn;
	Sat, 11 Apr 2026 04:18:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775845137;
	cv=none; b=HoM49qnmzgoZI5yBgL3kfFu9b0kcLzYfeqVK0avJN6O3imQVyxEHhdwhBf6GM+neA7jiNiNq6utfq/ECAfVXe5VW+8+lCanHkSy1OyHXcZnDEcLPZhe2RKg6FFuaF+IYmjXi+xa5JB5vqvh4eUTMwA3rfN/XR/7Ci3FK42EwZwM/PsfAnJH9K5vaNZIAAL1ANhjmMo/adeq0UkCYqiNy/DdVbaB7JQxF7JPx57XfpUnX77D4Tg31Tbj5S/mqu7451tjoxKYY53OD2xGO5fjIBqIHKot6MDPkf4hyMKHQTLVcoN9Zq39WJHYZrYUMi+bJ55tP59WIIbrO3rd8r1ZMLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775845137; c=relaxed/relaxed;
	bh=lVnQF8AiOqm++xByamoBjPn9RXkVjLqegbVaBrXmIQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wj5VTUiW+o3CZRxeGGS5ga2WyWvTNWEBUggNo5EOzSMsNEQ65g6qcsoi6fPCvRS/ABcJPo2FrE+iq0AB6fCPPSIlKHCI3Fb+19for+ZF/V5Ufr/htU5Cq28yFJ5i9J9r66t1DxTRouAWvAMrV+3YtMLBktexCIkxEOVnxFZiT8d0hFI/LiJV+EncbVFZ7aQ5GGc5MMzofDwqykAe8m6tLBEbnKZ6w0A7ESpNL42jjMVPlZ1T7Qt/C/iq1sWn6Ia9kcXWI5c/tSQMvdrDh+/icYzHUKq/7gvNE2DBgYk0eU81HKI20OyqRwfeLY3d31ujGnF9MqnOZt1Mo32ATEU65A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=JaSFsMZP; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=JaSFsMZP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fslS1104Tz2yhv
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Apr 2026 04:18:56 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id E616960142;
	Fri, 10 Apr 2026 18:18:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B684C19421;
	Fri, 10 Apr 2026 18:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775845133;
	bh=B/z6n4ykUpZ/HjNoDe8F4OtGtMpRbRRvw3eJfnpBZJs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JaSFsMZPOXPIakbkFhWLfjJ1YhKfMivp4DhIwdGS1qVrUWcvoQ9+G8jwAj9ljnd59
	 7gGG4EZEDpSD5jDvCzs4kveqo6GybnDPF+fu8kaZP0J6FbUMAd2L9ki5XQCMmoZsGC
	 KlO5VwkIHq/RpzPHVPT0tkEmmMUw801VkdNGtxI2rCoY4FVf6u0Rb5CeTjbJBv/LcG
	 7chjR3v528PzWJzC0CwOoC8BGARCR0oKxm99m4RH3JC5sdqEu6dMptsS8m2F5Dagh2
	 jhw7ZOmx2eozA2QXucHpY9Z05/t7MgcnQCTUO7PBBWbUbQBUI3Hu+wOV91la9NmYJ0
	 ByD/C6hFLlc0w==
Date: Sat, 11 Apr 2026 03:18:51 +0900
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
Subject: Re: [PATCH 00/20] PCI: Convert all dynamic sysfs attributes to static
Message-ID: <20260410181851.GA1951283@rocinante>
References: <20260410055040.39233-1-kwilczynski@kernel.org>
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
In-Reply-To: <20260410055040.39233-1-kwilczynski@kernel.org>

Hello,

> This series converts every dynamically allocated PCI sysfs attribute to
> a static const definition.  After the full series, pci_sysfs_init() and
> sysfs_initialized are gone, and every sysfs file is created by the
> driver model at device_add() time.

A note on testing:

  0-day bot (recent test runs; newer builds will arrive later):
    - https://lore.kernel.org/linux-pci/202603170336.zSLrDvlj-lkp@intel.com/
    - https://lore.kernel.org/linux-pci/202603122052.tMV5rzNq-lkp@intel.com/
    - https://lore.kernel.org/linux-pci/202603081334.b91RGVS6-lkp@intel.com/
    - https://lore.kernel.org/linux-pci/202603060207.pnGfKgGa-lkp@intel.com/

  KernelCI (for the "for-kernelci" branch):
    - https://dashboard.kernelci.org/tree/linux-pci/for-kernelci/

  Sashiko's feedback:
    - https://sashiko.dev/#/patchset/20260410055040.39233-1-kwilczynski%40kernel.org/

I sadly do not own any Alpha or PowerPC hardware, so when I was testing
these architectures while working on the series, it would be only under
QEMU.

Thank you!

	Krzysztof

