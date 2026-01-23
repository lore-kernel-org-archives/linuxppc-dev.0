Return-Path: <linuxppc-dev+bounces-16189-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBE04D6CFBD
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Jan 2026 06:08:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dy6t61zgWz3bll;
	Fri, 23 Jan 2026 17:07:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=159.226.251.84
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769148478;
	cv=none; b=ZkpBw0uwXPVba1BKYb9mI2bKFIQPs+iO7wZK/epmYqqyx8X+/Lf/5TiiMwD35iZdlZ6GrvwH+tF0jhw2mqBIznxBOKwU3U7+RmteuTxW+Kg7bjT4FVBWwHe0OzhVqDuTnYhLwOAq+H/3TuZm6rLteUa+9VnnILOfVPfnPCTUGlBEoZYUTtAtHqc5r5n5UbsGyKS5YuQQEpt/M9cx1BR99jN5jrA+61Se3htwYw9uEBp7AGnOHiKyy2fdmRyTLvqpYVCOrQlj64qViCRZ/usIaXtRSOIb8cZ2EknDbpZv8xfAdzliXWOY8kvpgF19Yb/8diQokveXqwBJBO/efBikxA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769148478; c=relaxed/relaxed;
	bh=Z+9caVik8imxXhz/kfL5t9h1pnvPAAvM2jsiUjE02c4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gCw9begaR+7Cj3iZDq9mxnXgQPoebkZ7KLpsUG94CckUZM0ikjRJg5KyM8tL0FUyIe0KiUZsp+6izrQN0oXOvaQlu6W5ybp8PZRT3HlIafYD+mVLG1Gtyt/h6zIV+9XawwUbTaHjRTBgHd1A+I+hk6ieIz2i1I9LR3GhaUTbciCMgxUXso7lJ89mj/244/PVrmnEOX8EHt2827ogrNvYOWx1rGAug5UBLtWDI3Lub8xV0bbQQ2JGmthE4vBaoaxwl5ILO4wL4fdSoJXIJfsZSR18avjBb5NjhDY24Rb1tyTjl2Wyp8AW9rqgBf7a+4h3xRLL9kS5CXKItbJ/oBoNUQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass (client-ip=159.226.251.84; helo=cstnet.cn; envelope-from=wangruikang@iscas.ac.cn; receiver=lists.ozlabs.org) smtp.mailfrom=iscas.ac.cn
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=iscas.ac.cn (client-ip=159.226.251.84; helo=cstnet.cn; envelope-from=wangruikang@iscas.ac.cn; receiver=lists.ozlabs.org)
Received: from cstnet.cn (unknown [159.226.251.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dy6t31Y03z2yF1
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jan 2026 17:07:54 +1100 (AEDT)
Received: from [127.0.0.2] (unknown [210.73.43.101])
	by APP-05 (Coremail) with SMTP id zQCowACnPBAiEHNp9tMuBg--.1678S5;
	Fri, 23 Jan 2026 14:07:32 +0800 (CST)
From: Vivian Wang <wangruikang@iscas.ac.cn>
Date: Fri, 23 Jan 2026 14:07:30 +0800
Subject: [PATCH v3 3/4] drm/radeon: Raise msi_addr_mask to dma_bits
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
Message-Id: <20260123-pci-msi-addr-mask-v3-3-9f9baa048524@iscas.ac.cn>
References: <20260123-pci-msi-addr-mask-v3-0-9f9baa048524@iscas.ac.cn>
In-Reply-To: <20260123-pci-msi-addr-mask-v3-0-9f9baa048524@iscas.ac.cn>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 "Creeley, Brett" <bcreeley@amd.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>
Cc: Han Gao <gaohan@iscas.ac.cn>, Vivian Wang <wangruikang@iscas.ac.cn>, 
 Thomas Gleixner <tglx@kernel.org>, linuxppc-dev@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, netdev@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-sound@vger.kernel.org, 
 linux-riscv@lists.infradead.org, sophgo@lists.linux.dev
X-Mailer: b4 0.14.3
X-CM-TRANSID:zQCowACnPBAiEHNp9tMuBg--.1678S5
X-Coremail-Antispam: 1UD129KBjvJXoW7tF4kGw13JrWxWr48KF4rKrg_yoW8ZF43pF
	43GFZxtrZIy3WUKay2kay7ZF15Aa18KayrWr4DG39xua45AryUCry3Z3y3J34kXrykXr42
	qr18G3y5uF1FvF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm214x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVF
	xhVjvjDU0xZFpf9x0pRVVbgUUUUU=
X-Originating-IP: [210.73.43.101]
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

The code was originally written using no_64bit_msi, which restricts the
device to 32-bit MSI addresses.

Since msi_addr_mask is introduced, use DMA_BIT_MASK(dma_bits) instead of
DMA_BIT_MASK(32) here for msi_addr_mask, describing the restriction more
precisely and allowing these devices to work on platforms with MSI
doorbell address above 32-bit space, as long as it is within the
hardware's addressable space.

Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>

---
v3: No changes
---
 drivers/gpu/drm/radeon/radeon_device.c  |  1 +
 drivers/gpu/drm/radeon/radeon_irq_kms.c | 10 ----------
 2 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_device.c b/drivers/gpu/drm/radeon/radeon_device.c
index 60afaa8e56b4..5faae0361361 100644
--- a/drivers/gpu/drm/radeon/radeon_device.c
+++ b/drivers/gpu/drm/radeon/radeon_device.c
@@ -1374,6 +1374,7 @@ int radeon_device_init(struct radeon_device *rdev,
 		pr_warn("radeon: No suitable DMA available\n");
 		return r;
 	}
+	rdev->pdev->msi_addr_mask = DMA_BIT_MASK(dma_bits);
 	rdev->need_swiotlb = drm_need_swiotlb(dma_bits);
 
 	/* Registers mapping */
diff --git a/drivers/gpu/drm/radeon/radeon_irq_kms.c b/drivers/gpu/drm/radeon/radeon_irq_kms.c
index d550554a6f3f..839d619e5602 100644
--- a/drivers/gpu/drm/radeon/radeon_irq_kms.c
+++ b/drivers/gpu/drm/radeon/radeon_irq_kms.c
@@ -245,16 +245,6 @@ static bool radeon_msi_ok(struct radeon_device *rdev)
 	if (rdev->flags & RADEON_IS_AGP)
 		return false;
 
-	/*
-	 * Older chips have a HW limitation, they can only generate 40 bits
-	 * of address for "64-bit" MSIs which breaks on some platforms, notably
-	 * IBM POWER servers, so we limit them
-	 */
-	if (rdev->family < CHIP_BONAIRE) {
-		dev_info(rdev->dev, "radeon: MSI limited to 32-bit\n");
-		rdev->pdev->msi_addr_mask = DMA_BIT_MASK(32);
-	}
-
 	/* force MSI on */
 	if (radeon_msi == 1)
 		return true;

-- 
2.52.0


