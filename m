Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065C5606A31A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Oct 2026 20:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=bagtLapK
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jFwR831wzz30WJ;
	Fri, 30 Oct 2026 07:13:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793304820;
	cv=none; b=hDCjqwSKA7Q0eYiwRKycnxlL08/zRognvBGp0+UuYi9fODgoAOY1QzF3HLtE9UYhL1qZeUmldv+8LEjyIs7jqxLcQJ873G7knzcUFUrFVe4Tz+mi0ys+NfSdoiTWE4ZMPc8OZFLYNE+sACy3AtPR6ixpE0dYM5acnnyDhXrUc3ntweXjRGVzMFdbYvIr1zpwKNolN228ui+4RuYSp/xw0lUlW6kIsulPXo4e809xKYKJ5AWqywNTaQo9rIuokkCRnkAD6iX6LHJeTuaHtUTAF/u2Cutso2OV7Jl+17JWE1E34jcDBHjiUNeiiY0Etm9gSfA6VSiTjpz6oy0D/wF/Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793304820; c=relaxed/relaxed;
	bh=cm7AnhXk5wAc7XObEF0sJTRKiswy58SF5A5r5BOqqXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B9/77CXJhQNrDoZguYlmiOFwlurwTyLIUaQMJNoygTgy6E/etE8aY9RW6PITH2X5EgQJv+jT2TzZ84JuL8FekkH4pe+3zvnIlrrqhl+DuvnTrVkM+sLIYu3HAhsN10cGmu7z9CQ8JPSCw4SjwFt2W4KlkoynxNw5UtYSgWn9h288IPgax+3fyiAsUgi2KWJ3zjy/ODjRtCo1PMAxQ9NNBLFSyp70biwtSxglKay4ph3ok/38yn0KSp1ADZo2G+kQpPl4OSrO0nZIE+47b0rk6R0aWVdr5JFNYfxzGP5vdy5aoKM8MeZoAp8gzPlPIk2A5TMU5OIbOF37WEaTomKXKQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=bagtLapK; dkim-atps=neutral; spf=pass (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=bagtLapK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jFwR16SZyz30Tm
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 07:13:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=cm7AnhXk5wAc7XObEF0sJTRKiswy58SF5A5r5BOqqXE=; b=bagtLapKIDd4nwLH+Y0NvaPPwH
	KRvJ4jY+gus0W47QDqSLtf/JAJkFSUy3Vgkd5HC3jMxDn7/eHquyYBShwdeWdxBfgY105ALiSGD0u
	VmlWXYdPFcAjh9WhZ1VkM/gqrTskgGN3a9lkSR66FQOg6U9RHXIpQTpa+PYWpcvuabHrXxVnKQEWA
	iS/mS3pUGXJMqoZLM7YOpocR4WNhcex4ZB5QH8+vLBV5FHJWjfupRB9ywNn/mZYbOlBAkz6eqmRf1
	xQfWHusIoPxVfBQOtS/Vb5U75QpTTR41OPRNy9KEq9GdtUQRiv21WHssQ7xejNmX3q5gekGUkahg3
	gbdtRzXQ==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMWV5-0000000AJR2-4Bjq;
	Thu, 29 Oct 2026 20:13:28 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: patches@lists.linux.dev
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Geoff Levand <geoff@infradead.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/4] powerpc/ps3: htab.c: fix enum ps3_lpar_vas_id kernel-doc
Date: Thu, 29 Oct 2026 13:13:24 -0700
Message-ID: <20261029201326.2672284-3-rdunlap@infradead.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029201326.2672284-1-rdunlap@infradead.org>
References: <20261029201326.2672284-1-rdunlap@infradead.org>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Use the correct enum name and member name to avoid kernel-doc
warnings:

Warning: arch/powerpc/platforms/ps3/htab.c:28 expecting prototype for
 enum lpar_vas_id. Prototype was for enum ps3_lpar_vas_id instead
Warning: arch/powerpc/platforms/ps3/htab.c:28 Enum value
 'PS3_LPAR_VAS_ID_CURRENT' not described in enum 'ps3_lpar_vas_id'
Warning: arch/powerpc/platforms/ps3/htab.c:28 Excess enum value
 '@lpar_vas_id_current' description in 'ps3_lpar_vas_id'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Geoff Levand <geoff@infradead.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org

 arch/powerpc/platforms/ps3/htab.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20260828.orig/arch/powerpc/platforms/ps3/htab.c
+++ linux-next-20260828/arch/powerpc/platforms/ps3/htab.c
@@ -18,8 +18,8 @@
 #include "platform.h"
 
 /**
- * enum lpar_vas_id - id of LPAR virtual address space.
- * @lpar_vas_id_current: Current selected virtual address space
+ * enum ps3_lpar_vas_id - id of LPAR virtual address space.
+ * @PS3_LPAR_VAS_ID_CURRENT: Current selected virtual address space
  *
  * Identify the target LPAR address space.
  */

