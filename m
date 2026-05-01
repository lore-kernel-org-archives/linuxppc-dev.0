Return-Path: <linuxppc-dev+bounces-20353-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8D83FF8864
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 May 2026 04:12:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g6HgZ623Mz30V0;
	Fri, 01 May 2026 14:12:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777608746;
	cv=none; b=G4GpEAijLzDOzQqX8PoKKdjo4XfeQDzPDGDL0i6i+U3oqJiyBArV7IwiXyRdAS4EJuOZufnRlsJXAmYNSRvEWjlNYkJGoZ1e5P2cAvC+osC8opKAI8JyfUSWxr0oqCGqp9M0Y+gvD5W2K4JjdUmSE2kdLJvmPSDFAHj+4BuW7MAdXvruzMZCWMUgJL7C5L36fXy0+rK+U7JKJLbx5SdnfAeCmiLvUyZzJ4ufNKGvaRYqqEwQF9Oo9yBgAuKKwtMC4uFGQEcHymqiBWPpJRSWe9xuSAVDiXybz+VrQydNdmKA77HvlbZ8pTYassoKn+ZMLY9ZzOrO8DuftblHfZAbWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777608746; c=relaxed/relaxed;
	bh=t0UuqUvbVXxe7PO3IdsW6Ps33YC23onFgbsbMbzoM7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GYC6WKPxXrqX6UDNyQaOtbIbWsXWLLh6414+tuOMbiEZ1tx+UGgQ2IunR/MA8NVOwEYoFGT5dIVlgmQkyHpMmsM0P/XcNduZO1tDpcgj3/289lwf6htRhUmv4xeLukeOJK0l3mB/+P2d6/FaAjjvRl1XKrCiS7RbIgVOqX3b777/JTCGsfLFRLIIT/FTFuloxiA5mMsXxRNHyHHhWMU5hLeF2kdmPwP0+HCdEbFZB8NFP9EMVxlMcqn5DPirr0evWeeyMFvMCyyuHhkPRjMYgmDtr/2jKS5h4r7iK7ghoCyQnKDd1WO+qUENgko+80vFIB2vqWaQrbM4eZq6fD7ztQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=euXBAH2l; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42c; helo=mail-pf1-x42c.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=euXBAH2l;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42c; helo=mail-pf1-x42c.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g6HgZ1jtRz2xjd
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 May 2026 14:12:26 +1000 (AEST)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-8296d553142so1110686b3a.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2026 21:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777608744; x=1778213544; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t0UuqUvbVXxe7PO3IdsW6Ps33YC23onFgbsbMbzoM7M=;
        b=euXBAH2l2/JuvrfRBFulSFV2s32PGA/7LvZ9e8A35jqABi/cOktcmmobZ/60GUz0z6
         VDDEYmw0120rpNxULifRqG5Za5Rh1TWCO/7e3Hi+MQO6j4EeRUq39A7e6kyMzBkyU8pW
         ouJCw9bz7EBsIg7eZZYgAV4+xf3JwB1OCJLX36j52Knh7jgSqDgIQhqxFGmTyZFUNT4X
         QzFe+j468mnzrmBUSEYg2swDTBERTfo4A17L/MxuMuKMOr8Udkal2k/szw8hMkA6ee8a
         A9FrI2eYOQGKuxq/xNdTEV+33By6MsPDA7bDG/DDeERDOD4zIpgbKSXL65YyMZVi/XyH
         zAGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777608744; x=1778213544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t0UuqUvbVXxe7PO3IdsW6Ps33YC23onFgbsbMbzoM7M=;
        b=DykDuy03VP1EglndlqjNaz2lcXYH/CtN2wOeqUbJtc87o7uQHobkm8+fquzFtvcG9I
         0VzlZE9jxpKfwURTu+e2QjuC+lw0kJpcR7fQpVHcLzfrONl5WNq5eJhAtxBa/xtcJoKW
         bKF+kil9ed3LEBhP3S/ZUDvwiOH3fvMvo+Xz3iwCpmMEVkxPtdZNiTXI7Q8MTCBZOPhi
         prVYYbnYD0sXvPxOMs5vW2qZyxWCFFEBf/lJw6Yh68sx4+Es8O8KH6n4LvgE98TIDSSC
         Kx4yUFptOdFb615su6RScspo4Gb44qHQwsv30b3ZySxlmqG8XGLbKmlKdEO/xVWBWarR
         M94g==
X-Gm-Message-State: AOJu0YxYhcvhKYMrJ6kOvhL/3oOOvJwHDwXCXBwRJ82O0w4ld+SvcxfT
	EnlTNYV3tkOfawIK6ToSZ46naEnqEWzNJlQjgZpzvxK9lt0no+yflkY0IPjHCNVL
X-Gm-Gg: AeBDieva5ozIhv7O9TFeJHux+LjFXpOhhMiSbuTQZpVwvY33ij3WAwoGygKFw2tEkgK
	WrOhH8PtRa7nHT6trTKEEPP4Y0msY+0l5fRsILpgM++IK9DU15Y/LNON53VhUHA3f3jhShb0AQI
	0raGVf2OQGCPlGzY63sBqnpPPJHURQFS27dTqRVWn1ewAswyP5X3MR8nbjQRLKhpT33P0VaxaWH
	uvmkhdKB/1Yd07mP9zA3gPw7/p8/aC9/N5mFWYLvYtPvoXMthDPPs2eex5569caKaZvh3VnPnke
	eYT+YXUdyZ9IVcha1z2xsJzGLypNCbO7djkT1hRYTZMc/iU4yZwAtSySAZaIIN3h9V5un57X8ug
	mTKYl55fcRLf6JyonpxVdYQO9LJqBcnTmLw46hUHlC+xJ5q7tCe0QE95zrEQMbIc1d4MpfWxTfn
	edZaWxdsxYAYo1KWuJVcX3jByYoCtG6hT5tf30GJ+Q6ssn0FbFweypO2bG3ojx7kw=
X-Received: by 2002:a05:6a00:181f:b0:82c:6b23:6d10 with SMTP id d2e1a72fcca58-834fdb58c54mr6377026b3a.3.1777608743787;
        Thu, 30 Apr 2026 21:12:23 -0700 (PDT)
Received: from localhost.localdomain ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83515b485eesm1159428b3a.48.2026.04.30.21.12.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 30 Apr 2026 21:12:22 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	Haren Myneni <haren@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 2/9] pseries/papr-hvpipe: Prevent kernel stack memory leak to userspace
Date: Fri,  1 May 2026 09:41:41 +0530
Message-ID: <7bfe03b65a282c856ed8182d1871bb973c0b78f2.1777606826.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1777606826.git.ritesh.list@gmail.com>
References: <cover.1777606826.git.ritesh.list@gmail.com>
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

The hdr variable is allocated on the stack and only hdr.version and
hdr.flags are initialized explicitly. Because the struct papr_hvpipe_hdr
contains reserved padding bytes (reserved[3] and reserved2[40]), these
could leak the uninitialized bytes to userspace after copy_to_user().

This patch fixes that by initializing the whole struct to 0.

Cc: stable@vger.kernel.org
Fixes: cebdb522fd3ed ("powerpc/pseries: Receive payload with ibm,receive-hvpipe-msg RTAS")
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/platforms/pseries/papr-hvpipe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/papr-hvpipe.c b/arch/powerpc/platforms/pseries/papr-hvpipe.c
index c41d45e1986d..3392874ebdf6 100644
--- a/arch/powerpc/platforms/pseries/papr-hvpipe.c
+++ b/arch/powerpc/platforms/pseries/papr-hvpipe.c
@@ -327,7 +327,7 @@ static ssize_t papr_hvpipe_handle_read(struct file *file,
 {
 
 	struct hvpipe_source_info *src_info = file->private_data;
-	struct papr_hvpipe_hdr hdr;
+	struct papr_hvpipe_hdr hdr = {};
 	long ret;
 
 	/*
-- 
2.39.5


