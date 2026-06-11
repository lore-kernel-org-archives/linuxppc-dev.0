Return-Path: <linuxppc-dev+bounces-22478-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7E3CCD98D2
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jun 2026 10:21:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gbdwk4LDdz3br5;
	Thu, 11 Jun 2026 20:21:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::429"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781173302;
	cv=none; b=BBKDxp9EcIh73KFBORV8cf/LyD9VKAVEC2nl/a34mktYXVPZbO9+QzXbL738NfIzPOyKBDlw89GW5xEmYbOAk/K+1DN/L0HUAr4gsp/J1yTUeYgMogJRWp8kLUk9Uh9j6nLc/eqU96xIfNEsWqTf0tlJ2t9My7GvIMVYcGsdsaMLbpRp7qJp+D6mQ1HSWAsYumHW1eWnanxM2x1iqdDMr+URlOHPZbORaj7UAStFTloY6qWdqdfn3QhDoJf1QUXFzJTV+/YSiX+ueikktA40vQb1DwVZ0zaEFz7ZuOuEWVXOIxQIgUs5tRvY+cQeMFiL7dHzbszZ3au/mGom7i1/Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781173302; c=relaxed/relaxed;
	bh=ks9XZxCyDCZpPl0hZOLfLDZkVcVXMB4BMtGl2dtDnVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BTaMNyA/OgjDx3FSP40UcQurZe5B2IoYRj4Nba1GpxKrIjh1UskkZHKjMrC/2Hl1qP7JaazWCjGOUbFGG1z5BaNsDQhzIQLbJ2fruLm2H9YpC1bqv7rHOvdKIeqYzdvRxZ/UWzET35bdPv/JKlYj6XxBC8GMZ5VComFboGZfe2MdvpJPKPDjJk3cv16TF4cltuf2YE/LTZmwHHn1Wgr6CrOMwbdL99DME6ps40BzyPV0I0ZUa9OWgOCDuo9OT+V3GdY/anm+nLFSH6+zEo0HNHfiDn22DSg9QyIIT2O9B3+vsEjVNrPpiy9PsvBggbhj+bh+ShqDewA0YF5bErcPeA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=resnulli.us; dkim=pass (2048-bit key; unprotected) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=GhbNMQBd; dkim-atps=neutral; spf=none (client-ip=2a00:1450:4864:20::429; helo=mail-wr1-x429.google.com; envelope-from=jiri@resnulli.us; receiver=lists.ozlabs.org) smtp.mailfrom=resnulli.us
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=GhbNMQBd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=resnulli.us (client-ip=2a00:1450:4864:20::429; helo=mail-wr1-x429.google.com; envelope-from=jiri@resnulli.us; receiver=lists.ozlabs.org)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbdwf6YQ9z3bpP
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 20:21:36 +1000 (AEST)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-45fd464d51fso4293306f8f.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 03:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1781173293; x=1781778093; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ks9XZxCyDCZpPl0hZOLfLDZkVcVXMB4BMtGl2dtDnVQ=;
        b=GhbNMQBd8u04nAyR2Y08Ce9FBBGoLJ6r8UAT6W+A38h12IiSXXul82QOk92HAhR/6T
         WuTp7BhgUhhI47awJyilolpZp2t4JGp6uTOLqzTahtE24VcSkZHth7aOWYqTsbWCAsZ1
         1SGkOI9qItlVb5j371fCZIpyAuP3vGZh/Ws0sYTE5xoPU7XSRzDe4WZS+d+bceVTrMiw
         vo9CpqSgUbbHQDNcdDQLP1+Af0a3ZVUNJfLUy+fcXSB1udOUPyOP3bBGZ3mS/5eWM+PR
         KShvE03nM65SWgNzHRYHHBy4iX6E+0IiAQBOKvw0059E/RNvptD+yJ2tAh6PPjvmpWS+
         x86Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781173293; x=1781778093;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ks9XZxCyDCZpPl0hZOLfLDZkVcVXMB4BMtGl2dtDnVQ=;
        b=UqOxy6/byfMCqBAw9xP714oY1Zc7JVSmVogmlBbS5JN+rHPcTDyI/QickONWgp8K6z
         yAodLGOe/5AsjqD8BY1FX2pUexuL6z2SqZqnDCOUgI4uBzqHeibvahDFMuO0FIRXGhEa
         lUKKjvz7iToz0LTKhjcTFpfW2tVykbL+VAycO/7Ci60tqpvv04i6x/p59e2T1pE/ODQA
         jblkfPmbu/zkHmEZwG/Ybzjb/yyTbfQYPEbkejFEuFjUVY3xLkNV9B9pDpChUxTexZJB
         RhuL1tdO3yzvhRFLIuKksZjXxw3f1ovoTUSFlzGR6lcZujd/ETXKGB9U0KBpqBJivKoj
         C0ng==
X-Forwarded-Encrypted: i=1; AFNElJ+fPVXcn2FcaUnxf6vghENsXf11t8wJioI/mDCN8OsadPUKIpU4jzAskeIhmefPt9UHqFjWvqZtjFfsuSI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyjO757HEY6XyVnexNrMofKlovart6OBaCNoe/hQiZ9rzkp9Z1O
	lEYRPIDbYPtDMqKi3rReikmCZsyF0Ws8B4sEkgWE2tYvGwS1yWRdPplHtLjNdoqlKUo=
X-Gm-Gg: Acq92OFFvnny02v/uYfNu7LX5un1Gwz9+MTM5gkepY2umBQGbPAi6j964l7gbdOifbQ
	5xpH1+WSQJUZop2rOEOnR7JOhLKjYKkuOIC5xl/HZyPq9j9+HMSKe2XY8c4B3JKEzxxzNv3bNmp
	QybRXfhCkjbPo1ZMBFkNSYlBDeL1ysyCyJJU7eKqGEp2LknQuTc3VEAToOAD4a94iSg82mNq8Kb
	t8ZE6od6UzBGVkPRti4vlrUSIS6WDYJKN55DpkNwWHt/Q3WoImoBVxkE/YLJIIy/81M/oKlm5Y/
	AirLka4q/ou0LCkNnnbEYoqdhDmaVAcaRNaUI2vZKagl1nDmr8UZlK/+LJTYbdvsYw3RVc0ptF7
	9vZbTl6rl1Ruyba1AuZsbL0A1OPmQFgyUftYXiVQ2SQM2Soc1hn/Df2N/3wgcCWynLQ69incIcA
	AiUaxRqTcd/cn5MJ+yYTAzF1I++gAwMd0qZ0dC7Q==
X-Received: by 2002:a05:6000:1449:b0:43c:ef4f:79e4 with SMTP id ffacd0b85a97d-460677c149emr3057787f8f.37.1781173293060;
        Thu, 11 Jun 2026 03:21:33 -0700 (PDT)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4602cda3651sm68603644f8f.32.2026.06.11.03.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 03:21:32 -0700 (PDT)
Date: Thu, 11 Jun 2026 12:21:27 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Sumit Semwal <sumit.semwal@linaro.org>
Cc: christian.koenig@amd.com, jgg@ziepe.ca, hch@infradead.org, 
	maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, 
	linuxppc-dev@lists.ozlabs.org, lkp@intel.com, agordeev@linux.ibm.com, 
	gerald.schaefer@linux.ibm.com, linux-s390@vger.kernel.org, djbw@kernel.org, 
	thomas.lendacky@amd.com, x86@kernel.org, arnd@linaro.org, benjamin.gaignard@collabora.com, 
	Brian.Starkey@arm.com, jstultz@google.com, tjmercier@google.com, mripard@kernel.org, 
	afd@ti.com, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] dma-buf: move system_cc_shared heap under separate
 Kconfig
Message-ID: <aiqLJUrJ1dnKhsJn@FV6GYCPJ69>
References: <20260610142329.3836808-1-sumit.semwal@linaro.org>
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
In-Reply-To: <20260610142329.3836808-1-sumit.semwal@linaro.org>

Wed, Jun 10, 2026 at 04:23:29PM +0200, sumit.semwal@linaro.org wrote:
>From: Arnd Bergmann <arnd@arndb.de>
>
>While system heap and system_cc_shared heap share a lot of code
>and hence the same source file, their users have different needs.
>
>system heap users need it to be a loadable module, while
>system_cc_shared heap users don't.
>
>Building as a loadable module breaks system_cc_shared heap on
>powerpc and s390 due to un-exported set_memory_encrypted /
>set_memory_decrypted functions.
>
>Fix these by reorganising code to put the system_cc_shared heap
>under a new Kconfig symbol, which allows either building both
>into the kernel, or leave encryption up to the consumers of the
>system heap.
>
>Fixes: fd55edff8a0a ("dma-buf: heaps: system: Turn the heap into a module")
>Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>Signed-off-by: Sumit Semwal <sumit.semwal@linaro.org>
>---
> drivers/dma-buf/heaps/Kconfig       |  8 ++++++++
> drivers/dma-buf/heaps/system_heap.c | 16 ++++++++++------
> 2 files changed, 18 insertions(+), 6 deletions(-)
>
>diff --git a/drivers/dma-buf/heaps/Kconfig b/drivers/dma-buf/heaps/Kconfig
>index e273fb18feca..a39decdcf067 100644
>--- a/drivers/dma-buf/heaps/Kconfig
>+++ b/drivers/dma-buf/heaps/Kconfig
>@@ -5,6 +5,14 @@ config DMABUF_HEAPS_SYSTEM
> 	  Choose this option to enable the system dmabuf heap. The system heap
> 	  is backed by pages from the buddy allocator. If in doubt, say Y.
> 
>+config DMABUF_HEAPS_CC_SYSTEM

Nit: "DMABUF_HEAPS_SYSTEM_CC_SHARED" to be consistent with the heap
name?

With or without it:
Reviewed-by: Jiri Pirko <jiri@nvidia.com>


