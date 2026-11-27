Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E65606A32E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Nov 2026 09:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Rh7fnU3m
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jbSY62Jfkz2yMP;
	Fri, 27 Nov 2026 20:19:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::429"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795771178;
	cv=none; b=HvwbtZtgf6tqDhLOERx/YHM4EpJuMiaSpTHNszDv74PgRx+shOV4dZV/OTkSJjHwAKceX+Bl9bg/EAcqHpwjqoh5hYd6NEmj9XBRDwdV9rS/Yqf9vQ2gyZztHhNn/3T4U+avmo3Xfxqi8yH1JD2QG8bik0uiyN65e8lcFKyUnAdOEvRlY8UEQrddwefcRAVGHYCTx5ED/wXNEPFWM7qqEXEx4g0JDPCsZt/Yi1Rz7uFEIp1XGYcJpseyAP/dIU39GYIHMx+Zorms3mqvFtFYiWesUSTHg5zmhVC3Rbo4Aok60sXsiD+0gf+wVYOp6O4Ugn6SFl+x1Xu4SXK8NeXQdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795771178; c=relaxed/relaxed;
	bh=ybRI/ts32jMrMimcIQY5ueXv6UCOl48wZhIdKBw+kZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RF7k4L1lEMzm9gQuWENXilxpQx2oejTapWODg1y7dpeNNeUovDlZnAv6en1QeZ6qLENgZ0y60BJig7Lfb4djXW77/rAORz0Ai2J1ydH5XMm6osxUfOKNokXtgb2F7duTSA4XWUzzuwHtkL3sdAmf7NpnxahJrPUoyLfd7aurFgn0ma9ShqORthlWoEuqFmDUhOQy8/lNciQ+vnuVXtBdP4R+5gdz4eZLisF0CzyID07AUPuemLLdJl3TfcFQssE1r3avDkCtGCGOcQlUdJCbWn66oAhyuKjt58o2zb7yl3sOrhzk9O/ijeUzZ7MIp1PACyviTb/OEMl3/DqroV8/Lg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Rh7fnU3m; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::429; helo=mail-wr1-x429.google.com; envelope-from=fourier.thomas@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Rh7fnU3m;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::429; helo=mail-wr1-x429.google.com; envelope-from=fourier.thomas@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jbSY44q06z2xlY
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2026 20:19:35 +1100 (AEDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-4a511d8a394so852331f8f.3
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2026 01:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795771170; x=1796375970; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ybRI/ts32jMrMimcIQY5ueXv6UCOl48wZhIdKBw+kZQ=;
        b=Rh7fnU3m0hxH3ioqvodFqt7+WL95YKDjmykZP8b65ixE7b1DOitDKiR/9TYSymd+TM
         PbgJ7uxPrsSggVhMJm1bagSpSqxRAn2cLNDB87EvB3JxTQ1n/bo010u7oAyZ+p12RLtc
         ou87ptvI1zJ6VyZxkV31NBy4s75pv1Kzn69MbsRbS6kAD+jkhG6eLRM8dUoeEosIS3fX
         qVVAAnVQHI13i7ZBT+nbqaO4Hgp8RB5noqWAVf3dC2hPJSewBAduTpMcKlNLpti1Hwxm
         /BnlFLgGL1FnxINJNjGT3n9izMIlSTbf8/CXZ5fI+juYH6YwLHZOgTsSgy7ft6v6dNiB
         uhlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795771170; x=1796375970;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ybRI/ts32jMrMimcIQY5ueXv6UCOl48wZhIdKBw+kZQ=;
        b=g4kCHHt9ZNk8q3ZOBiUR425uXJ/6ClaNZpmNPUBNgwSFEFPayO3mDz7Ln8GvOLae9U
         c1TzHEwNK5S5vQZM+qSccsmK5ct4pm7wIqAdJqhGE2PwvGJQZzHXert6QfmLHLUWXlRe
         Ll5dfO0AoiBwCc3RFNJeGkjsS4SZ0QIKhzRLkeeHcQDMpoYqwRVcPVtDwwDmucwAYbTB
         32UetGiDvVNn0d7C/9yj89D0D4HbZQNLA876fyI1g9GOwkX9t8GUTZrXjvVXREt0qJ0n
         6bBQs517eXtbAs83wpRLHD5kw4nkEN2r4sNTGxEPnp+/ukTmFposVL782vbqX7Hbq0oE
         xgZw==
X-Forwarded-Encrypted: i=1; AL+hErGnzjPulPuKyBekjeAC+W6QS8MDmzpr080QNoqX9GtdqORjQrVovwK3DDf/n+GnG1PzqWQsSDqVRyxQZQ4=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+n44VbRniqmsj7n212b27G6Qz6+NNvSXDFAWJ/V8Ti6z1LJSBb
	Qk2b8h3yR61YPe7QtSoSgsQZJ7rIebGvOJJ8duBDEGalwX8qVhBPToBs
X-Gm-Gg: AZFdTZez46R5C7BoX6bu48MtlWImqgHyBmFcPIQF4Uhwa0S/ebcTkLM8O48IuQWaQ3B
	4iYwGW6o4E5MFxF8Xr6o6/7ebCUx1RuFx7DgNhVhZfwD8XUEN6w31rSnOAVPqdGB4xtP9si/8bR
	PZZ0Damk7kDNSwgmrFoTmBuHAgMrIZEvTaRV0iR+9G8kbj1/CR0b+TkYW5O8xyY2aNDH3dwnSl0
	cN5eCxN0fpEIMsgvTJgc/GW7vyPdOJKwSdqbcEEKJuu3tDrZHEhuAtKVEuL70P64eRm464DU0A5
	DXPOS1L1YCvqqU8xexpDTDJOKSTPRlSqf8DbX8rvqOueFr1LnxE6ksQ15nehA7YCQFCM4L3V3oO
	r1XBRQWNGL+a9kUd7BAZjk05RsQXfh+2Pm10SWbEU3Sl8y2UZ/r6mNtTb8cCXZwRBohKNVvb7e+
	yZFAAfdY6e7N1WfBzaSzXtaEfN+q92QrkoBWSI3/kCgBt+1Qbe45WzhYjQSigSD+WubaBd5PGZC
	uGGUvlLe1/kGflvaxcRd7PMerygqGBvazYg7BGSjq7Q1wXQcbLJm/s1KvUeomc+KZfz4Y6FbPYP
	e3/vZ5H2H2RUNA6giQknCxTDMuItpVRH1koZyO36rr35xGuAasOy6MoGixEBAlvigQwiYJSRXQ0
	mjXqSXIrm0cgfBwq2OEE=
X-Received: by 2002:a05:600c:8284:b0:4bb:6c01:de9c with SMTP id 5b1f17b1804b1-4bb887f55c1mr428075425e9.2.1795771170214;
        Fri, 27 Nov 2026 01:19:30 -0800 (PST)
Received: from thomas-precision3591.paris.inria.fr (wifi-pro-83-006.paris.inria.fr. [128.93.83.6])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4bb884b7515sm926247635e9.13.2026.11.27.01.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 01:19:29 -0800 (PST)
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
Subject: [PATCH v2] powerpc/pasemi: Remove pasemi_dma_alloc_buf() and pasemi_dma_free_buf()
Date: Fri, 27 Nov 2026 10:11:55 +0100
Message-ID: <20261127091206.13045-2-fourier.thomas@gmail.com>
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

Remove pasemi_dma_alloc_buf() and pasemi_dma_free_buf() as these
functions are not used.

Fixes: 8ee9d8577935 ("pasemi: DMA engine management library")
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
v1->v2:
  - remove the functions instead of fixing them

 arch/powerpc/include/asm/pasemi_dma.h   |  5 ----
 arch/powerpc/platforms/pasemi/dma_lib.c | 31 -------------------------
 2 files changed, 36 deletions(-)

diff --git a/arch/powerpc/include/asm/pasemi_dma.h b/arch/powerpc/include/asm/pasemi_dma.h
index 712a0b32120f..bb2c347dfec2 100644
--- a/arch/powerpc/include/asm/pasemi_dma.h
+++ b/arch/powerpc/include/asm/pasemi_dma.h
@@ -505,11 +505,6 @@ extern int pasemi_dma_stop_chan(const struct pasemi_dmachan *chan);
 extern int pasemi_dma_alloc_ring(struct pasemi_dmachan *chan, int ring_size);
 extern void pasemi_dma_free_ring(struct pasemi_dmachan *chan);
 
-extern void *pasemi_dma_alloc_buf(struct pasemi_dmachan *chan, int size,
-				  dma_addr_t *handle);
-extern void pasemi_dma_free_buf(struct pasemi_dmachan *chan, int size,
-				dma_addr_t *handle);
-
 /* Routines to allocate flags (events) for channel synchronization */
 extern int  pasemi_dma_alloc_flag(void);
 extern void pasemi_dma_free_flag(int flag);
diff --git a/arch/powerpc/platforms/pasemi/dma_lib.c b/arch/powerpc/platforms/pasemi/dma_lib.c
index 1be1f18f6f09..d6ce553c53bf 100644
--- a/arch/powerpc/platforms/pasemi/dma_lib.c
+++ b/arch/powerpc/platforms/pasemi/dma_lib.c
@@ -336,37 +336,6 @@ int pasemi_dma_stop_chan(const struct pasemi_dmachan *chan)
 }
 EXPORT_SYMBOL(pasemi_dma_stop_chan);
 
-/* pasemi_dma_alloc_buf - Allocate a buffer to use for DMA
- * @chan: Channel to allocate for
- * @size: Size of buffer in bytes
- * @handle: DMA handle
- *
- * Allocate a buffer to be used by the DMA engine for read/write,
- * similar to dma_alloc_coherent().
- *
- * Returns the virtual address of the buffer, or NULL in case of failure.
- */
-void *pasemi_dma_alloc_buf(struct pasemi_dmachan *chan, int size,
-			   dma_addr_t *handle)
-{
-	return dma_alloc_coherent(&dma_pdev->dev, size, handle, GFP_KERNEL);
-}
-EXPORT_SYMBOL(pasemi_dma_alloc_buf);
-
-/* pasemi_dma_free_buf - Free a buffer used for DMA
- * @chan: Channel the buffer was allocated for
- * @size: Size of buffer in bytes
- * @handle: DMA handle
- *
- * Frees a previously allocated buffer.
- */
-void pasemi_dma_free_buf(struct pasemi_dmachan *chan, int size,
-			 dma_addr_t *handle)
-{
-	dma_free_coherent(&dma_pdev->dev, size, handle, GFP_KERNEL);
-}
-EXPORT_SYMBOL(pasemi_dma_free_buf);
-
 /* pasemi_dma_alloc_flag - Allocate a flag (event) for channel synchronization
  *
  * Allocates a flag for use with channel synchronization (event descriptors).
-- 
2.53.0


