Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F552606A31A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Nov 2026 13:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JERxS5RL
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jY6nn0bKKz2ynW;
	Tue, 24 Nov 2026 00:52:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1034"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795441949;
	cv=none; b=GQY5A8fwFcQhQpNQvygIM/uUPeUSSx8fp8LP3fZvjgqnYIJMVf+qpehV5sr5/BTUvYyMPvhKjKD014Ch2I8VhcU9odAcg/RVq/m4KJwIGAfrZalKMG5oRffsyQwaFNvLCy0GSSfsO/mAVdDgQni1eJlSWYCXTBX89yVJDSgiVjsJfYtFgJzAWznzq4dOVKk1tgOCgjQ3WoMskkXCD/7YRfNdVEzQz3xEXsARd3o41+HiW//i3adzACrsQBbQQfoFB91SGWG9jT3IC/VGkcXeZuN2AGCl4o1HWdOwCvJjwvxSI2TnmumgKIZevWphU4P7l/7iA3V0JtvfBCPrVBd5Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795441949; c=relaxed/relaxed;
	bh=qTTU/HttU3fjnx/LLkySkKgelZHAjJmF566oK0Z4Ap4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i/0iXpIq2YxvNsf/XQQedPVkvsXdhp5IWZaUj1Mw+0vyJhiyZ4ZhiEHHMkJPdPUVGzGm/veWQ3DOpcgyzPL9vfdv5oFuk3V4I6gPnhicTCH61iwu0Pe5CrS1rl8L8eTS+9ocHwa5HJcznhSgQgG5HqXz7Ewp3jByEf0ccPsQuOcO7xNtP2ecjAOolExTlOw0r9u/prYSNokEgMxyRLiABbBOx4WPCsBBdOrvuy9N1BPdrCMiwFvuGLzVWDb+rD5KOzUOJvmgSFNgDpxbLnu0Kw9L8QKmEodlPxSCcJVZGTLE9MCva6hv+TAQil2o4KckfW9kEdfAMFv2/jT+xi7Ixw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JERxS5RL; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JERxS5RL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jY6nm3Ltnz2ySc
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2026 00:52:28 +1100 (AEDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-3b44bdcea8aso1282618a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2026 05:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795441946; x=1796046746; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qTTU/HttU3fjnx/LLkySkKgelZHAjJmF566oK0Z4Ap4=;
        b=JERxS5RL4FRvsTzkrrSLv1tAtwyA0O8Y9eJMSUSzuGk1LTe+HqFW4u7slhlIe+9YMz
         KgrBrtE4tPPymkAvX7wD5L0tFReVuziEXlLxaZZFh9zA+CfNT5u7flKVo/BODyBqCrOF
         f52qHi8W/xHPeR6K6j70aqFPPBDxgNUxtuoJ1VnHpK8/7JtvS3zotYiSumwR5ppkLBxn
         Zt4CPJKWdP90VikOuauKxiajdy5FHLehAy8szSqmHtRuGgG7Z9xAXuM/IJgBy8WsINK6
         2FeB9pPjPyat73gGrC1AzxjU3gKGntx2FUnEf7q59gIDgd34b/OgV6wMPhFErcpqP0RP
         uBng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795441946; x=1796046746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qTTU/HttU3fjnx/LLkySkKgelZHAjJmF566oK0Z4Ap4=;
        b=0OcWKBdUoLkG/3TS55QTvVNwZOznymw/FfXmsxthWmh2D3h5Kb82GqzAv6QvjZj8Fo
         VDRaJrPjV8fLLWW/OlgLDUNXVVSHRQXe57UiZ3qF/jEfarBd0yF6G/QRWk8L+qV3dtWv
         1UakH2B7dWm590vvEQYUEbccAni8zSUM074SGZl/OM9Ng4YFVMGTZuJwo3qlL1/Oqt+S
         r2PD7mDVRlOp0uVvvWCdPc5Z/C8f76cIaQUgV4hj4KLB8Ln0ey2vng/RZru8hvjC8yzp
         so3vex7spZvPfgrYZS7h8eK37KI5aaGRlwG03Vfbxosnutl5q9Wm7FZh+DESYe/5ZYMD
         rTwA==
X-Gm-Message-State: APuU4Z+rOIogHTRSe2nQTKMqHjMffuQLGBK2XGmBSFZjIZ1X46oPY4Ih
	/rh3qBXXwivzbNryHwAR4kk0iedHxRhyji8HDbrguCKFn6Ta0gCLjpEOqSV2KQ==
X-Gm-Gg: AZFdTZfDb/glI45SlpdwKeggiijPAi0rtSLwz75xaP/gQpJlC5zE6kqGWe9DFwIPxDE
	p0H8QJdDs+bGcKZMmgCn622O7N3eOgpR27b1gIQqWQ+HgBvFPKDsqDZP6Kc4azOOIfVydRXzsxt
	EtVvWPLgzjeTZ3pHWWMl9LWO+S9bfLmlz5iWAIEOlqLCO81yTY0jt0AKpG/VCAmLHCb8Rhb1ZhD
	IbBdxbEj8HGwM2wHAr2JCdeySTE+R9xN8KE+dxiS6Waw4zCd1Jr4aUxKqiNhdqf8f6I18PczLvA
	voXPHoxCVnEXM9TsFkRavGTigFVaDJW9BOJ+kIi/WxTyK8uKIcUpjl9Yexkt0Pm1wG5lkbFKCYg
	M4JqpxB047+8nmJ7A3J+A5g4RHittjxWrRpjXeJptzf3a2GLqvdbzhKg1ZDXS0ylo3ghLT5PvV8
	H4s1YonBrVzqZ51A+zkgN5EPRHQJfgLRIATrBGTIHUD/onx2OHf/s+hyo8Djbjy4DCbPUIEVKL9
	jr6WmP8IzlieS04xgwuKiid7r8mOpKeL3QMg1Z3xQg0qFqsyNwczWPPdJmbOlsqvNF2xTxrGAl+
	moEg3BzcrMZxiulBo732tuSP4XusBMXLGA==
X-Received: by 2002:a17:90a:e70c:b0:3a0:d7f2:5a58 with SMTP id 98e67ed59e1d1-3b41c7bc5a5mr7828786a91.3.1795441946295;
        Mon, 23 Nov 2026 05:52:26 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405ec698dsm20842512a91.14.2026.11.23.05.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 05:52:24 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	chleroy@kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Mukesh Kumar Chaurasiya <mkchauras@gmail.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCHv3 4/4] powerpc/kvm-hv-pmu: Free hostwide stats buffers if perf_pmu_register() fails
Date: Mon, 23 Nov 2026 19:21:53 +0530
Message-Id: <a9e4029d0e11b3c944f4b4cb781fc5ff1696709b.1795441238.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1795441238.git.ritesh.list@gmail.com>
References: <cover.1795441238.git.ritesh.list@gmail.com>
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
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

kvmppc_register_pmu() calls kvmppc_init_hostwide(), which allocates
gsm_l0_stats and gsb_l0_stats. It then registers the pmu. If
perf_pmu_register() fails we return without freeing them.

Call kvmppc_cleanup_hostwide() on that error path.

Fixes: f0c9c49c5067 ("powerpc/kvm-hv-pmu: Implement GSB message-ops for hostwide counters")
Cc: stable@vger.kernel.org
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/perf/kvm-hv-pmu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/perf/kvm-hv-pmu.c b/arch/powerpc/perf/kvm-hv-pmu.c
index a58634f656e9..ec05b4855736 100644
--- a/arch/powerpc/perf/kvm-hv-pmu.c
+++ b/arch/powerpc/perf/kvm-hv-pmu.c
@@ -402,8 +402,10 @@ static int __init kvmppc_register_pmu(void)

 		/* Register the pmu */
 		rc = perf_pmu_register(&kvmppc_pmu, kvmppc_pmu.name, -1);
-		if (rc)
+		if (rc) {
+			kvmppc_cleanup_hostwide();
 			goto out;
+		}

 		pr_info("Registered kvm-hv pmu");
 	}
--
2.39.5


