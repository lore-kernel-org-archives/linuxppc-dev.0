Return-Path: <linuxppc-dev+bounces-29190-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A7B9CA9EBD
	for <linuxppc-dev@archiver.kernel.org>; Sun, 11 Oct 2026 11:31:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j2dhp5WDVz2yPR;
	Sun, 11 Oct 2026 22:31:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::430"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791718282;
	cv=none; b=be+tLC9AprQ7zbCROP/Bcx2ugMm8y1Daiprb0JNSUquf1DNuDkI6UjDR2YB2O74kkn1dFUe8UsA3TXJl/C+wWD1KpCoZ3TbUG7/IG4jc+YVa378LfbTg+NNZLnae4siaCsr3gGnmmzPtvd4wJ9D6Zm/nu3WDSZfF/lXgaRCX7I9YKB1iZQyF7QjGwTVBSdeVRZSuVrtxhvK1T/gp2C+r3yUefOLD2Hi31niR6QziIwLuc/lYqw0VZfkhqCdamqExuYaY+1rT/rQfMo/y+NoLVSbvzhK0N+RGQS41oSJkGS/JVOtSSzxXQfJQYVkkUQ5VvFvQVmYOFB9TFH+rMFt5VA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791718282; c=relaxed/relaxed;
	bh=EJJ/INsTbIeg+id7HIvFFqETJLWr/g2Eo73Obn7P+RY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CPeouiujYL/sGuahkNYHH7tLUwJ4cTNI+cgjMMIMhQzsic1bBi0z/9d9/GiArbyjgFXziFd3em9KnaUmCKyWnZFUi8bGwBVAMhBPAx8UPp71lIY7o5jfCIGbSahxQUAoqCsf5/osoy1pSFjNCEtwRgnCoyDkUxH5vEkQ3+DDsaFk1YlNF6gXPbKJGyQTIHqa8syOcrq3nA6WiPSOJP5JiAcQUeDOaZ6//ql7MDCCgy820bwiC2/6K4wd5/yhGU2TbbOORO2cHL6QzgOk1lAXTw9G6G976cvANE2Lxrrx4t3eIRvzq+zuMLW3ytdI5o99limZfMmq8mXIUCLEIu3ISg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kESWjT4F; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::430; helo=mail-wr1-x430.google.com; envelope-from=julianbraha@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kESWjT4F;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::430; helo=mail-wr1-x430.google.com; envelope-from=julianbraha@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j2dhm4pVbz2y8Z
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Oct 2026 22:31:19 +1100 (AEDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-48c411d6615so588719f8f.3
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Oct 2026 04:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791718271; x=1792323071; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EJJ/INsTbIeg+id7HIvFFqETJLWr/g2Eo73Obn7P+RY=;
        b=kESWjT4FLJ6K0hlkiNI6xv6cha1CV1PGjO66/D5AyAQ9ipeSb5sui2feCj5bwqoVJY
         pCHFJWA6NqFW4yrz8XWH7y/qce3lEyhQiSl19AL5gFjQWEXyjaNDYR0RmAHKroF0HNnT
         b4L/YX/PWM5CQWoM5as/0GKEv+do5863PatK5D3BlWq8XsBPO2kBLtnNq5rXu0Y1DNwA
         4qiPBZmxwdwTDPgD9K29G8PYWYy8+vcT0ZyiugAURpW7ikGa8ERV07HaE3Cxl8Rf7WqX
         bcaqm1qKYLIkdoZRBgLGPXJ8+tOHw/uhbz4LH59lp2hqXSnTOIjd8XVkbuu/hae68Ru8
         s4Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791718271; x=1792323071;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EJJ/INsTbIeg+id7HIvFFqETJLWr/g2Eo73Obn7P+RY=;
        b=HGIqpAyJ3cgPFg4rQyLzaZsHEWT1J6sDhiFfkmSVocywKBpmNRI2VoM5w3jvLmmKzG
         zklBrE4+VmuKATP+deueuoujHT2qZXxDCAw9/KC414XhiyzMajLNGSTvxtsTlw9FClTT
         HeTgew1H8zM6kbIY2NxgIFKQ2yOuXHzLO9Wj/DYe47duvKZEweWQJwkScsSBfDDAdY6V
         aZrcqd3eoD8ogLtYumEjqXw5GyK2rzemT1M/VLt3nPYT70x7hOH2dqs1pIXh0gumvxqv
         6xOdoaGANbdrmTaKKQi4b08+9VT/599TZ8ZjgMDNH2dhO9GVKrwE0W3/S6WCd5DiDif6
         4HkA==
X-Forwarded-Encrypted: i=1; AKwUvBxQHplIzCLe53f63JZr5v5WSWFMIOMi3Z8Qtrz73SRvfslCLpvs+rjFbhcTLXpqTHV7XSoGuAkkZghr9vo=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYKP62wo7tp1COm+nONqNtJkWy2tKrBfqS8KwJ19Fp5Vdpo2HF03
	Kc9+K7kJkGNN0mpiXEGgN4/ekow5vGx8w4grqN4O2QQ1ojxMJt4wU4QJ
X-Gm-Gg: AYBFou3d02JluLrbSrOKWKuHNDsG6Zi246T7a+ikuLHjU4bD6QKGlrEvPFEFD8muEk1
	2FiHB9NwZJ9i8c6EcLQem3pdGh3odEQyoQJxQHYyi9Z+9EKw0SDcbyNLhzDdRBVrCNjB7jMlxQK
	g19JXMWgWr/0eX8V2plhugirWmzsF3ApohOC+PSlm5PS+siuLRh/uDJwhyqZEpsfs2aBnXicQaC
	oAEAoyCZExTeG1AVUWNUG+OR3Dx09Z0WW92fj4JZSItorLaNXdbFSmntHiBZLdJhV79ysX7Qo9h
	kk/BuXfXFkyALqJYpWhUKrYouEFFoBBfEV7K6oLkDryfHWHwcaj5xh56PfUpxVcTS+W5Zvk5xPG
	8rz6xhrNC7VY+zn1EMD2PpXOUKs6E9AjhPOMpy/tM0OkcVClUCK1jpHYrQifoQOL82AQWPIvFrC
	GY+yHZ3a0EmAHfk+5hUwuZi36/MmvgRSJMGOo+fq0NUKftvCU3GkLZgAEYyUPvfz8XKJsVcRfdQ
	0bYfmOdwzm5JLvdZtZz+3Q9YwbFHUk=
X-Received: by 2002:a05:600d:6409:10b0:4a1:96cd:2f6e with SMTP id 5b1f17b1804b1-4a196cd3213mr35135595e9.4.1791718270878;
        Sun, 11 Oct 2026 04:31:10 -0700 (PDT)
Received: from nixos-office ([81.0.251.149])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bea0f1csm305044035e9.9.2026.10.11.04.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 04:31:10 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
From: Julian Braha <julianbraha@gmail.com>
To: maddy@linux.ibm.com
Cc: mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	ritesh.list@gmail.com,
	sshegde@linux.ibm.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Julian Braha <julianbraha@gmail.com>
Subject: [PATCH] powerpc/Kconfig: limit the PPC_85xx DATA_SHIFT range to STRICT_KERNEL_RWX
Date: Sun, 11 Oct 2026 12:31:08 +0100
Message-ID: <20261011113108.539470-1-julianbraha@gmail.com>
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

On PPC_85xx, enabling DEBUG_PAGEALLOC without STRICT_KERNEL_RWX activates
the DATA_SHIFT range of 20..24, but since the PAGE_SHIFT default is
outside the range (12), kconfig adjusts it to 20, causing 1mb alignment
instead of 4kb. However, the larger alignment is only needed for the
separate kernel permissions provided by STRICT_KERNEL_RWX.

Since PPC_85xx uses page poisoning for DEBUG_PAGEALLOC and does not
support KFENCE, let's restrict this range to STRICT_KERNEL_RWX.

This out-of-range default was detected by kconfirm, a static analysis tool
for Kconfig.

Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
 arch/powerpc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index c3b6cd655606..5e2a4799438d 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -896,7 +896,7 @@ config DATA_SHIFT
 	default 24 if STRICT_KERNEL_RWX && PPC64
 	range 17 28 if (STRICT_KERNEL_RWX || DEBUG_PAGEALLOC || KFENCE) && PPC_BOOK3S_32
 	range 14 23 if (STRICT_KERNEL_RWX || DEBUG_PAGEALLOC || KFENCE) && PPC_8xx
-	range 20 24 if (STRICT_KERNEL_RWX || DEBUG_PAGEALLOC || KFENCE) && PPC_85xx
+	range 20 24 if STRICT_KERNEL_RWX && PPC_85xx
 	default 22 if STRICT_KERNEL_RWX && PPC_BOOK3S_32
 	default 18 if (DEBUG_PAGEALLOC || KFENCE) && PPC_BOOK3S_32
 	default 23 if (STRICT_KERNEL_RWX || DEBUG_PAGEALLOC || KFENCE) && PPC_8xx && \
-- 
2.55.0


