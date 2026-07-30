Return-Path: <linuxppc-dev+bounces-25110-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D9C7C55165
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2026 13:03:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9qBg71XBz2yYd;
	Thu, 30 Jul 2026 23:03:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.180
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785416603;
	cv=none; b=SHKEejdzTzj9J7KwVjpygCXPKIsXdOiXcFmmuBZNkNCnKAo8WhoJru4j9h3sx2ZIzXr/SGCVXyjsgBq4DUAbrhRjtENInwh8RE4KSPb5054NErHE8vN14mEpOvnDSti4aNr+IdV1sXCTqiXI1QiCxiLCHy0lqrfq/zilmpzA7+o2zNoXfsTCnvptMBiRYdVbkCzNLaEx7woaDI+VwqwuLb+LKQ6lkl4tBzq9079BzhKwCMspTDaKBtMcvS6OAWOfXjj0z8Wmq7VKTU7Cn7VEJkUc6kWFyp4cQxuhEbakrFVdqu/YtE8wsOrSecf5jPRRYGKnqQ+P0dtZlTgBwK/idA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785416603; c=relaxed/relaxed;
	bh=dw9urfr1YSTyHqzxKfth9ryU6HxR+cmSffIEWqq5hyI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RTyopK/Ej7EEHeVSR1A5wZ0+7g3m/U76/NYXNUDpLKrS3VUYiSB3tyum+e2Iz6hD1T+mB/XoedkI8jxgmoOiqgZlw6w0RGgYYBMjhLIQg5ZFXlxsmrbiOvdBo2N9WlxprdTdNT+KjcbfFd4NxYrBB5XSQILvO8B976hIksBN0F2TiFW1OwkJTm7KSDlCTI0pWYtNSD+Ar67CXrT8tFhXJm1k4edmr5eMZ7bXrnkoV6C6DOBr0XXX8klTs9Lfl6jDiGodBaTLSjHi8u7VObuELASUHwouHb6zHTZU6NUaI02NAAmpA79w0UgQsRcyr4i7AzeDFXoKsURUX4jUe7yelA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=bzn++hGX; dkim-atps=neutral; spf=pass (client-ip=95.215.58.180; helo=out-180.mta1.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=bzn++hGX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.180; helo=out-180.mta1.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org)
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9qBg291pz2yDs
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 23:03:23 +1000 (AEST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785416582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dw9urfr1YSTyHqzxKfth9ryU6HxR+cmSffIEWqq5hyI=;
	b=bzn++hGXQ6Hf/7+mdXm1csZNZrvuBtP75eBbJWIXxR9iAt5xYddO1hLFPUBB3zdN4AKv6u
	7DRrwnABlwj8g1felD5sSo73/ttlD4hzoCkhiSTBTzzXjUN9M40XlezrpnT/KkQbuwhNK6
	wlfVM59gNUgd+ZHvyv0b8ETn+nOslhc=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Aditya Gupta <adityag@linux.ibm.com>,
	Hari Bathini <hbathini@linux.ibm.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] powerpc/kexec: Annotate umem_info members with __counted_by_ptr
Date: Thu, 30 Jul 2026 15:02:48 +0200
Message-ID: <20260730130248.597249-2-thorsten.blum@linux.dev>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2355; i=thorsten.blum@linux.dev; h=from:subject; bh=MSpHvAE60fRFfd3RO2phyZRoGoJZJYyVPtinNvJ5nas=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFnZ3hXn1/Z4a07NCL/aa1K1Q0nlT9N0s5tnN3H4RYrpz rPos5zcUcrCIMbFICumyPJg1o8ZvqU1lZtMInbCzGFlAhnCwMUpABNJqGRk+CcbdP6K8c7wZcqf /dJD0q1nKqReqn8pU+pWaLeo+hC3HiPD3O7ugzU38p1f53VzeXz/LSFwLGWD3EcOv+thjk++Jvp yAwA=
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add __counted_by_ptr() to umem_info::buf and umem_info::ranges to
improve access bounds checking via CONFIG_UBSAN_BOUNDS and
CONFIG_FORTIFY_SOURCE.

Set the count fields before assigning the corresponding pointers, return
early on krealloc() failure, and use sizeof(*buf) when deriving
max_entries from the allocation size.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/powerpc/kexec/file_load_64.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
index 8c72e12ea44e..6424b668f0e9 100644
--- a/arch/powerpc/kexec/file_load_64.c
+++ b/arch/powerpc/kexec/file_load_64.c
@@ -34,14 +34,15 @@
 #include <asm/cputhreads.h>
 
 struct umem_info {
-	__be64 *buf;		/* data buffer for usable-memory property */
+	/* data buffer for usable-memory property */
+	__be64 *buf __counted_by_ptr(max_entries);
 	u32 size;		/* size allocated for the data buffer */
 	u32 max_entries;	/* maximum no. of entries */
 	u32 idx;		/* index of current entry */
 
 	/* usable memory ranges to look up */
 	unsigned int nr_ranges;
-	const struct range *ranges;
+	const struct range *ranges __counted_by_ptr(nr_ranges);
 };
 
 const struct kexec_file_ops * const kexec_file_loaders[] = {
@@ -83,11 +84,12 @@ static __be64 *check_realloc_usable_mem(struct umem_info *um_info, int cnt)
 
 	new_size = um_info->size + MEM_RANGE_CHUNK_SZ;
 	tbuf = krealloc(um_info->buf, new_size, GFP_KERNEL);
-	if (tbuf) {
-		um_info->buf = tbuf;
-		um_info->size = new_size;
-		um_info->max_entries = (um_info->size / sizeof(u64));
-	}
+	if (!tbuf)
+		return NULL;
+
+	um_info->size = new_size;
+	um_info->max_entries = um_info->size / sizeof(*um_info->buf);
+	um_info->buf = tbuf;
 
 	return tbuf;
 }
@@ -288,13 +290,13 @@ static int update_usable_mem_fdt(void *fdt, struct crash_mem *usable_mem)
 		return -EINVAL;
 	}
 
-	um_info.buf  = NULL;
 	um_info.size = 0;
 	um_info.max_entries = 0;
-	um_info.idx  = 0;
+	um_info.buf = NULL;
+	um_info.idx = 0;
 	/* Memory ranges to look up */
-	um_info.ranges = &(usable_mem->ranges[0]);
 	um_info.nr_ranges = usable_mem->nr_ranges;
+	um_info.ranges = usable_mem->ranges;
 
 	dn = of_find_node_by_path("/ibm,dynamic-reconfiguration-memory");
 	if (dn) {

