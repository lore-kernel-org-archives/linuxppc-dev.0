Return-Path: <linuxppc-dev+bounces-16377-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55D12D46C01
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Jan 2026 01:56:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f1j1T0zyLz2yql;
	Thu, 29 Jan 2026 12:56:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=159.226.251.84
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769651805;
	cv=none; b=V6wujMHjIPw8ivJm/ELBONXfas+4H8wK/ToVGSYb34hIkgDyaFPTNVgpy6dBOSoDcEz/cSqGy0jQsm72f5LjvU3gfLFOjjfbMSzXRR9YTGmsevUfhGdw2lkE5uImwEVw+yILr5p5ce3WMRYKxtmofqvN4G7tGb+hC8YmvwF63h0ECVD/jYQLWmqh8KdI4PuzqKdrlxEL5CeKbhLYB6mu40bGX1lJPOHu4PnbdVQdTGwUsY+uJ451aDieJ52eRn2U7HrrUp9VebndKxJtROkkQ9SRflFa6LBr97/H/nf7yXYklsSTdk8PxsLxzUpKDXf/oFt6s4MdGmme0PoHna27HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769651805; c=relaxed/relaxed;
	bh=vw+pChxJjqs1bw+TXSQM5tT3iMUiOEitRzwi3TrzQjI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ILTNvHi+I5bUehavB5zdCqtlXrEBsyOS/1COpKjI61eCXpMHCbiB9FF0lZdMcqkzBGgdHXRTFc30tcowbpJfxBZcA+wSSuzPk4RJ0j4TMJs1mgdokP8lOVOHGkpmQn/LNApIKbl89IvQDVu0HHYMph8hnVhrvxiov6xsW9rDahhXRoui/goo3evr4uQEOkHRZyKzvTG9dwrqy5P/70/66kpJ6mio7266uF2E+8PJmvMCEn62HOb/IIhp3z49T/+Fp0DHTtA5uxL8xKIbrFrYpWNbkCwtXbH3jSuctyQxhmm/K4rePZ9OUQeH5j1vN6iLGJ2Eeyd2TBiDtWUzIlAgpQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass (client-ip=159.226.251.84; helo=cstnet.cn; envelope-from=wangruikang@iscas.ac.cn; receiver=lists.ozlabs.org) smtp.mailfrom=iscas.ac.cn
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=iscas.ac.cn (client-ip=159.226.251.84; helo=cstnet.cn; envelope-from=wangruikang@iscas.ac.cn; receiver=lists.ozlabs.org)
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f1j1S06qFz2ydq
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jan 2026 12:56:42 +1100 (AEDT)
Received: from [127.0.0.2] (unknown [210.73.43.101])
	by APP-05 (Coremail) with SMTP id zQCowAAntwpDvnpps5z0Bg--.39391S5;
	Thu, 29 Jan 2026 09:56:20 +0800 (CST)
From: Vivian Wang <wangruikang@iscas.ac.cn>
Date: Thu, 29 Jan 2026 09:56:08 +0800
Subject: [PATCH v4 3/4] drm/radeon: Raise msi_addr_mask to dma_bits
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
Message-Id: <20260129-pci-msi-addr-mask-v4-3-70da998f2750@iscas.ac.cn>
References: <20260129-pci-msi-addr-mask-v4-0-70da998f2750@iscas.ac.cn>
In-Reply-To: <20260129-pci-msi-addr-mask-v4-0-70da998f2750@iscas.ac.cn>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Brett Creeley <brett.creeley@amd.com>
Cc: Han Gao <gaohan@iscas.ac.cn>, Vivian Wang <wangruikang@iscas.ac.cn>, 
 Thomas Gleixner <tglx@kernel.org>, linuxppc-dev@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, netdev@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-sound@vger.kernel.org, 
 linux-riscv@lists.infradead.org, sophgo@lists.linux.dev
X-Mailer: b4 0.14.3
X-CM-TRANSID:zQCowAAntwpDvnpps5z0Bg--.39391S5
X-Coremail-Antispam: 1UD129KBjvJXoW7tF4kJF1UWF4fAr15JrWfuFg_yoW8Zw1kpF
	43GFZxtr9Iy3WUKa9Fkay7ZF15Aa1FkayfXr4DG39I9a4YyryUCry3Zw43J34kXr1kXr42
	qr18G3y5uF1FvF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQY14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxd
	M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
	v20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
	F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
	IY04v7MxkF7I0En4kS14v26r4a6rW5MxkIecxEwVAFwVWkMxAIw28IcxkI7VAKI48JMxC2
	0s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI
	0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE
	14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7sRRiF4JUUUUU==
X-Originating-IP: [210.73.43.101]
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

The code was originally written using no_64bit_msi, which restricts the
device to 32-bit MSI addresses.

Since msi_addr_mask is introduced, use DMA_BIT_MASK(dma_bits) instead of
DMA_BIT_MASK(32) here for msi_addr_mask, describing the restriction more
precisely and allowing these devices to work on platforms with MSI
doorbell address above the 32-bit limit, as long as it is within the
hardware's addressable range.

Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>

---
v4: Patch message rewording for more consistency
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


