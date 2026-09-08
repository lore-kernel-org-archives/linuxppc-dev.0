Return-Path: <linuxppc-dev+bounces-26725-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC44BC79F99
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Sep 2026 05:51:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfCkL24G8z2yv0;
	Tue, 08 Sep 2026 15:51:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::533"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788846714;
	cv=none; b=f9r4We5B++n1R9OaUKJ6Uf0id6VzPjlXzdWpdaK8v0DuupoDAB7aywXlGaad1AYiM7tYqV3NnE/hmBrl3RYtd6vDabbS0tJvA2XDB3ZGVmif5BHuuZUiT4akeqOD8HqCAXTHtAqhMZ+29m44rbKdao1GNtSvGcK+KysZ1h0fvbIP2W9V2YsXHtfWp7KktGQGOam2vsux7l74RldlvBPryOibG2sbR69SyggZHa/Umu2wJjh6YzhRoxNQ1zYu3l51HxUbJhmQzTSEO4omcWGy/0pNZUX3gQmMRbg8yS4iFwo694HgXZqO854nO2m5gjvV4cK2Q0WkzT7OQs4VY1z84w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788846714; c=relaxed/relaxed;
	bh=eU2hqSZpbBss3ZrupUP6xipFsBQw4quqy4F00JT4x5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cynv+eRmMibWdjWU+cpW5tR+SVxKbJ36tIEsvEaWGPHS3e8hrmmOzwosxDsZw/gktuCOPc0Y3cM/bDSxYhbyr2Zf/8r8jOGkgAmlgxjfcHc+UyrrZSLWuKYJ812aq01DV/zJ6/R9+dVRNvraRFU+4EDFSvolawMY3ZTgWk1Dd3zA9geucdpZgtC4o7WNbbd9pzYCAZdX4hjxhmpFF8LcLC4DsrYEEpOto3eSM8PJmqnV3nCVvLuF/t1JeQlfjL0Ay48xfMLu26uG6R50r4RaD0+ex/L2mhWrvclK35JrMIshtv6WE9/7msydUXJ0BeIoMdDNycFy8yEj7MYWB4kovw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jEeF2fsg; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::533; helo=mail-pg1-x533.google.com; envelope-from=hemanth.selam@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jEeF2fsg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::533; helo=mail-pg1-x533.google.com; envelope-from=hemanth.selam@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfCkK3dxjz2yFK
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Sep 2026 15:51:53 +1000 (AEST)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-ca766c1c9ccso2788492a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Sep 2026 22:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788846711; x=1789451511; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eU2hqSZpbBss3ZrupUP6xipFsBQw4quqy4F00JT4x5Q=;
        b=jEeF2fsg4QDO7GCeFVYVv4H68qZAu+nAy+vqUaVCg/3wBRf1f4QkArV3yUn4QFOJ6Q
         XbHsb56597fdUlQNCbxwGOw92JJc/6/A8m0fPXjN6TKnclb94eQ8ZAPPV1YmQIyjRI5e
         ROVABCUGNElPw/N5zJhv7HCK+Z7QyOqdYWdUBDKZakv6Aef7axjd3sVsTkpNBaSrGoE9
         RLU9JnMWz5wr4mQGKZwFvaD2Iggpz+0PztTgoWncATyLiKOp/c3ku4P6yTy60YumNYPK
         LPDCkZ65OpE+Ds1EHd3X+ZxgmSPkH8SzPa+kL8EA7qQ4D4p37WTjC/CzgyiaRHyIXFzF
         2rsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788846711; x=1789451511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eU2hqSZpbBss3ZrupUP6xipFsBQw4quqy4F00JT4x5Q=;
        b=jw4hgPDANVJBV0fBrfJP09xSFtIYtQ0v6XIPpS702jEDZwuRLHUuywKm2OJxIu2AK3
         /n49ujcSJ++SNBQfFEVEbLjXzzfUWNgs2qIVHCpb7gKqur1muDvA4gg3VU4OYCUY32Vx
         pzRhEVdXCzBG3e64eZDZwmItQNOg0FWU//nmMfRFE9csA5WRMdOfTwFm8ytgph0L5LFQ
         /uUitTvJIYvU57yIicZGctMVbppjt8xXWLu6ibWKe8tB7NlBNOxQ/y0P0Xep1ChG2Qmo
         O1WPQUZL++9zds5dr5iYuikF6O65OOLIrIQZ3+tihC2aWDEwCNaAUrVu+ONNsicg2Jx/
         y0ZQ==
X-Forwarded-Encrypted: i=1; AKwUvBwOTx5j4IUtqvfTuMWpfTayQe6B+Pfnwcxbqoko/gzgFrKkiAj19uIGY5aX9/BT5V/BECx6IzzAv7B0jsU=@lists.ozlabs.org
X-Gm-Message-State: AFuF++kOH0z9wGNc0ZBCTSFEdHmD4B4lKl8QOodg3k3KYcQPXYhhQMC2
	zI+qdGC3h4a0fdGjEYIKK9kKT0scNl6EcOMMhe56Vbe/GJQZ4juMOU41
X-Gm-Gg: AYBFou1iAL/9ku20EC/Wrhr3tMNyP0opQn+DOFZoH+rf3SsDrQdQ0uuTAQl2l8/dhjn
	dWrwvPUc2YMy5lpWwzFEDoYZoZBeW1XDWvotb2gFRM9un07qGLXHd8M7zwQrozD0+z+zZ1N2Vo2
	4H6RHLXXGp3XCqmJvfrw9J4BKEVV/CRpPhUHeM9IQtFY318Ns2zyRQ4mkiG3SbM+VImm3i77stL
	gAfv7L9K+gl8s7KsG7tjA5+dd8Cbx4xS+cOdH/5jIKznpbjz77Z/Bes6nyZ0HoIqDckVIPuVFPW
	RmQvMvy9lOatPVdOajo43IN5yDJUGpi0FShByk1hqpLsnHS02hYbuGLGT/8ofdiGb1r7gFQeq3a
	knIu7VM//UVxDtIlAL6Odw8zfcapHjZf1nQvETFFPv3GNYLI9wRudlcmrhE4GDOsdruHomHkiQU
	z547zbtJxomWw1f9cwkVcV7ZeZc3y7BzQ1xJOrDbRBahfJzFshHgfWmW8K9ap3mhLnWrvLrNLwN
	jLdkttKwEAeQg==
X-Received: by 2002:a05:6a21:648f:b0:3d1:5c01:e6cc with SMTP id adf61e73a8af0-3da39f7bf83mr40842064637.10.1788846711161;
        Mon, 07 Sep 2026 22:51:51 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339a534df1sm37719041eec.7.2026.09.07.22.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 22:51:50 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Oliver O'Halloran" <oohall@gmail.com>,
	Geoff Levand <geoff@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Shuah Khan <shuah@kernel.org>
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 2/2] powerpc: fix repeated words in comments
Date: Tue,  8 Sep 2026 11:21:33 +0530
Message-ID: <20260908055133.16469-3-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260908055133.16469-1-hemanth.selam@gmail.com>
References: <20260908055133.16469-1-hemanth.selam@gmail.com>
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

Drop words accidentally written twice, reported by checkpatch.pl as a
possible repeated word.  Only touches comments, no code changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 arch/powerpc/kernel/paca.c             | 2 +-
 arch/powerpc/sysdev/xics/xics-common.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index 0e263b97e016..2e0c5bac250d 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -101,7 +101,7 @@ static void *__init alloc_shared_lppaca(unsigned long size, unsigned long limit,
 /*
  * See asm/lppaca.h for more detail.
  *
- * lppaca structures must must be 1kB in size, L1 cache line aligned,
+ * lppaca structures must be 1kB in size, L1 cache line aligned,
  * and not cross 4kB boundary. A 1kB size and 1kB alignment will satisfy
  * these requirements.
  */
diff --git a/arch/powerpc/sysdev/xics/xics-common.c b/arch/powerpc/sysdev/xics/xics-common.c
index c3fa539a9898..c2486b43c5cc 100644
--- a/arch/powerpc/sysdev/xics/xics-common.c
+++ b/arch/powerpc/sysdev/xics/xics-common.c
@@ -384,7 +384,7 @@ int xics_set_irq_type(struct irq_data *d, unsigned int flow_type)
 	 * the corresponding descriptor bits mind you but those will in turn
 	 * affect the resend function when re-enabling an edge interrupt.
 	 *
-	 * Set set the default to edge as explained in map().
+	 * Set the default to edge as explained in map().
 	 */
 	if (flow_type == IRQ_TYPE_DEFAULT || flow_type == IRQ_TYPE_NONE)
 		flow_type = IRQ_TYPE_EDGE_RISING;
-- 
2.48.1


