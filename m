Return-Path: <linuxppc-dev+bounces-20036-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1AA8FB44A6
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Apr 2026 05:48:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g227W3Sqvz2xwH;
	Fri, 24 Apr 2026 15:48:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::635"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777009703;
	cv=none; b=CztrUohNZ7nC1smL2pLl1F4jJbQ3PKoSevNtiT6113ua3okiYJudrBxh7iN2TneBpyYLEZsWgh1yfmXDtCuuOJk8rY3lPCbqbbyj7/bqXc+uaC6q+ldOvB4nVh9kCL7v/RzKdr4mOMeP76w7nwkotAMetKKOGcvenqfFdgDeUm0yVmBHxMi96Tbhyqm761v/LbtknI3SqsCpCI7/13PUfve4te47wOpw+iY7TFurJWtM419tYl+3oSXTJpjVDoZxbx8s71iRYwOLJt4KQxTF7yiSS+rN6WARFwnPpjNLmF+ixJv83N71h1pbDVy74SE+uvrL2/z7dNC829xSmT+J2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777009703; c=relaxed/relaxed;
	bh=Ox8HNk2ehgX4u9MIzrQAUilnp/6GJtQsHeC9tfe3Lv8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SH3fkvKIy/4hHyTOCf57D+fwJzL6jzvjVdwUlW0sZ+IrVjlgED1xUaOhuo+SiOIg+/N6R2GbSiXoqvDpqIKpmhns71XyMzt5ITVfklQKV+qky7D5TOdLtdnyNNUJxdFIaDMZ3+jrPNtWfFgv4uUhaCKOlR0ThHy1EgAnrO5gYAiwSjqcbu4h9fLsRZMefWHLEAhBVeNXAzUuQFukYxPfbtsoT1KUmyEhQqo6/vyT8hp4EFyxvsRsfWnkBkwRi1efA99+7NiadNKAWjosTdO3OT4QM1W2PHDatCEMOxIQ1nFV1negf+yvBJ3npSixRuLEjvvaQg73w9o5hmeejraLxQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=K9WghBJM; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::635; helo=mail-pl1-x635.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=K9WghBJM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::635; helo=mail-pl1-x635.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g227V46FFz2xfR
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Apr 2026 15:48:22 +1000 (AEST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-2b2d3a9e149so39983195ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2026 22:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777009700; x=1777614500; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ox8HNk2ehgX4u9MIzrQAUilnp/6GJtQsHeC9tfe3Lv8=;
        b=K9WghBJMGmsi81+6p7iv1F3O6h11MgBrRqomEuTenE+f2T75oVNGj8dKXtiFMttdD4
         XThvCPKz+jmRaR4MaasU7Lpz9JmwolPVkQR4VMO4UTOaVNCRRyLtjmouxE2MreVkhoSe
         XVFvdJUBVgh+3iuyMz/QykUUn6r+mWkp+bu1g3pGXZcIT5AQAtepOuNFtFDj/DbjYzDj
         BrJA5O2EuSCCQMQZCtXf47YxKgf++KSADSmhjuXkUHuQnfl56nmBfInhibcm5Swsg1Ga
         48X19Igeg1xJXlRfNDqWpmQZqwvDu/D2j7qcXle3RIfWX4pKsWaX1doJ29G8Y8uuNFcM
         nbuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777009700; x=1777614500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ox8HNk2ehgX4u9MIzrQAUilnp/6GJtQsHeC9tfe3Lv8=;
        b=KQNaVMOsaPWoMWAG1dlppd9F/dAoU2oZo3Lzcy4JwP6DgYm9SRRCN5z87xY/r8+WVy
         Cu/g3zybFKAo85xBGSNvS7feI9SxhghK9yHeluxNhoMy6IXWyVLFWh4gtdcVrdoVXp6m
         uRSIPauYsia4+LHttfqItpzvv5AeYdCCKM34bcRG3LQ8FzgFqZ8aYCphEheDVrzCtWxQ
         FZEEe+8C+jjYGlC7DSUXxj+BkyWtza3s3/nH/08BKWmlPQCcKVg7Tm9newdzhrAUwzJ6
         QzWvTK1a2jD2123IUH4EgN6/HWCnmKEGCsrUNQGlTvPFk5TYGLkSBGzpp9rcPZtngJp0
         RCbA==
X-Forwarded-Encrypted: i=1; AFNElJ/w8l3rRIkN3o898KuiECJtMizSKbut8LpDVo+qS4Myq/La/OcxOqkJDoI2UsQe2Wz/w9/13pQRd3psLNA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyQnJfsqbnJP+TiIIjKgdH4r8EXoEQqTjy7HVMmhlV0Czt7yH1F
	iRzvbS4hIeX+AIArCrQbsL7Uqa205MllMqAgvTMwNbzSXSB6vIqoePJU
X-Gm-Gg: AeBDiesXqS/LVhP5DdCY5tTVSpTyu0p02mVc/xyak8tXptiriIcSxvoNbxPrcjX55OH
	2YVnRH+nq6s+nr9OBGgwqzjQOh8JakthPHNbmDOZ7lLoDEVsV3dO5TkADRIEhdPCeM7NNy5RpNm
	sSr3I+O3Lz7O1VGOUuYxS3eczEfeU397wJMGwkwIU+GFVEjkItljPPa7dEBSKJa0EEquIs1y6If
	GGo55OUhjETS57CWFw5dzjNO7p2TndH4/1AwMcU4521gzg0MEsQrQW1qHEKkvUp54JFzi9jMtTw
	dx3kcD+R54GaMe25ThuLXXfT1Ujk6T/PNcpb0CIAgN/dnFYPWtqlBHRY7Oy/K0LjXsBKqY8fmAW
	bb3vQB1/XqUJMo+871P4wTtFicuU8SP5odCmgrSi5+nbM50lUz+UDIsaZhod1OPtsmo9Rhs6/nu
	9w3VqU3dBgdCKuzrMHQVE3ps3gJt849OgTn1cAwfw9RUBEz4HMX6PsXDLB5tSs268tUkC9ixaCa
	LobLIUgCOwznm4=
X-Received: by 2002:a17:902:d591:b0:2b0:badc:c9cf with SMTP id d9443c01a7336-2b5f9e18812mr226513645ad.13.1777009699637;
        Thu, 23 Apr 2026 22:48:19 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.bl1-in.ibm.com ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5faa176e9sm208778245ad.20.2026.04.23.22.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 22:48:19 -0700 (PDT)
From: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
To: maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	peterz@infradead.org,
	jpoimboe@kernel.org,
	jbaron@akamai.com,
	aliceryhl@google.com,
	rostedt@goodmis.org,
	ardb@kernel.org,
	sumit.semwal@linaro.org,
	christian.koenig@amd.com,
	ojeda@kernel.org,
	boqun@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	tmgross@umich.edu,
	dakr@kernel.org,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	morbo@google.com,
	justinstitt@google.com,
	tamird@kernel.org,
	arnd@arndb.de,
	nsc@kernel.org,
	mkchauras@gmail.com,
	simona.vetter@ffwll.ch,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	rust-for-linux@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH V13 2/7] dma-resv: Fix undefined symbol when CONFIG_DMA_SHARED_BUFFER is disabled
Date: Fri, 24 Apr 2026 11:17:37 +0530
Message-ID: <20260424054742.45832-3-mkchauras@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424054742.45832-1-mkchauras@gmail.com>
References: <20260424054742.45832-1-mkchauras@gmail.com>
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

When building with LLVM=1 for architectures like powerpc where
CONFIG_DMA_SHARED_BUFFER is not enabled, the build fails with:

  ld.lld: error: undefined symbol: dma_resv_reset_max_fences
  >>> referenced by helpers.c
  >>>               rust/helpers/helpers.o:(rust_helper_dma_resv_unlock)

The issue occurs because:
1. CONFIG_DEBUG_MUTEXES=y is enabled
2. CONFIG_DMA_SHARED_BUFFER is not enabled
3. dma_resv_reset_max_fences() is declared in the header when
   CONFIG_DEBUG_MUTEXES is set
4. But the function is only compiled in drivers/dma-buf/dma-resv.c,
   which is only built when CONFIG_DMA_SHARED_BUFFER is enabled
5. Rust helpers call dma_resv_unlock() which calls
   dma_resv_reset_max_fences(), causing an undefined symbol

Fix this by making the function declaration conditional on both
CONFIG_DEBUG_MUTEXES and CONFIG_DMA_SHARED_BUFFER. When either is
disabled, use a static inline stub instead.

Fixes: 0c6b522abc2a ("dma-buf: cleanup dma-resv shared fence debugging a bit v2")
Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
---
 include/linux/dma-resv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/dma-resv.h b/include/linux/dma-resv.h
index c5ab6fd9ebe8..23c8db0b5214 100644
--- a/include/linux/dma-resv.h
+++ b/include/linux/dma-resv.h
@@ -311,7 +311,7 @@ static inline bool dma_resv_iter_is_restarted(struct dma_resv_iter *cursor)
 #define dma_resv_held(obj) lockdep_is_held(&(obj)->lock.base)
 #define dma_resv_assert_held(obj) lockdep_assert_held(&(obj)->lock.base)
 
-#ifdef CONFIG_DEBUG_MUTEXES
+#if IS_ENABLED(CONFIG_DEBUG_MUTEXES) && IS_ENABLED(CONFIG_DMA_SHARED_BUFFER)
 void dma_resv_reset_max_fences(struct dma_resv *obj);
 #else
 static inline void dma_resv_reset_max_fences(struct dma_resv *obj) {}
-- 
2.53.0


