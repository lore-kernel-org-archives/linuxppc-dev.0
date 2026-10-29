Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85980606A31C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Oct 2026 20:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=LlXSNsnD
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jFwR671KTz2ygg;
	Fri, 30 Oct 2026 07:13:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793304818;
	cv=none; b=LhAZGqEOvhpSnE0lK9nNkDNgPqm5JQRKHKGs0ZMknL4Tg0qQVggc6lvrLqcK1A3nTCaYfTEoxSHe4FHkUmgz3V/6iWfspcB0zTaGH8bt7RRm9Xdt48AHnK9JZiC1aDPJq684HZRmi8bJNOnGk97Nb+VyIEmkXunpivFygyEK9YNVQoi24NvsenezJpQmLinJ7N5lGU6Z2DAI9KcXYbMTNpl6B16hPrQdiDzs/FkJvXxTuILZ8S8EhrRu7hUXZskFkqoeQPqu+D8mfKxLLx313tUeQFzhEr+7yfFD35/AVzAvMomMVmpUzda87CThqSg3cNiaKJlDiPtovNBN1XUwFw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793304818; c=relaxed/relaxed;
	bh=j5wlQy9DCaktYGyQf5jBA58+1SExlqWK2qFF4AF0tHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d3ScZ7uKfPCkdDORrehHLU8LEY+aKNWReEyjiskgSaL8s5j2XERo1KvjemvABvs/Of5B8HmQglt6M5+K9U7AYOPKXNuyOyPWtkxrywHiFEzD3ja+q9F5ftx3QN/d5H27AYcw4xuAEXmASFrCOj5/k7Xpy7DxkTTs3HaGZfzh6IGc5Sy3zOwGEqXmQpV7orWm++1GmEZlPTidvObcUzYZW5dLaWX9Dj5fSHD8R7Bw6WFzjVGxylJCDmF6+8wAOXH8fI9ZmRCY406+DSgVdnT23fnkhQNISDTe9CHi9ZkGJV3nM8nsJMtcwcUNPHo679CnJKz7X0UVXas7DNvOABqJEg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=LlXSNsnD; dkim-atps=neutral; spf=pass (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=LlXSNsnD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jFwR16XpFz30Tp
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 07:13:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=j5wlQy9DCaktYGyQf5jBA58+1SExlqWK2qFF4AF0tHE=; b=LlXSNsnDOIdm4GZ9AenZo9tsU6
	ihmFx5dR9N4k6VcXIgf/BHd54XYUCNH1i3UtY8Rm3U+i1588tVMgXdGHn7yg2kp19F7bg9kWG5Oos
	K8GO8b+7LPiRWsT71Wfvs4/2/ZFACmy04UD4LL5tPN7cemXTBKPeuwiZpDXij4/iUf3mcOlHsLAgh
	3WbggiK5T/etPUK4BWFG+dGDtm5wI9Bbhy11UyDPgx4gfGREkGC1uazLEhieSgph3xnQn8dZ5ZHjv
	O6q70wPt1pSWQhmwstMp4iEeNoR7lzqq+Y4QwAN/TgckIX6QsX2E4ii0d5qtexwQ5KiGEeQ2ai02c
	Z/F9NrOw==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMWV6-0000000AJR2-2OX1;
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
Subject: [PATCH 4/4] powerpc/ps3: os-area.c: fix some kernel-doc warnings
Date: Thu, 29 Oct 2026 13:13:26 -0700
Message-ID: <20261029201326.2672284-5-rdunlap@infradead.org>
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

Add one struct member kernel-doc description.
Convert an enum and a struct to common C comments instead of kernel-doc
comments to avoid warnings.

Warning: arch/powerpc/platforms/ps3/os-area.c:139 struct member '_db_data'
 not described in 'os_area_db'
Warning: arch/powerpc/platforms/ps3/os-area.c:152 Enum value
 'OS_AREA_DB_OWNER_ANY' not described in enum 'os_area_db_owner'
Warning: arch/powerpc/platforms/ps3/os-area.c:152 Enum value
 'OS_AREA_DB_OWNER_NONE' not described in enum 'os_area_db_owner'
Warning: arch/powerpc/platforms/ps3/os-area.c:152 Enum value
 'OS_AREA_DB_OWNER_PROTOTYPE' not described in enum 'os_area_db_owner'
Warning: arch/powerpc/platforms/ps3/os-area.c:152 Enum value
 'OS_AREA_DB_OWNER_LINUX' not described in enum 'os_area_db_owner'
Warning: arch/powerpc/platforms/ps3/os-area.c:152 Enum value
 'OS_AREA_DB_OWNER_PETITBOOT' not described in enum 'os_area_db_owner'
Warning: arch/powerpc/platforms/ps3/os-area.c:152 Enum value
 'OS_AREA_DB_OWNER_MAX' not described in enum 'os_area_db_owner'
Warning: arch/powerpc/platforms/ps3/os-area.c:197 struct member 'valid'
 not described in 'saved_params'
Warning: arch/powerpc/platforms/ps3/os-area.c:197 struct member 'rtc_diff'
 not described in 'saved_params'
Warning: arch/powerpc/platforms/ps3/os-area.c:197 struct member
 'av_multi_out' not described in 'saved_params'

This leaves around 20 unrepaired kernel-doc warnings.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Geoff Levand <geoff@infradead.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org

 arch/powerpc/platforms/ps3/os-area.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- linux-next-20260828.orig/arch/powerpc/platforms/ps3/os-area.c
+++ linux-next-20260828/arch/powerpc/platforms/ps3/os-area.c
@@ -119,6 +119,7 @@ struct os_area_params {
  * @count_32: number of usable 32 bit index entries
  * @index_16: byte offset of the database id index for 16 bit variables.
  * @count_16: number of usable 16 bit index entries
+ * @_db_data: 1000 bytes of shared flash memory database
  *
  * Flash rom storage for exclusive use by guests running in the other os lpar.
  * The current system configuration allocates 1K (two segments) for other os
@@ -139,7 +140,7 @@ struct os_area_db {
 	u8 _db_data[1000];
 };
 
-/**
+/*
  * enum os_area_db_owner - Data owners.
  */
 
@@ -182,7 +183,7 @@ static const struct os_area_db_id os_are
 
 #define SECONDS_FROM_1970_TO_2000 946684800LL
 
-/**
+/*
  * struct saved_params - Static working copies of data from the PS3 'os area'.
  *
  * The order of preference we use for the rtc_diff source:

