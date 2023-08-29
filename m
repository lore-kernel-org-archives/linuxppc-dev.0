Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25115C83F12
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Aug 2023 11:36:35 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=fxwwGSDQ;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RZlkT28V5z3bgs
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Aug 2023 21:36:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=fxwwGSDQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=masahiroy@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RZljX4Tf5z2ygT
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Aug 2023 21:35:44 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 9662361196;
	Tue, 29 Aug 2023 11:35:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DED71C433C8;
	Tue, 29 Aug 2023 11:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693308942;
	bh=SEm+29cbjH0OCwAWFWoSuP1sSdbIL6i8Z3mrtpUFzk0=;
	h=From:To:Cc:Subject:Date:From;
	b=fxwwGSDQUQw4Q5QfZRDz+zr+x7HkaZksrDhPqVSYDf0eogzHxC0TIV37jg/+XENZf
	 THvUDi8u6zWZAC9/j3G0VwQFVdCEnbZS0FN5CgNdfy11tujT0rGrYhaRoFLS11Yemw
	 UuozUawY2Vma1IZqh6bze75GyzGZ6FOxD378v1V3A1OHNon5VxKMp1dIEs8oVKwuOd
	 AK+ybmDLK8S28oeQSxQ0xH+/ohqHqxlpF7yIWBinJfjS1TuQ+Z9A7/oaQrQEQwXl9A
	 vbcTCtugkxl4bjmlaIbewKYaih+Tc2A6EgjWHx6KrUvEReBb4FuZfguwK2WKc12jcX
	 P4E1qMsfttemw==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Subject: [PATCH] kbuild: single-quote the format string of printf
Date: Tue, 29 Aug 2023 20:35:31 +0900
Message-Id: <20230829113531.4004730-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
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
Cc: Nicolas Schier <nicolas@fjasle.eu>, Masahiro Yamada <masahiroy@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>, Nathan Chancellor <nathan@kernel.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Use single-quotes to avoid escape sequences (\\n).

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Makefile              | 8 ++++----
 arch/powerpc/Makefile | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 87a9eef3fb4b..d09600f7a036 100644
--- a/Makefile
+++ b/Makefile
@@ -1643,12 +1643,12 @@ help:
 	@echo  ''
 	@$(if $(boards), \
 		$(foreach b, $(boards), \
-		printf "  %-27s - Build for %s\\n" $(b) $(subst _defconfig,,$(b));) \
+		printf '  %-27s - Build for %s\n' $(b) $(subst _defconfig,,$(b));) \
 		echo '')
 	@$(if $(board-dirs), \
 		$(foreach b, $(board-dirs), \
-		printf "  %-16s - Show %s-specific targets\\n" help-$(b) $(b);) \
-		printf "  %-16s - Show all of the above\\n" help-boards; \
+		printf '  %-16s - Show %s-specific targets\n' help-$(b) $(b);) \
+		printf '  %-16s - Show all of the above\n' help-boards; \
 		echo '')
 
 	@echo  '  make V=n   [targets] 1: verbose build'
@@ -1684,7 +1684,7 @@ $(help-board-dirs): help-%:
 	@echo  'Architecture specific targets ($(SRCARCH) $*):'
 	@$(if $(boards-per-dir), \
 		$(foreach b, $(boards-per-dir), \
-		printf "  %-24s - Build for %s\\n" $*/$(b) $(subst _defconfig,,$(b));) \
+		printf '  %-24s - Build for %s\n' $*/$(b) $(subst _defconfig,,$(b));) \
 		echo '')
 
 
diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index dac7ca153886..f49ac05eae20 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -353,7 +353,7 @@ define archhelp
   echo '  (minus the .dts extension).'
   echo
   $(foreach cfg,$(generated_configs),
-    printf "  %-27s - Build for %s\\n" $(cfg) $(subst _defconfig,,$(cfg));)
+    printf '  %-27s - Build for %s\n' $(cfg) $(subst _defconfig,,$(cfg));)
 endef
 
 PHONY += install
-- 
2.39.2

