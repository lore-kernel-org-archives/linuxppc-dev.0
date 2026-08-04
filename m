Return-Path: <linuxppc-dev+bounces-25361-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6815C55184
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Aug 2026 11:21:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDrhM47hBz308j;
	Tue, 04 Aug 2026 21:21:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.164
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785842467;
	cv=none; b=aN13hnLrNvTgLE65QYe2lKh667eKBeQyuyaYmdAJaB3Yq6XnzZUrbuBivJcEZRDIJmuNSQA5DOdjDWMwHfcX9Y8cGSGuk/N7r2FmWWK+25ifmdNRjZMLwVLVO3FaSQUmUj/0bHsAZ4YB/KpWZCKnDEdxvtRXuermuk6kHNf46VigDAmx3ml07hEcB9s4uiisJEcF2+Sl+OumuxZuAyEpFuGvapI4skBpj+Hsh9bHUGKDKbsmdUjoFEZI66VWn+KOaznxqdR1Satf/lBhOPVJC7Kw+Rh362EE9BUCqbIUWlSbq9zw1YPA7zsWMzEuxrnKqRCgxLG/4k95W4DJWPelfg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785842467; c=relaxed/relaxed;
	bh=Xyi/I57k9vKvTrRMB8ca/XIbTpha6N+hD+lKVj3Jk2k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OBGOhvPnZVn+4B8K+YyDmX7Ljg1ZhK6AbB34wL+q6Z8dTfqnM6JbKKkiPQLMygkbmXOyUELlMfluNWu6Hu5D0ctv7Tl2F0BpQp4ymmio/3rh8aVEHMLr5pcflfDeo5NMBEEWjFLOPS83E02AeVgEwMj/1WWcI9YsX0Nl4jdhO5PwFJh0cU+2R9k0v18dWpiUiPe7OJpHJbmY2QppDDkVjtecxYpKQ9Vizz9HZcdbolwY4V2kynHRc9OLiCOcRU2snK5SaygP8+e6SnxCggKzMp8+RRkzPN01y1neGzyuCO4OGno7QdtFUGp6UalcOPF51fEDq68ABU70w3p6shxdqA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=HGSSt+s+; dkim-atps=neutral; spf=pass (client-ip=95.215.58.164; helo=out-164.mta1.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=HGSSt+s+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.164; helo=out-164.mta1.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org)
Received: from out-164.mta1.migadu.com (out-164.mta1.migadu.com [95.215.58.164])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDrhH0Gyhz2y1Y
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 21:21:01 +1000 (AEST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785842439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Xyi/I57k9vKvTrRMB8ca/XIbTpha6N+hD+lKVj3Jk2k=;
	b=HGSSt+s+rdpWkQUmuWt3oV0AdN3kGLD9rkLH1cD8GlxDhgWx2WVW9fhQFfPhP5gvjJsEk3
	kjIC5McjAhizf3TES2CRJt40aOHqERjTLfRTibIuyTqosAFsGjljOmTLxkziXWSk3P2z+u
	5gr2DFoCHm4nFgAoV/iMiJNVYIJ3fAM=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linuxppc-dev@lists.ozlabs.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] KVM: PPC: booke: Use min() in watchdog_next_timeout()
Date: Tue,  4 Aug 2026 13:20:12 +0200
Message-ID: <20260804112011.59416-3-thorsten.blum@linux.dev>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=748; i=thorsten.blum@linux.dev; h=from:subject; bh=y5BJJcHpdGJ2jUlaYs5zc4Wk57IOsDrfFAaXU3EEzsE=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFmFp15HJP0qqjfVsb569gvj1MuGazm2Nq9etbpp1wNp3 fNzV8zO7ShlYRDjYpAVU2R5MOvHDN/SmspNJhE7YeawMoEMYeDiFICJBB5mZFjvf/2G4o7EQ48v veKP+HPPN27t/4CVuzbJv9dgfhR25GE3I8PahsQHjs9Ud3DfkzjGP+HgWpc9uZY2/ItzzM6b/ZK sUeAHAA==
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace min_t() with the simpler min() macro since the values are
unsigned and compatible.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/powerpc/kvm/booke.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index f3ddb24ece74..543479fc9630 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -598,7 +598,7 @@ static unsigned long watchdog_next_timeout(struct kvm_vcpu *vcpu)
 	if (do_div(nr_jiffies, tb_ticks_per_jiffy))
 		nr_jiffies++;
 
-	return min_t(unsigned long long, nr_jiffies, TIMER_NEXT_MAX_DELTA);
+	return min(nr_jiffies, TIMER_NEXT_MAX_DELTA);
 }
 
 static void arm_next_watchdog(struct kvm_vcpu *vcpu)

