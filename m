Return-Path: <linuxppc-dev+bounces-28775-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 284EECA5FE0
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Oct 2026 19:48:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hxK8B4lJsz30Tf;
	Sat, 03 Oct 2026 05:48:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:33::c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790970490;
	cv=none; b=iMH86RbWLTzJ+ExY3OBQRNKsotYiAhIAmJHuCwoqL82amSAB/XNr6bNaQMi0ao3HN7z6uyhJoPhXBdkKmU2Jy40TV2WN+OWoB7xfUYpdmgUDC1ADOAUZfwemldF7tPSX1Q8OCP2MHeuNDlBsv5oQ/b87JTCcBVMqVj/g6Nza4LXsSIQQZc2cZUpCED2c3HcMvYFMpPk1NFcGHmFs+6UUOJ/bDlBFK3nS8hfmVhLIPmQ5WVxTRGC8f7rYAocrbMwuZQdzljDNL5zrNmMQRFs8zVAGl5M+LYQMCgqKiqkx+bk9WhzQRt3Uy66ufu/tj7QUow7T5W1IQw0vSnlzN1oBjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790970490; c=relaxed/relaxed;
	bh=peEOtIWNssxYKrb8NM+ypkApXFH2AI9AHn+rEkEvysE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QH2+uWzrJx1K+0l5q53Uv3S2FmQZ44CVYh13Weu5GtHuE91wOquYf/dLLG37mcaWPIjTkXVRyQ1JNzVaernyEHsOhCXIWHAfq/gKC8of0zApF5dCneCguriPHCi9YmoU0D09iKSuugEzE+PV26SlWk2Awy6HbmcajLKvfiErA8BMeaittoCAvrHYsGANLo0YVAFCW2uvKmL3SVRYIei/L2XnPcdqOfdaKzfy1JjDXb1kY5o9EVAxu4K3GZmXyO5vIeqTwaDCMXybgobvTCiYxBH9uQJ3E7G//D1cIVZi3pIxKOA2JtwbniHCAXABAjcMgaJ6Dlo7SmaIa3fow8zR5A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qbC/wgFn; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:33::c; helo=mail-qv2-x0c.google.com; envelope-from=mhun512@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qbC/wgFn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:33::c; helo=mail-qv2-x0c.google.com; envelope-from=mhun512@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-qv2-x0c.google.com (mail-qv2-x0c.google.com [IPv6:2607:f8b0:4864:33::c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hxK896x5Kz30Pp
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 03 Oct 2026 05:48:09 +1000 (AEST)
Received: by mail-qv2-x0c.google.com with SMTP id 6a1803df08f44-917ae0d5298so2791326d6.3
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2026 12:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790970487; x=1791575287; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=peEOtIWNssxYKrb8NM+ypkApXFH2AI9AHn+rEkEvysE=;
        b=qbC/wgFndnQIx68Z/kjgjSbmt5CStZFrnQ3qrj7OmRu+STsy7LMZFFyavWaRNz2w7l
         trbrF1jFlceAUkbVj1gYjEnCbGfJFvY0zj2k0k6S3eU6ZtTGzW3uE/0RueciR9PKyyhW
         +GIcVRieeaLQ1bCAAGIigrDzUFl002hWpfz+Run7fqc5eA2pxzVdyLmEt9ddk9d1umQd
         LQIKXadbGwDrySpuFaZ826yaCYfvjzb4wzjf4bW+ettUBOaT7hzyRmhg3ae75l3fqVra
         is0wfg87SGf+m4rofG8q/SNY5Tpl5HuObp1NliCMceQnZbApsm1Q5S4ShufVvhOdjc51
         dulA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790970487; x=1791575287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=peEOtIWNssxYKrb8NM+ypkApXFH2AI9AHn+rEkEvysE=;
        b=r/0h6MC3uDIvLe6/cOrRme5CuQjaQtPAiA/6/JJE8bns8cnjscx29vPpKDpf1CNIJA
         5H+6bkCqEmjZReAdwHPOkEnjB6WLvyLBw0i2RxHs8SLh/ovExjZoHDyiKJyc/C4UGjE3
         vpvJ7pWlOGAu8iXC8cX8eDvomE5XFvgrJ3ZiSinTlhxzjPavCLsYKiNmhLyvbsejYjkr
         iXOdV7XgFvwFVp7/lHA3DCQNHmn5ciYHBzwD+Uimh2xXR+2fKstVNueCz+h22YkcnAf2
         CkWeXbklswiJK5m2uVzKON/1fJ/pAOCjWeQ9iDJEa5mbksomZB2v6638iS+3XM0+o/xl
         VD3A==
X-Forwarded-Encrypted: i=1; AKwUvBxMYkr+1L8u3cHKQ+to80zzaVbvVMctve4FuxZziqv7JBVI6ZJa2U8kR7BEe9QukfO66TABJyU95ks+d7Q=@lists.ozlabs.org
X-Gm-Message-State: AFuF++n2Ck8oPeiWgIhYp0UWYYCVQlSvddP5q3QWKSTzDZ7XVpxQEpaI
	84vPnFFpe9wfCvG36da9uDol6kr4+u8GSjKtsQEj3u9S2a6dDv9wtf4=
X-Gm-Gg: AYBFou2l5gVD92+oHKubhEDQFpO+OA5mooozgJ1/Em5gzaHWYdAnlrXm6Qom4UvYprb
	+OrjDcRy1apWEZMaUutn/B3PZyYjJSpOyWGK/Rb+e/Qk2KdktAse+LrWRNHBvO529eeF3OkKzhR
	JolZ9TZJZbbdFj3kd+q3KoCzcKufrZURp72yIjc7l5Dw1yAiQQIrCeSc3oK+L1VruVDUtb9JKNg
	RZzWCRngq1I7hwpubtztB7aR6BieGfq2dIYXzM6KtjF2kXzzcOkl3GVBQaL/+7tUOiPYabWv/kB
	8xfSCqb8gU5D6Vm55eQCOo7/NeTfjQokrFRJ9Ng4u4USdXZmiJi0K48VdhUwWmAXgZ20w2ibBnN
	1TxVCOygwzd6o9UZwh/l4GyEDenasJCMybIaXhhgpUM7ifL+9eii8xWP0or4Hs4YCGyiCe0q4Px
	AejZFvD0ge+zB27a/zbdXSv4EBJP56tSKGf6+uUkC2yMdR1CVNYUsdU0oInTO31s5MSrvZUgPm/
	kgxib55Wa9TpMaN/AFQVPFn6ZnzbJNG57XlSOKcEhWcjcsUoff8n4JxQpzEXstiR2DELF0e42+P
	ZbY6vHdYaWkyqBrZBJ+cIEp/5gsy
X-Received: by 2002:a05:620a:4052:b0:93b:db80:e0cf with SMTP id af79cd13be357-93cf1a393damr685608685a.60.1790970487600;
        Fri, 02 Oct 2026 12:48:07 -0700 (PDT)
Received: from i4-gl-tmk5904-1.ad.psu.edu ([130.203.156.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93cca2ed5e2sm296846985a.47.2026.10.02.12.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 12:48:06 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Christophe Leroy <chleroy@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	Ijae Kim <ae878000@gmail.com>,
	mhun512@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] soc: fsl: dpio: Fix cleanup on IRQ registration failure
Date: Fri,  2 Oct 2026 15:48:01 -0400
Message-ID: <20261002194802.375497-2-mhun512@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261002194802.375497-1-mhun512@gmail.com>
References: <20261002194802.375497-1-mhun512@gmail.com>
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
Content-Transfer-Encoding: 8bit

IRQ registration happens after dpaa2_io_create(), but its failure path
only releases the IRQ resources and the MC portal. The I/O object stays
allocated and published in the service list and per-CPU lookup table,
while devres unmaps its portal registers after probe fails.

Call dpaa2_io_down() on IRQ registration failure to remove the object
from those lookup structures and free it. Reorder the error labels so
that a failed dpaa2_io_create() still skips this cleanup.

Remove unregister_dpio_irq_handlers() from the probe error path, since
no IRQ handler or affinity hint has been installed when registration
fails.

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Fixes: fe8fe7723a3a ("soc: fsl: dpio: register dpio irq handlers after dpio create")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
Changes in v2:
- Remove the unnecessary unregister_dpio_irq_handlers() call from
  the probe error path, as suggested by Ioana Ciornei.
- Include this fix as patch 1 of the two-patch DPIO cleanup series.
- Add Cc: stable@vger.kernel.org.

 drivers/soc/fsl/dpio/dpio-driver.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/fsl/dpio/dpio-driver.c b/drivers/soc/fsl/dpio/dpio-driver.c
index d5198ff..8d31346 100644
--- a/drivers/soc/fsl/dpio/dpio-driver.c
+++ b/drivers/soc/fsl/dpio/dpio-driver.c
@@ -244,9 +244,9 @@ static int dpaa2_dpio_probe(struct fsl_mc_device *dpio_dev)
 
 	return 0;
 
-err_dpaa2_io_create:
-	unregister_dpio_irq_handlers(dpio_dev);
 err_register_dpio_irq:
+	dpaa2_io_down(priv->io);
+err_dpaa2_io_create:
 	fsl_mc_free_irqs(dpio_dev);
 err_allocate_irqs:
 	dpio_disable(dpio_dev->mc_io, 0, dpio_dev->mc_handle);
-- 
2.53.0


