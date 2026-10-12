Return-Path: <linuxppc-dev+bounces-29308-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7B42CA9EDE
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Oct 2026 18:49:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j3RMC6tZWz3c3s;
	Tue, 13 Oct 2026 05:48:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::631"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791830935;
	cv=none; b=aIue4TDtCZUzgTSn0XIRM6fMyA6o2gTXbLzQphuJwyXsA1LUjkHgpccbnEmCfJdNEpN2z9V/gs5VYjEP907YcaevhLrXwbg3xOsDkM8EpAa+/R2ZVaxiWQbwJI9jFsEVZPLVPhPX51evjsdb8gqJSImu/ne9xaSxkQm0bQIDBabDwX6R4M5jFDE5z6lc+mdTiC3E07Z639qhuKFCYTWUB+u00fr0D3GeO3g+zc5p2zG58OG8vC6PBkorQhhdO9zdbVybzk8l/WRz4LFZ46pFApKOjhJGsQFFzbEwKBt9SW2V7coEyMUpMHQxtopQDme4ht5Kr8FeaEtWjso7AIuMcw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791830935; c=relaxed/relaxed;
	bh=lJQ3Hg947nYGt/YgtzMTiRanQurATHC6+G3Zb6saEl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hC3npSkogbOpaO+XSW/0Hwr+JdQAaeiivXGhTeBoq1G1hCI+MR4/cZmBroy5GXkLOid8iDZ5zJCWy7dhlCVV4sKxD94rVy7ePJ9hm0pvxS0mVIx4U1RfC55jCzTUtsrujEdfPbC86+f/RFtuiZ5q0qTPEVOjAfQUclgsw4E/XZ8zfPygyx3lCYS9yn4AMq3gy8Q33590ZBQlOs0YSjyGu5JYJQQpzp6pHkWeCQJe0nEZssH9mltOI+TMQbQw8A/jvVMjdc6tHfqzb+vyKPuKNJZXO+VOO0Dd38DxjZwApP72Dhe+BVZD4m4e8uACs7YBJU0yJmF72IWDrPjQHCqrbA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=md6okNh8; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::631; helo=mail-ej1-x631.google.com; envelope-from=linmag7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=md6okNh8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::631; helo=mail-ej1-x631.google.com; envelope-from=linmag7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j3RMC0nHlz3c2W
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2026 05:48:54 +1100 (AEDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-c31745ad205so686195566b.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2026 11:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791830931; x=1792435731; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lJQ3Hg947nYGt/YgtzMTiRanQurATHC6+G3Zb6saEl8=;
        b=md6okNh8Dnp/MocHIGA7B+e3XH9ddeNw4djyiXV/lYcP+KBEQoOsykUbtsVUrkOCGU
         lPlZhDM/gzJwPy4n/p9MuN5VplHEkXBrOFX017O4+o4Cw+feiwm5WKf6rteR3eVoLFXp
         hmsnexLTUVku0+SpP9o3gTAKP7tbJyYqcmWr/y6UX/NjUS5s66f+Hcw+omFCT03U0WbY
         ne7sf5PQ67CNsXzS6WmJCeeOVmwddcYhG3u6wDmkXfy4ob9WFsxaeK1s7pceQy4O2Lsi
         v2+3cKDdZLOF9hswsXR3vWIoWxHw8XMTABAE8d7IJXclTexWfyyujL/uETfYkNU2zCaA
         R6DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791830931; x=1792435731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lJQ3Hg947nYGt/YgtzMTiRanQurATHC6+G3Zb6saEl8=;
        b=vJG5489Qa8ak2XqHRYNNuazMxCY1X8y7WZp60TLH1C+iUydNb9XKAbIuo2o47ykQHu
         JHzmMwB49DdrSayUg1fPHWWNccbCkW9Y7BMGnK26YWRp4oWJxvlPRA6fkeJszn7q/XUx
         YA9OGRcDIe44CQUbdtUrm8vvz0Ij722gJhKAeRkjUulCqWZOVm5Z257YHSNmbo0OX2SF
         8j2dx7dPpYvwm/0cqsrThe6K+o0kvPO3GZKkCO/KQxc2eT4+C1MWMUCsxRhA3LXXOnfV
         HVtNTeezSwLYTBD9/M86actg2nmHV98h/P1L5cQu389rk3yBEwMhOAMonShKNVLCJSpm
         GUsg==
X-Forwarded-Encrypted: i=1; AKwUvByo9WV4hYigRCixJ3evW1y9BbtdvXwO4bBb4mxWF9bOLnk3/B4OLZI5CXHaQlrR5HAERa4XbD5y0D0ugug=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYLfYj2QGalSq6kFaW6PiA1msNlFy5onGb4rfaH4mDGD59uvx/Ad
	QZsS4WTPda5vCNB7YRMIMVCkWN+PpCG87K/USzvwLL9PpOdl1LYx1QQq
X-Gm-Gg: AYBFou2caqDTSyBFuQD7GU73dRSZyZmex+oj5F/7I1SZKI9fFhz2luSauAUf0dbQLm3
	GBIp8tY3TD5h2kHPryFiMN0Pi4OXwAfSEzxYMohzL/MWWRb9ASIx+a+Y8kO4NI9eGRVe/mSQ5zY
	wfSlK3sQzS3Jw6OIilBXaszZYWlYnuItKNBjs2VgxNdFb8+pcnOiZ4Yc0kUmksTCuMzjNyY2cJZ
	7z1DZQxvLxoaWI9FPcLKcYd0EAkbB+H+rbNlVc1asK3NlBk1XGoGvkP2ZCvWbHQ3wuqtAidBLUm
	uJmANdJOYj35M0YInWYj5lTxdYJH8o1OdiBc0jg9eibTE1R/ygffvHtz5Chviez2e1HII93qZ1u
	neQ/0V9Ho4c9dUbK/Yqng9ihB9eGlK9A5jv4WBxWgrKyNaBzO63Z7JbGYtOWhpuMXXGrlzVwWuy
	snptJw3UL/XM0GIsjJQEx+WfCBQTpaNentM+4ZaVzQxMCBOiuixlu6YhrhtGGxH+w/JXLuVAD33
	HCmGbzTrJxDtMy0h9LN1+Y3Uv1MNdc63qocbvqb6JFGpEQQX8M=
X-Received: by 2002:a17:907:e105:b0:c32:465f:826d with SMTP id a640c23a62f3a-c32465fa3cemr482522366b.17.1791830931322;
        Mon, 12 Oct 2026 11:48:51 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9aa5aa7sm488517666b.55.2026.10.12.11.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 11:48:50 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com,
	sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	linux-serial@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	krzk@kernel.org,
	oleg@redhat.com,
	linmag7@gmail.com
Subject: [PATCH v3 5/8] sparc64: validate Fire register properties before initialization
Date: Mon, 12 Oct 2026 20:48:06 +0200
Message-ID: <20261012184826.986050-6-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261012184826.986050-1-linmag7@gmail.com>
References: <20261012184826.986050-1-linmag7@gmail.com>
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

The Fire interrupt translator reads one reg entry, and PCI PBM setup
reads two, without checking that the firmware supplied enough data.

Check the property before allocating the translator or changing PBM
state. Halt early translation on invalid firmware data rather than leave
raw interrupt numbers untranslated. Return an error from PBM setup so
probe can release its allocations.

Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/kernel/pci_fire.c      | 9 +++++++--
 arch/sparc/kernel/prom_irqtrans.c | 8 +++++++-
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/kernel/pci_fire.c b/arch/sparc/kernel/pci_fire.c
index c35a8e3c1eae..db160eeb0ffe 100644
--- a/arch/sparc/kernel/pci_fire.c
+++ b/arch/sparc/kernel/pci_fire.c
@@ -416,7 +416,13 @@ static int pci_fire_pbm_init(struct pci_pbm_info *pbm,
 {
 	const struct linux_prom64_registers *regs;
 	struct device_node *dp = op->dev.of_node;
-	int err;
+	int err, len;
+
+	regs = of_get_property(dp, "reg", &len);
+	if (!regs || len < 2 * sizeof(*regs)) {
+		dev_err(&op->dev, "missing or short reg property\n");
+		return -EINVAL;
+	}
 
 	pbm->numa_node = NUMA_NO_NODE;
 
@@ -429,7 +435,6 @@ static int pci_fire_pbm_init(struct pci_pbm_info *pbm,
 	pbm->op = op;
 	pbm->name = dp->full_name;
 
-	regs = of_get_property(dp, "reg", NULL);
 	pbm->pbm_regs = regs[0].phys_addr;
 	pbm->controller_regs = regs[1].phys_addr - 0x410000UL;
 
diff --git a/arch/sparc/kernel/prom_irqtrans.c b/arch/sparc/kernel/prom_irqtrans.c
index 5752bfd73ac0..558ed5114664 100644
--- a/arch/sparc/kernel/prom_irqtrans.c
+++ b/arch/sparc/kernel/prom_irqtrans.c
@@ -544,13 +544,19 @@ static void __init fire_irq_trans_init(struct device_node *dp)
 {
 	const struct linux_prom64_registers *regs;
 	struct fire_irq_data *irq_data;
+	int len;
+
+	regs = of_get_property(dp, "reg", &len);
+	if (!regs || len < sizeof(*regs)) {
+		prom_printf("%s: missing or short reg property.\n", dp->full_name);
+		prom_halt();
+	}
 
 	dp->irq_trans = prom_early_alloc(sizeof(struct of_irq_controller));
 	dp->irq_trans->irq_build = fire_irq_build;
 
 	irq_data = prom_early_alloc(sizeof(struct fire_irq_data));
 
-	regs = of_get_property(dp, "reg", NULL);
 	dp->irq_trans->data = irq_data;
 
 	irq_data->pbm_regs = regs[0].phys_addr;

