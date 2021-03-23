Return-Path: <SRS0=XXYE=IV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA50C433DB
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Mar 2021 03:28:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9862261923
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Mar 2021 03:28:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9862261923
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F4GzF00WCz30DY
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Mar 2021 14:28:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=kVmvizCH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=2401:3900:2:1::2; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=kVmvizCH; 
 dkim-atps=neutral
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F4GxR5L6vz30Bt
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Mar 2021 14:26:35 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4F4GxR2gfXz9sW4; Tue, 23 Mar 2021 14:26:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1616469995;
 bh=GgBnlOVa1gpDB3kjVxAHIqLt6CNMfTOeOQdVmnuVbJY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=kVmvizCHuqyRuLLo/WiwPhXby0g4q7HkR/xLhPyPQP/08WIKejYjYrqjQDS4kVdl6
 rjSHfnr3EVw2B7QNt31yduqU0GZ+R9xibo+LxljBGwx3M4A/IyLblK2YL0tAJKi7D+
 G81hs/nK2xs3AvHAn+nay+4pAJDRGEIRtx7xQiH3SaK8RM6JZf3Tocm7wwWJXQpyKH
 DjPOgUt2Dq+agm3Lv1uQKDn5g5R+D/MsgeqmsWaL6nPvJP3cAnM2i6b5rAuFun501h
 KLG0oNiBrE840QRlaKlSTkYm2SpWi0IUtv3c4ekVvED0EK9W9F7tlwJsNo0at+h0oX
 1Nrc4vAOEbXqA==
From: Michael Ellerman <mpe@ellerman.id.au>
To: rust-for-linux@vger.kernel.org
Subject: [PATCH 3/4] powerpc/rust: Add target.json for ppc64le
Date: Tue, 23 Mar 2021 14:26:23 +1100
Message-Id: <20210323032624.1039422-4-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210323032624.1039422-1-mpe@ellerman.id.au>
References: <20210323032624.1039422-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Based on the x86 and arm64 versions, as well as output from:

  $ rustc +nightly -Z unstable-options --target=powerpc64le-unknown-linux-gnu --print target-spec-json

Notably disables altivec, vsx and hard-float.

The very cryptic data-layout:

  "data-layout": "e-m:e-i64:64-n32:64-S128",

Has the following meaning:

  e:     little endian
  m:e    ELF name mangling
  i64:64 64-bit integers 64-bit aligned
  n32:64 Native integer widths, 32-bit and 64-bit.
  S128   16-byte stack alignment

Those all come from the rustc output, with the exception of the stack
alignment. We obviously do have 8-bit & 16-bit integer types, but I'm
not sure if there's any need to specify that.

ppc64le only for now. We'll eventually need to come up with some way to
change the target.json that's used based on more than just $(ARCH).

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/rust/target.json | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 arch/powerpc/rust/target.json

diff --git a/arch/powerpc/rust/target.json b/arch/powerpc/rust/target.json
new file mode 100644
index 000000000000..1e53f8308092
--- /dev/null
+++ b/arch/powerpc/rust/target.json
@@ -0,0 +1,30 @@
+{
+  "arch": "powerpc64",
+  "code-mode": "kernel",
+  "cpu": "ppc64le",
+  "data-layout": "e-m:e-i64:64-n32:64",
+  "env": "gnu",
+  "features": "-altivec,-vsx,-hard-float",
+  "function-sections": false,
+  "is-builtin": true,
+  "linker-flavor": "gcc",
+  "linker-is-gnu": true,
+  "llvm-target": "powerpc64le-elf",
+  "max-atomic-width": 64,
+  "os": "none",
+  "panic-strategy": "abort",
+  "position-independent-executables": true,
+  "pre-link-args": {
+    "gcc": [
+      "-Wl,--as-needed",
+      "-Wl,-z,noexecstack",
+      "-m64"
+    ]
+  },
+  "relocation-model": "static",
+  "relro-level": "full",
+  "target-family": "unix",
+  "target-mcount": "_mcount",
+  "target-endian": "little",
+  "target-pointer-width": "64"
+}
-- 
2.25.1

