Return-Path: <linuxppc-dev+bounces-20039-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00344FB44A6
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Apr 2026 05:48:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g22864xphz2xnl;
	Fri, 24 Apr 2026 15:48:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777009734;
	cv=none; b=bibeBLCCtVW8pXTSjEzp08eMqKXEWicTCt76Qt/tiZq/4BYu60g29m2kizD92k4kIxEeDmu+JE6rh9z7VHllpRoYumAi2LfXoLgoTF4LP1fpGwxCnvrzdzayNb3Q9Hn5WPHou4w6gVrCePt/PMoXRotcjFvT+wxWMfsB5gQ9ROgYLj69V11hiOk/XXAZ612si5Zu18X1q8DLSicF5W4wO/wxRQU4vXDrLIt407JGESo50RVtu+julXUt42xbF7fXYSNU35nuziu7DclPSPT4z+tawa8I+lctAIy/NZjiDNKdNgAnvFpaz/zXVR6iIhrShQup8c09pkD0BfBrTETisQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777009734; c=relaxed/relaxed;
	bh=/jOMf9sHPOP+Fk6bUCc/tdd0deN6bifNBcXjhksEyrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eUUqiQSLiFQCiMiPcq8SE0hprVbY3LAcmYBJnw6WrixflxzZy/MD7WHNsRWHXDfqkPQFZ4GWuCiNEriQLVDrJgcpvaY45YR7XuZy8BeZGrrfMsBo40DGI2P7JSeK10Y+OZEpmwVH6uM3SBEv+RwCIEerGDWCfXx9F72s06y5YjKan77RakDSMz/AgFZ5vOEGn6jr1Khm2Y5aIrBQF3e9nKOqu9HyqpN8kay5YXhCdVc9O7WFvC6DAITGEegj83JD+CiYxfNHHF2bUYMJ/pa2jAyQPPB9Nhbk0psYVE5asPySdPUBGvEdan8R0tt2scwGvJh0iBc8qx7umHHmKmJQBQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GNY2ubdj; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GNY2ubdj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g22856x0qz2xfR
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Apr 2026 15:48:53 +1000 (AEST)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-35fb7c1a455so2910370a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2026 22:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777009732; x=1777614532; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/jOMf9sHPOP+Fk6bUCc/tdd0deN6bifNBcXjhksEyrM=;
        b=GNY2ubdjZtHhwPVwbidbFbvTOQ3AYqBl53NYp4/4oM6Wmo9ulnjSjf2yQmWKbdZ6pD
         ha19yPOSVLL/xxo3RW3T99ycX1Ax8o4dnXGiRREQMlS4r4JBUNYC8Z2s6bQ08J4809ES
         uSTYmwpa2Rs+I7PdivpC7I4lZH71cCVgwhwYTs76KNgfDN9C+0T5FsLlaH6w6/cGJMGs
         9aiiZd0ZxmefJTLMUTPLQHmsrjmrrsHQjtKVmxADgCzUdnL8QKFH73DXMhHa8XbSgeFs
         DTuPINLoi+0MLoDCFcvlHpgDDrIokI9ny2OG7PScqhp6Z//SI0C5+n7rpGwcDVWODkJX
         wVGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777009732; x=1777614532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/jOMf9sHPOP+Fk6bUCc/tdd0deN6bifNBcXjhksEyrM=;
        b=C4kEHJK9XS9N0tvExSaoHZ/kU2e7Asev4Yj2rvJqT2q7Nv+HtbuY+YgOfCq1Y6Y2OC
         pPIGfu+LpqDbOchWDw+/0OBsd5Xuj5jSFRixxU/gSoF0i1jkp46BewwiD0sa/DlGa9jY
         XPAEs+oZjjNLBOsTbBZJpV2h+wQFYRmiZgHuZN6fEH3rI8+PhD3ath7bMSBY1Dr1oWSc
         mRBRMiLNi2gf6OBVX/hGBblQ2xybqnXELF5tGhXWS65n58CVheaIkNjyMH/rOkhZj5fR
         cAYOgdFpMjk26WHU3oL77tC00QGDHWUXN1pI8rTQWKD+OnoGozQxcOMhPgQvdhQQMWLs
         HQDA==
X-Forwarded-Encrypted: i=1; AFNElJ/rk7sVAiBcxm826XQh+auoaCQ+IGV0JirSTFOgFHY1BrW75iQN9PzBC6Ftl3gnC5ptRSErjg1ZhJQHSO8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyqS95rowkw4eWUx0JxoARGmh1oOhdUu3bpZronLMjdS/bdXP0b
	PK8cBiCVlwY1k6BOlAAemwcomuuTL6gnAB/23MSuBtYBVaA55OCXSK7Q
X-Gm-Gg: AeBDiesD/7Ni20NYYVqJRwjL/CRnpxZT7EpbsxJ5fVuNiIO7D5GTMptNW2utBNguLuF
	lPi+InbCkeILQegJhO44xV46nazOG/ykwTfqs1qrNgotbfTAYNy0ZOCNqDYud4diSlizGdpUCr+
	Co+/a1KNcZCuueX4yq6n14ItFRdbMINz43yVPVReYo3VKQc9DH18hihy6tdYYBwNnDheFcExmb0
	mwHPvzMdeUsyDH3Ysunwdl7CtbiGNsqbBkd1BPWpX+yXOBXwv8sKNDloXgLeQNl8yqzteH6Hblx
	wll65GM8hH/bl1myN8LhCuGlFBSa6lsdw44dlz51QsQa+/Wh2pCyS+caxriOL5/i0ciA7a3IcGC
	hENacUzDfeApe4YVdxQ1fZJ/LiiJUBEdRCBucFlT0e5C26vTk0t9RLDTR3lFP04L5iJECUT/zfC
	2Y59b1R4/EqJc7kTDxvgIkc1O+IWlERXdoLtF+8FtJQoCYEG+KhiXhIkSeFDbkG8p//eXQgzEPZ
	bOFThyZ/56XgtI=
X-Received: by 2002:a17:90b:5185:b0:35c:29ba:bf92 with SMTP id 98e67ed59e1d1-361403d5988mr33141482a91.5.1777009732009;
        Thu, 23 Apr 2026 22:48:52 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.bl1-in.ibm.com ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5faa176e9sm208778245ad.20.2026.04.23.22.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 22:48:51 -0700 (PDT)
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
Cc: Link Mauve <linkmauve@linkmauve.fr>
Subject: [PATCH V13 5/7] rust: Make __udivdi3() and __umoddi3() panic
Date: Fri, 24 Apr 2026 11:17:40 +0530
Message-ID: <20260424054742.45832-6-mkchauras@gmail.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Link Mauve <linkmauve@linkmauve.fr>

The core crate currently depends on these two functions for i64/u64/
i128/u128/core::time::Duration formatting, but we shouldn’t use that in
the kernel so let’s panic if they are ever called.

This doesn’t yet fix drm_panic_qr.rs, which also uses __udivdi3 when
CONFIG_CC_OPTIMIZE_FOR_SIZE=y, but at least makes the rest of the kernel
build on PPC32.

Signed-off-by: Link Mauve <linkmauve@linkmauve.fr>
Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
---
 rust/Makefile             | 4 ++++
 rust/compiler_builtins.rs | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/rust/Makefile b/rust/Makefile
index 2a5428a5503d..ee11fba7a03d 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -616,6 +616,10 @@ ifneq ($(or $(CONFIG_ARM64),$(and $(CONFIG_RISCV),$(CONFIG_64BIT))),)
 		__ashrti3 \
 		__ashlti3 __lshrti3
 endif
+ifdef CONFIG_PPC32
+	redirect-intrinsics += \
+		__udivdi3 __umoddi3
+endif
 
 ifdef CONFIG_MODVERSIONS
 cmd_gendwarfksyms = $(if $(skip_gendwarfksyms),, \
diff --git a/rust/compiler_builtins.rs b/rust/compiler_builtins.rs
index dd16c1dc899c..fc6b54636dd5 100644
--- a/rust/compiler_builtins.rs
+++ b/rust/compiler_builtins.rs
@@ -97,5 +97,11 @@ pub extern "C" fn $ident() {
     __aeabi_uldivmod,
 });
 
+#[cfg(target_arch = "powerpc")]
+define_panicking_intrinsics!("`u64` division/modulo should not be used", {
+    __udivdi3,
+    __umoddi3,
+});
+
 // NOTE: if you are adding a new intrinsic here, you should also add it to
 // `redirect-intrinsics` in `rust/Makefile`.
-- 
2.53.0


