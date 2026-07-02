Return-Path: <linuxppc-dev+bounces-23376-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00D82C43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Jul 2026 08:57:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4grW3j4xhsz2xPb;
	Thu, 02 Jul 2026 18:57:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::435"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782961550;
	cv=none; b=X35teudGyzE3fgSHJBbHsXacgWvRjyYBrVg8J8dL9cyiluMYPKGq1lT/A7RI4tpXtHDGWZfXvPj6wIX7z/s6UCSibCcNStWNCSCVgassPmRflSTy66HaDTAfLagCrhHFZNue0rQjV6rxHYPyUmnq+9Qx3wmI08v4tPjSQMF+1I39GuWWTmI9I97rpf9SCaAGPhv78UFFuQq3Z0nvhG88CG532L7VTqtuLWyKKDm8djqolEDHa2RbYYa2FrMucuJkevOz8jvO75fk2fgQGlwUnI+nnGU0BJTFLF0WRlR5DfLNZnTqDluNGzLveAAIOxBw9krfKMYYpTaSCbl/28GQIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782961550; c=relaxed/relaxed;
	bh=ftPCUxA6Cux0mzU9qrlo7eK7xG8fUg3zJ+4KXq7SPJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jr732hWuYvgSJ7Z2qRG6mV85auNYJ2DFvTVbmJh+pwNlmnPkiy7JyAWjB2xCJCPD/3pieogkAnNHMVsnQdnMFyfJPI+POZDdlnyMXfT4/PpEJHgSMRWJ6SdpsKAnPl0MOblPhxyWwkR0pUMewUt3fBQAgH+2E/glMuYNxfQKrwSG3K2NnVzWUGM0r79oJLmzR0jR6KwKv7cYkQvMUc0mvjdUE5iFdcjrW1/KkEfwPxWf58FKAkc/mV6ks9McE0Alco+oKH761n9iwE2EYgyFvlGTdRgX9jsqceSAR71LsHU67y9W4rB9DaRFsmqWe7gTfdxeJfNs5ISRYwh6cd11xQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CpYi+csQ; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::435; helo=mail-wr1-x435.google.com; envelope-from=salman.farooq3310@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CpYi+csQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::435; helo=mail-wr1-x435.google.com; envelope-from=salman.farooq3310@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4grMG523MHz2xYg
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Jul 2026 13:05:48 +1000 (AEST)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-4758bd3731bso68639f8f.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 20:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782961544; x=1783566344; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ftPCUxA6Cux0mzU9qrlo7eK7xG8fUg3zJ+4KXq7SPJQ=;
        b=CpYi+csQK3j/imes3H2/1fX8W+zJU2GK/2sc96qB2QnGI9g2zMTg4+ZH90zVihPOGD
         9v6Jw5iUyLYVX4n16iOlpRxMm1LY7TEgOWAG7KtfnL6CtfOd/nX7rudhpnl502rF2or6
         ZS1fGFoibvYiIPOOuq/0iE7qRzVxc137XOAvAlMTMC34n2vbisshl26KPH8BZHetITnI
         N8M61gme9I6/udeTkCkfz5nZQ/sOx5ixPCWt71dD2xbT1haZxcVP0CfT/6G/K6r3EAXY
         JxUEkj8wPbwLigkMUKpNT1ktcuP2oWmSzxMvSPfsxB4OS/TyoyvxArRh3EmC0ABHi8Yw
         UTIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782961544; x=1783566344;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ftPCUxA6Cux0mzU9qrlo7eK7xG8fUg3zJ+4KXq7SPJQ=;
        b=OrNFJH8P+t0/11t/IS9aAZR2jrp+3MuFNDrkKy1lw16mtoxRzk3UzvFZs0BRLcgM2v
         mVJ/eJG8R2UHR3FnliQQCTpCn+jZvTSvuMpHmgeIeQddigAg2LbWoxAqh6ipv2nwlKC7
         TlXeCusxmOGCJgIOcvDuRcoa1EXNYART1NFpALavGbEMMcZvaZWf14wcqUuubsPDXxh1
         rfHCeTsmevQUPuARMdfbykLd/VvGDtTsl3YrZvfk7gbQ9xypudebLS/h5hk7s7kwEysK
         lpu//sXwI+ApRHZEJFqVBO1uH15jkexZO6OYp3P+pW+umXbP0Pg13YnRYZScOeSKB5eb
         R46w==
X-Forwarded-Encrypted: i=1; AHgh+RrD4GyhrL/uPfs1KQ/UUVmXAbqEluqzBCzfoO6lo7lFX2rMd3XaWL0N+1Rc7TKhdAgJL/WBJddzSq0puEI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy7vD5f+p4tgk0wpJS3jC0vMPBAg/WlESEKQ4fKp9emWuzei7Zo
	LULsmeMgnQQqhpgYsDLoc0UdADhLqLglvm817meze+faOwCNnBwEkSFQ
X-Gm-Gg: AfdE7ck0ZjguC2c0UviaDb3RE2y7WQ3xN/4TZirNXzWfUhOGC95++XSw4LeUFhiAvvJ
	rYJdJLJTE5eiyrlzkuteyoehiGsbvIaONqgktzdRfRA066bxggWu1WGRt1F5x9s0FYhhyrhMvjE
	7k+UBCL+LY0nuv/Aj8750gHQA3N5rsp1/fjh86w7SdxIIVKTo/Lz4a/v42klpFLxkAT+x+qz1ml
	6EhGc8nmt0CirvzRwAId65HEXkmgEL9rbZPN4t+qDNDZuNuGkMAez+lhd4BRe586aDB8xN7E9xf
	yzYRuXJXTWF+OCdw5RcUhluHcBu4Yltcnet6SWzBPPG12gQGiIlXpfKk8I/XbCgC6xNFEilJTOj
	X1aH312+nOxZV3Dwf5ydwI4NCC5Oczao7XxmTVWebi2N0i4xnSy/jqHdb/zmPsWPkcE8dtGQroW
	PaYKo0P1ogcGRCOJLZFOjmLsmdGAjNOtP1PA6WSuP5IIKU8iVCeHhWq/ooYRWZDQVmEoyGi5iHe
	Of6Mu31+QRHtOJuvILK2VEr/NGf7YAKRaC3oOqwOWkR+JhBoSZdrlrsvUtJC6OIGulj0CuCChQm
	Zr2AgWHliz13VR4=
X-Received: by 2002:adf:e18e:0:b0:460:d18:865c with SMTP id ffacd0b85a97d-475de07c91bmr15871082f8f.1.1782961543762;
        Wed, 01 Jul 2026 20:05:43 -0700 (PDT)
Received: from z16 ([101.53.234.106])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-477de3dd53fsm4550868f8f.37.2026.07.01.20.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 20:05:43 -0700 (PDT)
From: Salman Farooq <salman.farooq3310@gmail.com>
To: maddy@linux.ibm.com
Cc: npiggin@gmail.com,
	mpe@ellerman.id.au,
	chleroy@kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Salman Farooq <salman.farooq3310@gmail.com>
Subject: [PATCH] KVM: PPC: Book3S HV: Fix comment typos
Date: Thu,  2 Jul 2026 08:03:44 +0500
Message-ID: <20260702030344.2211462-1-salman.farooq3310@gmail.com>
X-Mailer: git-send-email 2.55.0
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

Fix two instances of a misspelled word in comments.

Signed-off-by: Salman Farooq <salman.farooq3310@gmail.com>
---
 arch/powerpc/kvm/book3s_hv_uvmem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv_uvmem.c b/arch/powerpc/kvm/book3s_hv_uvmem.c
index 5fbb95d90e99..6ac8364a7639 100644
--- a/arch/powerpc/kvm/book3s_hv_uvmem.c
+++ b/arch/powerpc/kvm/book3s_hv_uvmem.c
@@ -163,7 +163,7 @@ static DEFINE_SPINLOCK(kvmppc_uvmem_bitmap_lock);
  *  All its GFNs are moved to Normal-GFNs.
  *
  *  UV_TERMINATE transitions the secure-VM back to normal-VM. All
- *  the secure-GFN and shared-GFNs are tranistioned to normal-GFN
+ *  the secure-GFN and shared-GFNs are transitioned to normal-GFN
  *  Note: The contents of the normal-GFN is undefined at this point.
  *
  * GFN state implementation:
@@ -1010,7 +1010,7 @@ static vm_fault_t kvmppc_uvmem_migrate_to_ram(struct vm_fault *vmf)
 /*
  * Release the device PFN back to the pool
  *
- * Gets called when secure GFN tranistions from a secure-PFN
+ * Gets called when secure GFN transitions from a secure-PFN
  * to a normal PFN during H_SVM_PAGE_OUT.
  * Gets called with kvm->arch.uvmem_lock held.
  */
-- 
2.55.0


