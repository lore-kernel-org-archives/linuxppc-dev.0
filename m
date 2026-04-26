Return-Path: <linuxppc-dev+bounces-20109-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93C8CFF885C
	for <linuxppc-dev@archiver.kernel.org>; Sun, 26 Apr 2026 08:58:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g3LG22DqPz2ySV;
	Sun, 26 Apr 2026 18:58:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777193914;
	cv=none; b=Z2F69Nezo041e6PH2frAjgx06ioFyMqgM3j1Do/RofHXNKgmTdeC/zOgYdr/3/ES3yfAsvYxfjigpTXvDmA3H6OmCwFbjvTkY2oDmAYPxWOtQoP3VzcmrS+VOgCKPbrOace4ik2qlvMOvRts5yYy9TbhtN4UYcaCzugZf+XV5CYBSZR8BKPC0uzZSiPfQNHNXO+z2ls3m3qp6zA6zAthupWu7xXOqZCMMbbmWS7f2HhDdKvmoQbjfIawozqcdGeHRR6eGEBKTcEBC/Fs3Mp0nO5VQK+8a++2ZZ+uJH2a3XxOxzC/1SmdWXLw6cTVozssvbsFovVKFC62dnG5XelvOg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777193914; c=relaxed/relaxed;
	bh=xKjAi9HbHD3A8vBvpsVmPpMZEiOAHaxheYu3agjVGmU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b8OcJN5WJr2qiAs4ojsV4g1alDONjGmnkikjYMkqSvAWBw3MroLrM4h34LWmXkwVRLl0vywXpej6ypjPQcSRkKVTBsqOz+05NAxlJmZMUooL9C6kKJloK5+PkW2bEvarImeXDhN0CaDHBo5o7vPKpvo9uotKoyJmUvBOgUe3HVV2Ikl0nlvIRWZhVmKdKUMxqJnAZclqQ7ee20+IZ/7wVvOGaXKYrvFio33whEm32INXoU72N9YfNxNKLUVuOmXQzBF+EuleTc/YyY/SF8mjD47GIy686s1cYMywjofTyxNEyftCmWEZLdeJSH4UnRy/ocwZvRy4SwVEAxhVLCuqHg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FUfxQ28W; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FUfxQ28W;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g3LG14GtBz2ySC
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Apr 2026 18:58:33 +1000 (AEST)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-35d94f4ee36so5607073a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Apr 2026 01:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777193912; x=1777798712; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xKjAi9HbHD3A8vBvpsVmPpMZEiOAHaxheYu3agjVGmU=;
        b=FUfxQ28Wvf4kpMMmuxkRaRjWt9Dra/Iq8pskS+GAfbF409OTmFusl0hMy7zDbIyQXH
         ogcJRzlccdWBJ1DNpfupq6DDOAx0F7MVON3/bz4dPCHBT6MALF3qCDjkHB+oy7mE1gtM
         ovdyahlIl1OM5nNHq0gkUVUiiKTNOgR9NmwVZZQozn3hcQUCGFaKaxphBamlUlrbASSv
         fjFxSkRzDfaGRD1mnYuYkP555pbDj3FQZQEo7R/U5bmB3Lg/4wzi5jOEmX1+u2mrixwL
         fyNwGpUraH/GQ0YxeWs9xivH9DPMr2a/yw+mjSBztp7ADlFHH10oI4MHNzUcflzYnhiS
         orQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777193912; x=1777798712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xKjAi9HbHD3A8vBvpsVmPpMZEiOAHaxheYu3agjVGmU=;
        b=PZ6LQZY1WUttDDFd7GgwpyVGEKEODGCCN27fPvtTXkzV9Nb/TL+esSXDaLhMBGoM3h
         OAqlyxja1nC3McL7kj0uVBycxMwC8CmJVU+IuQ8Zo8G8uBc03ADb7FkFcKka2IJXhduM
         jUAJWYOhgFAQrlr4zP4iLrFlKTU0D0M1M56bx5oFcAz84S1bAWsMX6jDVp0BRet+4kRc
         TsBpLqJuPJS4ON0+uL/y7mpMq2UsKPaW7slLmzbo+27r0pjXA+Xx5JTfGFpEYXRrVH5f
         8orPRbeUMZf0ga+MnQLbIR/43u/jd92reBkxMvGJrlEpobTISAZTym3MY3fuzi3D/opj
         0AJg==
X-Forwarded-Encrypted: i=1; AFNElJ+zFp//N5GiyGCUxa+xjEoIXcAHnn3WMS6NE+k++UsKF42TFTxfI8NGFGbnxbxqbR7lJ8OgY7P6MST/RA4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxnWmuz5/wmAwJHSdyMn2WcOqtItAImWRjG6rmnM8G8/QoP+1r3
	ExLyD6cE6smvBl7sMwlKf4PaoeBPqD8L7Z0upK3tUA95BNlvVFtTXRAY
X-Gm-Gg: AeBDiethWQCnJusg8QKyeZ+lnfzcnw79HzMKuZBwnCgBP1rnCJmmp1Bas5ysNOpeOKb
	CxteAHMrrvdqJLnU+b0i4/jlb11x9vDje82tV8pUHiM/or9GgK7pMrNpPOoJkaWf2XFiKwrGlMi
	/AgdS0Yg3aj18bTc6iBDoTzf6DPxqlzltBBr6VGk6ZvErugo2aqqGUjpoPR7vvTK+Ns7ZXrScoc
	LavY01UTTY1hkBBKDDbM+vDH8zKCizqednS2FcQ58XCEJxpuVE8o7oIBjresj6h3dTnaXC0mkTc
	4EZ38Sr5uNg550J7+wsV48p0NT883U+Sw9EK7tlk6Lnaa1reUJ9APUTR/hjcGGTooyIdRH2BHE8
	UjUY6oCj/vVfBBcFxyww+777yzoqDoAqdjAVmtCka/bK8VDhQA6CDu4IvxqppXNO1i28VFWJDGX
	iiv8vjrwrb6SlB66jf+CPjMPscGm5M34C/P8TOBzaLJ19Dz0OgOirA4NnB5msDMoTs5eCMSVxxO
	pYjYu+3XHbUd+8=
X-Received: by 2002:a17:90b:4a0a:b0:35e:58d3:3284 with SMTP id 98e67ed59e1d1-361403e083bmr38831908a91.9.1777193911700;
        Sun, 26 Apr 2026 01:58:31 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com.com ([106.51.164.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36141868906sm27718937a91.3.2026.04.26.01.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 01:58:31 -0700 (PDT)
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
	mkchauras@gmail.com,
	lyude@redhat.com,
	airlied@gmail.com,
	j@jannau.net,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH V14 4/7] rust/powerpc: Set min rustc version for powerpc
Date: Sun, 26 Apr 2026 14:27:22 +0530
Message-ID: <20260426085725.2090827-5-mkchauras@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260426085725.2090827-1-mkchauras@gmail.com>
References: <20260426085725.2090827-1-mkchauras@gmail.com>
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


