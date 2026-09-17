Return-Path: <linuxppc-dev+bounces-27631-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82618C88E72
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2026 20:01:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hm68m4Rkbz2y2W;
	Fri, 18 Sep 2026 06:01:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:39::e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789675304;
	cv=none; b=kRuFaoxDFrpVThqzcB9jUnG/LWR781AcI9dJsdvoScipPIN4GRKqaWbwJ0y6AcElKEMKhV2RmQksJq8rUOl2M/mxj3A8ByQGWwKyOUif6fCtv5iga9x6Rk1AT2tbOLh9Zr308Y6XoosQPtKzxqzbmE+zCyAMhxYw+eHO9pDKSQB3a1M2O/dICvBQWDHV1UpZzk/nhObmYoqUfBhoqcvavjhYS+H5Lrv8Qd96j8ej88h/iPNxOTZ7QzU2yANve/orUIxi50SdhfiAvP+lM6D/7OAwzBe8rvq2NBe0sQRo+twZ1ow1sCxUL96qHCQC8wXh4ZfglItKNgcvsnRg3TWlVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789675304; c=relaxed/relaxed;
	bh=mhGEf8mpyg4UxEKpmS5TYtXOZtm+XpKxy7o28279ww0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GMP8iiHm8O/kmqGJlH1EoyPryqbJCmKdZaS1X8eqzXDXc0YmNfXUF/Bs8QVgvq4sPlYX0WTmQ97t9Bpy9Vty27cYWmMNVbod2nbuJRTJrz/VWNuR5M3NSAMT5Evk2voevLMwV7WR9Ht2tTZ2F4UpkWTCiTV9zYfP1+axe9sOehIy+GMGTMVIbK36H3Na+ofeY0HQkez7F8U3afZowUXgC9yOwgzJ3y5u268kNu4T49fRE6LYpTF9Qpx+895bYeUZnP0zn0o3bFelhm1G/BKZpTnh4gJdVpxmzJlryvVZwWU+B+LosVW+DLDyR1m+Eoc0w3LUGuKtQjYBApE4i4JVUQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=co02uZ7e; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:39::e; helo=mail-ua2-x0e.google.com; envelope-from=mhun512@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=co02uZ7e;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:39::e; helo=mail-ua2-x0e.google.com; envelope-from=mhun512@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ua2-x0e.google.com (mail-ua2-x0e.google.com [IPv6:2a00:1450:4864:39::e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hm68l20Twz2xbQ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 06:01:42 +1000 (AEST)
Received: by mail-ua2-x0e.google.com with SMTP id a1e0cc1a2514c-980b6159d30so332616241.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2026 13:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789675299; x=1790280099; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mhGEf8mpyg4UxEKpmS5TYtXOZtm+XpKxy7o28279ww0=;
        b=co02uZ7eqn/FZwx7RLHnLYGnSOLP/9sqFPeWy0NaVbFF53b0GjngMRYqL3LyS7FWfI
         5FjdXpSmt4pmSP/Z93FGn9qMdGuyzfYXYzLzpdfn3CGb+6z4gYoqsCDxnenKjPB8VJG/
         vaggeM8AVubuteuOneHbs/fmjQbx8C5+Cmf8KPhB/WYWSX8TRFVldp6IQyctFe2uB+jK
         GTPepWikXgawURzsJ9p+TUi24PVLqkn9jLTkc1dgRRrlg+NQUwhQftu1A3wjpekGYn4D
         vPdq+NUgePpZxYjz3rQLHTIw9dJUA12wazqYyYFYrkdOn5Sd2WkS17hjLAciOiuc8Y6l
         hy5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789675299; x=1790280099;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mhGEf8mpyg4UxEKpmS5TYtXOZtm+XpKxy7o28279ww0=;
        b=vxpjeMWIqYKW8GeTw9umxYbRkZAKbcAhf7LF9b6AcG4+zTpgs6bABPIzXfuz+4v0+0
         ABYeL90RuKYJIb1icTZgJg8o1cceVRRlLQ5AWsKeLQlkhW/1Aw0zBgGmagKe4PsnX0LM
         6iWwz/Ns8jl8LT2JES41RX2eB4dHr2MSAccg2FvAqsqlaBbQh8jGdMFP7k+l+EUKUjYE
         ewRwtx8EaEclY0SmxleolUtAVDTsjGhs2S5LcXl0ER1ehEA1pFymCRPJHxM/fq1A8h45
         c+jclfS+0hzmq5xJMWOX0u6a/HLsupVybSP+wdPcWv0VSbvbVBmQppLjwAybHIJho2a6
         NhKQ==
X-Forwarded-Encrypted: i=1; AKwUvBwUJ7Fygyel0nEklu3pnhctv57FXSmQmExElu41pp2gFvUR7jhQY9aXVxSU+0xuqkx5SD6B55pmZB2wSWY=@lists.ozlabs.org
X-Gm-Message-State: AFuF++nOofBGYbyEbo8EuSHOECMMHvKbzKeZpqTN5ObZ1WdDTOKS7Mqg
	04ziF3qoPa5YQH8H6slRg/yt+yQoVQv1hX5BX9QpvoElaIxo7Jzl1+Y=
X-Gm-Gg: AYBFou3QSueiynYg7fbKV2QhNuF5TjvLJ8RxYAoRhtAJ22Ly10r94wJY17fLb6odgS3
	g1rORbR2mRNpm5gZoqdexiv25l4k5St5ivpLoqT4Pbqac33DxUeww0pjyrXCdeljdgQ+BBxM0vp
	iNK5W4WMoOeazmuxxR3JlV70lmRRTzte5IiLinzjcreXzO6oH7vfhE7aVWRmkFTpCLUOj7ixfZ6
	GpLMDDRbpfKbMdDYeFA07YWt9hc2Qo98lWvV20P6QUag/rh5MMMfWr2bl1sW2wYZIxoDl42AufK
	cRSsdx69/U7kG/GCN4IpB2/xiywqwqkIw73EnMW0Q/AjqZQls/TC9mgNsxSf3zLETlG4RZjOG5o
	c3zteebzyFKu9cIWL10517JYy0uT2weKr8GFJkFi5/lkdqyeLf832i+VV/xArRmxB/MvmfmPOMe
	dZBO9sN6PNW51M6q/2x2eisAQxZtyBcZEJNkpml1bOhIrAHm/fiIuLP6PEWCRRhYysz/D4M+2HF
	JP0bc0o1Rq/4iOffGlScbfZORKGS55SFP2goyegRbvHvSV7oVRyrjwNJ0ogPKugKzao5lqttALJ
	jOhv2btGPQsEP66GS6iHK9+dRqrcz2AlEiij
X-Received: by 2002:a05:6102:e0e:b0:79f:eeb7:d630 with SMTP id ada2fe7eead31-7a55a226309mr83581137.6.1789675298545;
        Thu, 17 Sep 2026 13:01:38 -0700 (PDT)
Received: from localhost.localdomain ([104.39.169.225])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91252c7cb8bsm5425606d6.20.2026.09.17.13.01.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 17 Sep 2026 13:01:37 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Christophe Leroy <chleroy@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	Ijae Kim <ae878000@gmail.com>,
	Myeonghun Pak <mhun512@gmail.com>
Subject: [PATCH] soc: fsl: dpio: Free the IRQ before releasing the I/O object
Date: Thu, 17 Sep 2026 16:01:36 -0400
Message-ID: <20260917200136.75721-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
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

Explicitly free the managed IRQ before returning its resource to the
pool, and perform IRQ teardown before releasing the I/O object. This
also waits for an in-flight handler while the object is still valid.

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Fixes: 993fec7e11ca ("bus: fsl-mc: dpio: add the DPAA2 DPIO object driver")
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/soc/fsl/dpio/dpio-driver.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/fsl/dpio/dpio-driver.c b/drivers/soc/fsl/dpio/dpio-driver.c
index d5198ffc4455..fa82cdcc4922 100644
--- a/drivers/soc/fsl/dpio/dpio-driver.c
+++ b/drivers/soc/fsl/dpio/dpio-driver.c
@@ -263,6 +263,8 @@ static int dpaa2_dpio_probe(struct fsl_mc_device *dpio_dev)
 static void dpio_teardown_irqs(struct fsl_mc_device *dpio_dev)
 {
 	unregister_dpio_irq_handlers(dpio_dev);
+	devm_free_irq(&dpio_dev->dev, dpio_dev->irqs[0]->virq,
+		      &dpio_dev->dev);
 	fsl_mc_free_irqs(dpio_dev);
 }
 
@@ -276,10 +278,10 @@ static void dpaa2_dpio_remove(struct fsl_mc_device *dpio_dev)
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
2.47.1

