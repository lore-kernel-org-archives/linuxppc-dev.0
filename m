Return-Path: <linuxppc-dev+bounces-20021-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D598FDEE43
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Apr 2026 18:24:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g1kxw5zX4z2yHT;
	Fri, 24 Apr 2026 04:24:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776968644;
	cv=none; b=PGNNVEjWwvmDtErpX5nyVia6yoqyhK+8/4pBubDlIcSUtYM/pE1pZqaqTNQwvaOwBFfQRqn2Ig3kBqG8cPHtb62wDEY42lZfzj9ca7CGzVxfpAmNeaqHYrLLZf6QMlhM4uKyyBbrqgjNvB+ar7zqo4ZPbLmeIkVpgND4KEatFnilvexwpROAiLClSC2TyGETY2AcfPuigZU3gSY0Uecn5rkrYQRfVnqftJgXHdb3dRpoGmX4O7SbTx/q20s744MoKiaLYhUvuYhQLIRHTOfCJs2DAOWu1rUgGrU1hA7PySzRmKdLMylT0zu2MuotHCdPTFrIXBeHMLCwITZXI/35qA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776968644; c=relaxed/relaxed;
	bh=o02Bwsh302zqDKJS/WLJ/nmTDtHUYY+SPWMRJUajIQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=E/24jYVnH5hia9jhsdg/7tFA+rRmoo6geFsPoRv4MrMKppjTgZGHc2CXToUnUTeI1QcuKGbFePn7xcRJsnR5bCM4dl+0HekGeNuXzRMmiEjJfqpwPdhEnt+1fnj3Bn4OQmWRtDaOxFO/NsBpHuWnNW1AkkTG8x+0oW6Zv8bO0kC2q4qAuQaQm7jGbE/NsiKmUj+PquISgl07mrFoW95LaS7g4YZjXXBxB+XZwI3vAhK+5VUgc2xUr16C3xOtNtGGEzgDoTSwkXpv/LqiQLf/xLyXyiwK8gVgR1e9tszFQfUxwl0ttbA2GYK45ejUnAhMrd3knhbS7Qvbnog3X2Z3iQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=QQQ3e4R1; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=QQQ3e4R1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g1kxt6jy2z2yGf
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Apr 2026 04:24:02 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 9E682435EA;
	Thu, 23 Apr 2026 18:24:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 649CDC2BCAF;
	Thu, 23 Apr 2026 18:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776968640;
	bh=3d8ZmDarkOjA6NU39EQhXgpDDN9j4UEKZX4Zr+EHhQU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=QQQ3e4R15vnbbLmeHFfc8Fgth2tXRh//j2AAnWfZE1Io/yra+UAMjc/h5nO9Rvf5B
	 gHCVH2SxYRYuHnmibB4mqBxdstkQWH/o/mrJ7dm9gvAJY1mxdbuAS55UWccXnbC50i
	 Jw/32ZWL+qsezg+VzVMRQBpho0mGoyXtL8E3aJ8SsMDxUWnusoZH/TAePrVSW4bsjh
	 VXABUT5WE9kgNyP+T5kTfZkoc8viylzymJLKRsSGkPpPhd3HifSqoEB9HifV46PFCI
	 0flrXvdE9rmgPAis8fozbhynnW+fHNXqf9Dr7Xn35QLdWsGg0sQmGHjhyvI7mUwK8/
	 26rN80B7YH3qw==
Date: Thu, 23 Apr 2026 13:23:59 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
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
Subject: Re: [PATCH v6 00/24] PCI: Convert all dynamic sysfs attributes to
 static
Message-ID: <20260423182359.GA33696@bhelgaas>
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
In-Reply-To: <20260423172200.GA2271460@rocinante>

On Fri, Apr 24, 2026 at 02:22:00AM +0900, Krzysztof Wilczyński wrote:
> Hello,
> 
> > This series converts every dynamically allocated PCI sysfs attribute to
> > a static const definition.  After the full series, pci_sysfs_init() and
> > sysfs_initialized are gone, and every sysfs file is created by the
> > driver model at device_add() time.
> 
> A note on testing:
> 
>   0-day bot (recent test runs; newer builds will arrive later):
>     - https://lore.kernel.org/linux-pci/202604231622.DgR0zih3-lkp@intel.com
>     - https://lore.kernel.org/linux-pci/202604161928.DzuHQmeM-lkp@intel.com
>     - https://lore.kernel.org/linux-pci/202604121312.sF0Ua4gP-lkp@intel.com
>     - https://lore.kernel.org/linux-pci/202604111631.lrwAylMM-lkp@intel.com
>     - https://lore.kernel.org/linux-pci/202603170336.zSLrDvlj-lkp@intel.com
>     - https://lore.kernel.org/linux-pci/202603122052.tMV5rzNq-lkp@intel.com
>     - https://lore.kernel.org/linux-pci/202603081334.b91RGVS6-lkp@intel.com
>     - https://lore.kernel.org/linux-pci/202603060207.pnGfKgGa-lkp@intel.com
> 
>   KernelCI (for the "for-kernelci" branch):
>     - https://dashboard.kernelci.org/tree/linux-pci/for-kernelci/941dd7c3e16840724dc961f10b84e193d13cdb57
>     - https://dashboard.kernelci.org/tree/linux-pci/for-kernelci/683e66b11da157f730101f6919c7468a09cf3e3f
>     - https://dashboard.kernelci.org/tree/linux-pci/for-kernelci/209e2cfd205a8aad4bae32e6f82b96b20902aa74
>     - https://dashboard.kernelci.org/tree/linux-pci/for-kernelci/70293477e2c0ae8cbc250098818e726e1d658b53
>     - https://dashboard.kernelci.org/tree?ts=pci
> 
>   Sashiko's feedback:
>     - https://sashiko.dev/#/patchset/20260422161407.118748-1-kwilczynski%40kernel.org
>     - https://sashiko.dev/#/patchset/20260416180107.777065-1-kwilczynski%40kernel.org
>     - https://sashiko.dev/#/patchset/20260411080148.471335-1-kwilczynski%40kernel.org
>     - https://sashiko.dev/#/patchset/20260410055040.39233-1-kwilczynski%40kernel.org

Thanks for all this work!  I think this will be a great step forward.
I assume you've probably looked at the sashiko feedback and concluded
that no changes are needed, e.g., the feedback is out of scope for
this series?  Your thoughts there would help me out.

> I sadly do not own any Alpha or PowerPC hardware, so when I was testing
> these architectures while working on the series, it would be only under
> QEMU.
> 
> That said, Magnus Lindholm was able to test the series on the Alpha
> hardware he owns, see:
> 
>   - https://lore.kernel.org/linux-pci/CA+=Fv5Q1tZQwnanw99NbvzT-QenfYz7vUdY02_TuPqHX32ZAiA@mail.gmail.com
> 
> Lorenzo Pieralisi did some testing reported outside the mailing list (we
> talked on IRC), on the platform he had issues before, and while the issues
> were more with procfs races, similar to the sysfs ones this series aims to
> fix, he didn't notice regressions when having this series applied.
> 
> Thank you!
> 
>         Krzysztof

