Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC4F606A336
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Nov 2026 01:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UGeIgV2H
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNqJr5vq1z2yQJ;
	Tue, 10 Nov 2026 12:47:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1136"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794275228;
	cv=none; b=MN6GIkuT2M2jTCdlgxF3ffxHqTbFu2WoeDyN9Ghdxo0YSJbmcwbH0etdYOCab5bJI3X3CdqPEV4JkU/00V6DX6zM+dFjSJmzj0u80P+1sJ1QKErAqrSxE4vnxVjGan8HcskjtNaXphIpZEOnmOlWNkKtr46Y6zUbpqdNwZ/l3pGZQtPJXRADsOn9R0YmWz898Sa8p8CWfqCBkAigKIIuASpIs/hqJirTxWFLtVPq5SZXFAcFMgGBrpP7jczD6Ubhq4oeSu/7qTd5OqmS0T+PNSF1d+yv0woHg5G2H1wboC0848PH0ZQIaOGKWo9hnSdu/mLqvp1zxd0x5+yLp2eDcw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794275228; c=relaxed/relaxed;
	bh=UWasGv2YzuvIDNMrPYhW6hMTbdrTiz1RXd1lac2gzkg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YgUGcOEk486M4lbcXsGIp81VceP976ibuQlGjdS0/OdRITxZ9stjtBUJwDDf9F7dzAMKZPSjgqvw8HdhaUQYvae6KIGfr/5LYF8tC+/RTgs+P8/+2N+9/M6PupfSV0AbaLin8GKnQG/eIYWUauxxUx5fyYsRPhg7DOO1faTeitzybc4kVStyuOeK31WbvaxTvdYg3D/nEllQKSIHpz4W+r/ofczSfoa1AoxjKNGSdCGtTmZGsO5BkVPOQbld4zwu0JVQHvBjrV3+4bNEane0Fkhb1NIU8oMvHrOAqtLEF4oMBNvJM59oJH96V21E26TtGWnCHBYScDEbSJu4Hma4iQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UGeIgV2H; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1136; helo=mail-yw1-x1136.google.com; envelope-from=mattst88@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UGeIgV2H;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1136; helo=mail-yw1-x1136.google.com; envelope-from=mattst88@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNqJq4ktTz2xfK
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 12:47:07 +1100 (AEDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-8b31261e8a9so11455057b3.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Nov 2026 17:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794275225; x=1794880025; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UWasGv2YzuvIDNMrPYhW6hMTbdrTiz1RXd1lac2gzkg=;
        b=UGeIgV2HKkoPckDxVZUV25frusy8wcJ5l/Tc3J+VVdnh0q5C+jc04DTmLvYAY941nN
         1RcHR25jdOmyf4V5pp4Wnh8WcGgsAY2zhOAKDVTUypbYIwWoYDnavrG7/xK8wglT9soK
         efYj2DpzBV0Ephq0zPwiep4qQLxljqPAoBKsJQ4234FyJhN2nW593RT+zXhlR7VCCsBJ
         tThU9IrvErOGHl8mabledsrzNvjdCtZKi+T85FsBf46obh1/079GbJcw7CazaCrpKEkr
         C9xNCORaPWWESrxXSnv8VYV/xmf/gzMkuvefKg1tNenM4CRO6Do0zcuf7NAib6NLdOZC
         UjQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794275225; x=1794880025;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UWasGv2YzuvIDNMrPYhW6hMTbdrTiz1RXd1lac2gzkg=;
        b=y27bHRnHMUxK2YBN6XzI2cYQdaH48utOb9uEe4wUW8nqnkf1KwGXrjRkFnz5AG6+VD
         aKGVgb3drvydmXZPqqGHXSYtPJ2kWdVvpeJtv9+rXf0a3pklWuv51MJqnmcIBDnozYXL
         ptshsPyX5nCXT4c+rh2kEzMtdnILQiuRWI/La4Sn+GhIgQ+OaXwdO5DMF4TRu2aPv8Sf
         ixzRXhlOB1+2nn2LULPoCxhQZiP3ZMBAWE8DmFuAHRuZ8pQn02y1zZ9uXPbZlVLUFixP
         9IXPW4R0AJ1s3ozNstV1KlAnXVMMc6KOdgZQJwR61B+NhPKkLIJZvIYdq79RWyWx2ntA
         euDA==
X-Gm-Message-State: APuU4Z93kKq/ZuV64imzvD3qmHWdRt6Sv+6e9gyzrWs4zRw+6ZLuIq9G
	WJ5QDT0w84Lo1vxTuajm54St+LtPphXxz+deH6ZFh6OL/ljNSJL4NtMSHmGEL8Tg
X-Gm-Gg: AYBFou3nw4AWrqbBtHvCWVn3c+D+ut7n9GEIM8wFZ9FJR9agM31avb5W6EnKO8j9x9j
	2KRrM9Czlp55be3/gVZKtFmKnqe8d91hEVK3syfHN/Y46+J9rAww03DKCLYJxSSl2xqb2cqmbKj
	xXcqCmDmHk4p+aKQ6NYJfeamyyCm+TnFkRGtA0qDPJkLCSUC122vIm6TNHq8QebpuByzcUel+Ni
	8WIG5KT6yv7pWGJz9dJvRTH+620PoMbBGeoQy/yOvFdBldA4o23icyXL5QYoqXAS+RWBVYrfQpa
	DM/Qx3oJLBdSg7QYKwWQEHkIHB0BvStZ3N1iMlb1Q9qDg2TcI+vWBbGhv8KLd2ttru1MtqO8mK9
	vysABVbtLS+oEkZJFPRLreqdl8SKGxxqk7bS33W8hdyjY2xlRYsiCxPx9qwDO2LK12SYiUnZgfK
	XXDwG5hCLZ3YKGEynNE8cgbR9m12iy9lIVMRcQfvtANYDAmSnaSaSsyVwNLBz9S9GD8Wjq7Ro8L
	dy7l/6iBNs/rTU/OFlLseP3M0hbS05i9WjYg3oYWjLi5Z6ttdqlc22lkWWwrDOwvSu738wyp2Wn
	vakDY+/3YpSAqY6DEgKnb9/9QzjI9U5EKmm4/VBzcDR+SwZWXYF6ZH53V9AAvKgC5LfXVW7DciL
	HOcHT2gCZ9eW/MKqnvfY/xdxgsqzFtf8=
X-Received: by 2002:a05:690c:698b:b0:8b3:398e:8004 with SMTP id 00721157ae682-8b39297d3b9mr8600917b3.20.1794275224989;
        Mon, 09 Nov 2026 17:47:04 -0800 (PST)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b39324bf84sm8634687b3.3.2026.11.09.17.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 17:47:04 -0800 (PST)
From: Matt Turner <mattst88@gmail.com>
Date: Mon, 09 Nov 2026 20:47:01 -0500
Subject: [PATCH 2/8] powerpc/perf: mpc7450: Event 0x634 counts L2
 prefetches, not L1I
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
Message-Id: <20261109-ppc32-perf-v1-2-a6e8a55b3b48@gmail.com>
References: <20261109-ppc32-perf-v1-0-a6e8a55b3b48@gmail.com>
In-Reply-To: <20261109-ppc32-perf-v1-0-a6e8a55b3b48@gmail.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
 Shrikanth Hegde <sshegde@linux.ibm.com>, Paul Mackerras <paulus@ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Matt Turner <mattst88@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1849; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=TwlNAcp6eC0hJG+v2/kOLi3vElXUnRdKI+S9gxs5PKI=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLI+lU9hd/Dtkpw88Tpj9D6m3TdNn3lZyG9ZnGfVtbhEd
 NltLrv2jo8sDGJcDDPFFFni1iuyzGrbsdTntPQvmDmsTCBDpEUaGICAhYEvNzGv1EjHSM9U21DP
 EMjQMYqHyOkxaGQWF5emFummFRQ55OWXJJZk5ucV6+UXpOYVpBfopWWmlWRk5BcVpwKN0MtLLTF
 1dXQzMjQwsXS0MHOycDQ1cXZ2MnRyc3R0dnUysjQ3MXC2dDRxtTRn4OIUgLnmUy8jw/2q6LwdX6
 5efnRlk4O3xGPtqVsrPrHWuEl2hD5S2tv8JIKRoX29p9NxxRpT/ZpITvnZE8vuPGjgivl1YNdUh
 yRnra2TOAE=
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The cache event table maps L1-icache-prefetches to 0x634, PMC6 select
52.  The manual (MPC7450UM Rev. 5, Table 11-14) calls that event
"Prefetch engine request" and says it "counts new prefetches allocated
in the prefetch unit".  It is the first of six events about the L2
prefetch engine (selects 52-57), and the MPC7450 has no instruction
cache prefetch event.

On a 7448, a pointer chase over 64-byte nodes counts r634 at 0.00 per
load when the working set fits in the 1 MB L2, and at 1.00 per load,
one per L2 demand miss, at 4 MB.

The engine starts a prefetch only when an access misses in every cache,
fetches from the bus, and also fills the L3 if there is one (section
3.6.3.2), so it is a last-level prefetch with or without an L3.  Report
it as LL-prefetches, and L1-icache-prefetches as not supported.

Fixes: 7325927e5a20 ("perf_counter: powerpc: Add processor back-end for MPC7450 family")
Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 arch/powerpc/perf/mpc7450-pmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/perf/mpc7450-pmu.c b/arch/powerpc/perf/mpc7450-pmu.c
index 564f6dac3a00..5a882d934645 100644
--- a/arch/powerpc/perf/mpc7450-pmu.c
+++ b/arch/powerpc/perf/mpc7450-pmu.c
@@ -370,12 +370,12 @@ static u64 mpc7450_cache_events[C(MAX)][C(OP_MAX)][C(RESULT_MAX)] = {
 	[C(L1I)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
 		[C(OP_READ)] = {	0x129,		0x115	},
 		[C(OP_WRITE)] = {	-1,		-1	},
-		[C(OP_PREFETCH)] = {	0x634,		0	},
+		[C(OP_PREFETCH)] = {	0,		0	},
 	},
 	[C(LL)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
 		[C(OP_READ)] = {	0,		0	},
 		[C(OP_WRITE)] = {	0,		0	},
-		[C(OP_PREFETCH)] = {	0,		0	},
+		[C(OP_PREFETCH)] = {	0x634,		0	},
 	},
 	[C(DTLB)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
 		[C(OP_READ)] = {	0,		0x312	},

-- 
2.55.0


