Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8958606A6B9
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2026 08:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KEsAWcHv
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZqJc0SLcz2xns;
	Thu, 26 Nov 2026 19:21:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::432"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795681295;
	cv=none; b=bkGMk1klhLL3sQtY2JKXNppxOiUZpURZ4lDb7J0tfiMueoplod055zP6kfwesq9K97AdiQfHQgq8EVPDd9hGDetaQGQklJ5SyxuL0EltaXohMUDTsXf9YWmzuQvpKWbqUYWuN0kW4GiymSmPOsJMfG4WYIqNA/IUVXKauWDOqhuaGC7Ojp7YmmQyh6TA/SqGqOfVc5BP8AeJ8AOfu9c9t7y22RhWf94BGgLZ1NpkSG2uF2/P7pYlSD8JkM9jZPdQYPoEQV/U7GuQkB/KR8yR58nZxZKN2Sbo+siJoUrUCuU92wgqEBeSXzeWRJUpMotHxKPHhvNA79OW1q0whAZ5+w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795681295; c=relaxed/relaxed;
	bh=WT3cQ/tGuI3u/ymiGwGvMWdg9a6EnaubOAZTrPqjTqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cfYsUaY41fqwKXAGpq55uIW5xHxOSb2OFwl/epu7fR9qaNnXsv3gjEewZvHUOIOTpA1vGTNQPC9Ef0XWZxEkd8JKJM3RYvRkITYcFWkNSc1N0dNBxYynZy/ppvMrkDQRr60vNDUxxuAxQwu99fSD6mXb8VOvZ8t4sDTGGvvyzcHQr8RWfqYpK2M9WucFdtDwR0HuSVDgsSfkyzcrzlAfOHvaRQ/2Nt11QXN8f7uir31AT9DGzcqRPSol5eiQ8CT+u8PyNumLYRjHroScLq/6Vz1hPV764isLhKGM0cmeKGzLkV5xL2u5HjRMUYfV/IH8AY2RobScnWlba3H38m1Xpw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KEsAWcHv; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::432; helo=mail-wr1-x432.google.com; envelope-from=fourier.thomas@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KEsAWcHv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::432; helo=mail-wr1-x432.google.com; envelope-from=fourier.thomas@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZqJZ4qnRz2xjP
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 19:21:33 +1100 (AEDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-4a3ac4ac65bso331159f8f.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 00:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795681289; x=1796286089; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WT3cQ/tGuI3u/ymiGwGvMWdg9a6EnaubOAZTrPqjTqQ=;
        b=KEsAWcHvfZ/LJKtvLJJ3OZYlDHyDbx3mF5caIHp1kzs9iSnoNApyLWgnZU5Z0toUK+
         D/PfCFVJAnXUB6rtgzdjhw5Hma3TO7HkR/8EWpnXNuQkR2g7txwtdWRh7cZXFA5S58sQ
         CRqFDdtceNmtLg4gtBgdBM3RJYM09hjep2Qc1GfpNd/LRg3AqYADlUEaNPqI4qqR89BS
         HuXPY+1LbPXZoQAqnFiOWb0IZMRWn3EgS74dv//ib0JNEv0+uKoemR2fISBgvmXEoWU/
         SScpGAZCfNJxEp2AEkuR2lEO+dY4MCzMwdXQqgndhdsr6cJw5W1L2tt+tPzJMBDG4LFC
         y5uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795681289; x=1796286089;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WT3cQ/tGuI3u/ymiGwGvMWdg9a6EnaubOAZTrPqjTqQ=;
        b=ySIklXFTv8WdZjIRQ4jbsiksthaAnvxfIA+O4sbTbckkORsNeEIa6QtWQ75fxN1T6c
         a0blnpe5cRdiBFvNC1zUI7Agrb1TsYkbhbRf/rCEY1Avpfkh/rN9zWECz6qqiL0MDaZo
         KAusKbd5c99KVZwmkYS9wmAjOWDgcf5B5cQNEpxUSv5YL1Lvj8kSjdrVJnFEL6WsvasY
         AONkokHhf45JFcFkakcs17aOv+gAUGG8z8p99tCBbpd+8sd5Lbmn9gCnDZrqwEoEuo5i
         hb1MNqnDljFnlqPQ22g7N4KtAhC0acxxYP1xQ5U3q7gEaU2+cAFRK8OSXOIHIWut698d
         JuZA==
X-Forwarded-Encrypted: i=1; AL+hErHXMd7IjJoCjXBpgV8q3QzuuAQR75lKZsg02P/km50c7f0LfLioie97Sxr7won+qaaiHE7v0H6uUtTpmNI=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/nH2pmzBZzSOxk3GZhA5eX6czVKyLWh6Qkd4ybo5TVCWxtzejL
	x2D0y6aAlsIIvh+AxXY9yJoYZv9cUtJNwVXBJE4Hwb4ZJJ9klkpUefbz
X-Gm-Gg: AZFdTZeIuAvUBvWqbNX6Ht8PIJ2UjS3Z/+nTJDeh3phAW0dFMsQQMzGcPrppboI212D
	1TPkFKXgIKVGqcZkaUGHyW+zFFcEvQgPrIE0CtdqjOXMEUpnGMHT9Hzbt7TNV3E/rP+KIlokWZE
	bEDktspKZT5vfSdh/Is32qxS1f/frgp+IRzZTW2MYtq1obpqU5Vgkw3xaUI4TRdNkYwkAnaekZS
	hNThC3CUjS9AbrN77wu6Uh+i2047AUS5lD5E9TG8K+5Scdn24bkshDl62diMQC6NCFLtL6/zGYD
	ZQHIMW9Ly66UER14Oy9LzwlRtxipT6jVrvDgGV45lM4RwksXoA+Qe6hBCSF/9sBR6xMPEbLJATG
	8+B/dy3q6YbWxYog7JzyKtkfPZCgAcBT8yMsq1v3I3IWezKApX1pEQ6Ihxme3P8SzXssKZrHTNh
	d9O50QFQxvGmvK5PSAdlSikqpUcYzxe7fGamdefrPfGMk+13Lfk/2OOoly8efCBdjR5DPUWthVZ
	CuufKGiuDYjWJwW0p6ybScykK7cQ5eGOBg6s7F7bphCQWRaenFDp2du1qf8hvfFeImYzG5PJB9p
	P9bGZbgjqHKnVXdWX5ctr3nrCbcp/j9f5qmBb+R+iODuxUw2LXnrRORVtLU5QZx/y+yxNnBi/F/
	rbjZ9dhKlPiqMgMG80eE=
X-Received: by 2002:a05:6000:22c1:b0:48d:f1b3:7e82 with SMTP id ffacd0b85a97d-4aba531f89cmr44694047f8f.0.1795681288471;
        Thu, 26 Nov 2026 00:21:28 -0800 (PST)
Received: from thomas-precision3591.paris.inria.fr (wifi-pro-83-006.paris.inria.fr. [128.93.83.6])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-4ab658e2c8csm40094282f8f.2.2026.11.26.00.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 00:21:28 -0800 (PST)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Olof Johansson <olof@lixom.net>,
	Jeff Garzik <jeff@garzik.org>,
	linuxppc-dev@lists.ozlabs.org (open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] powerpc/pasemi: Fix pasemi_dma_free_buf()
Date: Thu, 26 Nov 2026 09:16:27 +0100
Message-ID: <20261126081637.13160-2-fourier.thomas@gmail.com>
X-Mailer: git-send-email 2.53.0
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

dma_free_coherent() is called with the wrong arguments. The two last
arguments must be the virtual address and the DMA address but the
DMA address and the allocation flags are passed. If this function were
called, it would call kfree() on a DMA address and dma_unmap() on the
allocation flag.

Add the buffer argument to pasemi_dma_free_buf() and pass the right
arguments to dma_free_coherent().

Fixes: 8ee9d8577935 ("pasemi: DMA engine management library")
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
 arch/powerpc/include/asm/pasemi_dma.h   | 2 +-
 arch/powerpc/platforms/pasemi/dma_lib.c | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/pasemi_dma.h b/arch/powerpc/include/asm/pasemi_dma.h
index 712a0b32120f..9285a38ff18a 100644
--- a/arch/powerpc/include/asm/pasemi_dma.h
+++ b/arch/powerpc/include/asm/pasemi_dma.h
@@ -508,7 +508,7 @@ extern void pasemi_dma_free_ring(struct pasemi_dmachan *chan);
 extern void *pasemi_dma_alloc_buf(struct pasemi_dmachan *chan, int size,
 				  dma_addr_t *handle);
 extern void pasemi_dma_free_buf(struct pasemi_dmachan *chan, int size,
-				dma_addr_t *handle);
+				void *buf, dma_addr_t *handle);
 
 /* Routines to allocate flags (events) for channel synchronization */
 extern int  pasemi_dma_alloc_flag(void);
diff --git a/arch/powerpc/platforms/pasemi/dma_lib.c b/arch/powerpc/platforms/pasemi/dma_lib.c
index 1be1f18f6f09..d33feb32c0a1 100644
--- a/arch/powerpc/platforms/pasemi/dma_lib.c
+++ b/arch/powerpc/platforms/pasemi/dma_lib.c
@@ -356,14 +356,15 @@ EXPORT_SYMBOL(pasemi_dma_alloc_buf);
 /* pasemi_dma_free_buf - Free a buffer used for DMA
  * @chan: Channel the buffer was allocated for
  * @size: Size of buffer in bytes
+ * @buf: Virtual address of the buffer
  * @handle: DMA handle
  *
  * Frees a previously allocated buffer.
  */
-void pasemi_dma_free_buf(struct pasemi_dmachan *chan, int size,
+void pasemi_dma_free_buf(struct pasemi_dmachan *chan, int size, void *buf,
 			 dma_addr_t *handle)
 {
-	dma_free_coherent(&dma_pdev->dev, size, handle, GFP_KERNEL);
+	dma_free_coherent(&dma_pdev->dev, size, buf, *handle);
 }
 EXPORT_SYMBOL(pasemi_dma_free_buf);
 
-- 
2.53.0


