Return-Path: <linuxppc-dev+bounces-26355-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B781C61DD6
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Sep 2026 06:34:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYx0K61Ygz2yCv;
	Tue, 01 Sep 2026 16:34:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788244449;
	cv=none; b=fTpf4Es4UzH3qfswmXXz8063WYG6R14SdTKH/VhnfnfK4g+zKnTZnBVlGyMkWN555hF/x8UireN8SIny3tQXHiwaJfFCuM/BDqoJovoPNdhF1rVDuoT6uMF8WUVDilEaFhXUslZpLz6uZjUJogcTDpjF80vTktYZ68ZWBrgoTgo87rFHD6wGv7CsI0Xz5pqiMJzVGQaUZCILLIA6r81FuBFTVKw3B+3J0/d03Pki1zjZowpntFf6XkV8uX7wG/dzWxIYmJD2iDTkZMkPu3QmEqvLbAjdppzNAA2VhLVGvp3ooqRM0Lv7JLPiE2hcNYWjTJ28m+5bBErMLLcL1DId4w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788244449; c=relaxed/relaxed;
	bh=j5wlQy9DCaktYGyQf5jBA58+1SExlqWK2qFF4AF0tHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eE0jL3o5zkBojfSWoLqGSTo5VRpQ8MKDpcRopRSFncRd+4uc5e4pzqnPoarPTBO4umXhOdUcp6+QtHkFjpqyCl+n0msJXuD3Zlfxj4POZyqw8iEXBNiVBtIfJPb3OqjhjuqpMJzvOWljMEqN6Rw52gkDwInlm0hmGaPm30DwaAMG39b3XBpifg+pyf8kMYcYNyQ1/BNZUvw05aEJiBRCRWv4dZ22+V5/JxW8ikYYqhteqqO87yrcqJg/h1o+Oky66CHWGWlGNq+rDOWinQ/EBhq6p6Zxz3Hx3nC/ztxByoI6MBM2rJ2MJPZGR6bG6xqhoJFuznWoH/+Fe6op6ml9OA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=qw/k8dT2; dkim-atps=neutral; spf=pass (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=qw/k8dT2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYx0C3KXvz2y2c
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Sep 2026 16:34:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=j5wlQy9DCaktYGyQf5jBA58+1SExlqWK2qFF4AF0tHE=; b=qw/k8dT2WCu2Q2i5MYxb6aIL62
	sKzPUd55TrAGjMvZCQVZsWPghnPaOb2qI+fY6Le6/UH048yVPLNGMFG4q8HVE8pTwOF0GfdaKBeky
	1eJ5KoC5DZAbJ4DfctwwNl0au+plyswCH1N3bOi+K74KtixzGRIYlquK8jRpp+H0Uif2aHOCpbZeD
	4Wc1JPS1nnD/f8Jy17oRD11O/nKTM8a4pv+hdAPrBosf3Y8FhX8LInbS9yZIao8NWjLluiHVjcS23
	aRsDNujkUFyAiw3BrYU2jnFaxLkHWvk8DtT4ewrrfl8qYIhKsXg2lFtS+Qu0i91FYfiixjESpnYbS
	OpCFl2jg==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1I4C-0000000B46j-27aT;
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
Subject: [PATCH 4/4] powerpc/ps3: os-area.c: fix some kernel-doc warnings
Date: Mon, 31 Aug 2026 23:33:54 -0700
Message-ID: <20260901063354.4012138-5-rdunlap@infradead.org>
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

