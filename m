Return-Path: <linuxppc-dev+bounces-20351-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78D6EFF885A
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 May 2026 04:12:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g6HgV689Kz2ygf;
	Fri, 01 May 2026 14:12:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777608742;
	cv=none; b=UPnvt3+k17No5LVSw+bXMhGyU3qrZblY9ffY10aBRrJL8pn0AUjt6fdehdjFB6XEXx4Is0182zrtGjpos3Jq79jUfnJx+I3GXgKshOih+/hYF+1RljZBRZ/locUWyXPd/t14i2BZm4sLpKnSDKVNvlGvqFqafSAyBPOjeTJESS2pZhtYl4yGVEksAZhEw55UCz/xT9SLIhnzQK60YL7/lDznK14N8S/pIOEgXty0Izv+xa9PPSU1qRItgnTlRiSheFJiOJOK4PPcTmGdIdxpduCCpECuEoKAQz89hwneiPHSBJ3Jtmy8x+URYEcN9wM7gMIMrYSpUS8/APx7IA+FZw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777608742; c=relaxed/relaxed;
	bh=4YsBlJc4jNUJBo+7TVpNvISQUlC/MjEmtJwMDNQlOeY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OYCaBRhZI3OG5uZQJhrlLLQWO1PTjqbZlxMwuL/FmzX4JPdVnxCDZ5zoX22dEdn71+SikKxwTWTLWrKpDX6dWor+ZsAXjp6IuXoeQPDKsez4yyaCBlXVJ/MnHLi/rCxC9q8evio7YmfFPj57OvUQyzAKe3ErzHrpbsXP7m45Ay7twmfuNnatvdSLo4xeT2/zO9eQSPvNGN3I4JCAtf7wkWUNPVaDu4sLFDVpXIeRpgA+u8rXnIBwUGpU9iA6qarGg6cl+eJd9z/65vrUzY5O7pAOwRiKUWEMZmaMQxwNuZXpb8+lfChmBGNw8iQiuS+2ejLeQ9LtCBxnNcGx6j9VXg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=slQ041kH; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52a; helo=mail-pg1-x52a.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=slQ041kH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52a; helo=mail-pg1-x52a.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g6HgS6MWLz2xPW
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 May 2026 14:12:20 +1000 (AEST)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-c796163fac5so940372a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2026 21:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777608735; x=1778213535; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4YsBlJc4jNUJBo+7TVpNvISQUlC/MjEmtJwMDNQlOeY=;
        b=slQ041kH5puPK7QBKEStS/hfZJ6ojM/SBAd1XAhQdN/sxgT2QQO8M4zY034lxZsZak
         Klz+HmUCnCq4YQBHoD7wfp14CxxZEkezBJZkGpqEeFz6Lkank3mzTvunHVdKjpfEBp0d
         fG4AHcQ0BFEPsO3hFM3o8TyzPEAxAEPU7YBoOAL9nI1wNdnbTj7FnclIw03TV37sI11S
         RSuROzb+z7jJYI3FWHsm8CIz+27LTvFregMZP3nHJ0IX72/XgVVAWgTAuzMqzbMNbFPW
         9VNQl9qkBVaIAGBdFPVMuiOFu9E5Sofdot0DkAtxaq5KOSw3ur1zlQBf6cSQ3qHk2Fka
         F3OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777608735; x=1778213535;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4YsBlJc4jNUJBo+7TVpNvISQUlC/MjEmtJwMDNQlOeY=;
        b=dYgt9l3fWVutrItxJ8sHZHHXKUzR59RaxLVkgZ8ba48KDZJXOW3/Q7KtE6Q7wV3APx
         2Dl7qLlxylLu13fipT4sFqf/I8tfX3BgCfKyE1Rvrg24XZB8UyVr+DgFWiTtkz584GmM
         8MpggxO5pU/Twl5F1HCo/Rl3AH8xmVGxFe52ktxXeHvqeFX8D9cFXBWc0sSyY0iLny7i
         Kwk7H57G5hCumqu1Pcv2QWzL+gtUxxA5TRqMzo1753mHXqMbPghWCqHt9d9ykDi9Up4S
         a4Yi8ajNcGeY3pRQXhbXFbxTprmMcYR3gT2MHivCO3KlqdoNrjnPaKfWsyHnuzeO44CV
         7qdw==
X-Gm-Message-State: AOJu0YxExvZV8stZaHXRM5L27JzXZBpP2mpc69c6kXKsjYc3LInz3Pwi
	QOJXJmt6hbP8WHWmFY861p4wNpRhBqE6VQ1muSULyZHP+MYhNvnua0jHjekgt4hu
X-Gm-Gg: AeBDiesmBelMomcuuUqiGALH9e+zU45JkFxYqiYGUw125J2uVUuiBEIVRLXxec2zDtw
	t3Ugfb1/DL6fcBNsISK4qC5/rJOrg/boWo+aKIgauc4zRhzMozXewkO9Jo/+GamKzR2lv8I0zpy
	3WedH/t4ByqOfvHOlCqXqdTsvv905JbGklLfklalbu41YSFFC0XcRtbB2VFfewBv51vO7Gyv+uq
	KL9HCAFGBE3S9A9UU/nhbwiSVquhFyRkpMx/vSGNPeCZyLtaSx+n8ppWrDU9rwIOJpxpB+7r+AF
	v8esccvGWndudsb7QLpIkryqgDxFY+OputXtLkWM3JpQI/OSfLuxK0Ug3fHXs6VQkH1K0p0OxRB
	b/7jGNB3kgZmdKpr3F+WHEp87ND6t90ebpR/jVNOuKxpZfG+1djX+5sBk3bloYmOIcd2yRPH/5s
	BaGdGhDwadX0HlzxProTLmNzZy/rp6k7ODCBpVOUrN2IN0W0UlJKGeEMpHryJmg/k=
X-Received: by 2002:a05:6a00:3e0c:b0:82f:8a29:e3b4 with SMTP id d2e1a72fcca58-8351a6077b2mr1546695b3a.50.1777608735185;
        Thu, 30 Apr 2026 21:12:15 -0700 (PDT)
Received: from localhost.localdomain ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83515b485eesm1159428b3a.48.2026.04.30.21.12.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 30 Apr 2026 21:12:14 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	Haren Myneni <haren@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v3 0/9] pseries/papr-hvpipe: Fix deadlock, races and misc cleanups
Date: Fri,  1 May 2026 09:41:39 +0530
Message-ID: <cover.1777606826.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.50.1
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

While going over papr-hvpipe code, there were a few fixes which were identified.
This patch series is an attempt to fix those along with some misc cleanups.
Me and Haren are trying to get these patches verified on a real HW. The tests
are not straight forward and we are waiting for the results.
Will update on the test results once we hear back from the internal test team.

v2->v3:
======
1. Rearranged the patches in such a way that it is easier to backport the fixes
   if required.
2. Clubbed patch-8 and patch-10 (of v2) since they both were changing the same function.
3. Handled ret>=0 case in copy_to_user patch, when the user itself may request
   for 0 effective bytes (after the HDR_LEN).

[v2]: https://lore.kernel.org/linuxppc-dev/cover.1775648406.git.ritesh.list@gmail.com/

v1->v2:
========
1. Fix a possible deadlock due to use of spin_lock instead of spin_lock_irqsave.
2. Prevent kernel stack uninit memory leak to userspace
3. Fix the race condition in null-ptr-deref case where there may be an
   msg pending to be consumed from the hvpipe.
4. Fixed error handling in init routine in patch-10

[v1]: https://lore.kernel.org/linuxppc-dev/cover.1775569027.git.ritesh.list@gmail.com/#t

Ritesh Harjani (IBM) (9):
  pseries/papr-hvpipe: Fix race with interrupt handler
  pseries/papr-hvpipe: Prevent kernel stack memory leak to userspace
  pseries/papr-hvpipe: Fix null ptr deref in papr_hvpipe_dev_create_handle()
  pseries/papr-hvpipe: Fix & simplify error handling in papr_hvpipe_init()
  pseries/papr-hvpipe: Fix the usage of copy_to_user()
  pseries/papr-hvpipe: Simplify spin unlock usage in papr_hvpipe_handle_release()
  pseries/papr-hvpipe: Kill task_struct pointer from struct hvpipe_source_info
  pseries/papr-hvpipe: Refactor and simplify hvpipe_rtas_recv_msg()
  pseries/papr-hvpipe: Fix style and checkpatch issues in enable_hvpipe_IRQ()

 arch/powerpc/platforms/pseries/papr-hvpipe.c | 181 ++++++++++---------
 arch/powerpc/platforms/pseries/papr-hvpipe.h |   1 -
 2 files changed, 97 insertions(+), 85 deletions(-)

--
2.39.5


