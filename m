Return-Path: <SRS0=ON6F=CR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7BFAC43461
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Sep 2020 13:01:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47687224B2
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Sep 2020 13:01:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="O8CUyi94"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47687224B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Bm4zL5565zDqSm
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Sep 2020 23:01:34 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Bm4wG5ymhzDqRc
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Sep 2020 22:58:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=O8CUyi94; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 4Bm4wG2CCQz9sSJ; Tue,  8 Sep 2020 22:58:54 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4Bm4wG1FFxz9sTS; Tue,  8 Sep 2020 22:58:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1599569934;
 bh=KE/Ra+TMjADqCw/JtrFXsMxvBsgybgLiIE//budiCjY=;
 h=From:To:Cc:Subject:Date:From;
 b=O8CUyi941MRk3CWrtnbPA7mmYix+Pcoc3m9z2CfwcRNSdOtZtbmm6WUStUoMMAb+Y
 Y2KOxhJPuFdg66Wl46EgE35UB/i3gZWurTF4+eCVDhPlqegMarUNkESeXUkPN1mVJA
 3wbrJ/CmVUJ6s/9jN68avuW6X8HDVij/YkX4dw7HfzewI4jrxCgje6PpYvutFTTEn6
 RPKVce84lAF0B690lyBBYQv3UqI8nqn2FrxoKtiqLIwmZfsCeVx9XWr7qwxB2QIXpF
 DPJ3Sh5eeF3ZsqPJOr2bF14iwCkzsvKmPwnLN5FWEK/OeHGKPqz4PLJ3Z1IYjsQwqo
 Alr8zd0eyd2Sw==
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/64: Make VDSO32 track COMPAT on 64-bit
Date: Tue,  8 Sep 2020 22:58:50 +1000
Message-Id: <20200908125850.407939-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.25.1
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
Cc: christophe.leroy@c-s.fr, msuchanek@suse.de
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

When we added the VDSO32 kconfig symbol, which controls building of
the 32-bit VDSO, we made it depend on CPU_BIG_ENDIAN (for 64-bit).

That was because back then COMPAT was always enabled for 64-bit, so
depending on it would have left the 32-bit VDSO always enabled, which
we didn't want.

But since then we have made COMPAT selectable, and off by default for
ppc64le, so VDSO32 should really depend on that.

For most people this makes no difference, none of the defconfigs
change, it's only if someone is building ppc64le with COMPAT=y, they
will now also get VDSO32. If they've enabled COMPAT in order to run
32-bit binaries they presumably also want the 32-bit VDSO.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/platforms/Kconfig.cputype | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 87737ec86d39..a80ad0ef436e 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -490,13 +490,12 @@ endmenu
 
 config VDSO32
 	def_bool y
-	depends on PPC32 || CPU_BIG_ENDIAN
+	depends on PPC32 || COMPAT
 	help
 	  This symbol controls whether we build the 32-bit VDSO. We obviously
 	  want to do that if we're building a 32-bit kernel. If we're building
-	  a 64-bit kernel then we only want a 32-bit VDSO if we're building for
-	  big endian. That is because the only little endian configuration we
-	  support is ppc64le which is 64-bit only.
+	  a 64-bit kernel then we only want a 32-bit VDSO if we're also enabling
+	  COMPAT.
 
 choice
 	prompt "Endianness selection"
-- 
2.25.1

