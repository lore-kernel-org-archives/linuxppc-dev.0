Return-Path: <linuxppc-dev+bounces-26359-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F9F1C61DE4
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Sep 2026 06:34:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYx0N0vpxz2yrD;
	Tue, 01 Sep 2026 16:34:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788244451;
	cv=none; b=YEQOBioFefFvMI4FD/ENXy/e49fdf2q5I4B2xElCD9QRVhUsSMlLeev+7nheGSEZzEES/G90cCwXn8v/gftT9kDIDJ4PwxYjFjsgpZZvtCiYAU4bDHnQ5YwiL5Lv6BoSTZJXTnFMcBqz1F5GiDYtzNZbfKmLSm/mdER7PgmB+UcOetzN7ZW7Px6y24tS6lR5tjMWZggSttDAv9zy/pKpJvahC0wY6GzOXx8jNMHWS7zmoKOuq23/QsaRYOgn8YmlnPWFF9JXLvoO5ElVwFdWCHnAAQBHqPmsuwjaWfKV6lr0ecUHIPKLCQwR+kivx5+cpvMwUYMsw1axFMjYxuMB4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788244451; c=relaxed/relaxed;
	bh=cm7AnhXk5wAc7XObEF0sJTRKiswy58SF5A5r5BOqqXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eqbEmmUX7/k5NHm0w4fqcsWwI/RKoHYAsgVaj+yhJnxmznQSK3yAV/BG6lofxkKsslx9JkReeP8e/q60Vd0ucE43aEMUfie5qoS/tomm0bQQ390jEgssf399mZlpcbDROsv0mZ8nyN30E8q4PBPhMXir5U05c8EzsZb2KOmJbxAeAtKka7/2W2ws0gkhQdFUPA/yw1rt8muKETuU6e0HUslzsTh6Ize4YzYR+Fk4z9R2vjrmTq7dUMceN2SMiA/emmSusH0AU+ijKSEETBvTgX1CmJm0S30PDdEV3zkXGLByl/gF5B9LWBe/KFblqiPx0aICTbEYcBt59m3AZYF7jw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=LqVd9zUX; dkim-atps=neutral; spf=pass (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=LqVd9zUX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYx0C4zdZz2yCL
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Sep 2026 16:34:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=cm7AnhXk5wAc7XObEF0sJTRKiswy58SF5A5r5BOqqXE=; b=LqVd9zUXioSOB4b05NZIh5RUYZ
	BeOBC07TghMyIResQYOdOTkxTJmFjHDjM4d1L3lmuQtkgN5IfPxJjlhq6YuL2OgThdqHO3zzqXTDL
	7+NlHrtfVjpftif0rbsQdu0D15TRFPyIdRLGjMDGyuOnHjGfcv+myJ/gX3zSkoCFPiIZp4ZR01sn6
	SoDpFThkt6x0QkDbHFla+FFgyQbANBu8ydaaxkylBXS5dVwO2hmPPP4VuQeJqXC3Z43j+rJkhHvXi
	HUx8qTdsQzEjcxFlMRuEVupF9Eaz3j5cdc5HhqK5kDJR083LRVJObwZ8hbK6sLzC1VpLVChD9HRjY
	yk+3881A==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1I4B-0000000B46j-4073;
	Tue, 01 Sep 2026 06:33:56 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Geoff Levand <geoff@infradead.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/4] powerpc/ps3: htab.c: fix enum ps3_lpar_vas_id kernel-doc
Date: Mon, 31 Aug 2026 23:33:52 -0700
Message-ID: <20260901063354.4012138-3-rdunlap@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260901063354.4012138-1-rdunlap@infradead.org>
References: <20260901063354.4012138-1-rdunlap@infradead.org>
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

