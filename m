Return-Path: <linuxppc-dev+bounces-21535-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30575CD5BD0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 May 2026 22:43:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gQ77d6PlKz2yZZ;
	Wed, 27 May 2026 08:43:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::44a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779818370;
	cv=none; b=OMEf1revtfsA4hUFQBjq7uvCojIcJu/UIECEX8ok3RBvC/27UsUfx+6T4SdNO8LE3XMI36FclaBn6wpjmYcHZLOsbvLcYZvZ47pKXGdzX4lv85aeJ6Ka5rx13E2E2cQ2Cu6awIF4PWZ/5+v/F4DYjRkutit3jL6UBPbJVl+qyNRVdTD+Jx/qU93YoUVPWpckHqmhGwnFKkw/TyukIDB7lt5ji+bkce9CFqzf+g8itW7zo5oPOTwlaYwJI7r3QIh6iOzDr/j+FTijNiADHAIXyV6e2kVmF/qdPz5FO/ICTxvg8bbunEn2GEERBjBaQLbtwn+t/gILw2AfAe16XURV8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779818370; c=relaxed/relaxed;
	bh=3mHEuoeqgeJwwKsR5vVxh3j7NIc/RKdm0H7T5NxNZG0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mCa5K7B9SA82ZEIY0ZCjfrceA5qfMqFMI4DqwhLBKB32wHI4akdP/AD/7vOkHnQo5lnUMbvLNmOuhQB2QEMk4wQRNG4Lb9QqvcL007dt4zOiNCDPaYgGsf5CccPFC/ZC/r79TRRf1p5tDeYmE0xxpo3IelgeR9qSaayQ5ivewBYpuOwrwZgZc2K9oyBXIEVt9Yv/Zmf2gQkUJwBgjrXz9h8FL6mS8niEwgUnPSbsZFy5nrDSVFzspRgWI84Cpgui7mOkWCmRw2PrEDmzQjVF0AoDd5emNWL3/E/Gwvg1R44kj5So9HlpB6hLyWos+29PDidKpoFjfW7S56Wi0sfAkA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=g1VkHoo9; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::44a; helo=mail-wr1-x44a.google.com; envelope-from=3fd8vaggkdoomdpn+sufsaasxq.oayxuzgjbbo-pqhxuefe.alxmne.ads@flex--ardb.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=g1VkHoo9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--ardb.bounces.google.com (client-ip=2a00:1450:4864:20::44a; helo=mail-wr1-x44a.google.com; envelope-from=3fd8vaggkdoomdpn+sufsaasxq.oayxuzgjbbo-pqhxuefe.alxmne.ads@flex--ardb.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gQ0rK06Dqz2xtC
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2026 03:59:28 +1000 (AEST)
Received: by mail-wr1-x44a.google.com with SMTP id ffacd0b85a97d-43d789cebcfso7466280f8f.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2026 10:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779818365; x=1780423165; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3mHEuoeqgeJwwKsR5vVxh3j7NIc/RKdm0H7T5NxNZG0=;
        b=g1VkHoo9OkUNxjHTNXDxtMhqQuqGcQg7nieKdkxZNqB/t8H1QCKy0klE7/azD+TaDa
         oAMg34MAg2Isq98b1hgdlJR16YYREaG+ulgytiW8GiDhuRe0L8mFoOYS5bfqCb+sCSP9
         yALi1KrJXYyYXE9z7yyMHlSP8OzmCpNXqf30TLQ0p85DFdzqDhlmFhk/J0fl+wsOWXbI
         aLtYBoXOtrgRsbvcSUXGAIjORpKRRGtOY13FXrjlRDO00yBrV1Hixp2x+KfUXRUMQku+
         RbNcwzny9wydTRhODXXivdy8CU4IsPcB8G1CiwqS9eww6hPCJfq//dji7ai++Day7zN1
         5tOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779818365; x=1780423165;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3mHEuoeqgeJwwKsR5vVxh3j7NIc/RKdm0H7T5NxNZG0=;
        b=ME2aiY3ekNc4WoUYb2osJZEKcx+bH2inZcAmvSTaVFJ6DJIyPmfzZqDlblx72jvRhq
         HNUNUS7YZr2tQRBmsZvj5h8JOUhzF8myhHd6gEeGiJc2ZyXs5H94/ZDptiTojwBoWXoz
         n1vWIhldO0gdOCsvpEHndinmQ8euu1iVxjbbgPyxS87EFevpg19oh0ZJt6rGxQRHPwmP
         ULJTmtwdP4Ische8/6xjJmwOL9J2ahSrTo7PpRcReiih0QXJ2e3cZ67xPBcD54UuT+Sg
         iQSyYlhzctKV4o4J6Co9Qa2l6pwPaSBFEsXaaR6fy4F2uarc3J7LEYe1ONOnAT3WS4He
         7jrQ==
X-Forwarded-Encrypted: i=1; AFNElJ/N/2wybCiLeZuJALCKKRteEARQSthOr73p7MQm48og6WOkdSoisOI/eMmgSwvy1E5dcFFfrKq4iyaXRSM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxJyAWZhkXgP5RpfnEw6xkE9PGoxuCYG3susf8y6KmZYUkSpPdp
	M0qRCX/wgR8VyJlt5c8oonnY+zQJwQSOJuH8aovZslki08Z0/dckoQF+necGaTPpuclAhV/3VQ=
	=
X-Received: from wmbh6.prod.google.com ([2002:a05:600c:a106:b0:48f:de29:3f52])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:a402:b0:48f:e230:29f5
 with SMTP id 5b1f17b1804b1-490426b0c92mr233953415e9.16.1779818365325; Tue, 26
 May 2026 10:59:25 -0700 (PDT)
Date: Tue, 26 May 2026 19:58:51 +0200
In-Reply-To: <20260526175846.2694125-17-ardb+git@google.com>
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
References: <20260526175846.2694125-17-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1360; i=ardb@kernel.org;
 h=from:subject; bh=HTVCAgvGTLScrJ2CZV4D8VSId3uhva+Scq8FVpoE17Y=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIUv0fgzPcSP+Z1uPSc089cXOMuHXyr/rHy2TE5mx/o6dx
 X9ece7OjlIWBjEuBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjARxViG/1GnxVK2TMh4vX6H
 yFPbSV03ey81Ml2OaYnZZ/vlkGzNih2MDIuvZ3AHycz03hNo9ypyg7OB0C2/DLkSk46sXolZjBl hfAA=
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260526175846.2694125-21-ardb+git@google.com>
Subject: [PATCH v6 04/15] arm64: mm: Preserve existing table mappings when
 mapping DRAM
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com, 
	mark.rutland@arm.com, Ard Biesheuvel <ardb@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Liz Prucka <lizprucka@google.com>, 
	Seth Jenkins <sethjenkins@google.com>, Kees Cook <kees@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@kernel.org>, 
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
2.54.0.794.g4f17f83d09-goog


