Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CC0606A31A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Oct 2026 20:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=RXMGdtYr
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jFwR90l2Dz30Tf;
	Fri, 30 Oct 2026 07:13:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793304820;
	cv=none; b=KrTOYDci99t2v5yRBi3Xe1ahIOddTnFgi6hDfiFV/Q/ZYLObDKBpsaIAoAv85CEqSsQ6ZFMKTTZ5MTgowtWsFKzpYNNCErrcXMa3ndZV+bjTCit0kT4AASU8a5Nnm75COSZXl4CSxP2v8jXovuBr6fowcF70y1wc3A9psI7ztdAwIa+NYOLaqspFY/uexnUE1JUAR9TCL9+Lh3drSooDvrLHX3cCnCho/hjLa4awlV05K1sAbRngpzOS8QjjyNaE4h7CAHREuPoErlNM2hHsjJUZtnJlcfwDuDEq0f+k7IH7RT90R2WMRYHBfy3WEve6oryBU3DQap8CTce3Hz+q4A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793304820; c=relaxed/relaxed;
	bh=Er0GRhCzdVU5yeaX5s1ElRVbYAULyDK/JtS7EUoH5DA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DjGObWfbDizWSSn6oPuB/OgzTkK9MYu04eNgWlhJPIzDBNMr21f7MCH+ZR3eO+HxQVB24VL5mu2k9FtcyJAcGwts3o+XbLFrCzppczbfiKnWTHtArVP+LOkfwyghajm6Pv47E60e4wSpOOm5NPqUxAQkRTwSa47x8hsCQRF1HJogViuPBnHQF7f8ocGcU4WTvQy5QN6nPLGiOl6g8GKLpW2Ff/yxN9O5kJZDe96Nzpy3QKUi0t07h3FbGrXC/8SQDiUhbm/1FhOb2wWUEVywv38ryG6ivDYOOvZOlL+ZG8xebYEVl45H4eZ3DIZWGgnuNLElMjR3LisvQ7jNMx6TGg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=RXMGdtYr; dkim-atps=neutral; spf=pass (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=RXMGdtYr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jFwR16LQsz30Sv
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 07:13:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Er0GRhCzdVU5yeaX5s1ElRVbYAULyDK/JtS7EUoH5DA=; b=RXMGdtYrfAa5668FmtkJtD0jWR
	52Tsrp6XYEwoye0vDyRMu59QTTY0vRswmc4gh39RfzNKFE1wNAzYGTqceEo+5PMPE9HOG6Rmi2FDb
	cnHlOGjt4bIVl2q0zktGvbaMaa23xkQ6NowEyM4hAfwCwkmVQKmLZjHI2aCiLdcRlHNbMzE+fSyY2
	2GuZubi/rI5V/00pfLG5tTPw1KKaVqsY80Xwt2nXzrfGOLa0hzz65m94BcSMn2CYDsCOm9uWggQpN
	+VG8DEGyVeAjAhO+ByRnhOJ8Dr6ypIwEDZHvHqKyTPLkBwWTUmLh3U9bC7/ZGt7aSdU7L7rdv2sk3
	UkJFxgww==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMWV6-0000000AJR2-1BaD;
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
Subject: [PATCH 3/4] powerpc/ps3: mm.c: clean up kernel-doc issues
Date: Thu, 29 Oct 2026 13:13:25 -0700
Message-ID: <20261029201326.2672284-4-rdunlap@infradead.org>
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

Use the correct format for struct members and function parameters.
Use the correct function names in kernel-doc comments.
Use the correct format for function descriptions.

This eliminates these kernel-doc warnings:

Warning: arch/powerpc/platforms/ps3/mm.c:102 struct member 'vas_id' not
 described in 'map'
Warning: arch/powerpc/platforms/ps3/mm.c:195 missing initial short
 description on line: * ps3_mm_vas_destroy -
Warning: arch/powerpc/platforms/ps3/mm.c:514 function parameter 'c_out'
 not described in 'dma_sb_map_pages'
Warning: arch/powerpc/platforms/ps3/mm.c:708 expecting prototype for
 dma_region_free(). Prototype was for dma_sb_region_free() instead
Warning: arch/powerpc/platforms/ps3/mm.c:1092 expecting prototype for
 dma_unmap_area_linear(). Prototype was for dma_sb_unmap_area_linear()
 instead

This leaves around 15 unrepaired kernel-doc warnings.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Geoff Levand <geoff@infradead.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org

 arch/powerpc/platforms/ps3/mm.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- linux-next-20260828.orig/arch/powerpc/platforms/ps3/mm.c
+++ linux-next-20260828/arch/powerpc/platforms/ps3/mm.c
@@ -79,7 +79,7 @@ struct mem_region {
 /**
  * struct map - address space state variables holder
  * @total: total memory available as reported by HV
- * @vas_id - HV virtual address space id
+ * @vas_id: HV virtual address space id
  * @htab_size: htab size in bytes
  *
  * The HV virtual address space (vas) allows for hotplug memory regions.
@@ -193,7 +193,7 @@ fail:
 }
 
 /**
- * ps3_mm_vas_destroy -
+ * ps3_mm_vas_destroy - destroy the virtual address space
  *
  * called during kexec sequence with MMU off.
  */
@@ -504,7 +504,7 @@ static int dma_ioc0_free_chunk(struct dm
  * @r: Pointer to a struct ps3_dma_region.
  * @phys_addr: Starting physical address of the area to map.
  * @len: Length in bytes of the area to map.
- * c_out: A pointer to receive an allocated struct dma_chunk for this area.
+ * @c_out: A pointer to receive an allocated struct dma_chunk for this area.
  *
  * This is the lowest level dma mapping routine, and is the one that will
  * make the HV call to add the pages into the io controller address space.
@@ -699,7 +699,7 @@ static int dma_ioc0_region_create(struct
 }
 
 /**
- * dma_region_free - Free a device dma region.
+ * dma_sb_region_free - Free a device dma region.
  * @r: Pointer to a struct ps3_dma_region.
  *
  * This is the lowest level dma region free routine, and is the one that
@@ -1081,7 +1081,7 @@ static int dma_sb_map_area_linear(struct
 }
 
 /**
- * dma_unmap_area_linear - Unmap an area of memory from a device dma region.
+ * dma_sb_unmap_area_linear - Unmap an area of memory from a device dma region.
  * @r: Pointer to a struct ps3_dma_region.
  * @bus_addr: The starting ioc bus address of the area to unmap.
  * @len: Length in bytes of the area to unmap.

