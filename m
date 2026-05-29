Return-Path: <linuxppc-dev+bounces-21736-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51D72CD6E4A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 May 2026 15:03:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRmmn56LQz3c2P;
	Sat, 30 May 2026 01:02:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::64a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780066953;
	cv=none; b=lXA1qf8N6SUgJA4q67V8Ir5yNQN7BdIY81Kofuzeoh/on0Zku6iL2tTIDotkDbyzJdk0udIqIRw3B9rn9ikuE+smeINzTk/oT1gw+bj5AJwE1AiaaAv6El1hbqdeVWbltZIBAM0JJZV4ITIyCToPi39ggcrPgJSGMTzE83q2ubLN4lSy5AMcV4bKKbhoQqPob6hHgdr/L70TNB+VUtyBNQKB+D2eqdRdxZrCQ3L0cx8M1Gx3sVJloRQQfSydyQ31Y+pOV7yZnp4IexRwWAhTbYuEL1kSrkYxIcGrXZ8OX2LcHc4TYC5cLyRiDmqYvuWkTG43LuK6fKFhZVhEvqINbA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780066953; c=relaxed/relaxed;
	bh=OI2PiSwVSqs1DMfWl+ZXR2POFOtjIsRCGzcVsnmPBAE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EBy4KcyM7J125vHgfHs4s9/wDO1qxPJJDcVnrUZihcBSI72Bq2E1bFhl9JVHNdiAYog45p4hOX9OnY1QEJVagzy3Sbtl64IHG67VjM/X1kp7WmfE+PBjAuOfPrzYj1gzeX9xeJr1pfEluPkk/XBhA0G98L8o2/rE5WxTQWw4l0xBI0r98RKpSc46hJUzEDr1tTEdX6U5LE2QMrVuozcrhg77Dma/Z1N9WVFT8j8xsRbD4aZEqbiA31xZFvIK/F4w8NOtgxZbkw+Pvvee/slQ1iyWFW1ChN7YOAjY6ayxIaKi4AIX1bNZJ2bgLhz8bKQO1BlVymneH95VnOCOtzLTKA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=aThqjoTd; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::64a; helo=mail-ej1-x64a.google.com; envelope-from=3haozaggkdjg2j53+8al8gg8d6.4gedafmphh4-56ndaklk.grd23k.gj8@flex--ardb.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=aThqjoTd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--ardb.bounces.google.com (client-ip=2a00:1450:4864:20::64a; helo=mail-ej1-x64a.google.com; envelope-from=3haozaggkdjg2j53+8al8gg8d6.4gedafmphh4-56ndaklk.grd23k.gj8@flex--ardb.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gRmmm4tY9z3bps
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 May 2026 01:02:32 +1000 (AEST)
Received: by mail-ej1-x64a.google.com with SMTP id a640c23a62f3a-bcea6a87383so1224288866b.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2026 08:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780066950; x=1780671750; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OI2PiSwVSqs1DMfWl+ZXR2POFOtjIsRCGzcVsnmPBAE=;
        b=aThqjoTdJF9TEwBDbaONrf8XXT1yO5Si3VkiW5Jv6uIDNb+vcA0Q/Lbalz0CToZPAO
         gCWTkkSua15PaFAOvyLZXtoiBOG+M06OqYySinoBAZN3c9YoOLyu/lm6guTuRW6HqDwk
         S00Fanx1nVBe51k8DyfjH/ReI51mqIA8BPdHaVSp4SOkn4X3W/7BW2A+DsEsUO73E2hZ
         P+fILzdco6UPmeWprIUIrw70yBpVVJ9KzIci/ks+Fayu5mfrDlHfODGEZiQq2/SFhWuB
         BA7i73X/PjcjkoPCeUWsyR4MbRQwpchF1IEE4QWGJtHRs2ShTcNJJv3VrYtiyl7u+NUp
         hqFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780066950; x=1780671750;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OI2PiSwVSqs1DMfWl+ZXR2POFOtjIsRCGzcVsnmPBAE=;
        b=eyahjtdOoUaRC7C0964vnQslmiZ0sKLmVCeD3Vt7isqqZ/0kmRJZrIVS51VY58SqRV
         YAtX3qb3QbArnkmMZHgrneOgDND040SaMbuH6GNTNJx0r8kRQUFSW5WbcWDE2Yn5H49b
         s7X5b2DFOxulHDdcYslhl5YrOhfmH14BE0uadbRwPNJ+KWy7YAPbKNrEl0AvCpw/0My/
         h+XQNjGOtNZDw8wpBDnGNLSfkN1LhvldRrg16NGIxyp/EDFq49C+TMepVPA1EfVAMyzc
         PHBReJBAkCsfLSmAivwX2DANoFrVOD/6WrzK9Y+7Me0tIMCm276LwHvPAzhtj4xb/FjN
         CAzg==
X-Forwarded-Encrypted: i=1; AFNElJ9kpxLG1fORDrFxyduU5Di9e9Dg3t7uyCy0n0Xl52RSPt7TE/GciqqtbejI578udVy2eZ5ojBCAE1nMQW0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwL2mqXvU2hAOlb89Xn973BlU3QQfsw4EcjrOCufH2ZmnqWfLS3
	Yb7XrOEQnxMic8Ynzyn/Oetv7+xGYR1mX8kr9LewakrVG42ie+KH2f1yeEx9rKiqSygqcbRjpg=
	=
X-Received: from wrmg9.prod.google.com ([2002:adf:e409:0:b0:45e:f392:2777])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:a07:b0:bd5:2e64:aef0
 with SMTP id a640c23a62f3a-be9cbdc6f6fmr179513966b.24.1780066949175; Fri, 29
 May 2026 08:02:29 -0700 (PDT)
Date: Fri, 29 May 2026 17:02:01 +0200
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2652; i=ardb@kernel.org;
 h=from:subject; bh=LBsPwtXISC3cDlPuViRIHN1SKeCiNO3w0g/LYP90bWk=;
 b=kA0DAAoWMG4JVi59LVwByyZiAGoZqmug957hRslXLEFSHUmrg+wMpqdQu/ZaCQ6ZVNlpR/e6R
 Yh1BAAWCgAdFiEEEJv97rnLkRp9Q5odMG4JVi59LVwFAmoZqmsACgkQMG4JVi59LVw9CgD+Kz5r
 yC92Fjmy2/vY5E6VGL4/Nm1StvBfLlgn5WtMnkABAJz+h8RdmiKW2M9JyTSGnfE2SIklxmyurX5 hqMMXobkC
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529150150.1670604-27-ardb+git@google.com>
Subject: [PATCH v7 10/15] arm64: mm: Don't abuse memblock NOMAP to check for overlaps
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

Now that the linear region mapping routines respect existing table
mappings and contiguous block and page mappings, it is no longer needed
to fiddle with the memblock tables to set and clear the NOMAP attribute
in order to omit text and rodata when creating the linear map.

Instead, map the kernel text and rodata alias first with the desired
initial attributes and granularity, so that the loop iterating over the
memblocks will not remap it in a manner that prevents it from being
remapped with updated attributes later.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/mm/mmu.c | 26 ++++++++------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 971996e46fd1..dcfca5667e5c 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1164,12 +1164,17 @@ static void __init map_mem(void)
 		flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
 
 	/*
-	 * Take care not to create a writable alias for the
-	 * read-only text and rodata sections of the kernel image.
-	 * So temporarily mark them as NOMAP to skip mappings in
-	 * the following for-loop
+	 * Map the linear alias of the [_text, __init_begin) interval first
+	 * so that its write permissions can be removed later without the need
+	 * to split any block mappings created by the loop below.
+	 *
+	 * Write permissions are needed for alternatives patching, and will be
+	 * removed later by mark_linear_text_alias_ro() above. This makes the
+	 * contents of the region accessible to subsystems such as hibernate,
+	 * but protects it from inadvertent modification or execution.
 	 */
-	memblock_mark_nomap(kernel_start, kernel_end - kernel_start);
+	__map_memblock(kernel_start, kernel_end, pgprot_tagged(PAGE_KERNEL),
+		       flags);
 
 	/* map all the memory banks */
 	for_each_mem_range(i, &start, &end) {
@@ -1181,17 +1186,6 @@ static void __init map_mem(void)
 		__map_memblock(start, end, pgprot_tagged(PAGE_KERNEL),
 			       flags);
 	}
-
-	/*
-	 * Map the linear alias of the [_text, __init_begin) interval
-	 * as non-executable now, and remove the write permission in
-	 * mark_linear_text_alias_ro() below (which will be called after
-	 * alternative patching has completed). This makes the contents
-	 * of the region accessible to subsystems such as hibernate,
-	 * but protects it from inadvertent modification or execution.
-	 */
-	__map_memblock(kernel_start, kernel_end, PAGE_KERNEL, 0);
-	memblock_clear_nomap(kernel_start, kernel_end - kernel_start);
 }
 
 void mark_rodata_ro(void)
-- 
2.54.0.823.g6e5bcc1fc9-goog


