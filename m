Return-Path: <SRS0=XXYE=IV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B827C433C1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Mar 2021 03:27:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 518F261923
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Mar 2021 03:27:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 518F261923
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F4Gyl64wnz30CG
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Mar 2021 14:27:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=M/X4a01p;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=2401:3900:2:1::2; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=M/X4a01p; 
 dkim-atps=neutral
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F4GxR2WJZz30CG
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Mar 2021 14:26:35 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4F4GxQ630wz9sW1; Tue, 23 Mar 2021 14:26:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1616469994;
 bh=EFE7LyzDCiEWIHFaedOFWCyrUEJoHI74qld4WEFKn3Y=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=M/X4a01pBGNQ0E7iGEGTXqBkaFXCLUS1utAGlpBvkKPgXS/3LFCJ/bhAKxQMO8AoT
 etI6y3FipOVcwPKneIm4TwVez8UUfubKkfYjFPPJUPX6/b5kxS+m49bTDXJtYNl6hp
 Jk9I4oWdEiX/AXTVi2xyzitxx1O7tGKf3pjVTPGC6NqDcfmTUQpJov8aJW6sMlamKN
 IU+nrAG55IRfhLsoKvIfkcW3wd2KDoSXzdn7qXeIQn/GbinoB2DVGm5sU9VnHoFO0a
 r83/JyYtnoYU2DoSwgw9i/LF9zxchioclkcsOanRDbmVibg2q4Sia3DgMgFkewaNrM
 x/joZen5exSsg==
From: Michael Ellerman <mpe@ellerman.id.au>
To: rust-for-linux@vger.kernel.org
Subject: [PATCH 2/4] rust: Add powerpc64 as a 64-bit target_arch in c_types.rs
Date: Tue, 23 Mar 2021 14:26:22 +1100
Message-Id: <20210323032624.1039422-3-mpe@ellerman.id.au>
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

powerpc kernel code uses int-ll64.h.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 rust/kernel/c_types.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/c_types.rs b/rust/kernel/c_types.rs
index 423ac1108ddb..988fd84b0d66 100644
--- a/rust/kernel/c_types.rs
+++ b/rust/kernel/c_types.rs
@@ -60,7 +60,7 @@ mod c {
     pub type c_size_t = usize;
 }
 
-#[cfg(any(target_arch = "aarch64", target_arch = "x86_64"))]
+#[cfg(any(target_arch = "aarch64", target_arch = "x86_64", target_arch = "powerpc64"))]
 mod c {
     /// C `void` type.
     pub type c_void = core::ffi::c_void;
-- 
2.25.1

