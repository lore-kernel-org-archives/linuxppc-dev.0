Return-Path: <linuxppc-dev+bounces-20038-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EC6DFB44B1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Apr 2026 05:48:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g227v6mDBz2ynH;
	Fri, 24 Apr 2026 15:48:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::530"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777009723;
	cv=none; b=JLCeJkLjAdqbZ73hbASSDXmafe2rr0EN1vCDu9VKL/ueh6MSTxeq5Pmd+xIa4vSiEUlk2KiKJp4vIb5zxQSKug0e1SJpaxZPSXyrhuU64L8okOwbgRkhpTUgpzuGRR3/OJd+1fZmX2im+b01ugju/1c+qy6e/sWfi+uIfYArED3W+yI67kr8uOel6bGANhXfmKI3w7mzZhs1/8+pTNVp+9uBMU+pFfbWqozqnNH7bEElwBButBg0zuzlSfAB4W8spKevnk38+5lkid9hY7VWaBnSxJ0uJd9p/Dn5EF81RihHUvm7vnQClYD1dadX/xjT8ShxBsZEIswaWfJMualCKA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777009723; c=relaxed/relaxed;
	bh=uUmefGJqV+IRkFPz6sSuv3GYeINth0c7dueYg2gp07o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OvpACYjpeMGgbKmwfy1z1fCLU0ElSiruL7HjXceKAwYtpHyAiT8Aa35WQaoKg+7OF5Gi4Yc4U0Z+yDjx56Qani5jTRZXDGY7uoefUThuK9b066MrBE+Lw1Ye8CMaaVlxp9ENCJ3CTiS0Sfo44DJ5HR7Wm1b0rqEEFOIb0ZoMHa5BI8isJ3NhRNGgpFxCTqSp0kO/EokLtuFnAZ89MfuK9T5mRf7uuXZnuB+woR+vWnFaKGjxbQpzoQaRqIBkqkrmcqEtIsfzmgzgVl1OlXCo44ZsVTicWx6sQ69HAiDW6DkkFfwGzc2N/J2IrJjtF1/hprK6L652UhFNF67bxS2gYw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fVY7ykem; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::530; helo=mail-pg1-x530.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fVY7ykem;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::530; helo=mail-pg1-x530.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g227v1nf0z2xfR
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Apr 2026 15:48:43 +1000 (AEST)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-c741692db4cso2289725a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2026 22:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777009721; x=1777614521; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uUmefGJqV+IRkFPz6sSuv3GYeINth0c7dueYg2gp07o=;
        b=fVY7ykemazcpK9J2G42O8VnLKRm5mr6dU2/aSEO4oOkVdJYjlqnbkD5lErJNmRdiiJ
         nihZ7J8fYhvbvcUUVJYy78viM9piJhwp2iComLSaYq/2UyKzaBxEWTjru8hSqcgV3KuQ
         ZQE1oqHlxfr/uurwxg1g+Bdsgo92qlNzWow0lVEbEYhPXG5GLcp7biEgst6/muctPapd
         EJK2eyLvgfAHIoKnR9NROeSQfOxGFJF9sieBnbLFJwXyQAklvlgJ3n3dyAXmxAvmMHZR
         berccjQUh/+Lh3h5nIcAhCObNOpnq5AQl4E1GxgKDINgCyNtXA/N+hlhpbln3/wwpEmv
         tgKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777009721; x=1777614521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uUmefGJqV+IRkFPz6sSuv3GYeINth0c7dueYg2gp07o=;
        b=ElydOnqydjoRV9tqL9ZmjdjbnScRh8TdYVhkr7Er0hkjud9GhK3GPS3dqhgCoEqWGP
         x4F9kHwuD1PaPnbJhB/QprQ/c6m+InRrQekBs/BjcBDX4031sA60wOhlhYUQC5KWvuYf
         ipaEElx37cV3JRkNHdGcrliCRj0yF/nhSEqd87FKkdjoEWrEqUZ9kHIErX95Yk3TVOJz
         wd0THdQnenreKIrOv1XLFlRL9PZiYP0/NgodC5qt3w+smxg/7vXraHdaawukNlErvuzX
         8kEnc4Om2gR+t9EAxy5/B+lZ+Ln9cY/HMfqS1KkXuPK4hIP/9KUy92LkXsOFCr1JgU+w
         fTAg==
X-Forwarded-Encrypted: i=1; AFNElJ+Cpi7JDOHjpowHoUS64HlPRYV4+qKRN6+bT3JaagzLVXosEWuf5Y6CeVOmVAZgiioyGy9S7zQsskO1y20=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw+Sv/DRtIZnr4pn54onxDnnNa+0OVx39/bBxALQEkIkrm5Bcn8
	R3eZyW2dvkmQj2D6HrpV6PBPR/2W2EGcUUhTXWc9vOgHJz6ZpsOS0RpI
X-Gm-Gg: AeBDievh+lNQ54ZRwkanAsfA+/ndJj/mFzzJA4fSvHg4Yo9M3RDLkGzQUKLtFz1O0Ih
	3pCE8K3fSjOzG5S3dwbX/jqe9MqCGaFxUMmpP0tlu5J3BwXdPI6hzax9QrakQSoq5FWTLJbrJ74
	T9GWCt3UONqTyrjujSqhEzaAH2LYs5v3WtAPoieSkNPFP4bJWG9ECXamxGvJJiBZnqpwh/Ix6+V
	1ZLQ7joXHS0QS0tHl1DLOjDzZB0cKXl5ifzIJbMl32TcE3ecEGLcP7zCs1SrFBcprSYG/O/+B+L
	26anpTmacBovXzSiMNgZE2CD+ZoFNRX1CbDJcQ1D5JJMbJMrou+IiXLbcuPea0FRFXT9rLZNQD/
	q4l83e54uHRgYDGazEn1Tm6/FocOOU6UrQudd4TvvziHSKDZoR4NaX3gYjxNrFNWt9qc9PMy5sD
	2obIIlaInVRczYP+xeVnI+CnTw15VXhdaTkTJ2WBM2Rkm3JPjd0mcDP/q/UDG/hbsAsyod3Sk4K
	+TtUr7jTlQkoRE=
X-Received: by 2002:a17:902:b195:b0:2b2:4bbc:14b0 with SMTP id d9443c01a7336-2b5f9eb272fmr183181305ad.20.1777009720961;
        Thu, 23 Apr 2026 22:48:40 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.bl1-in.ibm.com ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5faa176e9sm208778245ad.20.2026.04.23.22.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 22:48:40 -0700 (PDT)
From: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
To: maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	peterz@infradead.org,
	jpoimboe@kernel.org,
	jbaron@akamai.com,
	aliceryhl@google.com,
	rostedt@goodmis.org,
	ardb@kernel.org,
	sumit.semwal@linaro.org,
	christian.koenig@amd.com,
	ojeda@kernel.org,
	boqun@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	tmgross@umich.edu,
	dakr@kernel.org,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	morbo@google.com,
	justinstitt@google.com,
	tamird@kernel.org,
	arnd@arndb.de,
	nsc@kernel.org,
	mkchauras@gmail.com,
	simona.vetter@ffwll.ch,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	rust-for-linux@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH V13 4/7] rust/powerpc: Set min rustc version for powerpc
Date: Fri, 24 Apr 2026 11:17:39 +0530
Message-ID: <20260424054742.45832-5-mkchauras@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424054742.45832-1-mkchauras@gmail.com>
References: <20260424054742.45832-1-mkchauras@gmail.com>
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

Minimum `rustc` version required for powerpc is 1.95 as some critical
features required for compiling rust code for kernel is not there.

For e.g. Stable inline asm support which got merged in 1.95.

Link: https://github.com/rust-lang/rust/pull/147996
Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
---
 scripts/min-tool-version.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/scripts/min-tool-version.sh b/scripts/min-tool-version.sh
index b96ec2d379b6..406895621511 100755
--- a/scripts/min-tool-version.sh
+++ b/scripts/min-tool-version.sh
@@ -31,7 +31,11 @@ llvm)
 	fi
 	;;
 rustc)
-	echo 1.85.0
+	if [ "$ARCH" = powerpc ]; then
+		echo 1.95.0
+	else
+		echo 1.85.0
+	fi
 	;;
 bindgen)
 	echo 0.71.1
-- 
2.53.0


