Return-Path: <linuxppc-dev+bounces-17045-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5036DEA4FBA
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Feb 2026 13:03:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fKLcg5YM2z2yDk;
	Tue, 24 Feb 2026 00:02:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771851779;
	cv=none; b=hPF171I/Uh7R/RPQZjvQbg1f6EzWUkCHKJBdFVO0tSCY87bg9eB00K5UKjgnBLKU4tvhesFXb44lw0oDp2e+Asy43fEgBJQ8IHlVxm7s5rsfwJGUg41dPXe8jP2+NUvK0YnAguGSdeHF/ctiCHDKQW8xoUmwRTlPyHAbBO0jrKcMM3S4587hJvK/JQga9VO6kU7S3n1jVan/1Fd3Y3TmgmIIBV27Smf5dhpELIRrbQwcFlePJrgunIb+juI8MgXeIoJtsgIcKhBxRmNtFcoq+5NEedXBwKYoCLJyAmrwu2Iocdzl5LTP1niDQ59vJhmLVqlrGd0MW/3dk8uR1S+FHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771851779; c=relaxed/relaxed;
	bh=T8bNnw4n0yRZCqrV5DD7E0brTxIXyWYVqVFXtX6Tk2s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iWnf6zOEkhuE57pFcg0W6SLMQ6+AYfIU8zT/mOgcgzMgRBV3o+B/4MJ1rGEyrwnF5qXWyQABnLgrdNUadr/yYT7cDsItCm+aBfWhQxOZusaSIPL8yex5PPUOhsfbHEFu19wofb69plifI6B1KC4b9GvloB4saHkWKL5xM/kRuUYjMm36KegVNRSGWgfLzLezyvJ2Ha+wE7/n5kC93CEbCvipyNlFa8Uo3hu96Jt4aJt1paiqr7FyDNZau8rreG+zndFpqsHN3x2ClQHC5o/E27JTJhrMOubBr2K8DwTH4ir3l/hxhQHpiUui0p8VNxfqI7KbpR/zY1scjI6TioA9XQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=EACiBWri; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=EACiBWri;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fKLcf2q16z2xN8
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Feb 2026 00:02:57 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id E596B43BC3;
	Mon, 23 Feb 2026 13:02:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AC47C19424;
	Mon, 23 Feb 2026 13:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771851773;
	bh=iZBlwQliLKOaK+xvvX3FOn/PA3LT6MHuwUPt+gChPDg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=EACiBWriChy1jxD1pIwPsXwtgGcD9o364heVNUAxRBZ1sQkq+GJjO13PgypgojArv
	 +q3mxYpshrSqNHLUgfb8A2e5btCOVZs8KrKs/USVUB/GT97HWBgkwSNPGj/vwbLlge
	 CMX2UxlRJW+P7yxlkx+v8cnIEKQ+f25YYcsFho4wincbwYzmtGLFxgIfvd75uFSMdT
	 zSlUFnKsnPA72515URXnT7URdo00dBNZWh7eWWBfRyRtc0Pyca3knsGhf2aRTzLlVP
	 DFlEQ5BtDf9kMAv/DpHEmmk8soywcgeHB86IrDhR4OkzbMDsopTUbzbZEqpOOuU/si
	 vr8QCRbyNJryQ==
From: Thomas Gleixner <tglx@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>, "Christophe Leroy (CS GROUP)"
 <chleroy@kernel.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 3/6] irqchip/gic-v3-its: Add fsl_mc device plumbing to
 the msi-parent handling
In-Reply-To: <86qzqbal69.wl-maz@kernel.org>
References: <20260218135203.2267907-1-maz@kernel.org>
 <20260218135203.2267907-4-maz@kernel.org> <87seasv11z.ffs@tglx>
 <86qzqbal69.wl-maz@kernel.org>
Date: Mon, 23 Feb 2026 14:02:50 +0100
Message-ID: <87pl5vvchx.ffs@tglx>
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
Content-Type: text/plain

On Mon, Feb 23 2026 at 09:01, Marc Zyngier wrote:
> On Sun, 22 Feb 2026 22:57:44 +0000,
> Thomas Gleixner <tglx@kernel.org> wrote:
>> This rejects as you are building against an unmerged change (I assume
>> it's Lorenzos GIC5 stuff). I can fix it up when applying.
>
> That was against vanilla 6.19. I'll rebase on -rc1 to satisfy myself
> that this is still doing the right thing after the ACPI crap fest, and
> repost the result.

Ah. The other way round :)

My resolution is simple and it looks about right. Please note the
cosmetic changes I did on the way :)

Thanks,

        tglx
---
--- a/drivers/irqchip/irq-gic-its-msi-parent.c
+++ b/drivers/irqchip/irq-gic-its-msi-parent.c
@@ -5,6 +5,7 @@
 // Copyright (C) 2022 Intel
 
 #include <linux/acpi_iort.h>
+#include <linux/fsl/mc.h>
 #include <linux/of_address.h>
 #include <linux/pci.h>
 
@@ -186,10 +187,12 @@ static int its_pmsi_prepare(struct irq_d
 			    int nvec, msi_alloc_info_t *info)
 {
 	struct msi_domain_info *msi_info;
+	int ret = 0;
 	u32 dev_id;
-	int ret;
 
-	if (dev->of_node)
+	if (dev_is_fsl_mc(dev))
+		dev_id = fsl_mc_get_msi_id(dev);
+	else if (dev->of_node)
 		ret = of_pmsi_get_msi_info(domain->parent, dev, &dev_id, NULL);
 	else
 		ret = iort_pmsi_get_msi_info(dev, &dev_id, NULL);

