Return-Path: <linuxppc-dev+bounces-22827-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E957ACD4F26
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Jun 2026 18:39:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ghmb20s0Pz3bqM;
	Sat, 20 Jun 2026 04:39:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781894350;
	cv=none; b=cuRKCo3v5kVQSLTAGxJp6MOQlpMFPLBaPw0HcgvThLAm7QAMYXkq3mILLsC33MsigLfe05mA2RgDvCpTjzGBWcdfE6HjWla5vt7IexDi6MnPuX0rq8XP4q1iKY2+j8bkZ0R8YU+XOsFSnQC5pF0S+SLSREKH451LEc3jChxaHXnk8PoILm66/97QLbFZ7vuQ3d2O/PHrNM2KzIoLMYy0VsPT1hxhVcBh/uusNYbvS0Dec4BDlaPVAi1KJsiCd1Fks7R9faKb9jRn9uvRMsuO+AyYvRIKCsYMaEad+DLmU7CkhFUwkFrDaEF+1sCtw5dc/fykKd743x7sVM+Y5tS/HA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781894350; c=relaxed/relaxed;
	bh=6q6+QsyXfGEG92de2glYz9EexNTcqa1QfzBhVghDvOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bYbkxYaOh/LSB993vzOlVvAKYtCZoB07cwM7fs37yWJMV5ljhPUHFatk241Xd8Wm/Fn2IZ2Ur1KOELS3YOdXh3c60KuokyoWbbyYuIW9U72nYhQQTMJfHR61x6QeO+SrEWDK8yd0+yK0EV4WutUZ5OCtl15d942e22k+Mxsy8rnRT2S/ON7iOlE3u4/rNGKlMQnpMpqmeKaolhBxCiYAlMNEDkPkWjIzDgH81vwNkspSfF+VmUjtfXeNkTXu3nYrmhu7fRBoEtBOhKupxNSiEHcbPyOlQwgqfvX2ahKrO0KhU5mvec11kDC+RV3thzfLrT44vlEzJKm/P4vJ78TaeQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jaojH6LD; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jaojH6LD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ghmb00RpQz3bpm
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Jun 2026 04:39:07 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 3CDD140207;
	Fri, 19 Jun 2026 18:39:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA3081F000E9;
	Fri, 19 Jun 2026 18:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781894345;
	bh=6q6+QsyXfGEG92de2glYz9EexNTcqa1QfzBhVghDvOw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jaojH6LDYcKCn3dgewd6r0iMyWhoeXWxbAMY+QaxP4/ZbqH/GB2NKUBzfwy5f0RzY
	 FnZl8AyXeD0at65nDgl9jkmFAocHPKbrt/xMbMP9vBotjF958fYC5YBwMfmnjAi2G2
	 WfdplQTUlF17dHhK6CLdP4X7QzEHDDg5LLNzgoFLV1z1kfqO8LOS2dr99cAGXA/eEA
	 UKd1/snH2MGnB/tzCpxxVOwDIdTn/Cs8sZ3TEDtq+KgubtGT9pAWn9qGwZBEd/z6eR
	 gje/ubuPDZFjosCZd3+Isi8iWTWG2lCUXpVMXuIiTsbV8AmFrsNwAqB9qdaKwGnifi
	 3JeHPsMDxguyg==
Date: Sat, 20 Jun 2026 03:39:03 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Alex Williamson <alex@shazbot.org>, Magnus Lindholm <linmag7@gmail.com>, 
	Matt Turner <mattst88@gmail.com>, Richard Henderson <richard.henderson@linaro.org>, 
	Christophe Leroy <chleroy@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Dexuan Cui <decui@microsoft.com>, Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>, 
	Lukas Wunner <lukas@wunner.de>, Oliver O'Halloran <oohall@gmail.com>, 
	Saurabh Singh Sengar <ssengar@microsoft.com>, Shuan He <heshuan@bytedance.com>, 
	Srivatsa Bhat <srivatsabhat@microsoft.com>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	linux-pci@vger.kernel.org, linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v8 00/25] PCI: Convert all dynamic sysfs attributes to
 static
Message-ID: <20260619183229.GC2528910@rocinante>
References: <20260619085200.3729431-1-kwilczynski@kernel.org>
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
In-Reply-To: <20260619085200.3729431-1-kwilczynski@kernel.org>

Hello,

> This series converts every dynamically allocated PCI sysfs attribute to
> a static const definition.  After the full series, pci_sysfs_init() and
> sysfs_initialized are gone, and every sysfs file is created by the
> driver model at device_add() time.
[...]
> Changes in v8:
>   https://lore.kernel.org/linux-pci/20260508043543.217179-1-kwilczynski@kernel.org/
> 
>   - Renamed the generic resource attributes from dev_resourceN_{io,uc,wc}_attr
>     to pci_dev_resourceN_{io,uc,wc}_attr, for consistency, and cleaned up
>     resource macros definitions.
>   - Changed resource macros argument order to fix checkpatch.pl
>     complaint.
>   - Added two new macros, pci_legacy_resource_io_attr() and
>     pci_legacy_resource_mem_attr(), used for the legacy I/O and memory
>     conversion instead of open-coding each struct bin_attribute.  No
>     functional changes intended.

Updated the sysfs branch with this revision to get some testing coverage.

Changes here are mainly to clean some things up before the code potentially
lands in the mainline.  No functional changes whatsoever.

Thank you!

	Krzysztof

