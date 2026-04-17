Return-Path: <linuxppc-dev+bounces-19833-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBAC4F43695
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Apr 2026 11:49:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fxtTB0d9dz2xpt;
	Fri, 17 Apr 2026 21:49:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776426557;
	cv=none; b=gmPUkmLteEM51UWp8RMSQRpoXZ5ajVtUVV6aKn3+8rDUbER5KFFwciiepYNNpaQ1IW7Kmk7bYamk35mPvIYdo03A1dTOwPGsngp861fIdBawSBjgqwu0JtBGorNdX3u4KXo2KwuMW4h59uxl2LB5FujT4cryWU9y0ckZjfzUbDL+OCulJgEEXXeYdKGww3e+oJGJxeowHY79Y+7b5Acg5RZGyW++2JMD7iyC53KsKak6GvM2sqxbFw0w1vAYBDjHFCg1dHtfnsrGCxxb9uXM6tfx59hBdeN+qemLXTaN0nvqZKEZNSbqvbKXJr/lXURXp2830PA6HxAEZWSthnPC5A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776426557; c=relaxed/relaxed;
	bh=b/cPgj2045Ng5vcd8yRXGiwI6kAdbgiHOlYy3/Oj0l0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L8sxALz9gGUMUtL4zF8CT7i75n0wVggiP0imOnz87IVoNvrT7mCOStvhT9Nk6PIYzVqKYv4/I3pko6JGbE2w3QGNeY0SPPanDdQDb+wyfKv5T5uF2/33bIz3hBPlNOJJ+5Tp0LXgEgLOYmX/KmUQgUQ1OQPEvKQ3JRFXJsr/PpNoPf2h2Bqg2jFTzcFfWbOOiXe86ZorD8hekI9fXk9w+vDQ83zQM6Tqpr411x+YOMeStVm5WoM26q5HamKDpyBsD28aGW61SJBQYGBTSjsv9sUgGY+IBhTsqmZdDtURRFCrgojObMx1UlfqQEpGOatfG4MpPEJh29WwfNwUB+bo4A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=evTmeijV; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=evTmeijV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fxtT86qcsz2xfX
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Apr 2026 21:49:16 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 2D29360138;
	Fri, 17 Apr 2026 11:49:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95401C2BCB4;
	Fri, 17 Apr 2026 11:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776426553;
	bh=MI3uioBuwUgxsUjR1l3EmFcjUf9h5BvjSExDwm8I7tk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=evTmeijVDLEB6aLBYspix6gADC5LjwWgom00t6nqowr4w3aOXLvWeHsMrBUauYm5C
	 gGPAgcQeIUEHgSGU32kGesEYgbQdwwwXXPjqx7JtIeqN/22PeLHYQSCHf406lgGVZr
	 8gnXVj6QtH17T0cjEOXmlBEtq76tN23CEsgj1xYHtdE9lB4Y4DhE9u4UcPur2jR0d1
	 hG0a6P24tp3fZJJNKwyqT2g8Y3+f4QSrrys65VZmZ9KeuQW+xifnjgYlMlNU6YFY3A
	 wHpQq0XxKkzHMrvfxNiw5f97NRIzlp2iMzJTzi98fipcb/ETGn4xaF0LzDOGs3TBZC
	 KMEGe36WA60ow==
Date: Fri, 17 Apr 2026 20:49:12 +0900
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
Subject: Re: [PATCH v4 07/24] PCI/sysfs: Convert PCI resource files to static
 attributes
Message-ID: <20260417114912.GD1625998@rocinante>
References: <20260411080148.471335-1-kwilczynski@kernel.org>
 <20260411080148.471335-8-kwilczynski@kernel.org>
 <eca4c119-65a8-ac84-3869-4064aa1f0829@linux.intel.com>
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
In-Reply-To: <eca4c119-65a8-ac84-3869-4064aa1f0829@linux.intel.com>

Hello,

> > -	/* Expose the PCI resources from this device as files */
> > -	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
> > +	if (!pci_resource_len(pdev, bar))
> > +		return 0;
[...]
> Did you accidently forget to address some of the comments as I thought you 
> were agreeing to changing this to resource_assigned() but I found no 
> resource_assigned() from entire series?

I have not.  Sorry for late reply here.

When testing resource_assigned() as replacement for pci_resource_len(),
none of the resource files would be made visible.

The resource_assigned() checks res->parent, but the static .is_bin_visible
callback runs at device_add() time, called from pci_device_add() during bus
enumeration, so before pci_assign_unassigned_bus_resources() runs and inserts
resources into the resource tree via pci_claim_resource(), etc.

The call sequence in pci_host_probe() is:

  pci_scan_root_bus_bridge()
    pci_scan_child_bus()
      pci_scan_slot()
        pci_scan_single_device()
          pci_scan_device()
            pci_setup_device()
              pci_read_bases()        <- res->start/end set from BARs
          pci_device_add()
            device_add()              <- is_bin_visible() runs here
                                         res->parent still NULL

  pci_assign_unassigned_root_bus_resources()
    pci_claim_resource()
      request_resource_conflict()
        __request_resource()          <- res->parent set here

At that point, the pci_resource_len() would return a non-zero value as
res->start and res->end would already be set, but the res->parent is
still NULL (not yet assigned to tree).

The old dynamic code ran from pci_sysfs_init() as a late_initcall (after
assignment), where resource_assigned() would have worked.

As such, we can't really use resource_assigned() together with static
sysfs attributes, at least not without solving the resources evaluation
order here.

Thank you!

	Krzysztof

