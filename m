Return-Path: <linuxppc-dev+bounces-29197-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91D80CA9ECF
	for <linuxppc-dev@archiver.kernel.org>; Sun, 11 Oct 2026 19:58:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j2rxG26TKz2ygW;
	Mon, 12 Oct 2026 06:57:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::630"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791748674;
	cv=none; b=C19Uu3VFyAh8Iz3LxiqXFCQ9AH3bHEO+in5dg7hiHlpcY0nyG+gcAxYgVbaqDP93UU6yadSblL5rHoiNFcHUxHGZsOCx2ehKUYnw7xuwDLnDaxu6xm4wxMvEV2flfpe+/QEH0c1UgqF7uAPYjxQcY7osPrtuI/mpB7W5l8HD5P8cITn7li1BEuw2neh80uDmc+mhkZZrdf2bsZ2EBmvUr7AjnRGFm7/ZA8hLj1d8kjm+wKvlqfxsVml5ANxB7Fh3/av/tofKimbFHGsREBHzzzsp37c8uuxjT+n8vbcz3WWH4cZp/obn1WC+JRqe8nVpT9hTXOr79KioRI1MLv2CXw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791748674; c=relaxed/relaxed;
	bh=bd3F/qTb7l7go4vsYHnwO4e8nInvYSKDA0ySqIxH6Y0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EuaI+C9M0i8Zk/Ik5FwNaLWGYQ9dGsGlhTuNXC2NBaXREC2XOZKg9/rbQ4ffCJDXaI11sFwwq6atr42zNS5zKeEIiX5u8IR67qfe7yHzDcqkVXRXNjs5HJBFbKPqdGJ4/OuaYbxyZd5fGz6DAnPytQYH85yKb1bhjVEdyePbu3zXfu7E4KPHFhipVBFaj62mbCnsTWw+jKZopEoDqpgaK9CT+Zw7Wt8LvbLAhFQq4SwGir0Haxk7tW8hlmeDoquhLfMkfvVK7CV6p9FpywE32rnOI1Xr4MhzKQdois4gxw1ngsUUGbxQAb/qxGteU3dRzR0eOaNwW9ilEKu6VQS0FQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KuZL26wG; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::630; helo=mail-ej1-x630.google.com; envelope-from=linmag7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KuZL26wG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::630; helo=mail-ej1-x630.google.com; envelope-from=linmag7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j2rxF3ywhz3br2
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2026 06:57:53 +1100 (AEDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-c263415982eso145919566b.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Oct 2026 12:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791748670; x=1792353470; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bd3F/qTb7l7go4vsYHnwO4e8nInvYSKDA0ySqIxH6Y0=;
        b=KuZL26wGhTvZiwE7y2ZX7uasE3BOES89IlJYXqXxQyYuLCNRBwNOaiHEfE+ceTwA0G
         lysmD/ccIOBAmIFtppr94N2SQiRjI9meDyKSIX04kmhglmqmys9wICt0dfKbUlxn/VWk
         CkZTNQ5Zhn5OGd7mmUSGpEL/udWw+2ps5bqLNPm7ZORd1ox0vKw6odVe178AVtKQXz8E
         DBii1NqmaT/wVL1MmYelJyZDoouO1ZFkCyxKqWBPb9xibDv0tm+coqRC7Vk9aWCaXkrt
         ph1Ex2d8uGR6XmVsDWu9YV5a+SVAuScdHccXSvO5kbrdijenAp65y3yqlOoB1/2zAMVN
         +WmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791748670; x=1792353470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bd3F/qTb7l7go4vsYHnwO4e8nInvYSKDA0ySqIxH6Y0=;
        b=VsldZAI8BoAaD/u4/lL2jBwp2LW9IPchbr+g2IvYRbgOjeiZHUG23fpfmKNJuh5nih
         Tp9BaJbNpTxRLAWkYwaFUVWEhiEO7bYEJxMdzROESMnpGmJS4LSS7JizimTGHy/0rHBM
         9XkspAY5hrEkabRrxWfGepXQm+9vATB80c1cEI4gCiP6LoyGv0S8G8Wl4LiFH9WRuf34
         hGd0g958SdUT74PP8S8pC4yxxlLeSks9E2ZErPCODY1iiD4vJWjyIZLeNllDC7ALdBn/
         NFcYwuUag2IMtug6s8hCPsOVIjFqEfHXvXPrt7zN2wwZjlLFKO9lNp/qTDRoGyiTI2RO
         E2xg==
X-Forwarded-Encrypted: i=1; AKwUvBwregJXf6OiJDXyuuPw2LE7VUxNiDXMIEhbDLTFcmvxPCyFyR5ykYXCgdcQEUpuyVsIxfnHOazXzGsWMHc=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYKDtoRe9HUzAmRZbGRjFL1BnQsbLoWlHXjaFbMvkI2Rr8Qha259
	FR8fwz0gxoMznDjIprnbO+wv4YZqDgz9ynEzdouz53UzO31LAXfS+Wt1
X-Gm-Gg: AYBFou0/KJ55BhhzlCOYmOtHUCEF0j128MgyM1Ud8jVFvFXbqsBKBf5k46b2xU2antT
	w2Fyw4ZWKvT8uOp6ZWqrPf6T52tM4TMS3mTnaN455wGQLjRhejtRQFhCSzGgkk4KlphX8XKuVUI
	/EkjcsXa9ROEORmgfK1E2dS41wQR0f6ZQVpUGJQ1stSnod220fmhlB5NWceyesCQ9CD9sEsPDlR
	rGUw+mzGk3I0pZ7OXescjUPLJ1rzDWwP7eYJM4B6SYkcWBGhZgEFe83QTYzXNj17LEH5pqNbqZC
	QlJEvWKpoQXp+4GeVIrSSRG239JuG/ns/DZKcOvesbDzIL6vFCStYx3k8OFTISh3SD5S8v7jX0B
	zO8GmEmdqGp2mlKxHLZ4rg9DCT91Q3H/HNYblqi2S3C8UV5BkPD8oBRpR4n37Iul2r8UiTMqVld
	PpgY1RVoQy9RjKQftSOIr14NXdku/3sEZdxgqR5jsTXlDuKBJHKlpKIGDd3NryyHkpykuI9wAWk
	9O4AAsZ2+0hO0n6/gEd71XyITGTiDRagBqgUDAu
X-Received: by 2002:a17:907:9694:b0:c20:9447:bd5e with SMTP id a640c23a62f3a-c31a9fa1d3amr847020866b.9.1791748670007;
        Sun, 11 Oct 2026 12:57:50 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9a3ae9fsm381315566b.26.2026.10.11.12.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 12:57:48 -0700 (PDT)
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
	linmag7@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v2 2/6] sparc64: honor queued spinlock layout in secondary startup
Date: Sun, 11 Oct 2026 21:55:54 +0200
Message-ID: <20261011195729.981243-3-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261011195729.981243-1-linmag7@gmail.com>
References: <20261011195729.981243-1-linmag7@gmail.com>
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

The trampoline's ldstub modifies the queue-tail byte of prom_entry_lock,
not its locked byte, because SPARC64 uses big-endian queued spinlocks.
Acquire the word with CASA, release byte three and poll while contended.
Retain the predicted-branch barriers for Spitfire erratum 51.

See qspinlock_types.h for the layout and JPS2 A.10/A.35 for CASA/MEMBAR.

Fixes: 145d97858597 ("arch/sparc: Enable queued spinlock support for SPARC")
Cc: stable@vger.kernel.org

Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/kernel/trampoline_64.S | 34 +++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/kernel/trampoline_64.S b/arch/sparc/kernel/trampoline_64.S
index 51bf1eb92a36..62f404b3079a 100644
--- a/arch/sparc/kernel/trampoline_64.S
+++ b/arch/sparc/kernel/trampoline_64.S
@@ -106,9 +106,19 @@ startup_continue:
 	 * We lock 'num_kernel_image_mappings' consequetive entries.
 	 */
 	sethi		%hi(prom_entry_lock), %g2
-1:	ldstub		[%g2 + %lo(prom_entry_lock)], %g1
+	/* Big-endian qspinlock: acquire the whole 32-bit value, not byte 0. */
+	or		%g2, %lo(prom_entry_lock), %g2
+1:	lduw		[%g2], %g1
 	brnz,pn		%g1, 1b
 	 nop
+	mov		1, %g1
+	casa		[%g2] ASI_P, %g0, %g1
+	brnz,pn		%g1, 1b
+	 nop
+	/* Spitfire erratum 51: barrier in a predicted-taken delay slot. */
+	ba,pt		%xcc, 2f
+	 membar		#Sync
+2:
 
 	/* Get onto temporary stack which will be in the locked
 	 * kernel image.
@@ -212,7 +222,10 @@ startup_continue:
 	 nop
 
 	sethi		%hi(prom_entry_lock), %g2
-	stb		%g0, [%g2 + %lo(prom_entry_lock)]
+	/* Match membar_safe() for Spitfire erratum 51. */
+	ba,pt		%xcc, 2f
+	 membar		#StoreStore | #LoadStore
+2:	stb		%g0, [%g2 + %lo(prom_entry_lock) + 3]
 
 	ba,pt		%xcc, after_lock_tlb
 	 nop
@@ -326,9 +339,19 @@ after_lock_tlb:
 	wrpr		%g0, 0, %wstate
 
 	sethi		%hi(prom_entry_lock), %g2
-1:	ldstub		[%g2 + %lo(prom_entry_lock)], %g1
+	/* Big-endian qspinlock: acquire the whole 32-bit value, not byte 0. */
+	or		%g2, %lo(prom_entry_lock), %g2
+1:	lduw		[%g2], %g1
 	brnz,pn		%g1, 1b
 	 nop
+	mov		1, %g1
+	casa		[%g2] ASI_P, %g0, %g1
+	brnz,pn		%g1, 1b
+	 nop
+	/* Spitfire erratum 51: barrier in a predicted-taken delay slot. */
+	ba,pt		%xcc, 2f
+	 membar		#Sync
+2:
 
 	/* As a hack, put &init_thread_union into %g6.
 	 * prom_world() loads from here to restore the %asi
@@ -389,7 +412,10 @@ after_lock_tlb:
 	 add		%sp, (2047 + 128), %o0
 
 3:	sethi		%hi(prom_entry_lock), %g2
-	stb		%g0, [%g2 + %lo(prom_entry_lock)]
+	/* Match membar_safe() for Spitfire erratum 51. */
+	ba,pt		%xcc, 2f
+	 membar		#StoreStore | #LoadStore
+2:	stb		%g0, [%g2 + %lo(prom_entry_lock) + 3]
 
 	ldx		[%l0], %g6
 	ldx		[%g6 + TI_TASK], %g4
-- 
2.43.0


