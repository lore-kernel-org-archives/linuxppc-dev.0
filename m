Return-Path: <linuxppc-dev+bounces-19654-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DD76D58B04
	for <linuxppc-dev@archiver.kernel.org>; Sun, 12 Apr 2026 06:38:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ftgpX4cC3z2ydn;
	Sun, 12 Apr 2026 16:38:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775975892;
	cv=none; b=kOVmfvEx1jgT8rBX5mZWBW+P8qUP02fx3aby7ozHOClkmlFtg0Sq5nzEOhImAwR7aVfO/ovgJM0pN+HPryBXwqz9iHM+sN13kS9TPZtC5FuFWQWSb0hrmHZbA6TX63BFMzSj1ULxJGXwwIxmQCZKa3Umx8dIJmt/ei9ySyo3Xx8fd4BK3mDj1KNpfa7HCeAlTUyNbv/P+l5KylnR9iYm+Zli9R54Aa+2DP0snMfKFAFlYXBCet4eJBDIEKXG9HTkFSKAj4G7AOcbss8UU0AzFcEgz7nFdNoJxNKtO5Orj16EAtVxpYSQBJK9q0ncfstrpQCzLKEe3t4YIcdNPQczZw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775975892; c=relaxed/relaxed;
	bh=JAYAoSnp852ajT0S2qoNTL7kDXQ6p6KT2mhr5M16bSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fkS/ScPZI3ZVMKa0aJ9C6HcRVmKzFrRgIgmqZuLL+06W2ws7J4Ua5WhZVUW+AwAf8ewWEHmmtJ6lzPijaL0qAhCutrnN9D9M6UsknL6eOiJPlRwKko0E1fzKzOCMbInU1M12mytPfw5pbCCXNRvo3YnqO83f0dYynL5vpv16TCOR/2WsLC1O8VlnE1g4d+wr4igQQr40KQal69rYNU6jFtkJClcAgX6Qa7YVNEXpsyAv6Xox4rxDaMz7B+yarH7HzvqH3gxr5H3XUVqZzOYVRI4VZ7y+zoKMct43Z5x/BWtDYYTf4PU5E+wo6aVx5OJ6ISZiWsubUANV9GgzWuIqCw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=P5VfRa+f; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=P5VfRa+f;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ftgpW0crQz2yYJ
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Apr 2026 16:38:10 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 0E39A60008;
	Sun, 12 Apr 2026 06:38:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24957C19424;
	Sun, 12 Apr 2026 06:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775975885;
	bh=sTTFTGEFAtVBl1AdOtumfXjQUbSRjk8/CzL0mvAKNBU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P5VfRa+f8Bq9oWoKaDhwdknQhKG1iG4zqj8NDKZCwDkCRnFuMMtzbLsYJ8ZAkCO7J
	 1NTU9Ns9AyZ78ETJA5JsSiDLVJTjWhRly1gI7ROcrNjI5svAVdmCuzivmqDB+/sf2+
	 gn6YLD8CzuODxIw77WI72qIfRwsz8M6xWenUrgrvgwFHnZO9KLKf6EOG5wGDNmv9+/
	 VFuxPdCyAMqun5yluXF/5J2+vJyY2e6IKlBGFVJh3OEUEGFAtHvvdYQNVsT8imj8qr
	 gNk5WoFPNJ6bQ8vrKRzLl9Uv8jYidJCInvkefrkbLmapzgVFWX5RQ0dGB+V2FcS0e5
	 2K2SF97vJwIoA==
Date: Sun, 12 Apr 2026 15:38:03 +0900
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
Subject: Re: [PATCH v4 00/24] PCI: Convert all dynamic sysfs attributes to
 static
Message-ID: <20260412063803.GA2085076@rocinante>
References: <20260411080148.471335-1-kwilczynski@kernel.org>
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
In-Reply-To: <20260411080148.471335-1-kwilczynski@kernel.org>

Hello,

> This series converts every dynamically allocated PCI sysfs attribute to
> a static const definition.  After the full series, pci_sysfs_init() and
> sysfs_initialized are gone, and every sysfs file is created by the
> driver model at device_add() time.

A note on testing:

  0-day bot (recent test runs; newer builds will arrive later):
    - https://lore.kernel.org/linux-pci/202604121312.sF0Ua4gP-lkp@intel.com
    - https://lore.kernel.org/linux-pci/202604111631.lrwAylMM-lkp@intel.com
    - https://lore.kernel.org/linux-pci/202603170336.zSLrDvlj-lkp@intel.com
    - https://lore.kernel.org/linux-pci/202603122052.tMV5rzNq-lkp@intel.com
    - https://lore.kernel.org/linux-pci/202603081334.b91RGVS6-lkp@intel.com
    - https://lore.kernel.org/linux-pci/202603060207.pnGfKgGa-lkp@intel.com

  KernelCI (for the "for-kernelci" branch):
    - https://dashboard.kernelci.org/tree/linux-pci/for-kernelci/209e2cfd205a8aad4bae32e6f82b96b20902aa74
    - https://dashboard.kernelci.org/tree/linux-pci/for-kernelci/70293477e2c0ae8cbc250098818e726e1d658b53
    - https://dashboard.kernelci.org/tree?ts=pci

  Sashiko's feedback:
    - https://sashiko.dev/#/patchset/20260411080148.471335-1-kwilczynski%40kernel.org
    - https://sashiko.dev/#/patchset/20260410055040.39233-1-kwilczynski%40kernel.org

I sadly do not own any Alpha or PowerPC hardware, so when I was testing
these architectures while working on the series, it would be only under
QEMU.

That said, Magnus Lindholm was able to test the series on the Alpha
hardware he owns, see:

  - https://lore.kernel.org/linux-pci/CA+=Fv5Q1tZQwnanw99NbvzT-QenfYz7vUdY02_TuPqHX32ZAiA@mail.gmail.com

Lorenzo Pieralisi did some testing reported outside the mailing list (we
talked on IRC), on the platform he had issues before, and while the issues
were more with procfs races, similar to the sysfs ones this series aims to
fix, he didn't notice regressions when having this series applied.

Thank you!

	Krzysztof

