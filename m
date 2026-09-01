Return-Path: <linuxppc-dev+bounces-26356-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0FC0C61DE4
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Sep 2026 06:34:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYx0K73gXz2yDD;
	Tue, 01 Sep 2026 16:34:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788244449;
	cv=none; b=R9cz10OvRGTNhUrnYaiPHBbE9NI8l+EBLv+oDT0qhdv0pFgkBNZtBLjwhikBLBu2MqXOeNskF4GXD7opXYy90CMrmSbp3iruNHaI3VFonejqnUlQ1ii+1FGTMv/LlXNlT+L8lqnmDhNFipLy1vPqCqQp7blWe9ZmBpp0Eoa9sI/r51svmnlvj5yRjNTCjj1AajDXHIdfNMXi4/TEtjU991H5vL0JbYG0w3qKvOCbsAD2ibVwWMSo1BAeaMuSmOquy7zsMVa4dnMhPuwCyeDJiOAUfHi3FYqlibxEF06lTy77itxZwj5Ur+WSG3uyEZNYTSYwvkUiMkYTu/tnrcnIOA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788244449; c=relaxed/relaxed;
	bh=Er0GRhCzdVU5yeaX5s1ElRVbYAULyDK/JtS7EUoH5DA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fq0EbctHv9YZ1/cHQO7FsmtYa5tsZNosz/MmO46u+i5X51UjeGqh6sbELegqV1XBVMP8P2slodm1K438zRxFVEpQEyFXbKhn16muOdtNTM577fCNImBuexeYvHcdtBkI8kq1P85kxrLLjnUlLpjEXFjK0W0KopHsKamatTb2luY7A2OPMk0Ia8Vu+v89QSCVHDWTPsPTn7eU7VIxO6cPPSKmePSUDdab5JgmTvdnOJtPBkIXvd0irSnK4T+6Z+3onz2AMWmxtct3XtiRTvAtSbup1WBjmZNgiS1EeDNp8HUQZPfOvQ20klhFkKmPi65PPoBraR6af+zNHH5Yz5WxSg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=NtGiVFwC; dkim-atps=neutral; spf=pass (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=NtGiVFwC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYx0C0fThz2y2P
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Sep 2026 16:34:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Er0GRhCzdVU5yeaX5s1ElRVbYAULyDK/JtS7EUoH5DA=; b=NtGiVFwCiayfmXPuPDsb8GhQyq
	V7wW1OWlpbgqmJNsvjxJEHcHjfPfyXnJPi5RQf6RQ98iIK8oJWkEXocIxtIs6LQKiVvr5oUreeAwi
	NLZIwv1fauKhCaykoXyKYWGZAS4PsRrkmIEQ1+W9wggaeqaNWpro72e12GvoQ8tNzhGdJH7s2iv43
	IHoY3M9oUE5wKTVQWvih76QJ/lMngpF3W1TTF0P4VZVzmwDAcsCURPVCL7WyP/FnCdDc+YZyySEN9
	l4L5MH/xnrafYjs/h06CT4gUHsaSP73o6OSeNsLKPHyYVARoDJj3Y4YqwtrY3ewR2hC4kcrSbIBiT
	bk1GZaxA==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1I4C-0000000B46j-0x7Q;
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
Subject: [PATCH 3/4] powerpc/ps3: mm.c: clean up kernel-doc issues
Date: Mon, 31 Aug 2026 23:33:53 -0700
Message-ID: <20260901063354.4012138-4-rdunlap@infradead.org>
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

