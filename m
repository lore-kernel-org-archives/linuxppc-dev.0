Return-Path: <linuxppc-dev+bounces-19827-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23C4CF4368D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Apr 2026 10:41:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fxrzC4wqDz2xSX;
	Fri, 17 Apr 2026 20:41:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776422503;
	cv=none; b=lKQTBGK7uPYy2rsWahmqWEG3khH92JIrG0ZDMZIdWxRMo3bGEfLqpxxLLiEqWzE6TBXU2IsEWFKhAo+4y8FdRzUCpyPXEIVNcMNHZk2r11TsdSphWJW98xcI+M1kU8GPyFDdTqaYRDP71Own6zYbPoejtaeorVI/ektR5+B/utW56qnVS1VSap43dVBcO69RzLakYozMcqcc9qjg0kE6psCDJ5aqEN0tErhdc3fP7mrT+j24ysHORekS/fitPsOX3uSks/pgtoQQJVHc0hnzzsnSyBGYw/AAAsOsQ3p2r/tsbYsJfD9Jn5HDIOjPFGMIXTiCNP/q3ZdL2sGe5anU8w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776422503; c=relaxed/relaxed;
	bh=yOoUBIUqhCIVLOdAqGhaBWNMye351UmLYnIENehpwOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bvKd7j/rR5gyjx6wHQ3XGlY8uCwYE5vCOBRhH3TXYuVFpW3Kw4BFsqz/OpTBa8fOtuWUvq3fPvRA/HX96aafpV84zBWyIeS4dh6nIcjTj9DsN4dGYUAkUjbm7MgpNwi71X+ToHJGFu3iQhjJV/f3XyTpznAzlRnNLTEhgXgaKBAKwpBsUzHECnvJwD94XMaIxW+aLS19INAsdNbDRJfzey5+KJ6xbaJWTxoTTa/UiPTfGB1Lqj/Roa/2mI0cUERNOO/jSAwR9SItayPneotaWFZP7I913jzPgVd8VwaeIM1OgWZL+1b8tACcbvtYgh0G3Npq/ez7oNGH+ReaPq1wyw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=TtPgyx4s; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=TtPgyx4s;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fxrzB23cmz2xS3
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Apr 2026 20:41:42 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 0CAD160128;
	Fri, 17 Apr 2026 10:41:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59875C19425;
	Fri, 17 Apr 2026 10:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776422498;
	bh=L0GTYKccieNMJTwUsBo2lGzUOj3BIShZ21D9v4UZBhs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TtPgyx4sEoslirAFE1xOCCdvIzjXlIjN54E+c8UrNTbbbHeVbnL/3O7TGX2obODny
	 MJy0RbFLJn2cB1Y7/bznD8F6Lmel7w7rY8sRGAMaGrW5reJeqH2pt4DTdOTtUh5JFW
	 +bX/1in7EvNP/3fRBdmr/Nnbqt03Z09y1e8DLfOnXCiTsrsxGW7Qnm2Y7TTcdfrmFl
	 InRRB4TZ8CsrvL5dm4KFtT6uPCtuYzVThV70NnPqP27OMJcIPLoNAXwJvDzdOREY+t
	 CiK8hNtMffvkBGlAxw9Gt7NnHqErYrjGdZ9H/vbdtPN5eutVtkF2M5n2QDq18LGps9
	 3yWIZMCNnEIug==
Date: Fri, 17 Apr 2026 19:41:36 +0900
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
Subject: Re: [PATCH v5 00/23] PCI: Convert all dynamic sysfs attributes to
 static
Message-ID: <20260417104136.GA1524638@rocinante>
References: <20260416180107.777065-1-kwilczynski@kernel.org>
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
In-Reply-To: <20260416180107.777065-1-kwilczynski@kernel.org>

Hello,

> This series converts every dynamically allocated PCI sysfs attribute to
> a static const definition.  After the full series, pci_sysfs_init() and
> sysfs_initialized are gone, and every sysfs file is created by the
> driver model at device_add() time.

A note on testing:

  0-day bot (recent test runs; newer builds will arrive later):
    - https://lore.kernel.org/linux-pci/202604161928.DzuHQmeM-lkp@intel.com
    - https://lore.kernel.org/linux-pci/202604121312.sF0Ua4gP-lkp@intel.com
    - https://lore.kernel.org/linux-pci/202604111631.lrwAylMM-lkp@intel.com
    - https://lore.kernel.org/linux-pci/202603170336.zSLrDvlj-lkp@intel.com
    - https://lore.kernel.org/linux-pci/202603122052.tMV5rzNq-lkp@intel.com
    - https://lore.kernel.org/linux-pci/202603081334.b91RGVS6-lkp@intel.com
    - https://lore.kernel.org/linux-pci/202603060207.pnGfKgGa-lkp@intel.com

  KernelCI (for the "for-kernelci" branch):
    - https://dashboard.kernelci.org/tree/linux-pci/for-kernelci/683e66b11da157f730101f6919c7468a09cf3e3f
    - https://dashboard.kernelci.org/tree/linux-pci/for-kernelci/209e2cfd205a8aad4bae32e6f82b96b20902aa74
    - https://dashboard.kernelci.org/tree/linux-pci/for-kernelci/70293477e2c0ae8cbc250098818e726e1d658b53
    - https://dashboard.kernelci.org/tree?ts=pci

  Sashiko's feedback:
    - https://sashiko.dev/#/patchset/20260416180107.777065-1-kwilczynski%40kernel.org
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

