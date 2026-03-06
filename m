Return-Path: <linuxppc-dev+bounces-17853-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E547FCC07C
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Mar 2026 21:23:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fSKCN4zRwz2xll;
	Sat, 07 Mar 2026 08:23:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772832224;
	cv=none; b=oPDCDBHmR+NZg+tgyZ+bf0Qe5TK/uQY2d6p8AtU1Dffv+Qnr4edMP7PwRF8SSJpJsklnxflx/HIsgnAT35428u1s6aNehXbtJdHCmHdll9Z756YhVXcwj2SAUOsWefOhbR2dU0pkhz/J3u81S9520FHHfZzX6j+hRxX34SpADtjdhAxTtBWwebi5pHwiZI0mRvTKX7f6yUnwufX3vCVKmTcHLybpH4TfRa225OZ657dvAFt+HWTV6QwpTX6pQEDEoyWPhYWvkXiEPKSlCVN/oJe96Jvhc5OaFT5IPxOwnfWu08eqz70fr1kFqS8FDaZzO6tGMvkNz5h5gXRbCHOWdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772832224; c=relaxed/relaxed;
	bh=qfSAcTzbabDbWNK2J+FCB3tCrQy+A2yi+Bw0kC47bnk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hs98DEhw6AqwhrGYDlj2iZIUEp+vhIaj1pIptdDa8vMAUlCwPMIe+ouX203YGLzk8pSjPmXN1hN3qlLbgHZguCRFoGWdDu0se3HPq3Ld6md3Yo2v9Gmo6CVTqNs7au3y1eyOK0nOyuvz+TLArvQVauq7B0KPlo8HuBAFdHLGGYu3qnzx9K7N9DycmKoqNcIaveXASPSm7V2NRyIGl6Xw7BErhw78ePVClOGJv3sVcsk6BgEhP9iJXecyeENmFCFHP2CYvTDv7cX3wUHVJk/TOn/Eyy74xP9dVBOi95h451DxGTpUp8tyWl48kBMKavA16ijfG9Dz0JFTq9nnG1KHHA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=I94WaO42; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=I94WaO42;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fSKCN0D9Sz2xjQ
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 07 Mar 2026 08:23:43 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 546606001D;
	Fri,  6 Mar 2026 21:23:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2BA0C4CEF7;
	Fri,  6 Mar 2026 21:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772832220;
	bh=OuYfbVudPcdD1WrPShIxTEXnVYwKm2phYB5eMZ+H0o8=;
	h=Date:From:To:Cc:Subject:From;
	b=I94WaO42tFN+vaFenM3V1l4H6JjVtNcYaspg8KQ9SDlT4s0gUbjrv14TRisqPbzu5
	 nzb9SZ0vjqydlXxZCVCu4IbrSTFB8sxmL8AkKrQiSMZ8FyuXqY10BK0psZpEYdKt8X
	 QBzWuEjG06BqdWVmxVWHLlsRmIX33eaWV3lZMwqabkLt/ALDRxUdDDoVHZMvt3Rc3/
	 j3rUHAB2rG/gjqm3gvLdrHZfLF5RhZIH8EfeObRLMpQ6Eci39nYQLXF80TatHWbXgb
	 svMR6SFT2W8oBFSq9JGRWZ2hPAuRm/03ZKtONHm1BzN9yx/y4vHsZy0r69CZJYpXkT
	 ock2FYdrQ3LxA==
Date: Fri, 6 Mar 2026 15:23:38 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Nam Cao <namcao@linutronix.de>,
	Vivian Wang <wangruikang@iscas.ac.cn>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Han Gao <gaohan@iscas.ac.cn>,
	Nathaniel Roach <nroach44@nroach44.id.au>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>, sparclinux@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	linuxppc-dev@lists.ozlabs.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Joyce Ooi <joyce.ooi@intel.com>
Subject: [GIT PULL] PCI fixes for v7.0
Message-ID: <20260306212338.GA241358@bhelgaas>
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

The following changes since commit 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f:

  Linux 7.0-rc1 (2026-02-22 13:18:59 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v7.0-fixes-3

for you to fetch changes up to 9f2c7349b2810c671badfc1adc804f711a83e420:

  MAINTAINERS: Orphan Altera PCIe controller driver (2026-03-05 11:34:21 -0600)

----------------------------------------------------------------

- Initialize msi_addr_mask for OF-created PCI devices to fix sparc and
  powerpc probe regressions (Nilay Shroff)

- Orphan the Altera PCIe controller driver (Dave Hansen)

----------------------------------------------------------------
Dave Hansen (1):
      MAINTAINERS: Orphan Altera PCIe controller driver

Nilay Shroff (2):
      powerpc/pci: Initialize msi_addr_mask for OF-created PCI devices
      sparc/PCI: Initialize msi_addr_mask for OF-created PCI devices

 MAINTAINERS                       | 6 ++----
 arch/powerpc/kernel/pci_of_scan.c | 7 +++++++
 arch/sparc/kernel/pci.c           | 7 +++++++
 3 files changed, 16 insertions(+), 4 deletions(-)

