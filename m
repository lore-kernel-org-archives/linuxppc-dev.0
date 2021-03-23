Return-Path: <SRS0=XXYE=IV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA5E4C433EA
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Mar 2021 03:27:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B02A619B4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Mar 2021 03:27:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B02A619B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F4GyK0xG9z3btg
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Mar 2021 14:27:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=Vbg7Kgy5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=Vbg7Kgy5; 
 dkim-atps=neutral
Received: from ozlabs.org (ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F4GxQ4xFtz30Bt
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Mar 2021 14:26:34 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4F4GxQ2Fdxz9sVt; Tue, 23 Mar 2021 14:26:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1616469994;
 bh=pI3r2Prfzt94X/Go8BVnLJk6iersevs1fjV3F+dAlsU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Vbg7Kgy5nKoxbRoiK5LmncSHeETXcsRbXXaj5+ZaXVf5z2MAeaATJf2u6+0D+AEde
 tc0RIiwAVBDT9qPA9miYAojJ/cnpDs5JTNxZUagM9uqYUYdbVMFPC754wsZr6t1mN+
 IKTwL+WYim4u9aaBP4CV5jEpfHkFoopKXHLGzHXBSH0Ie9juWEzK+i8dR8RATcZ7NK
 PTSduRN2WpSETdR9D/9fFYjc6MRQ1yLqty+V39RUq/MKoY9yikXa4djkrJSMtQX+BI
 pa7mRhcgxkmOdI2HfB9ol1XtcszjHC5iIo7uLpLHOY/JMc7Zv1iIBDqlAcsGNGYrg5
 sWtFiXxyssNxg==
From: Michael Ellerman <mpe@ellerman.id.au>
To: rust-for-linux@vger.kernel.org
Subject: [PATCH 1/4] rust: Export symbols in initialized data section
Date: Tue, 23 Mar 2021 14:26:21 +1100
Message-Id: <20210323032624.1039422-2-mpe@ellerman.id.au>
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

On powerpc some symbols end up in the initialized data section, which
means they aren't detected by the logic in cmd_export, leading to errors
such as:

  ERROR: modpost: "_RNvNtCsbDqzXfLQacH_6kernel12module_param15PARAM_OPS_USIZE" [drivers/char/rust_example_4.ko] undefined!

nm represents the "initialized data section" with "D", so also look for
that when exporting symbols.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 rust/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/Makefile b/rust/Makefile
index eb8f12ce1644..4cddae9d4a25 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -73,7 +73,7 @@ $(objtree)/rust/bindings_generated.rs: $(srctree)/rust/kernel/bindings_helper.h
 quiet_cmd_exports = EXPORTS $@
       cmd_exports = \
 	$(NM) -p --defined-only $< \
-		| grep -E ' (T|R) ' | cut -d ' ' -f 3 | grep -E '^(__rust_|_R)' \
+		| grep -E ' (T|R|D) ' | cut -d ' ' -f 3 | grep -E '^(__rust_|_R)' \
 		| xargs -n1 -Isymbol \
 		echo 'EXPORT_SYMBOL$(exports_target_type)(symbol);' > $@
 
-- 
2.25.1

