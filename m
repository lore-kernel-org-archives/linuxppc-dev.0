Return-Path: <linuxppc-dev+bounces-29021-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1079CA5FFD
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Oct 2026 03:49:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j0bbT6CQMz308H;
	Thu, 08 Oct 2026 14:49:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1032"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791431381;
	cv=none; b=k6CCkHtsDmYp+YcfoRHQbXF8SpERuFFjR6Mc8SGi9f9RQACYVYqufB1xMCZf1fdZENmICYnML+mIEF0kO/VsRrqLdSciYgvmv/wrZAKWHh1NV+YVYUHy0nYLamebuh06S8wrkRcB5PNt2iWfEFTcBCK85J8musisXxc2LoLoyLVw6vDEXpYIVdonE+kdDtG3BndCUnZVkBKn7r9hs4srTL0tFTwYtR6wcMgeQoAdduDw0r+YUW5Bs4TjkuAZK3BtXNxEJxUUeOnAQ7q7RWJt39DOkTofw3s1BEDUSg4zWNMew/AyF/fc8Z8cuyqwWdc1tIqCJB/ahKZq4aykIItMZw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791431381; c=relaxed/relaxed;
	bh=wRzqJI5tgXt0j4be7EpqBBdFFXnOhcz/YfnZ4NSC5q0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ijMKDpunc9u5JEDMWkRGQdSqBTYP2igvLv6C3DimXXqYCvj19Ey2lqIdKPKmrg/aeUCPhQ8sh+1jQH9q5soimtvThB2ZePFTpVMgaWu5ts4xzNS2enf1UGC4yU3Oocwai8ZNGfuVINs4y+H5udMMpJrBWPAlanA1c8Z5d/8QtANtGpVcI7Pdt5nPnsVtWRz6IsoVpPG05gVujxiy3Q9Kg8yqaHK9UAxOqoOGMv5n4UO5INytIdyKv5jjncf+9Ne57lgER7S9gaEAGCk6ECE+ydSq6ljvJ4g6nzPfE5FYA26Q7q6T1AmxxQ4KKfbj4IhcFySsIPtutnzdwJpx+x0I1Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PPZojxSs; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1032; helo=mail-pj1-x1032.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PPZojxSs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1032; helo=mail-pj1-x1032.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j0bbS11xLz2yjN
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Oct 2026 14:49:38 +1100 (AEDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-3a7cfe8f761so159188a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Oct 2026 20:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791431375; x=1792036175; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wRzqJI5tgXt0j4be7EpqBBdFFXnOhcz/YfnZ4NSC5q0=;
        b=PPZojxSs8GcWw2T6bD6qy0JMtRpMTpjPeVbZUsJiI1gNNBivopY5YS7T/ZnPtJeBP3
         d8wYeuHJQDEWf0m2PuJ123i58NfNssHyTBv+ZgiEw6cb422ez1QYWcOpJl+mey5dym9Z
         rD+RxLAtGOBWlssQOqAOd2Gc3ZCdotoIpx7ANgd4J9rPRHo3S+ODZFTyJO+hngiFd6iJ
         iu8yiHf99XPBlKZFIO/pmcjZrJogIQ/AVyvMOYNxfKD7jHF/izGhSB83hGTksEflbG/b
         ArW10PvJyvu0drIxy17XBy/Wd66O0ZdkWqx00mTpTMjGmR62U2rjNhRprsk9VpfRMbnC
         fD3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791431375; x=1792036175;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wRzqJI5tgXt0j4be7EpqBBdFFXnOhcz/YfnZ4NSC5q0=;
        b=YZQkIjW8lQEQ583XfeRzXDfAZPrdA3BcpHCloKNDB/SKJnp/oyxKNTsgjfw6+jMqT5
         d7nSI0Mzx1Abiv9dZ+RQUc+QjHul3zHi4YT14EeJXvG42PcEFPZ1NMjHzuxIWacTX6co
         s3BIZNyWFgjBFg9PzMGa5b53SDktKeCeYk4stbehXLQkO+RQ3og6O+YTUry4G0CHj7XZ
         H0D57WQ4gSz8lS0c25SLoQaKLLIkkf45hx1MHHlD699OSu+3L423pivJDPpRE1btFh/g
         YmejVjt77NW4FhJPtV4VqsMpEuZMdwGXrqDswHGcp/FccwM0DEvfw/313b96dNvnmhIA
         G/Bg==
X-Gm-Message-State: AFq9FYLz4mPRGSn3/RLxAJkU4cqbvI6OKOte2wUyUzxg4Ki/5qWiZi0r
	eSaLirR7vOKsOAuOYH76zCi8ANG3UppDq0p8L3IgWOGb9OwtQuY3b7T4SFvC9OQd
X-Gm-Gg: AYBFou3S22pToKFl1VdmNBZTspWml1ks9kP6TaGt2u0Bm4WIbAuNmq7szJpE0z4nczy
	1L4MutQimEGHCAtx9ReLGW3rqZUasLTwwDtAtPusDDsbRSBiko1JVufxAQTKK6289WVPPs6eQPd
	KM15mr6MwJbuviuDQmEFORPeYkI+pKcl7hAvLtb6sWb1dtxwsQFwK4OKKp7o7uUL6b813p2KiTR
	IDUqekfRpY6BBBoTMQ8d3fzBF+1ryaK0gfo39f+yWME4qCrv3yf9PS8r4D6BGwoCSbuwV5hpUrE
	XstaK1SPUFvvzKO7RRHpPoi8e//LvsWSiOdQuZShaWMWHExdaTAq3ZztSpkqc3fwrVAhKvpoZtt
	WfDB0fTZoTHMPrFzNc7GHNzEUXPGcXuld5/cFwP/6JtdOpMw5mxTuYpXwhx5iqDwkCQR792qDdv
	lWSf23pOgbDXbaGYIZbNY7wZAx0lf8JWvvMaGcwUkx3YHdpRIXL2iscFEY8FZhUBKdBbJG6W2iK
	6B2+IJMritxs0Qbl+u2joIsGeCpv+EX1b98HLzxp5NeBqWaYZoCf4ADJRK4Z/9DcrRnlQpSdO3a
	2tMcR/t8+vhBkwzT7A9ZGOifZ7MxE25Z5lHyy10wVQGdhRM8
X-Received: by 2002:a17:90b:2ec8:b0:3a7:96d:feaf with SMTP id 98e67ed59e1d1-3aadffb8250mr632594a91.16.1791431374811;
        Wed, 07 Oct 2026 20:49:34 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a9ff8c2396sm2194058a91.11.2026.10.07.20.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 20:49:34 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] powerpc/lib: prefetch ahead in __csum_partial()
Date: Wed,  7 Oct 2026 20:49:32 -0700
Message-ID: <20261008034932.3180490-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.56.0
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

__csum_partial() reads every byte of the buffer once and never touches
it again, so on cores without a hardware prefetcher every cache line is
a demand miss. After a non-coherent DMA the received data is never in
the cache, which makes the GRO checksum validation of forwarded TCP
traffic the top entry in the profile on a 464FP (APM82181): 22% of all
cycles were spent in __csum_partial() when routing with GRO enabled.

Issue a dcbt four cache lines ahead in the main loop. dcbt is a hint and
never faults, so prefetching past the end of the buffer is harmless.

On a Meraki MX60 (APM82181 at 800 MHz, single TCP stream routed through
a qca8k DSA switch, iperf3 median of 3, A/B in the same boot):

  prefetch distance   LAN->WAN   WAN->LAN  (Mbit/s)
  none                370        341
  64 bytes            430        381
  96 bytes            438        397
  128 bytes           438        385
  160 bytes           434        386
  256 bytes           423        383

Prefetching the first lines before the loop made no measurable
difference and is not done.

Assisted-by: LLM
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 arch/powerpc/lib/checksum_32.S | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/lib/checksum_32.S b/arch/powerpc/lib/checksum_32.S
index cd00b9bdd772..5a14d45c7b9d 100644
--- a/arch/powerpc/lib/checksum_32.S
+++ b/arch/powerpc/lib/checksum_32.S
@@ -43,6 +43,7 @@ _GLOBAL(__csum_partial)
 	bdnz	2b
 21:	srwi.	r6,r4,4		/* # blocks of 4 words to do */
 	beq	3f
+	li	r9,4*L1_CACHE_BYTES	/* prefetch distance */
 	lwz	r0,4(r3)
 	mtctr	r6
 	lwz	r6,8(r3)
@@ -52,7 +53,8 @@ _GLOBAL(__csum_partial)
 	lwzu	r8,16(r3)
 	adde	r5,r5,r7
 	bdz	23f
-22:	lwz	r0,4(r3)
+22:	dcbt	r3,r9
+	lwz	r0,4(r3)
 	adde	r5,r5,r8
 	lwz	r6,8(r3)
 	adde	r5,r5,r0
-- 
2.56.0


