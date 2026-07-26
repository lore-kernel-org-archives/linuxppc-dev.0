Return-Path: <linuxppc-dev+bounces-24836-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B60DAC531CC
	for <linuxppc-dev@archiver.kernel.org>; Sun, 26 Jul 2026 08:23:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h7F9Y6pKrz2yFP;
	Sun, 26 Jul 2026 18:23:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785054209;
	cv=none; b=MyUvXiWh8lrTcwZNqx5DP2yqhRF06rGH+JOloy4cXLK5QBjtkAHTKX1dgrI3YmzndIFKpDFKyb0IkRfVAaPdnBy50Z8WXDUxoi8I0bdn0j55OQ7W7QnBMQuM/ApQ7SmeatOk2YgLqLdpREirNOZz+iR2zHq3Owrm8GBHxCfPpXDmR/gFAGYVxbZZZAJk8isVJPcyEgh4JSweo4dCITNzOxWrXqXTK0yd3obwuxW6JeYWRMZbqJ0AfdqWx+77m+7hZXm7Uzycl6Xyad3S9+siIb9nLEgy8jGQaT/YYmZ+/W73/aO0EGghTv6KpXMyjdIRnOvEM4+rF7e+MTVsApM6iw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785054209; c=relaxed/relaxed;
	bh=EURZIPTZJFvZM2NBjtixgY4zUoPQrTRaxQBigdxQ/mU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=F5Fsb64T/QjD9qVVVpfRVF05MOcK1If9ZJAeVEf+mufeUQIjrUcU/gnE4gRndDAeQE0Why0MnMNG/DZVwW+CE1wc3CRFvLUQZQUijh8D1oUxH6QlDKlLdwWPtpfR1bM9PhCp9kFTQJaBmo2ueTpMeoXPtCRbR+imRoCeVG7T6jgsg76hAnR6kTD+H+liXkNRpes24fbAYi6iejdzMUSZQpEN1MJSlWSUGCXr0zePGZj0Z0kbsmh19oonzrBIHgizC6xJB70DH5IA8eAg2OOGtvR/ENQKUMN7s/k3cpJ5/IkNiImV8xjaYxijhw2/cMl3VgFWtiJxjQYD3eHxJeSwqA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TeXg6iMc; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=leon@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TeXg6iMc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=leon@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h7F9Y1pH1z2xyk
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Jul 2026 18:23:29 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 996224074B;
	Sun, 26 Jul 2026 08:23:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB45B1F000E9;
	Sun, 26 Jul 2026 08:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785054205;
	bh=EURZIPTZJFvZM2NBjtixgY4zUoPQrTRaxQBigdxQ/mU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=TeXg6iMcktCeyB0+3f1Wqj6isZ1zp0BU3PodckqWnMC2VKkG+ycD66oY2ApKlngBf
	 yAlCvF0EiSAcdRWOHejLHvFI2lp/BfVYEJaNEAezyC1m7Z22pItQAbp+G5n7Fw7F1/
	 7rHkZrbYeJQC0lUoE/g5t+gYdHVntH5IjWPqatLleUPfDUGmpwWFAv1WIK5Td3Iztu
	 JvyEsSwzlU8o+f2iHWM0Iqfkryb7ufpyENncD3S78477VweJHa2DypdYjOEzepQBD7
	 6Dyr29IFlCQZX6ZEICY+Ba6YdflI6c05BKNRGKONCtuOWHMgQXReJZs33Ey9qNuJz6
	 /Ff3R3RjZRV0Q==
From: Leon Romanovsky <leon@kernel.org>
To: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
 chleroy@kernel.org, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, bharat@chelsio.com, 
 jgg@ziepe.ca, akpm@linux-foundation.org, namcao@linutronix.de, 
 ynorov@nvidia.com, sshegde@linux.ibm.com, nilay@linux.ibm.com, clg@kaod.org, 
 Gou Hao <gouhao@uniontech.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org, 
 linux-mm@kvack.org, gouhaojake@163.com, kernel@uniontech.com
In-Reply-To: <20260724022851.466017-1-gouhao@uniontech.com>
References: <20260724022851.466017-1-gouhao@uniontech.com>
Subject: Re: (subset) [PATCH v2 0/6] remove dead NULL checks after
 GFP_NOFAIL allocations and fix xive use-after-free
Message-Id: <178505420268.4050106.14417810250582879470.b4-ty@kernel.org>
Date: Sun, 26 Jul 2026 04:23:22 -0400
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-18f8f


On Fri, 24 Jul 2026 10:28:45 +0800, Gou Hao wrote:
> Changes in v2:
> - Remove the now-unused out_free_domain error label in the xive
>   patch after deleting the unreachable NULL check goto.
> - Fix a use-after-free of xive_ipis: when xive_init_ipis() fails,
>   the error path frees xive_ipis but xive_smp_probe() ignores the
>   error and proceeds to dereference it in xive_setup_cpu_ipi().
>   Propagate the error return through xive_smp_probe() and check
>   it in both pnv_smp_probe() and pSeries_smp_probe().
> 
> [...]

Applied, thanks!

[6/6] RDMA/cxgb4: remove dead NULL checks after GFP_NOFAIL allocations
      https://git.kernel.org/rdma/rdma/c/a273210687f255

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


