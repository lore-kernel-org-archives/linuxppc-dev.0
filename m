Return-Path: <linuxppc-dev+bounces-20125-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFE51FF885C
	for <linuxppc-dev@archiver.kernel.org>; Sun, 26 Apr 2026 11:00:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g3Nz04Ml8z2y2B;
	Sun, 26 Apr 2026 21:00:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1029"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777201244;
	cv=none; b=TxNy5n5K9CmXkhHAjpR4wSejWUzYNP0hhZReNV+PM927iR0XhQqHi23XL3swYgbn/8zw8n9P2F9JRhV0xvLULQT4LCsLemQKT3eunChuLE+0t9pAFpC8hWd9IJOPtNRDEhyIcPpkm24Kr4icIFf1PeLWt//mPasBMwJph0yg1mnY7YbKc+sEN1iffUEbbyjiXsRIVi0hjqpVhl9v7UItvvf8QKsNANfyJddaVK+McEbKZSbx42gLYWA2rJD3iKs2pN/YcsoXwtpUx2T8vI+7qujHg9JwVc5jOf2G1RZg0ku9mDaDU6nFTgHmYS1OWwLyuYG2QqBWIQiEHrZ1JWsqlw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777201244; c=relaxed/relaxed;
	bh=xKjAi9HbHD3A8vBvpsVmPpMZEiOAHaxheYu3agjVGmU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k3u6naiJYExqG6gvNbUW7+4hROsuudXQW0od1AWdZv3XC+qayUCAh2h8nslIQnmTSW8xEed0nAtPO4ZM8ROuDFN3kPV/xcJJgFd169/vot4bihylNU9ZVKtP8lU/+5mbh8aFY3a2zglEmWTFaplDghOlrHvUxfg3WJnT8y4WQPPPfsLvkdzCFwLrt6812nKpE1Qpci5Qtw5zM0UHRFZFJ36gPCFG04K204/PjaKUKVtTtqgsn3bIKBPnsILAD+ES6IOPzqzPeY3V5N+/kAehaDyd6blgTrFE4FfX8GaU8V6lnPZSLY9/rOtOPo7PX0Gw6fEbXC3/YM8rsPn4fD5FyA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=b/O9ljB8; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=b/O9ljB8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g3Nyz6zFXz2xfX
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Apr 2026 21:00:43 +1000 (AEST)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-35da9692ec3so7965972a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Apr 2026 04:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777201242; x=1777806042; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xKjAi9HbHD3A8vBvpsVmPpMZEiOAHaxheYu3agjVGmU=;
        b=b/O9ljB8wgR4zzow3qRHSztBSjWDExI/rEUuqTLV4zYE2SldbGNKB3r4cYWHeV+gTd
         cih5cZoWXrml98HUytD1mp1FDIXMwWTfWwYuztJW8IhxbOdZuoBI6URLiyDco+9bRiWY
         oidJvGBvd1EWMymYLzda5TYoIVCz1rUMRxqYQBIPO8Hw399bES6g9Rj38i3gfKPvUpfb
         xeYGXGHu1rCc7BK0uAuuLDYWkQSj9j1tWj61Hg81QjFTRICO9PDDGX9CrNx8uLYp7QLJ
         qwtLhauWNhJEUqKGvf2mIamGQlu2QOKM/eXOdr0KxLvQ7oDWU/jOcdgU1fGRUneWwvM6
         voow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777201242; x=1777806042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xKjAi9HbHD3A8vBvpsVmPpMZEiOAHaxheYu3agjVGmU=;
        b=VOXAkYqWrdadopzNvGIqCZlvcrfR6VJRCCniOmNjQcZDz54DAl+HzWJQ89BATfUxp1
         RlRkFA6a2DkVsUNQSs/AVWBPN58jMWuIODlwnCqaw36QD92FgUYz9liZkzE4Dfvi6V9E
         Jl1/fgq0lnlTQVsdMRGz97WAR56b0BIHGk4JjNFgAocUGloXjyUIBVFHzLQN6RpE/pTI
         5ZZ+serfRA2kjIBUW+ghpEB7zsI6Jf50ys9kCOpesA3UkgMPACONI+PQc+4IrQHbOCMa
         5WfcUHyiOlmsnKzlbFFLQJNI8PcSk9xnIru5SgcspkvHBbxd42vQHGDWBXPMX5gge4F/
         wYiA==
X-Forwarded-Encrypted: i=1; AFNElJ+fCb6c/ngEmhfaiQInsr1vwYckyteATn20BYqq6xXLzbk2Zr5VXrNUh8CgDmkx3uUfG1QzeHquP/P5gEU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx/b6/9o99qXgVIRWtd/vujfmSjBZRO6WH+tBBF5S3wzaT1F2Ic
	wDWBU0r//dgsMMe00jtWajTq2qG2fdI76Z+5Hh8MbH4xWWvgyXN8m+WQ
X-Gm-Gg: AeBDietPvrnTD6lMrqdOn1i+Vd8qBhwJ+uBbKQUNKtVsZVcsjRtR/P0pp7ogFuB3UEj
	zsg1DImo3xqSzk6thZu+YICNNRSdN/mDnmidAtpe2aE/3fdvjHBdQZ8LxcIPvf+9r7717tCtmZD
	ivnT1W+0texmz45H+Y17e6Cxz5x71zb4qlzxzuN+TDNI4SVxCJA+vl4llNy24+lu1dIwMbma+4I
	7ksMSu3YWWUiP9BlMheHydp/09givbgcGK0ppi9CLSUCNwGgXEnYlC6yu4kXAqWhuAXmUZWuRTb
	MaNTbRW8OKP97PyaURsokvaMMgdV0YCNBdyYHIHhywbSXr8DW8wBpY0vhZOigrZbbVVAh0qm15r
	wei3c7cYEjvIYNVgJFuY0jAfJrlUfpwJVf7qHnrfmRj82D94xdFUQBiP2QnHWZpVtK8Mr58/7U5
	4f9H1P3oq9KDJWNe5RAALkKPCJJy9uJGI2aNsd/ZDk32q7EDrjiAwVLa212qyH+WAwW59pDaUKA
	Heyk5bdl5dJaEg=
X-Received: by 2002:a17:903:32c9:b0:2b0:5923:5194 with SMTP id d9443c01a7336-2b5f9fa70e1mr403887325ad.27.1777201241796;
        Sun, 26 Apr 2026 04:00:41 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com.com ([106.51.164.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5faa2f129sm256667235ad.29.2026.04.26.04.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 04:00:41 -0700 (PDT)
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
	daniel.almeida@collabora.com,
	fujita.tomonori@gmail.com,
	viresh.kumar@linaro.org,
	prafulrai522@gmail.com,
	gregkh@linuxfoundation.org,
	arnd@arndb.de,
	tamird@kernel.org,
	mark.rutland@arm.com,
	mkchauras@gmail.com,
	lyude@redhat.com,
	lina+kernel@asahilina.net,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH V15 4/7] rust/powerpc: Set min rustc version for powerpc
Date: Sun, 26 Apr 2026 16:29:29 +0530
Message-ID: <20260426105932.2270364-5-mkchauras@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260426105932.2270364-1-mkchauras@gmail.com>
References: <20260426105932.2270364-1-mkchauras@gmail.com>
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
features required for compiling rust code for kernel are not there.

For example Stable inline asm support which got merged in 1.95.

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


