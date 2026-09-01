Return-Path: <linuxppc-dev+bounces-26357-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37133C61DE4
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Sep 2026 06:34:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYx0M3Gcpz2yqd;
	Tue, 01 Sep 2026 16:34:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788244451;
	cv=none; b=Xxdofg2fILkdvX/fIX55D2BuPM+ktBMpx2X5+23eLiUft3OZR1ABKXIY+oUE1/Z9QQ/rfqwdFSVjacsJ6gZ4lc+DLlefNw3Wj881cPbFfz6NFRxgAkfNMZXBjL3UB/+2J1FxSeebnFcl174c4KiTe5FlfF4HWKW/3hNohlIt6w6cL9siScCn+gCUDB6G6Bbp56o3zpHYKY0YKNvmKC1je8zVPSjlfz8qXvUWti5AZET78n6g0MnPkz+KuDxKrsK39Xc8dBRDsP9Y/6d0AQDOuvfIf+sHtNBbJurhsRF3kgIGCwBXhSKoq6eO9KI3fTdjDb8gH96R2cyy1MW6Ty7AwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788244451; c=relaxed/relaxed;
	bh=/URtJhh5qYgdD+SvrO47CWxV2uFOw6FeCWrobwxfu1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QZ1wjcR8iC56+PJ/oLGNGDq7ytAXQzLonArrOybG2VlG4IzVvZ/t60WxX83RyEVqpeGFRol8B7bHnlqmVK/tkSmSi+62Hj+5Y6MxhzFC+2iIS2tLu6D0MXKcy4srTIlMmm/aVBuWEskbZj0LKlRK5vUCqk9lQhEzpRllCOWgICCeOX2pr1gH72xGlSd9qZ+y0Q2/MX2+2li7yruEnFCrGPsVLMGSu+JIc/kHYK3KfnT29cZRAEYiExmZeLjERkKOijOIalJ/fD5OdkD0QxSdMschWA6y2fA9i8jR3JO/HPC+udGt8DZALoA6JA4qKMVkbBqwt6MIr7svog3teIxgzQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=YCO336YV; dkim-atps=neutral; spf=pass (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=YCO336YV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYx0C4cqVz2y2h
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Sep 2026 16:34:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=/URtJhh5qYgdD+SvrO47CWxV2uFOw6FeCWrobwxfu1o=; b=YCO336YVvU0hxZ5piXMZqbJCdN
	saNrXtXc7Nnyhvp5PHB46NIO6ByIbvbHlmKYZzFEA8m7kNPozght5CJMCeqyU5Lg1ApPfgD4B6jHl
	2WE9BqfHx3l8LQsyY7bXLQ+bDrSat6WnBCgCbeHHOKs9sQOyH0anv11V2NZlGveKI/imm64MoFPhF
	/KEc1MSz/4+8WdjVdqb/QMlyT6dF25Y5iSlG2P4wj8nNnIJ2eRSy55jhz6x5NzK1egkKVLZ0Zs5bQ
	Iul7PAzeNke/Z28knRh0/g0x2ZaSbtWx8bRaA+VUwblHjBe/mS55jqJeV1qbhMW0W2st/7xg1PPr0
	14mFxgKA==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1I4B-0000000B46j-2s9E;
	Tue, 01 Sep 2026 06:33:55 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Geoff Levand <geoff@infradead.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/4] powerpc/ps3: platform.h: fix enum ps3_spu_resource_type kernel-doc
Date: Mon, 31 Aug 2026 23:33:51 -0700
Message-ID: <20260901063354.4012138-2-rdunlap@infradead.org>
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

Use the correct enum name and member names to eliminate kernel-doc
warnings:

Warning: arch/powerpc/platforms/ps3/platform.h:240 expecting prototype for
 enum spu_resource_type. Prototype was for enum ps3_spu_resource_type
 instead
Warning: arch/powerpc/platforms/ps3/platform.h:240 Enum value
 'PS3_SPU_RESOURCE_TYPE_SHARED' not described in enum
 'ps3_spu_resource_type'
Warning: arch/powerpc/platforms/ps3/platform.h:240 Enum value
 'PS3_SPU_RESOURCE_TYPE_EXCLUSIVE' not described in enum
 'ps3_spu_resource_type'
Warning: arch/powerpc/platforms/ps3/platform.h:240 Excess enum value
 '@spu_resource_type_shared' description in 'ps3_spu_resource_type'
Warning: arch/powerpc/platforms/ps3/platform.h:240 Excess enum value
 '@spu_resource_type_exclusive' description in 'ps3_spu_resource_type'

Also fix misspellings of "partitions."

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Geoff Levand <geoff@infradead.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org

 arch/powerpc/platforms/ps3/platform.h |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- linux-next-20260828.orig/arch/powerpc/platforms/ps3/platform.h
+++ linux-next-20260828/arch/powerpc/platforms/ps3/platform.h
@@ -228,9 +228,10 @@ int ps3_repository_read_boot_dat_info(u6
 /* repository spu info */
 
 /**
- * enum spu_resource_type - Type of spu resource.
- * @spu_resource_type_shared: Logical spu is shared with other partions.
- * @spu_resource_type_exclusive: Logical spu is not shared with other partions.
+ * enum ps3_spu_resource_type - Type of spu resource.
+ * @PS3_SPU_RESOURCE_TYPE_SHARED: Logical spu is shared with other partitions.
+ * @PS3_SPU_RESOURCE_TYPE_EXCLUSIVE: Logical spu is not shared with other
+ * partitions.
  *
  * Returned by ps3_repository_read_spu_resource_id().
  */

