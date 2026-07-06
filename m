Return-Path: <linuxppc-dev+bounces-23644-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9E4DC43458
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jul 2026 17:59:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gvBvf2DKmz3bqs;
	Tue, 07 Jul 2026 03:59:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783360782;
	cv=none; b=OR6cZK846esDJzw181y32jvXkh65tH9cDtpDWqhzfqZ5J6J7LKJbJ9lfmntaDr/hk5ETapjwaxUSh5IQlBexJ3atpxKmmie8yaIjR2llE5xATFjOClGvn+XO3v2DkjzF+EPkb2+xCT7/wDmKC0rHzUMz1D3FzxCSZkNTkHyoz2oi/ot9O6rduKH5K4hXos3Wjrwfyd/Uqu9WjatxXYvDalktkYxLncmJil2RdDTsVagZ02UUNvWpl3in83IJwfyMIKTpbODr8oFVR5YR56bZKrGD1fyH04qJZbCBRhSk6nZwckMeBO6rnW8hMoJmgzJTuBHNZUTCYzYAUl23djU2sw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783360782; c=relaxed/relaxed;
	bh=HmJC/8vvDL2HoOKSt77yU01Xd8+oFpwXQVS5MUC1ip4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dhi7dJzwiv+Ifzt6XZLrBgd0ad9SFaV9IVM7qli9tiwbBB3cXdTOvrCgrMFAukWEbLP1dCazfB8bP9ViY/JO29MdPGy4CC27y1vJH6lGQhgI4tKjffDzKpDalihsyaHw0CKI435RuTFRE4qMgiBZa4fFyTPXQ9sRu4wfXfzXsmJla292p3v/qaAqDLpidrUwpq2n/WfTeZWPMk6S+xazyq2ltk0TK6Icxb0CUQyJ1190J+lsx+bHi5hfWXadIOqmellDfuDHoKM5npbcO7LyAdrm2iCl8wgy7aPLQqiOYh9swNZ+fA21oq/lbPQX3PfgHUZjM6/pprsd64OpSCiv9A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e14/gzWo; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e14/gzWo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gvBvd1Kzyz3bps
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Jul 2026 03:59:41 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id F055743526;
	Mon,  6 Jul 2026 17:59:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CCFF1F000E9;
	Mon,  6 Jul 2026 17:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783360778;
	bh=HmJC/8vvDL2HoOKSt77yU01Xd8+oFpwXQVS5MUC1ip4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=e14/gzWo6xW3YOVH51Kits+m+wP2GGjgCPTFCZzuQY2e4zbXL/oW0CbOJFthhXV6W
	 TH/fIo4ygI1HJ2OEZJ+m8tmUalcJDi+rjiPiAAU6xkaqavP3GELwrAB/tugOUc6nm0
	 pOxxaO6ql7oe0jGraejMO3iq+bl2FyOjkcYRL6+/8L7Z8WD78Kp+gHBD8R5kCGA0xM
	 W0u6YoEvDio+HO1z6tbnV8plCvPwugzTqZFAzPUPINGUlOSK1DU4mEJIpV6awT4/2M
	 rXLjKkIyroNo3Q5IPiKbUzUThbfBGIa7YUUeW513KasCfefHfz065nMGrxrDPQfjs3
	 aQJA7FFNz4K3Q==
Date: Tue, 7 Jul 2026 02:59:36 +0900
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
Message-ID: <20260706175653.GB265195@rocinante>
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

I will send a follow-up patch with the above changed, mainly to
clean the code up, as v8 didn't made it in time before the merge
window closed.  There were no functional changes.

Thank you!

	Krzysztof

