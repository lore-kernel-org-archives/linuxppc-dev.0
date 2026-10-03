Return-Path: <linuxppc-dev+bounces-28867-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ABD7CA5FE6
	for <linuxppc-dev@archiver.kernel.org>; Sat,  3 Oct 2026 18:42:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hxvfS4kFTz2y32;
	Sun, 04 Oct 2026 05:42:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::333"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791052976;
	cv=none; b=lMTIhVToVwy5boJnCwkg9ZAE34VdsnQXkSoV8EpJhN9hwOFBJlSDSoHsUaHJ98FNnqB3DSGBaBxuGNA6PZGoQ6YDk36kNlbaQVXmcske6pFozYeVS/sN3PB+rIU6Wgm0FCY1BwqQsLHT7KRwg/ZgP+eQzOp1D8leCY0Ij+YvbdoZDXHSRD04wEcjfkX0BGNlQr35nG7KsG5rFgZ6i+ZfeiyIJqe5AhL2HQ7lmXBhCINFaB/xYyIM2y70oM2BG6p63PBeXADL9sqbDDRBRpjByN7pRXFVoMBQPEwle3tTBE1WrGgcQxgZxz+cwX6EVLxW4XAwFXTkypy8H4PF/5ketw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791052976; c=relaxed/relaxed;
	bh=bZGoz0Gc1L+br4jm8tbpJBdxBSRHrIPgq8dt3xJ4aBQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IA+KF5GSshlOR4iCq/2kF33IKrIG3K6ycgJcFm2uNEV+WCuE2qbQAFanuXct3c2Oq3+NS3Biz4rlyw/5ld/78k+30edcMRyjVpp2dPxKv77Ebs9wuipwrPdnb+PYyy3o2IJ8bJjgL0KSsvfcCcpIWxSgOa1aDEGZ45OcupLOif19X+82uj9L94Kuw7pt0CPrJ/gAzeVV+6kkxt9n+pWRgfPq5sPJAY8MxFtOxv2qr2De46Dm6UFUNhRxNQqjpwagsUkOr5+YRR87sQP8xirdR8aA7vHNMl/8lqOz8Eal227mb8Ym3Hpn70GAXnQq7+CU2Aqfo5EVbr4gGnIFd/50HA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ep7snbCF; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com; envelope-from=kmehltretter@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ep7snbCF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com; envelope-from=kmehltretter@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hxvfQ2F7Mz2xnv
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 04 Oct 2026 05:42:52 +1100 (AEDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso7543685e9.3
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 03 Oct 2026 11:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791052964; x=1791657764; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bZGoz0Gc1L+br4jm8tbpJBdxBSRHrIPgq8dt3xJ4aBQ=;
        b=ep7snbCF1drUtSY9tp6Yupbp8ZXP3Hb5WYSsSqtJ89VCd+XHp/fp2Q/l5H/687dUDz
         nMbjztG+QVD/wq6DPDYP+oCTnxA/T1Bc9gm9j8QXhbEc56fHyT3DxHxky5ygia3NOeUO
         YCLxl6TWrBqI0suYpLUgl7FbAov8ywaYbDn3vCCaIejjF0AD+gfhGJiU9lX7UBBPZGeS
         4iYVk+L883tJTv3ISU8kQtgmHGE9veUcxCuVyrJfvGA5LrwPJcd7At0qXsVhE09jGSDo
         B6lhppDom0jEUISWAkbAYsi7mO61rhZxQXrP6ItGg2zMjL6PzeAaZNmG44y0X1U5E4kf
         lapw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791052964; x=1791657764;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bZGoz0Gc1L+br4jm8tbpJBdxBSRHrIPgq8dt3xJ4aBQ=;
        b=igSPhnw9zX6VKpycpQo0HGdRu3fR+cAI2zk8g629vKskj12bccdcHSmHRtc4tc/DpO
         5EEfXlzRxf55afW/U7H9hAueZxicIQbUwkAp5gSoN4gqNvpEZetXnMCmco+odHbZ6ERG
         F2iRsyGBU7y2t3ETwPRlkQqXilyGukYNC15SyQmrIDYDpyoiLyeD7pARj3ZBEviN+Hqi
         jY8n+ozF7HBewhpasmdM67lgvLzaHxoUMr8LAEfAtXlVvIScd3uwkFMGO8fnOzNGTtVe
         drtXRphRxqys5m0Kkzrpup/R37Wh1YrbWdWSSH3r5HjApzyXTcU8UGqA9KOiklX2rDe8
         RcwA==
X-Forwarded-Encrypted: i=1; AKwUvBwpZ4GQHw+IYr9TZtRP2xHu/V1/9piu2OLevVs44gbn9+tcnrrKAzqMuKdr+bA+Er3W+WMH+B1RMrsEm+s=@lists.ozlabs.org
X-Gm-Message-State: AFuF++kti55TNEie/9/Qf1CQv0D+BUh3fBZKmaySL7hlmlG8HA6mN422
	XxZiCUKTREJtIYBijqsMojzL6AyZtBh/fCfDQlGhB3VU8YKq+Z51bKfg
X-Gm-Gg: AYBFou2TEiIKPHXMJqfh7ZsCRon2gYHQHmdIxy3T7hxrRh0HpJhbj0pBCwcLZvj3Xq/
	dYfBDlmUaEJgYdxON8IHdK4U8QpWwk1jUHe/APEmxEvw1bCLcCprHjAwkeeMsnUAByPUOqYGzLY
	EinPKAO0HvyNWRZdMYQ5chupLJ7gIvLB07YhBnxBHVTOx9Lf4SM+AG+yOryihe4XHDSVPbuDheu
	cqiPDXPgK1AWw62kZRFPXjcao+IYxNRRkCH3r/gOqvKDnmxz3S473BBszr+BWcK91Z2EwkoMf7F
	6AMZJXe5z0JuWG81s8Zl3hf46o4qJABwoCOOkwxcpEcAwIWgdLMpSYW+xZpagPGyqqOVHoVwl03
	3H0NFQZZ9dXqUkqonFIwLcayUTqnWL3fVLf5fkinT7BvkOFRkgGWmS5JNPBaHSW/6u2N5oNl6zq
	33mJF3+g4gjKaw2h5qzxws395Z2Ms+aOUVwNwj8l2zWQccPXZysMhfsGOycOfPlHhaVxqpRaoow
	LuAnWSLNQ238mpOhbrwgrAOc5DoN/yoBFo5SyFQEOUNHiPB65THjn7+xAiXsQ+xf19BvR0Mrzyq
	u6eJf1crYpacX1teLAMtfX9PzWYhFxzpMDPfKiRyBlz2JKWstOMyN6/5YxgzPJssm197iyZjz4d
	8pg==
X-Received: by 2002:a05:600c:1f84:b0:49d:17d4:d6ad with SMTP id 5b1f17b1804b1-4a1680fdbc3mr46273435e9.23.1791052964121;
        Sat, 03 Oct 2026 11:42:44 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-b2e2-2001-c47f-5a89-3d9a-cd2d.310.pool.telefonica.de. [2a02:3100:b2e2:2001:c47f:5a89:3d9a:cd2d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a027735be1sm259072935e9.11.2026.10.03.11.42.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 03 Oct 2026 11:42:43 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Hari Bathini <hbathini@linux.ibm.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Naveen N Rao <naveen@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Abhishek Dubey <adubey@linux.ibm.com>,
	Dan Carpenter <error27@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] powerpc32/bpf: return false from bpf_jit_supports_fsession() on ppc32
Date: Sat,  3 Oct 2026 20:42:26 +0200
Message-Id: <20261003184226.76740-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
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

bpf_jit_supports_fsession() returns bool. Commit 92258b5bf1ec
("powerpc32/bpf: Add fsession support") made it return -EOPNOTSUPP on
ppc32 until fsession is validated there. The negative value converts to
true, so the verifier does not reject fsession programs on ppc32. Such a
program loads, and only attaching it fails because
__arch_prepare_bpf_trampoline() returns -EOPNOTSUPP on ppc32.

Return false instead. The load then fails with "JIT does not support
fsession". Tested with a ppc32 kernel on QEMU g3beige.

Fixes: 92258b5bf1ec ("powerpc32/bpf: Add fsession support")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Closes: https://lore.kernel.org/r/202608010958.cYfBCQAC-lkp@intel.com/
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 arch/powerpc/net/bpf_jit_comp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index 7a612688e7a2..64e70f3226b2 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -539,7 +539,7 @@ bool bpf_jit_supports_fsession(void)
 	 * for fsession and trampoline on ppc32.
 	 */
 	if (IS_ENABLED(CONFIG_PPC32))
-		return -EOPNOTSUPP;
+		return false;
 	return true;
 }
 

base-commit: e767a4ea70a3992c37ed604157d32f0dfbf9b1e3
-- 
2.53.0


