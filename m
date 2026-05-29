Return-Path: <linuxppc-dev+bounces-21730-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6809CD6E54
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 May 2026 15:02:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRmmg56YVz3bsP;
	Sat, 30 May 2026 01:02:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::449"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780066947;
	cv=none; b=CXEnNFNEvbi7zpoXfwxqlic6urvBXPsq0uoI8Xilh2lRQrOpIvJQlsn4eL8C/n5qOMKvtrCYXcF4Sydl4o5aof5ZDK2dysjnl+eoxJrkrGBjP10uAxCKrdL7EKwINftD9gihZrFz/fdazCr0ZHDdnwk2+1TlC2j7kddZG9QlcJGxGRfVKMjc3RPSt/6qBo1dsq1T6gvr9PCBJJSVGVXEdLrysWCZ0/x1U9K/uSJ6iPagIUqWMsLFPWa/7hTOzTCPDH1uGzZahX66vomWcFaH2jOQFAjzu+fd8uBhdVtoo3RMyGSCj30GMbR1EBCAZt2CtMommS27wgsee7AbgNySUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780066947; c=relaxed/relaxed;
	bh=9SMbp+4SpJBPuSW3tE55txpooI4fjODhC3THY1otv5g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=R8ONhH+w3hUkpme3NicuW7NvG5O0g6SBoUu7iMxECtgOAwo4aRi6FYlwXa202FIorzx76GDmjjkPLtPSKsXar2eMeXHXXhQ4fu1VDyTWPGmlaq/yp2xBL0pgf0nrlIzS8bcTFOo4bRodZsifqDaW0SzBDRzKzkHHMEgTwW2UIkxTADzRbDRztE98np/B8rQcpA9Hw0yUE4S68IT8usa0F4R4spaXI0vJWkXvZcnW1vGY0P5CPYALliI6rQ7zeW/E582sGwH94WnJYzDYb6voBEZJ4LKTs73Xf1HwJBo3UibwDPKpTEIuYopVKUIWnYLuXRyV7Xsya5cCdSO42V2w8A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Pa/wcl9o; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::449; helo=mail-wr1-x449.google.com; envelope-from=3fqozaggkdjevcyw+13e19916z.x97638fiaax-yzg63ded.9k6vwd.9c1@flex--ardb.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Pa/wcl9o;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--ardb.bounces.google.com (client-ip=2a00:1450:4864:20::449; helo=mail-wr1-x449.google.com; envelope-from=3fqozaggkdjevcyw+13e19916z.x97638fiaax-yzg63ded.9k6vwd.9c1@flex--ardb.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gRmmf0JhYz3bps
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 May 2026 01:02:25 +1000 (AEST)
Received: by mail-wr1-x449.google.com with SMTP id ffacd0b85a97d-45eeee26201so666429f8f.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2026 08:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780066942; x=1780671742; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9SMbp+4SpJBPuSW3tE55txpooI4fjODhC3THY1otv5g=;
        b=Pa/wcl9o1wGAvt2GIqB4zrpZyXwrOADRo2WUM7BxNjjp0NuYZs7VcpvWtY4ICPmMMd
         6yn/9igPm85PF0Qbf8pRLhGHRMpJk824hPA4pZKmfQSa4aI3uGmYk9N6fm1S45Godu7B
         qJ0NVTAqpNw55abaGiIZB5oly9gOhyOUGYWbd1Rgj+kXCjbxpt4WlbPJ+W6ElQA0Lp6q
         G2FDw4q4ACm0XRaZHmi8UpmJ+7orFUKUUBHI5ZkAIksZlHcDK7me96K3wKDY6UvOvMcc
         QHJRO1Kvq1jR6f5d5yFQoaJ8tCpjzE8UzDqsEPiNrmVDM64mAKRyTvDLqx5L6mSp509J
         1ybA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780066942; x=1780671742;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9SMbp+4SpJBPuSW3tE55txpooI4fjODhC3THY1otv5g=;
        b=m9CYGEWCJLCcN1tRm/2ZVGJ4OrLITNGYbLYG8b46/LdbxvU3B+GO/+GRMBiSQrC8iA
         12Hwzyv5Od5nRyco5K/Uux7JRjZRx9j8FOJj+3IqUbkViQDsAi1+cIbBUqiueuqP/mvA
         SAo1GGiJvb0JMitqSnW0Cf+yCWR8r29Sj5Pr4nTJir1k24lIRilHwmGugy1lST57YyVO
         V89S16KgLWIOuvohJ+W4/vzrN0EbHkPHXjuaxb7+F0ySG+wfjBphUJkh4HY4hu7CbNCt
         5tqhQzr5H/cpdjzgSOWGci4NhlYFp+Gw3A9ddfWz0p3QzHUYMPY74zwrqrGW6/1o9LzK
         duUw==
X-Forwarded-Encrypted: i=1; AFNElJ8UEdXqr4k82HyzkLcLDvMGnwbZjZ9Xft4qRE5BB6rowdVAaiVILTo7CfsMIWYgruRZF47JhYCFRAH+GuY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy81DImLTYwBXCpPJiwdMgroFqfYY2tJtJbVn3fyp+YhW++DxVj
	+a6A6r15yadxE2cUzo3Abw8pIcZ47Gd1vvdQspXGSUGQd4D0wTaAJBHOfFM0x4D2llxP3lv1ew=
	=
X-Received: from wrna16.prod.google.com ([2002:adf:e5d0:0:b0:43f:df99:cb43])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:b05:b0:45e:e3ea:1101
 with SMTP id ffacd0b85a97d-45ef6b3a9d3mr250438f8f.17.1780066942102; Fri, 29
 May 2026 08:02:22 -0700 (PDT)
Date: Fri, 29 May 2026 17:01:55 +0200
In-Reply-To: <20260529150150.1670604-17-ardb+git@google.com>
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
Mime-Version: 1.0
References: <20260529150150.1670604-17-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1360; i=ardb@kernel.org;
 h=from:subject; bh=zgVblspip5ZINNAWS3J63kCjniwJXU0OYP5r0DXGxEI=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIUtyVfJJkczPYfGm/hd8+FL02y7q1vnc3l5lLz2B/bWeR
 ZyU8q+OUhYGMS4GWTFFFoHZf9/tPD1RqtZ5lizMHFYmkCEMXJwCMJGrFxn+e55rMk6KmS+o8qjx
 TFPydss+tp/hHKtbs3vkHc/PO8RoyvA/WrE+UfB50QXpS/Hr3nSqW/oxK2XsCGS8dSmZxXNHTQs /AA==
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529150150.1670604-21-ardb+git@google.com>
Subject: [PATCH v7 04/15] arm64: mm: Preserve existing table mappings when
 mapping DRAM
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com, 
	mark.rutland@arm.com, Ard Biesheuvel <ardb@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, 
	Liz Prucka <lizprucka@google.com>, Seth Jenkins <sethjenkins@google.com>, 
	Kees Cook <kees@kernel.org>, Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sh@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Instead of blindly overwriting an existing table entry when mapping DRAM
regions, take care not to replace a pre-existing table entry with a
block entry. This permits the logic of mapping the kernel's linear alias
to be simplified in a subsequent patch.

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/mm/mmu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index b2ba5b35c35f..5c827fa3cd38 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -256,7 +256,8 @@ static int init_pmd(pmd_t *pmdp, unsigned long addr, unsigned long end,
 
 		/* try section mapping first */
 		if (((addr | next | phys) & ~PMD_MASK) == 0 &&
-		    (flags & NO_BLOCK_MAPPINGS) == 0) {
+		    (flags & NO_BLOCK_MAPPINGS) == 0 &&
+		    !pmd_table(old_pmd)) {
 			WARN_ON(!pmd_set_huge(pmdp, phys, prot));
 
 			/*
@@ -379,7 +380,8 @@ static int alloc_init_pud(p4d_t *p4dp, unsigned long addr, unsigned long end,
 		 */
 		if (pud_sect_supported() &&
 		   ((addr | next | phys) & ~PUD_MASK) == 0 &&
-		    (flags & NO_BLOCK_MAPPINGS) == 0) {
+		    (flags & NO_BLOCK_MAPPINGS) == 0 &&
+		    !pud_table(old_pud)) {
 			WARN_ON(!pud_set_huge(pudp, phys, prot));
 
 			/*
-- 
2.54.0.823.g6e5bcc1fc9-goog


