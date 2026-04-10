Return-Path: <linuxppc-dev+bounces-19563-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2DB3F44842
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Apr 2026 11:21:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fsZBT4Vccz2yZ6;
	Fri, 10 Apr 2026 21:21:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775820097;
	cv=none; b=R8828eP6Tq8W2z0Lz6gdP7cncQlBnkKn/2Mcg/UDzzToO4c7NHsN/V1/PmvFM1B3Xrng/1eFyVd+Sx4soVW9nhyjR8c9oJzIhvyVYoYoT9S98Xype0sDvydo3zs+zS0241oFCwxSjs/MqrFTD/4us9+xLXKWznHunaV3LYGL4GWnh4VZLWXZoTn2N/M+JjofVnsiHt5m4G4ghM4F/wuiEXTuZ6lz4y8wCHVgyom7Go5gKy1UvPgyfkOWno4LLgCNGrOjb0M8l9ryJ042Kacl+Qfv1FuHZjiMmJ5lrP6irY0fDXXEwpVSVmudGr65lNfJQdGd+HVtrb8s1j/N2C0bIA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775820097; c=relaxed/relaxed;
	bh=DO3bk2LokekSM5u9nj3g8L2Gu4sIxDP1/VVvzOyDO+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ILbMEgzmyZKEegQHe/QACu+ewtc7KSN5829Vwz6rK4ty7ZLDOy1eoFvXc/mcWJu2BGxKOzyGErGGngik1eg/3RJ5mSeSTDubfqdvndJkYsVU/wCy2g3RV4JAzTHqEV6bi/nUp9vVZ6rUxhSsMJrf4eIQytM9RO8B1dhGicYEDGUldbJtHoqLYqnNCy4It0YtbiLqPyL+2dUz3qQHIDPYMgXfWfuVVBl89bwzIh5WHDJETiGF0PXi0UNx/kQwHNJy/avOhST3EycpDk7xHqTRkEPW+Xr5AaTCNwzTHWZEbWiiMwyn5Yr0igax/9pX4CXwiRg2xZsmD2YvyOClj7Wk7w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=aNkWsMkv; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=aNkWsMkv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fsZBS72j0z2xT6
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2026 21:21:36 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id D32496014B;
	Fri, 10 Apr 2026 11:21:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DC07C19421;
	Fri, 10 Apr 2026 11:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775820094;
	bh=xLa+rJ9E7aCqjS27Iq/hgGnSH2oHxIMaRffEJnqkauE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aNkWsMkvMG+Va6sAFKXUZym1llx13MYasPeV+K/sG2YsNB5fhSi1QGBWHW0lr8cEe
	 Ev40On4E48kLxL4u5xdErZMqk8eBFmaEvlczXiYn844NLVvbOf+5VF6GQjp83Cd6RR
	 URaOH6uyIvSnEz0s89g95P5FSEndyI6GSpvz+kofOapbCZ+SqnRpgUxmlcj+BjRr6d
	 tUF3nGYNEh0ST+8xFRk7Kvo5dNDV1K+Mm4nyz7O3WrJ93GDtGkKwnZnfK/X17X7k2b
	 f0faK0yZgmPX7lfc4nMqHmxbcB/3MooRWPwhpnkEtpGRlxGcqByVvM4/hDJUcHMRuX
	 9X5aOtHCv4PlQ==
Date: Fri, 10 Apr 2026 20:21:32 +0900
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
Message-ID: <20260410112132.GA1756033@rocinante>
References: <20260410055040.39233-1-kwilczynski@kernel.org>
 <20260410055040.39233-14-kwilczynski@kernel.org>
 <66eb23bf-1995-363f-78e6-f5a397a063a2@linux.intel.com>
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
In-Reply-To: <66eb23bf-1995-363f-78e6-f5a397a063a2@linux.intel.com>

Hello,

> > Currently, __pci_mmap_fits() computes the BAR size using
> > pci_resource_len() - 1, which wraps to a large value when the
> > BAR length is zero, causing the bounds check to incorrectly
> > succeed.
> > 
> > Thus, add an early return for empty resources.
> > 
> > Also, remove the WARN() that fires when userspace attempts to
> > mmap beyond the BAR bounds.  The check still returns 0 to reject
> > the mapping, but the warning is excessive for normal operation.
> > 
> > A similar warning was removed from the PCI core in the commit
> > 3b519e4ea618 ("PCI: fix size checks for mmap() on /proc/bus/pci files").
> 
> This looks like entirely separate two changes to me which just happen 
> within the same context.

True.  I could split this into two separate patches.  However, the early
return is so trivial, that I decided to keep it here, in lieu of that the
linked patch did, too.

Thoughts?

Thank you!

	Krzysztof

