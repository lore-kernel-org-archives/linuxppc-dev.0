Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C157606A332
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2026 17:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PuSz4a0p
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTXCh2jmyz2yMn;
	Wed, 18 Nov 2026 04:44:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1129"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794937440;
	cv=none; b=Yvzyl+jDgGjbSL3d9Px6RLuDjeZIT1YGijavRbiUvXfAGekungHbDwn02rmVgtW/y6EV3RxeA63bcEFjoNrmIMRxa6zmTcFctbouSkGVXwjaYOEsqk31N2YkNomQX864wIKElzT7qPaTUkdVrw+Fu0PDKkVgXnYt20XVhTmLbn+PdPYdlrIlXP5A53w1bLZdCXN7Dm4gw+HxJBn9KsJ+SFTgtd3Ate9o2TPLxwH+euo1b3exKe//Uexf4kO4UVl4xTEkVFP7AUPt2+oJMCeD0xAaNjOL8/PCV08UzEdY0XbHkI+5YfpeiScXHI+bjMOJXdWeakslZsVZACT9SYYB3w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794937440; c=relaxed/relaxed;
	bh=4i2zokTFO59EM5OtymCggaFGZxyWZfmPQA4ZgdZWwkg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h7n2VSLmPou9tmU7KqFPOxKojGETG9JjXO93mN0y3TnhMpdKWUrimeukF95lo0idaGSLk3kyRBLVB0iFyOocMCeF3hu2VnyLkADsZfzhE+TaXlq+aG/MaJ5j9Xo9yaIVWSbtbA3ia2cADWMdyNpv+QSUvolCpeSHc0f5BWDgFXPkillv96CT68k3BT+nuOPQMEVr0/29A8So05H+Uyh7Ia/G7gU3Eha5Wc3AHq7Eu2ZjBY8m9zZ89rcicRR7x9rgm3uxvPldhv4CE6rzfvL7G9nuC7RLs8BNTJcjP1lAmQHa7fK6nCxN8yhOzqDEegUgACYtpMa8U+L/WrUhGvp5jw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PuSz4a0p; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1129; helo=mail-yw1-x1129.google.com; envelope-from=mattst88@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PuSz4a0p;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1129; helo=mail-yw1-x1129.google.com; envelope-from=mattst88@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTXCf6rh5z2yDm
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 04:43:58 +1100 (AEDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-8b315dd057bso31496117b3.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2026 09:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794937436; x=1795542236; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4i2zokTFO59EM5OtymCggaFGZxyWZfmPQA4ZgdZWwkg=;
        b=PuSz4a0phb234DLSH7clWEfEC7BDAh0T/aSoXTqbQ71VZPzQDirTYzDQGX9D6X7+mP
         RkrrSMGIGO77SmRkKowm8o1/inIz+DfUDp9Ajy9mu9jyglSamANSbZNjzJm7aaKVyii6
         HAe5sVUzuv+d9xm2pdmrimeMVB1MimgPT5xQ+SPoHEh/ujRPN2WJct3EBCtmat+Tiq62
         uWpyhIt9Kkt8XQBC5Vl2NPYV1ZHDVE5iLGT7QFMRVahYzH9NED0TtKhRKKPL0P0ueCm/
         vyJj76n1dCywt9qJ6zaWwPelw8n0V1lgHvmZrnkGGlRsQanzWuT2fszFFQ75s1LnhT5J
         P34w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794937436; x=1795542236;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4i2zokTFO59EM5OtymCggaFGZxyWZfmPQA4ZgdZWwkg=;
        b=EbtpFIedkL1KSUuYz7GwcK3npKjLEhCN3sog6IvO2YK0wqs6AHR4P/JJ3gqZKRjAWD
         /t9/5zWH8lEkrfHSdB+13Xjivdk9V7Cj5eRTENeb09cq01Uok71HaUNL/3jv+d6KC7qV
         Ja2U2gA1PcaPQ3HP+Q1p3IGXQQ2Ek5eOGUR63Hye7jzv9yNGrebhQ1HuzwzcgpZqUQn7
         FUZMyAtCjUWzQD+Cnn/Ioqa5+8F8AWAKjJAtxBFEzjZeCX23MoxAIY/qZa5yvKzzXx8a
         02yFNGYYqi28kp2RW49Ft/21dG1dKpPeJ4rCff+Z06aooljKKuKmiSp82V0JkLAoX3IG
         SK9g==
X-Gm-Message-State: APuU4Z+BwkuIu4l/vA9iG+y/d4LnrDBC+iqqOmm4s54tQhw+t02d0GiJ
	7wWrkyjMREa3dHs8YYtaTs9oBCIFNMOy6XPH87YQK0CuRve+8FwOvLDc
X-Gm-Gg: AZFdTZdu9LhKg4blS9irr93L0y8Jg3S/b/hz8LtTm8dW2MuC1awjzcvK4c81SdUCrN+
	dkQdyPeCsQ7Ax8vX2+SiZtRZ94qDkJGCS4ulgx5g4jhKMhygUwhIDSd9BoB66szfyTKdqBls7XY
	HwmV6ieLCsotAOBJhNVL+Sf1qQYCxhsEomCaNbm3jF2muFOT1rIlUrjTr9xMVZDxEQxnXYfSnoA
	5DeT8JjVtvpSRO7UCe1uIRaQb3kRhzinRj/bHEMbmW7M7ABGGm7kXbQ6Qz1R2fI1L3EFXZh8kRv
	/z4H5vvn2YMSAGWoLhL4UUCeHgF2RrEm7OaDLgNnnKqAMX1zpsFIapRZ8QQJChERsfjBTG5hBpR
	sHtPUj765QvISPk+6ap2HlkkcfnmnmRnJThuWrm444pyPnv/CcYRBSs1a54mfCTfrBKcTYnK9rq
	RWWODudVQTnOuMFPMBTh8fG65+e1PpS9Q36ah4QdoVc1JKxEptYhg7lh4jjFh7CNQZvNEprz2RN
	t4g3jn1sCMZTAN/VVhpQN/9VAX9j6Y8yCZpemmHSPzKeqoDVKD46a/6HN3SO8ERa5R6gswPuyOc
	s/qiPsDDIKF/pN91jiuDA3a5roIUnj/aArliplVQ9XvD7rJjsCsWfFRnTUgVuRDWe8rnVbBC7LB
	V4Hm+++dOdlGjB/JXBi1EjtiFNc3lN3H51fhGGJ/Hgyfyn/Rui48Tk382IGB3JtArnZE2SFDAxp
	wRi6q5HtktFx0kkS/7qw==
X-Received: by 2002:a05:690c:d8c:b0:8b2:e86a:8f0f with SMTP id 00721157ae682-8b4aa2e4bc7mr87789057b3.28.1794937436463;
        Tue, 17 Nov 2026 09:43:56 -0800 (PST)
Received: from localhost (107-220-129-194.lightspeed.chrlnc.sbcglobal.net. [107.220.129.194])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b4fe115a43sm2013517b3.42.2026.11.17.09.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 09:43:55 -0800 (PST)
From: Matt Turner <mattst88@gmail.com>
Date: Tue, 17 Nov 2026 12:43:52 -0500
Subject: [PATCH v2 1/8] powerpc/perf: mpc7450: Event 0x30d does not use the
 threshold
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
Message-Id: <20261117-ppc32-perf-v2-1-2072e9b90009@gmail.com>
References: <20261117-ppc32-perf-v2-0-2072e9b90009@gmail.com>
In-Reply-To: <20261117-ppc32-perf-v2-0-2072e9b90009@gmail.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
 Shrikanth Hegde <sshegde@linux.ibm.com>, Paul Mackerras <paulus@ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Matt Turner <mattst88@gmail.com>, Tanushree Shah <tshah@linux.ibm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1520; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=TtTDFi7v6z+KDY4gBi2LmgBe9ld12hzvxesJ8HRVaAk=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLL+TIpY/6Km0tREfoa9Ke8ib6HbNoJRR6bnnG929nFSu
 6qbsSu84yMLgxgXw0wxRZa49Yoss9p2LPU5Lf0LZg4rE8gQaZEGBiBgYeDLTcwrNdIx0jPVNtQz
 BDJ0jOIhcnoMGpnFxaWpRbppBUUOefkliSWZ+XnFevkFqXkF6QV6aZlpJRkZ+UXFqUAj9PJSS0x
 dHd2MDA1MLB0tzJwsHE1NnJ2dDJ3cHB2dXZ2MLM1NDJwtHU1cLc0ZuDgFYK65+pvhv1P/MZ4fEh
 7C/2etuG1ZmJh/dErzuociMj+N0uJrN9TtqGNkWH08Usn1h8nmgzvqGh6Ed354+09o9f4yva+5B
 cv6M8zecgMA
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

mpc7450_threshold_use() reports event 0x30d (PMC3 select 13, FPR issue
queue entries) as using MMCR0[THRESHOLD], and the comment above it marks
the event with a question mark.  The manual (MPC7450UM Rev. 5, Table
11-11) says the event counts the valid FPR issue queue entries each
cycle, with no threshold.  PMC3 select 12, the GPR rename buffer event
next to it, is the one that uses the threshold.

The only effect is that r30d cannot be counted together with a threshold
event that uses a different threshold.  Drop it from the list.

Fixes: 7325927e5a20 ("perf_counter: powerpc: Add processor back-end for MPC7450 family")
Reviewed-by: Tanushree Shah <tshah@linux.ibm.com>
Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 arch/powerpc/perf/mpc7450-pmu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/perf/mpc7450-pmu.c b/arch/powerpc/perf/mpc7450-pmu.c
index db451b9aac35..564f6dac3a00 100644
--- a/arch/powerpc/perf/mpc7450-pmu.c
+++ b/arch/powerpc/perf/mpc7450-pmu.c
@@ -65,7 +65,6 @@ static int mpc7450_classify_event(u32 event)
  *	12b	Y	PM_LD_MISS_EXCEED_L1_CYC
  *	220	N	PM_CQ_EXCEED_CYC
  *	30c	N	PM_GPR_RB_EXCEED_CYC
- *	30d	?	PM_FPR_IQ_EXCEED_CYC ?
  *	311	Y	PM_ITLB_SEARCH_EXCEED
  *	410	N	PM_GPR_IQ_EXCEED_CYC
  */
@@ -92,7 +91,7 @@ static int mpc7450_threshold_use(u32 event)
 			return 1;
 		break;
 	case 3:
-		if (sel == 0xc || sel == 0xd)
+		if (sel == 0xc)
 			return 1;
 		if (sel == 0x11)
 			return 2;

-- 
2.56.1


