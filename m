Return-Path: <linuxppc-dev+bounces-22727-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9067CD98E1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Jun 2026 18:30:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gfwXS2zBRz3c52;
	Wed, 17 Jun 2026 04:30:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::631"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781634632;
	cv=none; b=aez70kEtZUAWS5hmZ+i842osvfAizczlzEJfatzduTcFspXAIEGTBvZkXeItnRSS3yYVBsnG8+U+Gwut1r7yUsDDR1fIdFnlsCP0pduKarTr/M+H2A1xddi5a7LvR6K4RN8F671Vr4Pjfwh1R4ReWoApooOmjleZsT41Swaaxi3hyF5TIs0E1YgRlyoxNjuvWg/hY62M1UxnG5CCTwveG67tyHdYHv2yt/UMeTiTDrBBELuj+C0z4ZEXta38kJWks8ChYQ63kSEVqkg+6i6WauCb6Pn2j35ph4896R77PRJN2UI76Tv9YO6BPBq0B2e3wc+JtlruUphMl0Js4aMDkA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781634632; c=relaxed/relaxed;
	bh=K1he5shRljJErqV+epkFIAgUXMzw0QNV0w27axVOLuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gZDL98YvK4tjJW/M6qkhG3Fuk7HBACxC79iyqbqS3StRp7Y9/9YHhP+Z0okBAnAs/E9dU/q2Q2iSpXKrtVS1Zq8hjbL+kP68V3VRPFv9q+3LfOV583VG0ALTdBIFz44iywinabDCtWSVkhEbiT5Bif2LQacC6yunM/eiBdqDsvpQfZ/RNUmgKPHSQ8sMaW3QHnC6rTCdT6OcfDHZ4oA+qiy7BCyIObO3A5XSimtECZHvVMMNWhDPEEgqM5vAnWWUOjNPi9ij2f7M8gvv++2OtJ8w1P1ImHWsY6ruZn/naMqaVFGduEpOjbSfTNH3J6c+TqpFtQnSbpCBXs5a31XNQg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WOsxJe88; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=ekffu200098@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WOsxJe88;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=ekffu200098@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gfwXR4Tm1z3c4Y
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jun 2026 04:30:31 +1000 (AEST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-2c6a97e1d1bso5698455ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2026 11:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781634629; x=1782239429; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K1he5shRljJErqV+epkFIAgUXMzw0QNV0w27axVOLuE=;
        b=WOsxJe884pnapGqMI1mCaRidVBlAHcPA1m2V/9BAhG7KkR+2l/nob7WE65MjUeYQQi
         yOk/q4ICBpB+HU/jQZQWXnSSidMOwTFVbbLzswSAEoeFUBeX6XRPznxDadYlmqJdlQrm
         G2lHT9pO787rsOFwCzZecMNMw1WdApUgwGdSaZ+CZfAAR+gMTi6ss8Gl1B4AggsEZR1Q
         RdJsrHkwt1Ix1MkVV8IwD9JrUjAa4CQFBSX9kA6fqjX4w7NnvbSX2+2HKVLvqB+1z2c4
         ohoLxQgGeLckdNouWURCoW4No80tp17RSxLF/sac1IgIgSUNVw/JwD3ljInl30R8Z8Xq
         qsuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781634629; x=1782239429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K1he5shRljJErqV+epkFIAgUXMzw0QNV0w27axVOLuE=;
        b=Q6BgBzkwzYD0G+aAfwkzXvebY6DieKeXZ6MdoP7PsNSFyqYNeL8rqQsHyJFTeo0q4y
         tIeeAvnBL+r1U5XTuaFM9Ocx02FpXVJuC2cYibapIGFleauVWkV9I1dK1FDMifZJE+/K
         ARc73msBlPzcRN5zLEW/dK/cOSPGSzz7n1srnud+XViZuZoaoLXe3X5P8umExfmpjINr
         yBZBF6GAmiIYJwughL+hTWH89AK4AIyeDwWOXrF7q4b+vn+1VySrIWLV3GgblbaVVvei
         xfQQbv0u+szHZ/9/WaBLVY4mr3rJuzJ8tOscOVkCEu0OAHhYRoKUDH3L5aDWfuQr4d70
         3ntQ==
X-Forwarded-Encrypted: i=1; AFNElJ8ewQ2lGw55awv56gX7APWYqnPzwO33SxC5AVRlZy6th88oEczFuUAa8Co3iYxTrYoBOtAkIbWLrZKb7kg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwYT3PK+mpgmeBgOr6Yi/F+htkUPmCrjqHM4x8gTYDlDG9iuzpE
	DSKVup0TlNs9vfOcr6xfy8fa0Brk5Ls4MZ3JOJ9oes0ZCQyneJHZTq0L
X-Gm-Gg: AfdE7ckvknghaqBK2egrCAEZGDYGXHVIh9f2oibCqLxNgHVra6F+MagMDIyP5J/YOW9
	DzE4pK1/O0foo/O0J3DySCjvtjrNia1G7ppAfg+rGhp/WgsZxVPkxEtVc4uqfW1heyBvTWnF0qA
	nvJdZokfMS+QWjfIFopPXLjECfQEE7lXfKZzDci0fOtRXaoWUHmDy5s300PDrV/HgNf9odes93x
	M3kHmOMlmJJoyBISvnlz96UyU5qfUHmDBly+MdHSFK80PJ+rdwIFY7xVEaI60rGzwy0nSk3kA5u
	eqPVHuU4ZExbaCB2SDTVRM1fGbLe59B6euq5k2sY7lDfyeQdSpSHTGqdMK1HKfTkKqy0ApXbNp0
	P49WrYg3bCk0ibmZdTah6jTHWis726cYyrGqy8M4S95zTuLq5WbWSvjfupNAN4iELlj3/kOXyAG
	216NNXTVHNsoEFZr7FPA==
X-Received: by 2002:a17:902:da88:b0:2c2:245a:336c with SMTP id d9443c01a7336-2c6bc0aa0camr2020545ad.14.1781634629498;
        Tue, 16 Jun 2026 11:30:29 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c43345e3ffsm141092685ad.71.2026.06.16.11.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 11:30:28 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Cc: Sang-Heon Jeon <ekffu200098@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 3/5] powerpc/fadump: remove unreachable memblock_reserve() return value checks
Date: Wed, 17 Jun 2026 03:29:54 +0900
Message-ID: <20260616182959.2429774-4-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616182959.2429774-1-ekffu200098@gmail.com>
References: <20260616182959.2429774-1-ekffu200098@gmail.com>
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

fadump_append_bootargs() and fadump_reserve_mem() both run from
early_init_devtree(), before it calls memblock_allow_resize(). At that
point memblock_reserve() either succeeds or panics, never returning an
error.

Therefore the return value checks are unreachable, so remove them and the
related logic.

No functional change.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 arch/powerpc/kernel/fadump.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index a313b1653124..88ca6156b81a 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -154,13 +154,8 @@ void __init fadump_append_bootargs(void)
 	if (!fw_dump.dump_active || !fw_dump.param_area_supported || !fw_dump.param_area)
 		return;
 
-	if (fw_dump.param_area < fw_dump.boot_mem_top) {
-		if (memblock_reserve(fw_dump.param_area, COMMAND_LINE_SIZE)) {
-			pr_warn("WARNING: Can't use additional parameters area!\n");
-			fw_dump.param_area = 0;
-			return;
-		}
-	}
+	if (fw_dump.param_area < fw_dump.boot_mem_top)
+		memblock_reserve(fw_dump.param_area, COMMAND_LINE_SIZE);
 
 	append_args = (char *)fw_dump.param_area;
 	len = strlen(boot_command_line);
@@ -632,10 +627,7 @@ int __init fadump_reserve_mem(void)
 		    (fw_dump.ops->fadump_setup_metadata(&fw_dump) < 0))
 			goto error_out;
 
-		if (memblock_reserve(base, size)) {
-			pr_err("Failed to reserve memory!\n");
-			goto error_out;
-		}
+		memblock_reserve(base, size);
 
 		pr_info("Reserved %lldMB of memory at %#016llx (System RAM: %lldMB)\n",
 			(size >> 20), base, (memblock_phys_mem_size() >> 20));
-- 
2.43.0


