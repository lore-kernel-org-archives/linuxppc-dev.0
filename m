Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02C1CC54E41
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Mar 2024 12:59:38 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=ZoBxq3Yq;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TqXZc4Q0Dz3vXT
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Mar 2024 23:59:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=ZoBxq3Yq;
	dkim-atps=neutral
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TqXYr0Nxyz2ykt
	for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Mar 2024 23:58:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1709729935;
	bh=9RwCidLittcTSYA5I7tueyDJwlx4nsoQCHawsQpmFDo=;
	h=From:To:Subject:Date:From;
	b=ZoBxq3Yq2h4S+tEJXk39E0HvOQo+QS16H+MYBznEoRKb9j+3uvjM7WITyM+WoxyNO
	 HGlbI4XthlgwpVPFOFR49SRps90XVvXO049iLTeFUnlahW32m/CoI0HvTOX0swlOHf
	 YMXd3i1wleS5uZwhXBwk6bHpZ1VFl0BsEuGdP8nky5TWyQ6OXC4Cn6A8QF+ais58Dd
	 iQTzzURSD8DD2UGzSBsMW4cCzv41hfBBvTQgeFMT1L+OgiD2BpIB9IMdv6YVcMoj+m
	 tpMHHgnjJfMQd3yr9bbC+d0V1k/lNa69BasjFLCMAWBxSDXbk7lL4e5fzpouEoUtcp
	 r2d65jnsAuWbQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TqXYq6C2nz4wcF;
	Wed,  6 Mar 2024 23:58:55 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 1/3] powerpc/64s: Fix get_hugepd_cache_index() build failure
Date: Wed,  6 Mar 2024 23:58:51 +1100
Message-ID: <20240306125853.3714578-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.43.2
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

With CONFIG_BUG=n, the 64-bit Book3S build fails with:

  arch/powerpc/include/asm/book3s/64/pgtable-64k.h: In function 'get_hugepd_cache_index':
  arch/powerpc/include/asm/book3s/64/pgtable-64k.h:51:1: error: no return statement in function returning non-void

Currently the body of the function is just BUG(), so when CONFIG_BUG=n
it is an empty function, leading to the error.

get_hugepd_cache_index() should never be called, the only call is behind
an is_hugepd() check, which is always false for this configuration.

Instead mark it as always inline, and change the BUG() to BUILD_BUG().
That should allow the compiler to see that the function is never called,
and therefore that it never returns, fixing the build error.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/book3s/64/pgtable-64k.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable-64k.h b/arch/powerpc/include/asm/book3s/64/pgtable-64k.h
index 2fce3498b000..ced7ee8b42fc 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable-64k.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable-64k.h
@@ -45,9 +45,9 @@ static inline int hugepd_ok(hugepd_t hpd)
 /*
  * This should never get called
  */
-static inline int get_hugepd_cache_index(int index)
+static __always_inline int get_hugepd_cache_index(int index)
 {
-	BUG();
+	BUILD_BUG();
 }
 
 #endif /* CONFIG_HUGETLB_PAGE */
-- 
2.43.2

