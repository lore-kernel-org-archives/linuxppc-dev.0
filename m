Return-Path: <linuxppc-dev+bounces-29509-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95F6BC3DA7A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Oct 2026 19:48:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j4hZz67Kkz2xyk;
	Thu, 15 Oct 2026 06:48:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::429"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792007307;
	cv=none; b=UBtnSqtBG1bIfTYAAE2mGMynL6G8UN9BzayXmOjko5isrH26pn/lLxkYefdfL7vWHO5GsSYFS7+yDjaErz6v+IAff7k5b8LibLmn+slNs78+m4hd7utGb5ffR+J5auRZEgsY6H3wBYkeygq0wY2FJ1DqhXMZn4HhcqdZ0r0WQ6rfZka7OrQFuQ7m77MtsLvRckYj/Qap2jI93jQLLw2FC7fLo8YbIYx8mdbg/Op/duQGIr3Bg5YR6WBMBGb+wsSLsfrnV9W+24XQsRJBkKVrfyzUfi7DcgGuiVCVU1Kt2thH1ZGrIeCi16v0A6onNKHvXTmOjUcOVnPkZCvhlt9rCg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792007307; c=relaxed/relaxed;
	bh=j1OEKiLFmZZA8uQuqTPnrH94Sp0/0PEPLNTXQpBXzI8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W8iuMM42w35gTu6wc1H+zo7guRgmHcyYiHJL+MFNc7PcL3zGalgbRmWGMCqRpK9nS59+hd3y2dOeeHzLAB6ZUm35KWiZEW9LK2hPOOCPuwVkF/H0rTt0FGd2SiFl0MAokzMGzEyQzU29W7sau5491GsiEdgGwyEzCFqh947N+uyGOhxN7a6+lEKNjk6YWE6RSxTwyTWvgwR08eYlsRgvEM+uXvEMdUzKLRVfOx36g6oLaoBESnpbNDbPZwc6mlA+xmPZve1TWGWI3DJSCROeYJmAZclIzWGL3CbSakED9Z99BaPs8h2h+4vlok4xvdb4FUVNY5wcS+VJAMRLD614xQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MDHzOp3r; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::429; helo=mail-pf1-x429.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MDHzOp3r;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::429; helo=mail-pf1-x429.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j4hZy1HrWz2xM9
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2026 06:48:24 +1100 (AEDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-8874539bccbso485157b3a.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2026 12:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792007302; x=1792612102; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=j1OEKiLFmZZA8uQuqTPnrH94Sp0/0PEPLNTXQpBXzI8=;
        b=MDHzOp3rgyzEjn6uPhFKxvA6LM0bCy4gFVjCApUtmLydDHzmnYd2ctL7mKoVMOvVN1
         Vo+QOSwo/wdhKvU2iakHUAWt+rPikxvtqHB9Geep/0LwLW+asZmw14zgDsmUp7oXrcQI
         25AmRCVeFMbyKGct3HpF671b4OY1lk0KApTS2ELORSInCUUJxLSQmEOaoO7BsA1JjNHt
         cl0D2v1DQmby2sA9+jaKAMdEImkKtQf77OOe+u0X9yeRyPPAOFJ8iVkLbu6Kef7Aquns
         v5Wwp1lrfyOhXS3qR4AJ4d8dWcMd5xxv1nSZ99b0yEACP6V1m2WEdEPNbJQn+ZHsUnTE
         UwRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792007302; x=1792612102;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j1OEKiLFmZZA8uQuqTPnrH94Sp0/0PEPLNTXQpBXzI8=;
        b=WBbv403L24GsG7M4HlWNj0Q5qMHii22WhcMvdZxOThS5p4oYo2geT9gF9iB1pKwkOK
         n/jWEDNzXI50FUHtK4PkFAMUPk2Z1sRbIuP9OPec4rop5AJVN0pD/pXR66bVwq9OodFu
         7/k4Z2TplLcUOvz9zDGFPLu6XS4G8QVPw5lrbqtw+A/6ezV0ptk37hK8H3FYbIC45C41
         NUdl6oXUtoEFk84LWvHSAv5tbDm7pydHYJUusOSgsoNyx3qj6S2PoSZlkoCvXxfIGF+D
         LwSDGEr8ZutOk+/Wft95yyjuTZ2yDPWYNCOTR1D2B1yaRhJy/wNWKIq7ocmIPHX3l3PE
         rYeQ==
X-Gm-Message-State: AFq9FYLvW7kYRthoSu9EIDiESUDwMojwfSv6wGID8D22Iohn3zHzZ3Xd
	M6WUoFlVFaRPwzI9U+CoxDMEph1QDRIHvAF+bMlU7TJY0DkLcNRmUU2oqQ61IUGB
X-Gm-Gg: AYBFou2gsI2ClmWV9r/uUJne/CKkGLSbxC8f4NXwxH392+ugwB8keIRkbL8Mt1ydkGm
	NERqrPmn7+M4UljlCxS35/U7SF5wwebGzZwtHHAuifxJ+ZK5dx/7c6vv9XaIPJ+C20L8mpYP5jr
	u4fsBBsG4xJ2UtP1EiWLH+OhphYc2FNZB+ukuI+8AtaA1pl0vYzxpA1N07Qfs31HK5Wl4OWR2he
	+Y8tvAXg3xSo2H2fB29x1HgzVtgH2SJl+AfR+bivmD5DBckL6FFZ5arhTrcT7nPG3//fEGzsNrb
	YpyiF3gb10+yuWY2vt6bWwTCf7qK8my0A28FLMUAnBkaIgoi+q4woTNwS4334TtS8ZZnfhk5mgR
	6hYR9zXFNCPvQ4LqR2LLZ8gtOyFx6nEMGw02gCeMA66ErjvjVsKYc+ki1YyQGE/aUikxMskMheZ
	1yMN/7CD8oCudMXD3DU0xVG3Pvvo4Zo66Uq/8KnvWNn/a/W25WbU6tBz6JjhwDCxO8/nwS6VRzg
	ssG97t9jw88TKQTVoWNM/1JR7M+Y2Xm2lGPnTRnczMMS/TIt3XXJ0qCnH3Kr08im3aivpVTXvcW
	IKT+To3ABroOcAAXVDq+v/Bw5zgmCdjrk7cvEkgw+GHp4NoV
X-Received: by 2002:a05:6a00:1806:b0:881:552b:15bf with SMTP id d2e1a72fcca58-897c6e1b2bdmr16161905b3a.19.1792007302159;
        Wed, 14 Oct 2026 12:48:22 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89d8050d76csm1468779b3a.52.2026.10.14.12.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 12:48:21 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Michael Stapelberg <michael@stapelberg.de>,
	linux-kernel@vger.kernel.org (open list),
	netdev@vger.kernel.org (open list:ETHERNET PHY LIBRARY)
Subject: [PATCH v3] powerpc/lib: prefetch ahead in __csum_partial()
Date: Wed, 14 Oct 2026 12:48:17 -0700
Message-ID: <20261014194818.11640-1-rosenp@gmail.com>
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

Issue a dcbt MAX_COPY_PREFETCH cache lines ahead in the main loop,
the same distance csum_partial_copy_generic() already uses. That is
128 bytes on the 44x. dcbt is only a hint and never faults, so
prefetching past the end of the buffer is harmless. Lines that are
already cached, for example when checksumming data the CPU just wrote,
are left untouched.

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
 v3: use MAX_COPY_PREFETCH
 v2: reword commit message and retest numbers.
 arch/powerpc/lib/checksum_32.S | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/lib/checksum_32.S b/arch/powerpc/lib/checksum_32.S
index cd00b9bdd772..5bb872e9e68f 100644
--- a/arch/powerpc/lib/checksum_32.S
+++ b/arch/powerpc/lib/checksum_32.S
@@ -43,6 +43,7 @@ _GLOBAL(__csum_partial)
 	bdnz	2b
 21:	srwi.	r6,r4,4		/* # blocks of 4 words to do */
 	beq	3f
+	li	r9,MAX_COPY_PREFETCH*L1_CACHE_BYTES /* prefetch distance */
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


