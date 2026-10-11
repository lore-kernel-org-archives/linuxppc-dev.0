Return-Path: <linuxppc-dev+bounces-29196-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 628E6CA9ECF
	for <linuxppc-dev@archiver.kernel.org>; Sun, 11 Oct 2026 19:58:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j2rxD4z27z3bV5;
	Mon, 12 Oct 2026 06:57:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::630"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791748672;
	cv=none; b=gnFigmD2aAB3061944w2hVCQS0oRJvsfKJo95MI7Rw7g91gLQA7gY4an1cysBhtNqXAojpwWp4HjApm8favCq4B2OmLaauv6AaSZ5P1im3uT3aooWQdP9yibFCe7JnC7Z+6xJT+T1HguhhDF8Gs70U0mjLzsKpFSQ32ux9r7duVJBGWSNIcfymz3VGyI3h8XimFba9O+pq8swSgpvm/+jImO+Ndb9H2J+x6ow17WB811aJuJOHy4+ovApXhAhtd5YA18ibsqoXC7HaUpQOfN06vIJr3vwhPpzgWJIl2+PXBt+7BHMatd1K2VbM7nEHFIFmHJu3VwaFuN4DSkWTR/fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791748672; c=relaxed/relaxed;
	bh=ZtyEZmwj0f19Lpw83gnqEqbS3r4hbHydMWKTWR/TdRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iwrp7oLlYujj1GABhy67Tb7eUPUZYNmx0WBM8EjtA23CWfcEOb6yhDqOBBviElPxObuUKShOez+rLOuJ3ERdd0ol6IqrdqWrvIPfF0ZRRgT916rI98tpTGV0SkD+C4SIjN0ORC3iWgKI8U7Jmiwa9w1ebace7lNR12iHOgQeEq1b8nik7YqRyCtbj4qKPOY4lQ66kyIADhcrYYsayvaiAenChf4YcFYzvgr0skIpMD/+9/BaOuuhI+cB5chFomwWA0pjwCzhrv1NE0TA3pwdmAhYk8DNMZD3xubH2N+yADLIhe9ABfIQEGbJzV3FYmXvDC8cyI+m3nuJCUNem52KJw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VURnd1mQ; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::630; helo=mail-ej1-x630.google.com; envelope-from=linmag7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VURnd1mQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::630; helo=mail-ej1-x630.google.com; envelope-from=linmag7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j2rxC5T9kz2ygW
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2026 06:57:51 +1100 (AEDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-c2e5f8fe879so209928166b.3
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Oct 2026 12:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791748668; x=1792353468; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZtyEZmwj0f19Lpw83gnqEqbS3r4hbHydMWKTWR/TdRU=;
        b=VURnd1mQLva7FHBsjmuujFB4Gul0zk7haRVQvYv0f2va4XQqTWsURzWHLE11/y/c7e
         7+4EyF2+nVwkGM2Qt7T80yP1Q0HxazE/sb6DNEkXGBUxEP6MLJg8ZcKoQB4tcvsT0VVp
         b7R8pGyI4d69f2QsxH4XNO+/xUG5Lxsg3J0ESRGaiS9ETAEyuK9yNouUm92puoYjUd+m
         dzOIh/iEXyrJq0Kul90KFDYSq4Sl68XGJhLihEs8yJDJ5syI9jLih5qHpaXMiYwXp5gn
         wl3nIvSbDi6vCUa+pEykHCmiTJprzS6OKwkE4UOCWR3Bu5IyGsVgzIXj3ja1k2tq+Co2
         JApg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791748668; x=1792353468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZtyEZmwj0f19Lpw83gnqEqbS3r4hbHydMWKTWR/TdRU=;
        b=OsPBlU1zuH0xEhDCPf+EPa9+VhCCa4k7/q5SW/j/qlBGZAIhvUxPmni+Yci84auXg2
         1v7nIPyuNDUa9IfqRkkDMz/aBRzPW9VZXEy2+YtCWMrvkVWWC3eud6nwr3SCBreB/43R
         Okq1cZxtZIoXlXLqboZHaCcFiN/jdQNAC9s2v38+LEZOmoZ3pWRaYGKVdUosg9QGkPLx
         jIc1+W2dLQJ2EbPmsnIw7kJwvDnicWgvDYMY5eaOmAMX4EnzCodovia/SgWSLpU7C7WD
         b+wmzNfqCKeJRRyM05hOJvDDr59QLUHLrIL0W9Pvo5E3ny6R/yuJpWnAvrJpTJ3EbeSk
         v84A==
X-Forwarded-Encrypted: i=1; AKwUvBwpMSXi2aWY7RLUloOFleCn2pW//d3PIIxaBVVp4g8fGlbGGoEflqVRMyFLWHzqtPJCLk8y5nKaZKjcOgI=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYI/8naaQL5EeVB0vzalksw8rV0NBAV1cYs7Pgz8F4LRDctIAxmw
	dLIYZbcPTyTRl4RWS8O9Hmuac/+FgmbSqaChiIIRsqvB+H0adV5hiuJd
X-Gm-Gg: AYBFou3AOiCyzOG8q3scQFc34nqJr5ADJDfMwxiOi9SSteR3Kf3YB5KDiG+hP6bkpU8
	kNSBz1FSwFSjDwvgQeLWTgNS/81AmPN9M/cvht05T0Dy5Lqhc1OOvofw7RlPdzyngN+bqeUoMdA
	fzeM8wJ05CWvSV7UcuWicZHoGB6MK34k+p/C4cUptISNJsOZ+G7jZ1GFyrVnE+48OaWU9ERWrlu
	gmjxjNYkdaDfofJaWlJtcpYcqI2k+T4R3ZbOIYTuWOKBSm7Yzbjptits8mz9RsepwKJgEwIL/4K
	ur6YQNekeYRCeInK8zvLsSuJvAdH23C+HAf1pDmTsFqLzhL//LjGR4quTsa5PbA6zVTZaP7x75x
	hnOTcyvps5+et3P50i4z+7u6h2X4yvoxKCJuc9K1H026q3C8TS2lj6eV7mZNzgMczdR3f8zipr+
	aiUna5P4TpfTczDUPOWzekxaIlQ2Udwhx0RPfzq2XeUvOljxDHPnjETD9OXoNK8HgkPGGCTFhFA
	ibV/EGvh2pYXgEKFc8c5UuXPBl6oABogKxBTSo7kUm1hPnYi9Y=
X-Received: by 2002:a17:906:dc8c:b0:c31:8984:7fad with SMTP id a640c23a62f3a-c31a9feb114mr762553566b.15.1791748668114;
        Sun, 11 Oct 2026 12:57:48 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9a3ae9fsm381315566b.26.2026.10.11.12.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 12:57:47 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com,
	sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	linux-serial@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	krzk@kernel.org,
	oleg@redhat.com,
	linmag7@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v2 1/6] sparc64: return from the generic clear_page implementation
Date: Sun, 11 Oct 2026 21:55:53 +0200
Message-ID: <20261011195729.981243-2-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261011195729.981243-1-linmag7@gmail.com>
References: <20261011195729.981243-1-linmag7@gmail.com>
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

GENclear_page falls through into generic_patch_pageops after clearing
its page. The patcher then rewrites kernel text on each invocation.
Return to the caller once the clear loop completes, as GENcopy_page does.
This affects processors using the generic page-operation fallback.

Fixes: 6c70b6fc7b6f ("[SPARC64]: Do not assume sun4v chips have load-twin/store-init support.")
Cc: stable@vger.kernel.org

Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/lib/GENpage.S | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/sparc/lib/GENpage.S b/arch/sparc/lib/GENpage.S
index c143c4d1de3f..6ce11108e143 100644
--- a/arch/sparc/lib/GENpage.S
+++ b/arch/sparc/lib/GENpage.S
@@ -48,6 +48,9 @@ GENclear_user_page:
 	bne,pt	%xcc, 1b
 	 add	%o0, 64, %o0
 
+	retl
+	 nop
+
 #define BRANCH_ALWAYS	0x10680000
 #define NOP		0x01000000
 #define GEN_DO_PATCH(OLD, NEW)	\
-- 
2.43.0


