Return-Path: <linuxppc-dev+bounces-23388-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6680C43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Jul 2026 12:06:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4grbG125wjz2yR5;
	Thu, 02 Jul 2026 22:06:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=91.218.175.182
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782993993;
	cv=none; b=l9sR4Jw7jeg90HyVRo8GvTDtnZ1m/fjv4y+eaPWcQPvEYw+JjmQHN2PXKvEA7jN8PLpgzxSIh/nKSe2iOpjnxpcWnHy9D69sfFjem+oq8cQdF1MdP2qVreJeZCl6gXp+FN1aVeYhwMCyqfj8egjV5eQ7ufj/buScHusnll5QjB8DChezk6KRiMHpBoLIeghZ5Ha3iAZ4iLbKByslgJ9pdz6C7k5fTh1GVQrK1ZbgtU6PVWfdKWzQDlqqW0cgeHVTUHTIt46LzIxDR+8i/KAXyA9dzdGZPr/L3fXL51Ctrt6euyHkxUA55XSdHggLGIMpYn0jfGGhKrJp/Xs6jg5u7g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782993993; c=relaxed/relaxed;
	bh=ot8Pbi2ksMCb71ohLRuXFssEPjkwMgegS5vpVomHt3o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aGbjEKF2MMOCYIbJ+vnelGuACnukwBn0ge8Oi8nmCM4HBIGFer7raumHFFr+9t2w0jwXXxRLeIA8h3Gttvf0SxziJrW/yIoTwHMu9N++8srsQM4IUDCyspc8PoRp1jcgUnUSRzhAm0fXvhOvZurHSgvvCzwifkbSNY4nuqBStj1JQjjMYYKgH9uctoL23k9+I3Aejmm1vRUadentr9zjLfqkWwawkrCZVUa8Xo5VCXneGpHM7O63rlH5aHoQWWloQUlrnAW8SUkM/Am4rRusNOVgUpGTSFxlpMRG1675KDykzk5Ap8St2SjekmJTDp8H7TVUvZq+NEKvtBRZMxWv5g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=DLkLz76Q; dkim-atps=neutral; spf=pass (client-ip=91.218.175.182; helo=out-182.mta0.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=DLkLz76Q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=91.218.175.182; helo=out-182.mta0.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org)
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4grbFy578Hz2yQG
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Jul 2026 22:06:30 +1000 (AEST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782993970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ot8Pbi2ksMCb71ohLRuXFssEPjkwMgegS5vpVomHt3o=;
	b=DLkLz76Qy07SpkjgRlbk1XaeIGakKBaKar/d744vhL1M11MSRoNs+e6pFM8xMn9zFtWVdB
	PRU49ACRUjA28JcsX8rOKJFgUaWDJ8yIsWUXEAxhNxykVp/NyRa9eQEs3hXDK/bXhaKh0L
	6ZeP6QkAAViQ/7rHWF5Wb5s7qyzOYQk=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Jiri Bohac <jbohac@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Diana Craciun <diana.craciun@nxp.com>,
	Jason Yan <yanaijie@huawei.com>,
	Scott Wood <oss@buserror.net>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	stable@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] powerpc/kaslr_booke: Fix reserved region overlap checks
Date: Thu,  2 Jul 2026 14:05:50 +0200
Message-ID: <20260702120551.3046-3-thorsten.blum@linux.dev>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2273; i=thorsten.blum@linux.dev; h=from:subject; bh=wL6EI+19wHEEY+WMTOkkSKEWQTxQHKe051Ieglp4iaI=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFluIfIbpxwsLWjZ+Hfl5JmbThsJJulfuz7zjVTrXaWZt /bPDzjG11HKwiDGxSArpsjyYNaPGb6lNZWbTCJ2wsxhZQIZwsDFKQATmbSYkeHj9oAEvc5lkyzE 47wXfbv4zqZrm7SauY1F9cFHzdvmPzNg+F/xPUWXL0uird1pYuyuo7VP3zgrBd/XL+9/4drA7WU twwsA
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

FDT reserved region addresses can be 64-bit, but regions_overlap() takes
32-bit arguments, which could truncate values before comparing them and
cause KASLR to incorrectly detect or miss overlaps. Make
regions_overlap() work with 64-bit values instead.

Also clamp reservation sizes before computing their end addresses to
prevent the addition from overflowing.

Fixes: 6a38ea1d7b94 ("powerpc/fsl_booke/32: randomize the kernel image offset")
Cc: stable@vger.kernel.org
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/powerpc/mm/nohash/kaslr_booke.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/mm/nohash/kaslr_booke.c b/arch/powerpc/mm/nohash/kaslr_booke.c
index 5e4897daaaea..3e5e67c76bda 100644
--- a/arch/powerpc/mm/nohash/kaslr_booke.c
+++ b/arch/powerpc/mm/nohash/kaslr_booke.c
@@ -91,7 +91,7 @@ static __init u64 get_kaslr_seed(void *fdt)
 	return ret;
 }
 
-static __init bool regions_overlap(u32 s1, u32 e1, u32 s2, u32 e2)
+static __init bool regions_overlap(u64 s1, u64 e1, u64 s2, u64 e2)
 {
 	return e1 >= s2 && e2 >= s1;
 }
@@ -100,13 +100,15 @@ static __init bool overlaps_reserved_region(const void *fdt, u32 start,
 					    u32 end)
 {
 	int subnode, len, i;
-	u64 base, size;
+	u64 base, size, rsv_end;
 
 	/* check for overlap with /memreserve/ entries */
 	for (i = 0; i < fdt_num_mem_rsv(fdt); i++) {
 		if (fdt_get_mem_rsv(fdt, i, &base, &size) < 0)
 			continue;
-		if (regions_overlap(start, end, base, base + size))
+
+		rsv_end = base + min(size, U64_MAX - base);
+		if (regions_overlap(start, end, base, rsv_end))
 			return true;
 	}
 
@@ -118,7 +120,6 @@ static __init bool overlaps_reserved_region(const void *fdt, u32 start,
 	     subnode >= 0;
 	     subnode = fdt_next_subnode(fdt, subnode)) {
 		const fdt32_t *reg;
-		u64 rsv_end;
 
 		len = 0;
 		reg = fdt_getprop(fdt, subnode, "reg", &len);
@@ -141,8 +142,7 @@ static __init bool overlaps_reserved_region(const void *fdt, u32 start,
 			if (base >= regions.pa_end)
 				continue;
 
-			rsv_end = min(base + size, (u64)U32_MAX);
-
+			rsv_end = base + min(size, U64_MAX - base);
 			if (regions_overlap(start, end, base, rsv_end))
 				return true;
 		}

