Return-Path: <linuxppc-dev+bounces-29278-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C710CA9EDE
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Oct 2026 18:01:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j3QHz5GwFz2xwN;
	Tue, 13 Oct 2026 05:01:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791828063;
	cv=none; b=ghjQVtx9IVqw11weIw/lezchyf7U2HrS3Idqdh7bGunvNCJFaty6qeb9Sv6jY2kV7zeyjopTFsZrKzTbLbBoh+JJtVp1NnmyaFy0xy4PXT9lW+QSGlTeM9bnU+KWX2nbram4ux85XjvAv/FDGR2xbT29poNnm2KVn97/FxFvDo++Q99a/MdM0Y3HmVLIHEXiW31BNBPNnp2qOlKALZPxZoJ0fwJH+JhHYFJj520c2fp3EPU5ASrNLn8nWiAKijde06fWxEU7ovNaGRLrzKXm/Pifp2a6OiOrIIQ1QbUNE8btshgElkXmEPUxnBHQa1Mll0uNvWg0hw1LPYG60OgHtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791828063; c=relaxed/relaxed;
	bh=Q0LZ3VbBlAPZVH9a4e0Yvdir8t3mhQma02ZGhVPq1+w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hM/3GOXfWqalwbUK7G64uMiPmUyjJzQvIoCvfBIlXuWRdNU7nnVbVW0rgmx67a955z5TQMTSdbjvMet+2ux8RNCrPcxXx9h2EQbl4ZBReEgtIxuw8zs28LReLqnMcQQSxNbGWVuEbA37Gq1VQiR53uboAapHf3HBZiDqnGpq8Q2+bGOb2Q0QXoB3JcSpMZHBWy9fvLj7S+Y/VjRIg0XnEjAJZ+NuxIHVyd2oq/MWx0yOyx5FXJpM6gP9ygklPh9SP1OMA0+v+yV2oZrqoPkQhFLD+V+fjNP2CsMY6zUgFxbxralSHXqyNMUbKDPW18nw+IDxlQCiWKdfSvklgPCOAg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZNAjLLfP; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZNAjLLfP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j3QHy33ycz2xrL
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2026 05:01:01 +1100 (AEDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-2dd9cbb661bso15531165ad.3
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2026 11:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791828058; x=1792432858; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q0LZ3VbBlAPZVH9a4e0Yvdir8t3mhQma02ZGhVPq1+w=;
        b=ZNAjLLfPaWNF11xfDweogq8AGs7DDVRgfeMfLJhR0S3mXvFcr3ylkS7EeI5efFtqRX
         o11dAcHJnwzBlLqmYFHwYBzWue1B+gniEQNLUwxKGAzPSefJQxV1CXKlupRVhxuNdB3R
         rRuad3gWlPjhwIVIDry3EIZgNUadoFmZpTCcp0FSd3CzISQ1XRSV2uFZv3Z31+IE/YzZ
         BCNzydNrHiUk+KnzCE9sOYMBX1eVRpf93vgFC1nqAdg3DIN0r4n62PH9Pigs8mjJGLjB
         E1uK1XKsT3m0GG9Kvqz8bKIimEnkITkF8pbzeYC2bfEitm6vdUAhidD3eDu3Pu4N847E
         MaCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791828058; x=1792432858;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q0LZ3VbBlAPZVH9a4e0Yvdir8t3mhQma02ZGhVPq1+w=;
        b=U0LgYALq0Y+KEwe6lWhiwCyxyajeI3du5Vv5nKIz8BeFdAy940JEwUDZhdMFpeXt+1
         fUB3av1vRpYUMis9jcpNB2EL78x412uz1v1k1/euEUf5Ogqocc0RBLl/hU7HiZVK8oZZ
         xHzgchUi56t90OfNFKxnfzIp/w0cT7rJwmSvTWt2Eq3kcjgDGz/Nzvo/9UfJufZPjkg5
         mrw1U69BMhsneewgGa37TMT2hg1Ait1XtT1FxMmFwTAVR0qcIfOow3QvC8SNuoWuHudM
         N3G5MooWwxJR17q6WYNVulMiL4SX84EsL53mppuIfVjx6681NXFAf9k5IDf/qtGno/Os
         GZvQ==
X-Gm-Message-State: AFq9FYIOx/+31rC9XKSKkymKUUGU2KpHbE/Ag8Jh7N8OLhb06uBoXQNR
	xPy0A8vSfn20xz0yH+n4ZNk4q3bL3cAqO3MOT3qRW6hrkz5W4X3XekAliLGlvS8D
X-Gm-Gg: AYBFou0hTX6PCsvP6+6kSWIci38MTCQlORbcDVic2vkgS3I0SJ05mrKWNKWpfGHAjYs
	Fc3/7hmwvClrRQ6inbyxzcfBswl6P533OBUtLQVYz1TtqBCbInCIgwOHItwYJ+LSKmEzcJJm1Uq
	uVB91Emao2ne5g4VYE0lhSAYvEqTq/mapy3laiM5w2Igr/oi2DNbrU89LJWXeyguoQFHeN+fMDT
	TYKo0PIYS0vtXL8mNdi457O8g8+4+m6W9r97QRXxDx/1L9Z3+NgOO4XgToAAu+zqYiJQAhdZtNX
	yPSMbgJYxnH3lDONRZbckEzNO32xlNXC0ubNGNRt/6yiq0A+WpcPJzvN/yW+MQ51/3k80EpnxWN
	OZQavyf+zTF/7QxzQgFxtUubBNXvegJufIL+C8N9DU2aF+kAL2h8DMxZ6c57JSUKl1V/0iNo1df
	SNVwLa5Iuo5NRp6ATRnU3tqYmp4Qffb943G2iGc+NHIGC0hbEje50t/j38ej6BCD8sE5yOdnA+f
	UD77vuqYHSlvO4uBjCVmds4vHvObniqSeSpOy1q1Hobx9ybDUrxTNQ5l8A4V6XzOSxQdcoyLoam
	pfMUXKIeZ1lX4yDu7NiApV/vgzEj1iXVjluUK+btsIaIURD23A==
X-Received: by 2002:a17:902:cec2:b0:2e6:1715:e48d with SMTP id d9443c01a7336-2e842ac8863mr98151965ad.35.1791828057465;
        Mon, 12 Oct 2026 11:00:57 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e841a04b22sm45805785ad.8.2026.10.12.11.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 11:00:56 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] powerpc/lib: prefetch ahead in __csum_partial()
Date: Mon, 12 Oct 2026 11:00:52 -0700
Message-ID: <20261012180052.55578-1-rosenp@gmail.com>
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

__csum_partial() walks the buffer linearly and reads each cache line
exactly once. On cores without a hardware prefetcher, such as the 464FP
in the APM82181, every new line is therefore a demand miss that stalls
the loop. Packets received by non-coherent DMA are never in the cache,
so this is the common case for GRO checksum validation: when routing
TCP with GRO enabled on a Meraki MX60, __csum_partial() takes about 30%
of all cycles and is the top entry in the profile.

Issue a dcbt four cache lines (128 bytes) ahead in the main loop.
dcbt is only a hint and never faults, so prefetching past the end of
the buffer is harmless. Lines that are already cached, for example when
checksumming data the CPU just wrote, are left untouched.

Measured on a Meraki MX60 (APM82181 at 800 MHz), single TCP stream
routed through a qca8k DSA switch, iperf3 median of 5. Only the dcbt
was toggled at runtime, in the same boot:

              LAN->WAN               WAN->LAN
              Mbit/s  csum cycles    Mbit/s  csum cycles
  before      495     30.5%          439     27.2%
  after       599     15.3%          520     13.7%

That is 58% less time spent in __csum_partial() per byte.

The prefetch distance was chosen with an earlier, slower driver
configuration (median of 3, Mbit/s):

  distance    LAN->WAN   WAN->LAN
  none        370        341
  64 bytes    430        381
  96 bytes    438        397
  128 bytes   438        385
  160 bytes   434        386
  256 bytes   423        383

Prefetching the first lines before entering the loop made no
measurable difference and is not done.

Assisted-by: LLM
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: reword commit message and retest numbers.
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


