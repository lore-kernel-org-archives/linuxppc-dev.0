Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0ECA606A321
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Nov 2026 01:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dMGYnuwQ
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNqJy5VgNz3bSy;
	Tue, 10 Nov 2026 12:47:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1129"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794275234;
	cv=none; b=MW9HxEPuEHwTa7T65Jllx6/C3GxkdLEpBIZN0sjea7361MYQmJMc3LyEAiQXyESAOHraDfZIBg9AlxUIxH/iaVCzSbR/t5EBRj3vxyHJVQv/6LZcyYxqtvtIJbAXIdmSl1LCjMOv+CZDJr1unPpBfo9P8nHqYdtLujHizUCc6lGs2k8nFG/op9rtV2gDshIBad1CCBvxeDA8wSdvmamBZMSgNLKjTZF3wlS3HSTR1FHMfdMJA+y2P2VJRLdadb/xHC1u2zxera4b95tTtR51ezY/T7G7/kMarl3WxUsXODFKugLI6COPA6oByTsCB4K9ja5sgvS1EDyBRQiZxWEHUw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794275234; c=relaxed/relaxed;
	bh=LyEW4G6IiaD7cKAlJyc5b0j/vS7ap7Ko3xTmCG8Q3gw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aT43TbqWZk72sIbCLFLjyK2QnihK+A7HSb0vdXzlZg2g/mOWs+ToOij/ghNeCAH8omoBpNLB0D5nGcGcra6JdiwHmycl9kGf5DP9b1TFAYEnwDYGifJfChm+2ot/C6caSoRZjlZsa2qRIX8QngqtwI7h0z7JRrEZevr49Qdem0wBWx+8bwuZ/rvHgb0EXB8462vYeXY/ZIdO8Is8kuHGXYH5yyKjyKkO9iNfTXzhQET8oOpJuKtaXYrp+vzBl38DFXUC9eA1rpqQVpPb9TFvbdt0TrheZycNwGCJRL3615N4pPs7tS/JFGCkSYAlYv2xjEUrOdjPBJuj5zGN+/zk7g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dMGYnuwQ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1129; helo=mail-yw1-x1129.google.com; envelope-from=mattst88@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dMGYnuwQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1129; helo=mail-yw1-x1129.google.com; envelope-from=mattst88@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNqJy0JNwz30WQ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 12:47:13 +1100 (AEDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-8b305312e4fso12709697b3.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Nov 2026 17:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794275231; x=1794880031; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LyEW4G6IiaD7cKAlJyc5b0j/vS7ap7Ko3xTmCG8Q3gw=;
        b=dMGYnuwQLzKFiIf8d3bwq26EgPGsrvr+XFmzZdkZLJuzXL5VCauDaSUEkFc1/pc7Tp
         BgQdvtdguSSZ4xCkNEt2F7pQi/VUU9RCQslU0tk2cdZ+pcVjttJdgBYFPvl0TvmbFqq9
         O82EURuKOygIRswCQRfjIPNyPmLvXRYeFmDgN9bJQo52+0D9soGzvAGwkomHgj4Y9E62
         3CYJN4FAVuvFR74C8ZJlJt4RMqT76InJ5sRNwMYpoQDzE9WsyG2X+FCg6/VMXQw14fHZ
         SXaVpOOeP9Y5+Q9qkBU4jbp13ecTx/yykvgxN0/txT84quEdBuYqs91kvvEWv4QLTt0K
         CNgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794275231; x=1794880031;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LyEW4G6IiaD7cKAlJyc5b0j/vS7ap7Ko3xTmCG8Q3gw=;
        b=n4a7T56OFxFXaN+Frm9dI/s5xFPCDa3LR6l924JlMq9pjp+ciQY54O30RjR7O3kug2
         oQ3BI2wLUjFYF7lxLsT/TTc9MQMb1mIz33EH9b8J8DGr1gaMJlDaJGlaO3/spf6aFGV6
         2qQNH9h90RjEXpLWzzGLaV20QPPVD2C8D4hI3/WbmnaYQt2kUj9Ge4diSUKwO7E7nphf
         QBP6laQd7TXQphjW2Fwdj6YzgC1IPO/KutllXvOoigWD5C/b5ySW9mlptaRd96CvJTgi
         kn/ZaVhKhjAgktTRkP3i09wwhfO2lI1yVulWA/z0WbAhcRaasJzDsiay+Uf483RilmLm
         kuWg==
X-Gm-Message-State: APuU4Z8vwB/5plrTfEr7/+3lvwhMpNs1jP9y3oi01s2Fb4XJcXzz7x51
	2yCkY75I36jZmRj1Wbn69l4NrIC9Yghvj/io4YdAc5ucZ2lQAa1GDs2j8DVsHYdq
X-Gm-Gg: AYBFou19aUDV+0iGSvpRjacjXn9Glkx0I+nmVbhB39dnmLDoPq29D/yQc5CQUyCUqLV
	+VWjegXHwUZutIKWbHdOi6FJV/6qxDrMhCWmv/QuHwxBmCC7N3Ve07sabLN89FDa2Actau/y+8C
	93Vb3vUcan7hwAuaEC7ma/z0DYw6d0f3JXlMirwJAk086BT+Mkmeah6nlxgGuy/z2FvFOd3QXQV
	eQ7MlSxNmGImfZ56pUimgHL+g99y3DmtRdz8ih1C2Ots8RUNFZDTbPoVdkVEf1Lg0FPVcxWT/xl
	WGs7MOgrh1yYYCYmmldeCM6veYGsQBMSCRwmehTilu3C+nSv9muaJ2oUcRFeQio0YEHv1dwm7zS
	q+e3hdz0z3mnG/CAqCwHKZ/en8rEXGyTLVUPRy1w1SBbSaYSe44HwNXD3q2hrp8AYJ9AJtSlfrL
	i6F+kVLxKJX8enp/kuZ1VbrY0HQ81EHrD9v5feyz6VFWvk3WBEb9WxdZfyT1UWyV6mStT7/wTIk
	lRhc8vddOCLcmT8IX9b3Ts4yZIGPEQEtwTur8iVDqRmWJGS3bxnK6vC0CPPPZ2yEVLJnJor3jMa
	A+aOO7ydyqnFiRYbleCiEwXVIib4Tuqj9WeKGVNjKzmP4WTMtH8DeSxpMp73FuTzUITGMzOR7f3
	D2r7Q1TxPJg==
X-Received: by 2002:a05:690c:a409:20b0:8b3:2405:6dab with SMTP id 00721157ae682-8b392c4b2b2mr5085867b3.69.1794275231320;
        Mon, 09 Nov 2026 17:47:11 -0800 (PST)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b393408893sm8423327b3.26.2026.11.09.17.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 17:47:08 -0800 (PST)
From: Matt Turner <mattst88@gmail.com>
Date: Mon, 09 Nov 2026 20:47:03 -0500
Subject: [PATCH 4/8] powerpc/perf: mpc7450: Fill in the L1 data cache
 events
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-ppc32-perf-v1-4-a6e8a55b3b48@gmail.com>
References: <20261109-ppc32-perf-v1-0-a6e8a55b3b48@gmail.com>
In-Reply-To: <20261109-ppc32-perf-v1-0-a6e8a55b3b48@gmail.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
 Shrikanth Hegde <sshegde@linux.ibm.com>, Paul Mackerras <paulus@ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Matt Turner <mattst88@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1724; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=vxh969Hcy9WrgNGikVvry8J80j4iE34/QdKKb/UQT9A=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLI+lU8xOlEfF3rij4y+FmuL7owp62wag77+brff8IKlV
 fPqKuM7HR9ZGMS4GGaKKbLErVdkmdW2Y6nPaelfMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 IZChYxQPkdNj0MgsLi5NLdJNKyhyyMsvSSzJzM8r1ssvSM0rSC/QS8tMK8nIyC8qTgUaoZeXWmL
 q6uhmZGhgYuloYeZk4Whq4uzsZOjk5ujo7OpkZGluYuBs6WjiamnOwMUpAHONRDvDX9nqbTbqlZ
 K2J19eNft0e7U7+/sXCcYvPx+8snCVTzlzlwrD/0C5jjkX4ralP/lyILH4hD9bqfdlH7dLMyUmN
 3dNNnp8iw8A
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The L1D row of the cache event table has load and store misses but no
accesses, and nothing for prefetches, so L1-dcache-loads,
L1-dcache-stores and L1-dcache-prefetch-misses are not supported.

The MPC7450 has no L1 data cache access event, so approximate the
accesses with PMC2 select 26 (load instructions completed) and select
20 (store instructions completed, PMC1 or PMC2).  These also count
cache-inhibited accesses.  PMC2 select 38 counts dcbt, dcbtst and dst
line fetches that miss in the L1 data cache.

On a 7448, a loop with one store in every 32 instructions counted
645840841 instructions and 19773839 L1-dcache-stores, about one store
per 33 instructions.

Loads and load misses are both PMC2-only events, so perf multiplexes
L1-dcache-loads and L1-dcache-load-misses when both are requested, and
refuses them in one group.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 arch/powerpc/perf/mpc7450-pmu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/perf/mpc7450-pmu.c b/arch/powerpc/perf/mpc7450-pmu.c
index 9890c87c58ef..27337a03ebde 100644
--- a/arch/powerpc/perf/mpc7450-pmu.c
+++ b/arch/powerpc/perf/mpc7450-pmu.c
@@ -362,9 +362,9 @@ static int mpc7450_generic_events[] = {
  */
 static u64 mpc7450_cache_events[C(MAX)][C(OP_MAX)][C(RESULT_MAX)] = {
 	[C(L1D)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
-		[C(OP_READ)] = {	0,		0x225	},
-		[C(OP_WRITE)] = {	0,		0x227	},
-		[C(OP_PREFETCH)] = {	0,		0	},
+		[C(OP_READ)] = {	0x21a,		0x225	},
+		[C(OP_WRITE)] = {	0x014,		0x227	},
+		[C(OP_PREFETCH)] = {	0,		0x226	},
 	},
 	[C(L1I)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
 		[C(OP_READ)] = {	0x129,		0x115	},

-- 
2.55.0


