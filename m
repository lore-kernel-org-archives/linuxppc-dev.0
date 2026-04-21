Return-Path: <linuxppc-dev+bounces-19913-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03CB8F94CAA
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Apr 2026 19:50:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g0Xyv3kPpz30WX;
	Wed, 22 Apr 2026 05:50:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776801047;
	cv=none; b=f3XjRRnqYVL15wtykHJaHmAZv8dhv6nj9Iu+FHDe8ehc7TEn0W0ZIK2vDGs2I79LoGNzLAuOqiCoqISOr1/jF2Kzf+Y34Lps5NqPztoovkKnDqbSary9077TX0XsTHyQIraD/iIgIJWIcii7Dk7xOyXWpOVipxPS14F0wWUSX4oO/6xz747x+cYPKUM7WDZ77w5r9dGu43IpTLtf9ZnPde00wfeTKQduCyU5M1D5y5PzF1PSw6qal9xo3m/1PgAL0U3MQbYcYQ9ZFSjn4+egt9wRwsK6kHudDQFShXWKPpXwtBIMEJc4DBM0e6CkjJslQrLD2hAel/k/SWPKneqOWA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776801047; c=relaxed/relaxed;
	bh=fHdkP/YSV1JBsv1HLBhc8GJUwKj7/oOdCUPF6mdXDUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UhqdpBmTGnvQNlmXu+Ik1RAEhDN7vnOPaT6jhlIw/dlzXjKsyPyNzkMxTo78aNQ8bV+MKuru+uLQVtxw64LvlSfBk3Hiv8yMZWZaYhSVqKBtp5rs+2YTaBmReuQhAx4XIPcvetnxMB5DvBWNHMFLrL33qzXL++kv7dQJ4V3cQdTeSJ9jLM5LEbFckbsdzoG06rolZdm4yJ+BaSgVPvIsdyHXRN450JpPQ/bWzLDcfx03tzvoB/67n3XXCgl8pIS5E9u/R6m3Tr3ONZyGojs7YBHWYbIqrKiLC+/wMTtFn6K5/jC+DZicaj1EfvmEdWtv9+bzBbZWXtVpSfurnmzf3w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=XCYXlXCD; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=XCYXlXCD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g0Xyt3qFZz30WT
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2026 05:50:46 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 2532741957;
	Tue, 21 Apr 2026 19:50:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B40D7C2BCB4;
	Tue, 21 Apr 2026 19:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776801044;
	bh=ooUX033PRSor4DZZcfiE5ZgW5rEzRajyd8nkM8cfXwc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XCYXlXCD5ncatsOJrtdenK4w6lbDvos2aOvw1Vk0DVjK9s1BJl+4Yh6nhtCD21UtX
	 8Aj+jgcfHe7bMH0TJ2A1fuhrgOrVc98OKspi1hYSNiDXiIiTh2NpZ6sR7hga2m7WZD
	 Jf1tUW33tnqt+sKJvc+Ap0ut/TAsl9S+nza2U+lyoKpDN6zKk1UZ9Z4UJKx7wZIPv9
	 NrQhx1+I04JOQ8tzkj56EudFABZqJY0SH6KxkOpwy0iiHexCeWwmyT328QwzyPX9fK
	 7HI4JT4EmPdwn0qnOtYTgeWILzZNoGhCIOc6nQY2448nY4xnBw4Mk8bwW6WXMXMI9N
	 CqS5bIo6A0CEg==
Date: Wed, 22 Apr 2026 04:50:42 +0900
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
Subject: Re: [PATCH v5 11/23] alpha/PCI: Add security_locked_down() check to
 pci_mmap_resource()
Message-ID: <20260421195042.GD1684602@rocinante>
References: <20260416180107.777065-1-kwilczynski@kernel.org>
 <20260416180107.777065-12-kwilczynski@kernel.org>
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
In-Reply-To: <20260416180107.777065-12-kwilczynski@kernel.org>

Hello,

> @@ -71,7 +72,11 @@ static int pci_mmap_resource(struct kobject *kobj,
>  	struct resource *res = attr->private;
>  	enum pci_mmap_state mmap_type;
>  	struct pci_bus_region bar;
> -	int i;
> +	int i, ret;
> +
> +	ret = security_locked_down(LOCKDOWN_PCI_ACCESS);
> +	if (ret)
> +		return ret;

There is feedback from Sashiko about this:

  https://sashiko.dev/#/patchset/20260416180107.777065-1-kwilczynski%40kernel.org?part=11

Might be something to look into later.  Out of scope for this series.

Thank you!

	Krzysztof

