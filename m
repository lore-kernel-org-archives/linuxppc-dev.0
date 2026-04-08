Return-Path: <linuxppc-dev+bounces-19498-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 548131073CA3
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Apr 2026 12:02:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4frMB60kmwz2yqW;
	Wed, 08 Apr 2026 22:02:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::432"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775649726;
	cv=none; b=Uk0mQ19dZPaVPB6psh3S4ELbfaFBnBFjGvPGnfygxctwyR6fDTVePc0oiLXVCf8Bll0hHNEcIWvj6nUHn21gYeJZ0JlUlWakX1b1CS4Sp9MkCNBGCSBDSnaqMBl7c6/ZY8QpnSCCF27lT9Y4+Bl7X+3Vn2zwIvkucIizMBM+DOxzZlPeuJiiQwc48EROnR0psNQbPIYNUu/e/QXXj4ZKr9hePt0CjttYMhCvfv626hXxe/m0lwfK4Jy/Xu9iwCGWn8ah5s2FrCoWZyGbGpyoPpnhcsbFyqfp8reLEo/AMAUKwkiq1iyKXaaNFNsLqfwsC4J0MTE14LxSNvVPfT2OsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775649726; c=relaxed/relaxed;
	bh=PHdUj5TFH9dKxJLMiJUsQpHQaLsjedD8VYK/u5ysz28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DEb1maL+8SMNv/4vDHhvG5PbMjBTYJL0LDA/hy1VZLO4jyG8XZ9UwRYT6+NatWyJs2TK/+a5WMPFoz7NCEH7yFB48uFo96VwC3rJZukNKqr90y4KCd0PWx6jtCY+ip/1vhY9lNa+vPU+p3XY7hHB9UgCW0KEa8Yftfpxyq+FqaA+AOPHiA18LJ/zLamRzq9PKVGzXnbZOkiVBYI6l/U7wk/lBDQp2hYNHVl8BjzpWjD/CD/24rmvgMFiqeLp9+VpCOtYg3h8047+R5O2Vq7TOVAXg77glic0xQ65VEjhFc2Od7G9gKAiXsYk6zZjpqwSzYqS2PvGmfWwkINOe60+MQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UgoaCnvs; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UgoaCnvs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4frMB52Q8fz2xc8
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Apr 2026 22:02:04 +1000 (AEST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-82a7ebc729dso2669270b3a.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Apr 2026 05:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775649722; x=1776254522; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PHdUj5TFH9dKxJLMiJUsQpHQaLsjedD8VYK/u5ysz28=;
        b=UgoaCnvsqI3vYJXcGZ/lNTiBNVXX+JGlZBMooeHFbpfOEjshRzbgWcTJbZYMljebXA
         2hqLsjIrWv+tgsEZtbd4XEpq04Y3vbG4f9cd5p8DvKY6JswpugJ93sCKRaxyUsPcTvS+
         A1sgInbqRQykCcKQpSuDb/PlFHwrhL+M9PqknPw22jTHZwoTKito4gJALbuUp96bj5xg
         csUW/aunmu10Pg8SCdIPdEgGaKAkLuiGjoXUF9zNcCx/WkJpKngqH6qmkKqnOa7l2BgZ
         uBvza7nHOByGSw5h+jWQk5kOClEX7B8KI1O2f1WE+w8iHr9T8NXa92krJjrDphpvXUXw
         cqJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775649722; x=1776254522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PHdUj5TFH9dKxJLMiJUsQpHQaLsjedD8VYK/u5ysz28=;
        b=GyeABLITpVpBtPRil8FqJFIVChoKtRtqdFL9w2MLvQ6VUM+1FUBT+kQeg36FIian4a
         LO3ygFYQyCsxfo2mnGe/qVNrRA3gVmix9PXm5iHgbxaY5UvbDR0eIisxlKpYu7y0GFrh
         xQbSIj79/I5Ql3q6Wh1Y4qplueFGkDz4rcJF2qqQkI6QXjPb/JR/7vl+NVXOfeDSd5lg
         d+H2IMfTyA4p7s4+5GhwMR/gcIqkc6RFvfK96me4uoei2nNoC2sl7t8+5hqhV+9wpYMg
         moNNHV32VBYgUbmpgIJRRuAvSL17b9rP/JRrqoO5xRzeNNGAD8fjGuuzRcjq8v/oOUAH
         0SyA==
X-Gm-Message-State: AOJu0YzwG0tJjmmSSWV7qx2cDynRRsyCQYcFvk9XmCcbtiF5mNvD9G6G
	eZpuGFNezCqXLir+anOk6btkdSrKtF+6WAVzVoVtkES85Fg4LBqCnPUvCfHFtQ==
X-Gm-Gg: AeBDieu3rz+kvEAgCHsPoFFMQ8H7/g1F57mH//JoH3szdcAGDg9dHarahFSBqFpsGdk
	x7e7GWLwsI1yp9hIGRBWqykgQh1FSg+VigM3l0V3uEl6oJnXR9a45OxzfTaumz8ZKtI/P8Tqjq7
	PQYHxY2pYu2jy7Hkns+OK5+HcqSXRK2UVDEfmC2GHkZ9XPtfs2f/3ULw2GU48B2/j8dd9HDWye0
	nfpLoQeoz4Y/ml3dPM/f0l6mvwsPIDe/ym5f6iCHnmowSJeOgK7xJd3pUJR4kA2EWsQNW9P9zGw
	0ROT/AV2clHo69TJKn0bXwSBWWCpH6c+BTuilacvls6CYutaI8pnScHfSyyALVFZkkrM7c/4UNC
	VPSlQJu4S7nJYsqz2u03lulzdvq7knbK7sLSZMwruAh+ZMgzJTxDliTupIczZbg/PG4DoDhaFDh
	Pno1sNhIIy7iimGoaopYCSLqOXAdBiM6yaPwTXEZMzvDIk
X-Received: by 2002:a05:6a00:4b50:b0:820:2f9b:fe31 with SMTP id d2e1a72fcca58-82d0db53786mr21789802b3a.30.1775649722177;
        Wed, 08 Apr 2026 05:02:02 -0700 (PDT)
Received: from Mac.localdomain ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b3e169sm21209322b3a.18.2026.04.08.05.01.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 08 Apr 2026 05:02:01 -0700 (PDT)
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
Subject: [RFC v2 02/10] pseries/papr-hvpipe: Prevent kernel stack memory leak to userspace
Date: Wed,  8 Apr 2026 17:31:32 +0530
Message-ID: <aafb835339cafc1544280c027200db8b28df6edb.1775648406.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1775648406.git.ritesh.list@gmail.com>
References: <cover.1775648406.git.ritesh.list@gmail.com>
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
Fixes: 814ef095f12c9 ("powerpc/pseries: Add papr-hvpipe char driver for HVPIPE interfaces")
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


