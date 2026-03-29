Return-Path: <linuxppc-dev+bounces-18972-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7EDCF3D60A
	for <linuxppc-dev@archiver.kernel.org>; Sun, 29 Mar 2026 16:03:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fkK142ynnz2yj3;
	Mon, 30 Mar 2026 03:03:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774800200;
	cv=none; b=B7lkki6InZ1ML2DcQgJEfTKbpEtzxi9M225/08YfHK1+dEwA2pjRkUOOz5uodzykUQQE/C90zTvGZ1Ob6r+9UTvHnXaAIEehSY9WInYnIM4W5w1USr+1c8q6qG2cV1Bl4CweIFG/y9JFBodl0bKuKxGl6yczeHv3vikAjDsAE5d7vdQEsge8WCTzIqGrTX7Rw9m9h1XrUtGen4v6KL2XDhWBjLOUNslfGuj2URz+LfrLPzqckbZHtcyQP7LZPmMy/0xEEl5rTzKda9mAMACRtJjSCSGQTPffhEzuDTxpxTQMJp959wUnD8mwA3tlyRtio9g2ytsrLP6wJH+A1Jie+A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774800200; c=relaxed/relaxed;
	bh=uFobi584Ko0XKuKylhtkyLR5aYVs05x6vhchjMWGRW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gTM1GjwwNftMNQP47ElWfcxr3D2E/SxnRQET5NsMlS0GXKs4z3JKwIHWcltVjsJF56hb16lmkEW/4E4eNLjHO76yc4FrcOmV0889vmNrOBgvOUHXe6uVAXQJozGC5u3/qxEMKIHIP7QKXKxYke0BZUyxgu3kd3MQx9uYCPm/63uywpe00AInsPTZF3BdNmmZAhTGEYD0NnO8vl2ylpJcFP9yBvaVMC7hh+s//B10x62p9qvYsOpYhBnQyvsv2xF6PRnsvgO14S7KJl4X8u0QhmBXosOuL3v8eUEkyDvUsakTGCE1uxc+PjQnm6igXZorVx98KUVCFAgAG/QhkqISGw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ObYp2Szl; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ObYp2Szl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fkK1239ZVz2xlK
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2026 03:03:18 +1100 (AEDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-2ad9516a653so15844855ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Mar 2026 09:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774800196; x=1775404996; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uFobi584Ko0XKuKylhtkyLR5aYVs05x6vhchjMWGRW0=;
        b=ObYp2SzlXbee7fTyisVTEzriyrElCbCvzeATU7/Dly4fI46Q8D4ElaTEIkQC3WXb+l
         tGzcv453B0GjsGxC2EcRabfIKPRY1yphjSX0o7AdnZ2Hy5eckOka6Hgh4gL/0w9CCIoR
         1HW5c/vkD2eHg4RS250mhxib3zXhXPYtBOcaZqwrFTWw+MXCoQJUuCKXq5USnBFNmfRF
         J0DnFa18wM7+pGwGCIMyU5T/F2fDUm7jfGuymub4koUAEXfVVP/VOnuTK3qkJ2UbFYkR
         B7PYmlu3Oktg1qdkEi/6jw9gIIE5XDHLfIjZmbDB5pN/Y08KRfjxLZtn3I1y3WBAHlc3
         yTdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774800196; x=1775404996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uFobi584Ko0XKuKylhtkyLR5aYVs05x6vhchjMWGRW0=;
        b=b0dXW5jXGDYKwc7oeWirdh974Aww4EvAncELTH2e69UlbJ+opLvUBzVxtwv7yMk9Li
         5PkEEgDhLW+VCb9Pyk+QGnnvCWD7ZXgMNztWErraVSNB0P2lnDUysdspMvuJRSR2xWXP
         /Vi+rIhYLw/C4x2PjOfHTpKES3xCp15PN8S0v6kWc6QhN76WFgzYpaxonrTLTd/wTaF7
         yj6HmTzHRuItc9WH9nFg6nmGiT+rsdzM8E1WRj81CYdVSte2Ag8OE7Zymcp4tzItz35f
         OCmj5+vd3ivd2EMjzwGy5sDSZgPTuO1AbOxZBoUKqb0bRCgrQdGsdCqu78YsEFzXolom
         E5mw==
X-Forwarded-Encrypted: i=1; AJvYcCWP+1MNpKtuTiskLtQoTakbpo6w2/dnYnqtaNAbVdhsIOF7AHwq77ERza/62m/lAY003Q9FWSO5tsMyqHo=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwwFOiePIEh6mqBgEVNP+5hn6NVk3eMXmRuL1OfqYfBlSYIBWQ/
	DnKwV4vgShA6bBlECLRoeNnwKYWxr768DjmOfRSXDo55qPxTfkvkCMKY
X-Gm-Gg: ATEYQzzn5PNYSbAfkO4+rZLocG5iu50uAfmKUT0WSolj/3ojfubjwdCojW4d3u0LxYA
	TKKfgAG2d/07EJriYQus55+ntuaQgL+QQmRMzYJOLrnVF+MCIvr2Uzrh/egXatjVRQ7piLMXTic
	v212TcIUpMwp054RtCqvwOwpyGZuYkgY/dJns4+QB4OLnAHXeV7wjU7bliAE1WrWVDa/Ip3dms3
	qPc/j6/KR14GNX45IcChwnvH/g67d2IhVpWrek7KBCP4+7yBQ9rw31pn6dAsBFsgfK39OyN1ZyF
	M7kAAhTQKvYQiN/il//ajbyrDMDmiTHt6XeEac/GjDTcf37FJZGlvSJk5SzeZ5mEpXf1FZQaMb0
	zjR8O5Mm90eYrkXkAsAFH3UFWvrIlgc/ObXunYT49jFY2C/j9wgalF04Hhe6a/+Fa9vXhJkc1XA
	PifZ5yZKDmS03gHlfxzZ9WxQBj17sAsoGsAmXQYWPvifeJ7d8lqBsz28v7jFN+rc4CU9flvdZ06
	Nw=
X-Received: by 2002:a17:902:e802:b0:2ae:b991:a46f with SMTP id d9443c01a7336-2b0cdd1a6b4mr106203235ad.42.1774800196182;
        Sun, 29 Mar 2026 09:03:16 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com.com ([106.51.160.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2427c176fsm52521175ad.77.2026.03.29.09.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 09:03:15 -0700 (PDT)
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
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
Subject: [PATCH V7 1/4] rust: Fix a race condition in Makefile
Date: Sun, 29 Mar 2026 21:32:51 +0530
Message-ID: <20260329160254.2592207-2-mkchauras@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260329160254.2592207-1-mkchauras@gmail.com>
References: <20260329160254.2592207-1-mkchauras@gmail.com>
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

When compiling with -j1 flag in powerpc, the libproc_macro finds the
libcore.rmeta both in toolchain and local rust directory. libproc_macro
should use the toolchain provided libcore.rmeta.

So for this, make libproc_macro2 libquote and libsyn dependent on core.o
so that libcore.rmeta is generated after these 3 files are done
compiling.

Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
---
 rust/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/rust/Makefile b/rust/Makefile
index 9801af2e1e02..8e62f6fcf94f 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -650,7 +650,8 @@ $(obj)/core.o: private skip_flags = $(core-skip_flags)
 $(obj)/core.o: private rustc_objcopy = $(foreach sym,$(redirect-intrinsics),--redefine-sym $(sym)=__rust$(sym))
 $(obj)/core.o: private rustc_target_flags = $(core-flags)
 $(obj)/core.o: $(RUST_LIB_SRC)/core/src/lib.rs \
-    $(wildcard $(objtree)/include/config/RUSTC_VERSION_TEXT) FORCE
+    $(wildcard $(objtree)/include/config/RUSTC_VERSION_TEXT) FORCE \
+    | $(obj)/libproc_macro2.rlib $(obj)/libquote.rlib $(obj)/libsyn.rlib FORCE
 	+$(call if_changed_rule,rustc_library)
 ifneq ($(or $(CONFIG_X86_64),$(CONFIG_X86_32)),)
 $(obj)/core.o: scripts/target.json
-- 
2.53.0


