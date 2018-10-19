Return-Path: <SRS0=4s7t=M7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B81ECDE43
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 04:20:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A540B2145D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 04:20:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A540B2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42bt404j2QzF3XW
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 15:20:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42bswk0DGCzF3St
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Oct 2018 15:13:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 42bswj6lTrz9sCm; Fri, 19 Oct 2018 15:13:41 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 42bswj6R70z9sDJ; Fri, 19 Oct 2018 15:13:41 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/6] powerpc/mm/radix: Fix small page at boundary when
 splitting
Date: Fri, 19 Oct 2018 15:13:31 +1100
Message-Id: <20181019041334.4945-3-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181019041334.4945-1-mpe@ellerman.id.au>
References: <20181019041334.4945-1-mpe@ellerman.id.au>
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: aneesh.kumar@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

When we have CONFIG_STRICT_KERNEL_RWX enabled, we want to split the
linear mapping at the text/data boundary so we can map the kernel
text read only.

Currently we always use a small page at the text/data boundary, even
when that's not necessary:

  Mapped 0x0000000000000000-0x0000000000e00000 with 2.00 MiB pages
  Mapped 0x0000000000e00000-0x0000000001000000 with 64.0 KiB pages
  Mapped 0x0000000001000000-0x0000000040000000 with 2.00 MiB pages

This is because the check that the mapping crosses the __init_begin
boundary is too strict, it also returns true when we map exactly up to
the boundary.

So fix it to check that the mapping would actually map past
__init_begin, and with that we see:

  Mapped 0x0000000000000000-0x0000000040000000 with 2.00 MiB pages
  Mapped 0x0000000040000000-0x0000000100000000 with 1.00 GiB pages

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/mm/pgtable-radix.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index bb85c58b96c8..7a44ec276290 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -295,14 +295,14 @@ static int __meminit create_physical_mapping(unsigned long start,
 
 		if (split_text_mapping && (mapping_size == PUD_SIZE) &&
 			(addr < __pa_symbol(__init_begin)) &&
-			(addr + mapping_size) >= __pa_symbol(__init_begin)) {
+			(addr + mapping_size) > __pa_symbol(__init_begin)) {
 			max_mapping_size = PMD_SIZE;
 			goto retry;
 		}
 
 		if (split_text_mapping && (mapping_size == PMD_SIZE) &&
 		    (addr < __pa_symbol(__init_begin)) &&
-		    (addr + mapping_size) >= __pa_symbol(__init_begin)) {
+		    (addr + mapping_size) > __pa_symbol(__init_begin)) {
 			mapping_size = PAGE_SIZE;
 			psize = mmu_virtual_psize;
 		}
-- 
2.17.2

