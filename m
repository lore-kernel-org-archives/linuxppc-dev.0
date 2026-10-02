Return-Path: <linuxppc-dev+bounces-28776-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AFFBCA5FE0
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Oct 2026 19:48:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hxK8D17bhz30Pp;
	Sat, 03 Oct 2026 05:48:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:34::d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790970492;
	cv=none; b=J9NfBRlN7hk/byshX7VnjREuNEulg1rJKP6Xrs0JuECqGJLdE6fv7uvlfKGkZhMKfTzPSKzfPA61tgYdeaEcKrSEOYvvhq/Yltw96csGZneCGYg1YOW45tOScbro63z8zFusJyAxkt+/gyxy2DoknzJh6WnWm9wuOjeQdarFEKb9CX96LIZIGYzJSiA7HlEE77j1Ov2c7RmzROxuCcA4JeAog+AqhqDloTkIgJWNV4ge+6Hpnx9jsQZdjPZKQt2h/uwc30FmYabDjHHX5NTNn7ZpSWf6f1Gf55y1iv5QqAo6NE5WAmuSzbHoF4oyaKk78oyTPdUyHVNwlLCgpukgbw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790970492; c=relaxed/relaxed;
	bh=KZEY2KuFMnZ9k0uAKqAQRBac5uCnzYVHzYqMLMLbH1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nNZVbmVkZo4e5N1E0RhHbgWx8VZ6Az0kYl1miD0HDY4N9G59LZj25h2DEudECJk0iJmUa2PStGjnMdHxHjiZOTgSVv/+aniDphrGFmgX0P2qFLtM9GtH3tMoFq/C6XUn+Dv9oDX/5YS0+7KjXE8K7nTLH/gLDvON39i+jBWUUjQLkIPnnfLTXc/s5zXpqrMO22JXmKT/5GJtWV0sOw7myYT7Ojv7TM5zSsjHGSjYI+THr6ia9zgOiMqO2M8lpXNFOJVFVIplpI4rj7nf8PKphnMg7C8rIokMgOmizjPN9Qv5r1xOUO+7Th4eKRQI9GU1rhpjFDORkH5wJAi5mIuUoA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AyKfMbDG; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:34::d; helo=mail-qk2-x0d.google.com; envelope-from=mhun512@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AyKfMbDG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:34::d; helo=mail-qk2-x0d.google.com; envelope-from=mhun512@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-qk2-x0d.google.com (mail-qk2-x0d.google.com [IPv6:2607:f8b0:4864:34::d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hxK8C3YfZz30WX
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 03 Oct 2026 05:48:11 +1000 (AEST)
Received: by mail-qk2-x0d.google.com with SMTP id af79cd13be357-93c57d36d37so808433385a.3
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2026 12:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790970489; x=1791575289; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KZEY2KuFMnZ9k0uAKqAQRBac5uCnzYVHzYqMLMLbH1Y=;
        b=AyKfMbDGdnMIVr3IlhL+rSY5aPS2D8PGrfjEMiQeHc1dAJoqXn+3EOoRUl/W+y3st1
         a2S/h9iq6XiHniq+qGrnW0p/Y8pl5fddLLdPoRNhAN7t7sEAt0Oa9xqJuCPF+VEabidc
         D0SWwg7PTV0nMsbW/tgOUqPTg7RUb8/d7tHJCfwHB/kJjQvLxm5n+VgYlNBNN/4tzJ6P
         gTwUt89PfKAla/eAoqw7XQUtpEXr4A/oYfU4WOtyA3JKY8a2YOi4DQB0OK6H/9E3HDnh
         TvpctL4GVbyu4xI2JkE7WNyL1OL0C3MHzBcZzSZSmWQ2cCeykWZ0k61bm6lU/tRSPEca
         kROg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790970489; x=1791575289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KZEY2KuFMnZ9k0uAKqAQRBac5uCnzYVHzYqMLMLbH1Y=;
        b=I2vtOLbS+f2XJ3PhR3v7Ho2lRxehoSkWR0LvIcQbr7BWJ+ceizAMOKyb1PMGkolnq0
         upFfOVc0Qc6c6oiEu0HNgKXJiWNnB8XamELCjo0izZJ2p2tI79mrL794qC9lADOj16RP
         WNWxG8k145BoWH9I8IIQlr978C7l58/+LXnPFVCKM9YVFdwK1+c+mE5/T/KXIwo1/b1z
         NY9QZBCZpWH5QOzLm63WGrsURthEzOt8lui/z2UE6Rz7MUndXp+nuT9+f2VIUkfhVZYQ
         uaKR+Lte9EDfmZkosCRD8nA4/SK7lh5t9DSPzft0Ifs8U7pDhieNg/I+6M3By/TJ5z+y
         LHzw==
X-Forwarded-Encrypted: i=1; AKwUvBxVtVIK6Ctu2NBH2Jlco9qog0z1R7DzcajUsX8mppoJjNMWyREPy+4zBvVljK0EfQAspWbKgdp8C2FEL5w=@lists.ozlabs.org
X-Gm-Message-State: AFuF++luhFukpStWpnwWNfIfJ76E1EwNuTwbC0LHYEH2vbOra4zXSYAg
	CDRqoPmNtSWH/NaXogmeEHIKU3LjvWWH/0S6up7IFS73ci1DRu4s5cuJgCYzat4=
X-Gm-Gg: AYBFou3kqnhM440aiQ3TI+Kxgo2/6B/HdPF9eH7y86sHEkleklJAknQAsUML/PMXji3
	Pyx2b6QxoLyD77xDCd6jALDVQEuZrJG+XDT8QoMPGY9BuxLO7KUcFgKk6pilNTnRoxmp1FHcdFf
	U3vDl73NzjNsPfLwoENAQAqcUDtoK0DcolUYFDoUo27SlmudVXJ8mz2LNXZYlDItAMsJwTWtcli
	00NPxIYO3MmUXKMgjQTOdSwl8yhhauqMbXEPlu4rHyWR//Zgwa4N01EmAseZ6pF68UXFqH99WY9
	xRh9vuoh9WhesBS8nqNIirEVaBM2YfxzaBsy1/nuvblBGGqtUqdbWeHBiJFGjEa1Mtr7DZB+NeF
	bnm7hOfE8WA8WDPCKxGxeKMNpC4rNxqOLL1R1Ox13S92bnQCgJPwI1WB4miJpEgMxt0z42nAYfn
	bb3tBAiozeP6LXSBEU1Va/pnbKTvvFVcugtKLZYaTu8aJCE0s8NfV12CUzlcmkp7ePb4HGRGnm4
	eTCrBOf1GCB/IAQBx093nekbl7U5PRrmgfPNW2RpkwaC5ZaEZq1LX2Bd0fecLfWrTK37xLQ/ZOZ
	x68Jzt7fRO4QeXeMv6OjwrTOD1X90YJZc71iNjM=
X-Received: by 2002:a05:620a:1a24:b0:93c:ab1c:fc2 with SMTP id af79cd13be357-93cf18b1773mr713989785a.33.1790970488621;
        Fri, 02 Oct 2026 12:48:08 -0700 (PDT)
Received: from i4-gl-tmk5904-1.ad.psu.edu ([130.203.156.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93cca2ed5e2sm296846985a.47.2026.10.02.12.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 12:48:07 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Christophe Leroy <chleroy@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	Ijae Kim <ae878000@gmail.com>,
	mhun512@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] soc: fsl: dpio: Free the IRQ before releasing the I/O object
Date: Fri,  2 Oct 2026 15:48:02 -0400
Message-ID: <20261002194802.375497-3-mhun512@gmail.com>
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

The DPIO interrupt handler accesses priv->io, but dpaa2_dpio_remove()
releases that object before tearing down the interrupts. The IRQ was
requested with devm_request_irq(), and unregister_dpio_irq_handlers()
only clears its affinity hint. fsl_mc_free_irqs() returns IRQ resources
to the MC resource pool without freeing the handler. An interrupt can
therefore access the freed I/O object before devres releases the IRQ.

Explicitly free the managed IRQ in unregister_dpio_irq_handlers() before
returning its resource to the pool, and perform IRQ teardown before
releasing the I/O object. This also waits for an in-flight handler while
the object is still valid.

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Fixes: 993fec7e11ca ("bus: fsl-mc: dpio: add the DPAA2 DPIO object driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
Changes in v2:
- Move devm_free_irq() into unregister_dpio_irq_handlers(), as suggested
  by Ioana Ciornei, to keep IRQ registration and unregistration in sync.
- Base this patch on the probe cleanup fix in patch 1, which removes the
  unregister call from the probe error path.
- Add Cc: stable@vger.kernel.org.

 drivers/soc/fsl/dpio/dpio-driver.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/fsl/dpio/dpio-driver.c b/drivers/soc/fsl/dpio/dpio-driver.c
index 8d31346..d8f28fb 100644
--- a/drivers/soc/fsl/dpio/dpio-driver.c
+++ b/drivers/soc/fsl/dpio/dpio-driver.c
@@ -88,6 +88,7 @@ static void unregister_dpio_irq_handlers(struct fsl_mc_device *dpio_dev)
 
 	/* clear the affinity hint */
 	irq_set_affinity_hint(irq->virq, NULL);
+	devm_free_irq(&dpio_dev->dev, irq->virq, &dpio_dev->dev);
 }
 
 static int register_dpio_irq_handlers(struct fsl_mc_device *dpio_dev, int cpu)
@@ -276,10 +277,10 @@ static void dpaa2_dpio_remove(struct fsl_mc_device *dpio_dev)
 	priv = dev_get_drvdata(dev);
 	cpu = dpaa2_io_get_cpu(priv->io);
 
-	dpaa2_io_down(priv->io);
-
 	dpio_teardown_irqs(dpio_dev);
 
+	dpaa2_io_down(priv->io);
+
 	cpumask_set_cpu(cpu, cpus_unused_mask);
 
 	err = dpio_open(dpio_dev->mc_io, 0, dpio_dev->obj_desc.id,
-- 
2.53.0


