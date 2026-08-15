Return-Path: <linuxppc-dev+bounces-25884-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 260C7C5CFC1
	for <linuxppc-dev@archiver.kernel.org>; Sat, 15 Aug 2026 10:37:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hMbBM16kZz2xnW;
	Sat, 15 Aug 2026 20:36:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::633"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786790219;
	cv=none; b=j47AGSTzvh+bzZUCnwBOhzY41nXx9AR9cPqQ+iNObebMWQAfTAMSWD1zZNhMCbwkF9Xc5kmaHJBwHYYniW5rFGIr92ycNe+E4/9hM4AkKNgcbLEoFN8BaqUAWJDO4N/KqcKHU+l3nqvZwUfjZYESjD8R/3Ka+H6W06RFR0OPgGrx/U8zBYTE2nQWI0Fcqgjj5TGoom4KRae265m0zfdjacLzyDqopY1Qo3XR4BQslCLfrfnwq4gSWW3SDkUwgH09Eq31Twka0Oz/B0ME1xDUaCvZXH7b/NQcihkf/L3kw8Nx065noqP7FIMvEYy9P4JpXmEiFDgKv18W+tCJi1VXhw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786790219; c=relaxed/relaxed;
	bh=NO3qcNt9868NrnyM/QD7pq3oywENIyYI7Ixnody6czs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=olvhBTW8628qLJ3eFYhVje9XwlOZ9MtJYO6/brHMojphD9U5PRqHyMAqMXGa4p1OumXYlx0t48FEVpr77ffEENJl+A/HZTTlz9CISH2ydWiQhezmUkjvoO+CLyY9gXn2bJL5AUQpIf6DxNcGA8m+IttgcczIOsgkQq2duhkNwypCJJPuLiCxgQ+IJ7FggyRoyUQKcrR/4nCnKApSrneI2sKnvEYlMGbNpicbyUlTTTyjL7rzhuy7LaJkOIbEeAffZxH0oVtBf1d8EVOiCZQ7M1jjBGWQtAVlGR3v9BbIOBoFzEK6LyF0LUQGWcrIc1FVFUxFh7B4pjrIeHtlHNk1+g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hDpYNaX/; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=whi4ed0g@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hDpYNaX/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=whi4ed0g@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hMbBJ3qFkz2xlw
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Aug 2026 20:36:55 +1000 (AEST)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-2ceab75934dso22951515ad.2
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Aug 2026 03:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786790213; x=1787395013; darn=lists.ozlabs.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NO3qcNt9868NrnyM/QD7pq3oywENIyYI7Ixnody6czs=;
        b=hDpYNaX/dB+5448Dg4IHonOt9I2LQ7ejjLcOLFwjJ8CHTO93GerrZSEhbzcxXeaRHx
         f6IZG+jNITvC/ISl0J6YbtqinVKscFkX6Gjhhin+mznaY+vGKqnaI0zIFHRpPZygEYhs
         JqBOva7I02nfMZyDAlVcQ+hMXwGRWOAHG+ZiAegUZKVUg5lP7T/ccKdofGZ9fHafsVXF
         DIze+PpUxQ2WCSj3GxO6xGTtrBv7zIWYGUBqcdJpQfYdQY+0D/Oc4wzxzEn/Dye7513Q
         sOs0l8ABEJ0kDgngnVVfSi5WLI/LdlTBwbkgaBgspGyGi9V16TdmGxXnvvt4CjbcfOTC
         hjXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786790213; x=1787395013;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=NO3qcNt9868NrnyM/QD7pq3oywENIyYI7Ixnody6czs=;
        b=tX7P5sLnYsNHU0legEAD87U+4oGkO6Lyv7klSIR3gBPaNiDodXlspQgBOnR1Ltb6Hc
         P7E/ja4LHosVGA6RQmL9Nq4lQdBfI+vtGN5mV2zJLCuidHogzMGN3vR89K96Gflo8LzV
         KXUbOiAvBT6OAf13Q2/zdX+S5SvR1RxIviC+fIZmcwgOqnlzy+9ogHnXnIPevW2N/C7a
         S2SYsmE2CcNcjv1PAlrGLKSs0IOSY5S2y8eRP654JtpVk86FlnrtpY1eigQA+/WEnMd+
         XST50UPlnKqp5Sl4uUGMqr7hrmDtPCyRxqs523NwWP5kRG/KJgCzlBjaYYB2qtYzRs0y
         h0ww==
X-Gm-Message-State: AOJu0YxXL76q5S/yEQaXUZsLSUioCAHPNIvfwVHmgolB0nf/Nk3gzsDO
	VGYoLRp6VeAif6p2FdFP3tJshI8o/imIZibM2ZAWfg80ohjYDBD2JyWN
X-Gm-Gg: AR+sD13WUnWEXKmZPmV+icyw5RlzgU4tvSXv6XaaJvPmStxxO5yTnvefTNz55KDdLLL
	tnrIWEc7eotgGLoOOK2jt0m2il+lS6Hkodr7g/AMWLX7T9v1L+Ni02vzi+IAZ6fi8XIyqBpeSGa
	UWsOAqeFKSUYr1ZLUotW4r8zKGcwxg9yF/I7tB3JzhbcSwlohPzUUSN1Mh3xzhVITh7tTQiSmqQ
	6ECnZwD/01UfVE0UfWzGWFnlIBdkj9o2s1lzH5cKDemn2wbFmapDcFU96V2DJNlVINH6dC2yvje
	SMK63gmUNHaf9n6AWYu2v76f7aS6Nk7xg6Nq1byQ7Z9/nC7HaHCXyQVTcllJyNcdS2sXLCSr8un
	64OWrt9ZaaveGF6yBdLOGaNw7eccg5fDE+RUwliU/b15qBx9ETUbadeuJslGnY12VvhZfIz3U1l
	TMTTG12Y8EouGd6EnWwsFIKBchYpFvn+Ukh8Xl2ZMEa8GX0zQF1xne9g7ndGz9Y2ChyMg50oM=
X-Received: by 2002:a17:90b:3bce:b0:393:288:29e3 with SMTP id 98e67ed59e1d1-3933e5c8586mr13824749a91.10.1786790213210;
        Sat, 15 Aug 2026 03:36:53 -0700 (PDT)
Received: from LAPTOP-N3B6U5LC.localdomain ([117.147.100.52])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-394ebc32b24sm5774757a91.17.2026.08.15.03.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 03:36:52 -0700 (PDT)
From: Zhenhao Wan <whi4ed0g@gmail.com>
Date: Sat, 15 Aug 2026 18:32:03 +0800
Subject: [PATCH] powerpc/spufs: account SPU context save area to memcg
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260815-spufs-lscsa-unaccounted-v1-1-3ee0949de787@gmail.com>
X-B4-Tracking: v=1; b=H4sIACJAgGoC/yWMywrCMBBFf6XM2oG22Af+iriYTCY2omnJJCKU/
 ruJLs/lnrODSvSicGl2iPL26tdQoDs1wAuFu6C3haFv+7GduwF1y07xqayEORDzmkMSi5OhwY0
 yze5sodhbFOc/v/L19mfN5iGcaq4+DKmgiRR4qdOLNEmE4/gCsoFg8JQAAAA=
X-Change-ID: 20260815-spufs-lscsa-unaccounted-7ba5f6e78f4d
To: Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Yuhao Jiang <danisjiang@gmail.com>, Zhenhao Wan <whi4ed0g@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786790206; l=2340;
 i=whi4ed0g@gmail.com; h=from:subject:message-id;
 bh=rfMjaCOvmJRa0bbW+d5HkY5VYdG1X8m8Ugnqw/d236I=;
 b=wg58LxDZIXz1hpQmLQwgWCGJJTZT2uI4XeLYPtgnYerF32KxQGvId9qgFmti5zPlOEulIMrIq
 QIQF7gZb76KDYjB5QPlPu+2grZXfQklZRiO0u8neFCHRpH48zYPHuEt
X-Developer-Key: i=whi4ed0g@gmail.com; a=ed25519;
 pk=zRTKlstE0LmilshGwJsFYEVjiT6RiXMBXK8Og6VmuVQ=

Creating an SPU context with the spu_create(2) syscall allocates a
struct spu_lscsa in spu_alloc_lscsa() to hold the context's save area.
struct spu_lscsa embeds the 256 KiB local store and aligns it to a 64 KiB
boundary, so sizeof(struct spu_lscsa) is 320 KiB and each context pins a
320 KiB vmalloc allocation.  The allocation uses plain vzalloc()
(GFP_KERNEL | __GFP_ZERO), so it carries no __GFP_ACCOUNT and is not
charged to any memory cgroup.

The default spu_create() path (flags == 0) performs no capability check
-- it is gated only by ordinary directory write permission on the spufs
mount -- and spufs imposes no limit of its own on how many contexts a
caller may hold open (nr_spu_contexts is only a statistic, never
compared against a limit).  An unprivileged user with spufs access can
therefore hold many contexts open, pinning kernel memory that is not
attributed to, and so cannot be limited by, their memory cgroup.

Charge the save area to the allocating task's memory cgroup by switching
to __vmalloc() with GFP_KERNEL_ACCOUNT.  __GFP_ZERO preserves the zeroing
that vzalloc() provided; the local store pages are mapped into user space
via the context's "mem" file, so they must not expose stale memory.  This
mirrors commit ec403e2ae0df ("memcg: enable accounting for ldt_struct
objects"), which accounts the x86 LDT the same way.

Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Zhenhao Wan <whi4ed0g@gmail.com>
---
 arch/powerpc/platforms/cell/spufs/lscsa_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/cell/spufs/lscsa_alloc.c b/arch/powerpc/platforms/cell/spufs/lscsa_alloc.c
index 43b9dde7fd0d..df93e65bc7c1 100644
--- a/arch/powerpc/platforms/cell/spufs/lscsa_alloc.c
+++ b/arch/powerpc/platforms/cell/spufs/lscsa_alloc.c
@@ -23,7 +23,7 @@ int spu_alloc_lscsa(struct spu_state *csa)
 	struct spu_lscsa *lscsa;
 	unsigned char *p;
 
-	lscsa = vzalloc(sizeof(*lscsa));
+	lscsa = __vmalloc(sizeof(*lscsa), GFP_KERNEL_ACCOUNT | __GFP_ZERO);
 	if (!lscsa)
 		return -ENOMEM;
 	csa->lscsa = lscsa;

---
base-commit: f80f8c5c68a5e4d68a829ca1d8717b943a26b334
change-id: 20260815-spufs-lscsa-unaccounted-7ba5f6e78f4d

Best regards,
--  
Zhenhao Wan <whi4ed0g@gmail.com>


