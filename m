Return-Path: <linuxppc-dev+bounces-27490-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B73A8C982C3
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Sep 2026 15:13:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hlMpX5pS5z2yGT;
	Thu, 17 Sep 2026 01:13:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789571604;
	cv=none; b=dRGl7MvwSjasxHbV/L9rBERqzYqnTQ4TAvDPJgsbCzE/E7i0mjg7aFzpg6PEP+KRn5o3UqkcdXPoLCfzYe2t5rZxMKDUaSVxwOa5HMNDnlnQtLOr/W9hzBBkNAwgod5XyNK+I7Q/yfk55l2NVtZ8qUFpvNJx63QF0Pxhh14VIAuKYI6FZgcdlehl8JtBTcdwte/bzDTLBxWLayCPhQEBDsSEkYH1iEuFaC+5PEGIOkVSNh0qNYF+Q3elGfCA1WmE5vGH757ODfBME/jD8zhV5dBIqYRg4Xx7tDcO1+hmSJ5TwmPiANUAQr+Zaiz7c+GLkkT6mhGbwtGFZCScUoLzGw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789571604; c=relaxed/relaxed;
	bh=EfiDcpeJiDNKPvZl61Ff5PtwQjnEBlm97861RTojIS4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EjZ4uqaLh4L98UpEfa8Sw64jpBg3UF4/VC90v2yTy74NwfFVB0JbMLpY5/+2jRsN4Oo76/Mr2TMY5Qsa20Fsdj8/F3jz67x9inWFvV5NAF39y/6wPLhV39HBN1oxjnl740a971Ze3JSo86+EvIy/pI46JlasxBkqmWR/B/qwJPAxyiliNl4G73i6GjR42WLqVcYeW+L2KatKcw6K0T9NhcLRQzMfTYzdQ/Fw4HS1HJbMqquA7NBPQzZFCL7y9nAfqaKr18ZE3hi/47I8AwaBpZoHM7IpTGdpwYqcyQGr8kfvGbE/gYA5/X9jDI5ahbdXUnadBj6TxKvcH5xhA+quww==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R1debaM0; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=blum@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R1debaM0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=blum@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hlMpW5YSwz2xqp
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2026 01:13:23 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 2341F4148F;
	Wed, 16 Sep 2026 15:13:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 164491F000FF;
	Wed, 16 Sep 2026 15:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789571601;
	bh=EfiDcpeJiDNKPvZl61Ff5PtwQjnEBlm97861RTojIS4=;
	h=From:To:Cc:Subject:Date;
	b=R1debaM03SBh1osZZ+x21/1BLJ7fdq57H8PS88WeA1QRyjNn1Fxqv6emg/X2wh4sD
	 dU+2TZt95mAwYcyxNKFWSwlA7BtGgvOEIEQkR/i87AemVLoMpCx5+/xUEYqy2Iai1A
	 QTbVdR7E6CthArqNyPDY2m1uxIRfNKsiuYMia4Pc32ntHCIR5LDMULsQ9x4TSr2HVI
	 p/lzV1xKpLnTNoRVHcv8Zq1AjC0xYIUTj0usBg+VKEdKA2LuXsdRbWBEjCOAc4ssVz
	 dnEKdEhEjvyK+3g/L5dLUis9AN5ngXDca7AN2BnYf3PCBY4KrR5QQ54ftsNlhJX0zn
	 VimiNyilaxSFA==
From: Thorsten Blum <blum@kernel.org>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Thorsten Blum <blum@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/sysfs: Remove redundant wait time clamps
Date: Wed, 16 Sep 2026 17:12:54 +0200
Message-ID: <20260916151254.120629-2-blum@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=953; i=blum@kernel.org; h=from:subject; bh=hkj1eYUfDe8QekhEvX19k7VsTERrsklhsYarx3TxM5Y=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFmrNn775Dxhdsz6i5ZSubf5H8lvez01sOBXA29ajuGl/ SF/wuUnd5SyMIhxMciKKbI8mPVjhm9pTeUmk4idMHNYmUCGMHBxCsBELuoz/GZZtWtut1vcTttz N2L22nTkqPbssFGXCun8+qq6uWda0wlGhsVC01v4Yr+utmAUbDs42yU59JqKCUPdnxiNB1kMbyR qeAA=
X-Developer-Key: i=blum@kernel.org; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit

The wait times are u64 and cannot be negative. Remove the redundant
clamps.

Signed-off-by: Thorsten Blum <blum@kernel.org>
---
 arch/powerpc/kernel/sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
index 329c1690b5ed..2100c5e2c821 100644
--- a/arch/powerpc/kernel/sysfs.c
+++ b/arch/powerpc/kernel/sysfs.c
@@ -338,7 +338,7 @@ static ssize_t show_pw20_wait_time(struct device *dev,
 		time = pw20_wt;
 	}
 
-	return sysfs_emit(buf, "%llu\n", time > 0 ? time : 0);
+	return sysfs_emit(buf, "%llu\n", time);
 }
 
 static void set_pw20_wait_entry_bit(void *val)
@@ -460,7 +460,7 @@ static ssize_t show_altivec_idle_wait_time(struct device *dev,
 		time = altivec_idle_wt;
 	}
 
-	return sysfs_emit(buf, "%llu\n", time > 0 ? time : 0);
+	return sysfs_emit(buf, "%llu\n", time);
 }
 
 static void set_altivec_idle_wait_entry_bit(void *val)

