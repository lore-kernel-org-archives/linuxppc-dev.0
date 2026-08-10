Return-Path: <linuxppc-dev+bounces-25682-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5008DC5AE49
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Aug 2026 14:59:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hJdFl5J3Xz2yxG;
	Tue, 11 Aug 2026 00:59:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::b1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786373979;
	cv=none; b=IBJTj/fWe8GbdYc7EXB8XwomRQ7hIDKe2NzM3jbGo7XqeHou7+UXJL5e4DvvppVoIc/xNq0T+gdwXwL2WFxn42Dj6KtKatGVhJuxPMoyB9pN7fXPtUS4+4TW7ZhnP2xg47POj6hE+G0037Q3j/ukVwr7ZvfUcL2noXqV33dRA43qEhMSlm5I+NOPZjscC5xz4hUFFqPDqqYFr1kcFUMXr0+5jAPjl2BQvT9Mqc4G7Ac/3ObVO6eI+zcfPGsuWuFIC1ye8vJsl7BeCUXeSN8cr4bfkhYkLc5xQ2FXmpC1E2pN+5byIB+f8qyxDA4jVfjlPW6BFCIQmrwM1lMlLkwRiw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786373979; c=relaxed/relaxed;
	bh=QBSVQCIcPTFPONPO0r2svBU7MgEW/L0OhswnDVKP3Vw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bRAgXBOiZ5NinrDglNjL4/cP7hgIiFcLrcSD/LxnLq3cnuUyCiAZReR3qtrSJJJyUfP2j8RuDC56ukxnHQIh+gn2YpxyKdAISH8Qj0gkmX23gKnN6QoghG8uvqyIpUT5m1oH8omf7/2JOcutrr9XyXFVvtxs9Qq9DI0tB6qtPd35LbVi0hdTcPmPu56V5Y4I/K32ABTwjFAsz5qJ+Tfy9IDg+bmBvVrdiSQDcMRO+cVzGwMFN95TT6AUc90El/65pmnxSJrj8lTbsKXrDM5ESur+Y38EEmESHsfhWMSBqI2Iku6l4mwuvd3Jp88Gkl7hr6/sIdiLcnw0QPwp/bKtrQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=If0MMZ6d; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::b1; helo=out-177.mta0.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=If0MMZ6d;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::b1; helo=out-177.mta0.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org)
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hJdFg3vVCz2ytv
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2026 00:59:33 +1000 (AEST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786373951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QBSVQCIcPTFPONPO0r2svBU7MgEW/L0OhswnDVKP3Vw=;
	b=If0MMZ6d/FLOZM1OKhoy3Z5P/YMKFOHxDwWoUxRVcBSGEHa/8kSJgCOFKisu3CcxXN2LNx
	dUeuUpjfwgOe4F9Ms0VKJbNUJpVe52/65pV7toGO/AW+jqSl6VN4vkBKEdr4WkK7l0h1Yq
	d4YswN74XBtS6+q87oR+fyKh1hAejVc=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Aditya Gupta <adityag@linux.ibm.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/kexec_file: Use inclusive range checks for excluded memory
Date: Mon, 10 Aug 2026 16:58:27 +0200
Message-ID: <20260810145827.157972-3-thorsten.blum@linux.dev>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1236; i=thorsten.blum@linux.dev; h=from:subject; bh=RxeXQNEjeIoAq+PW4Rv9liZkIgOa04vUqgNKQcRM6eo=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFmVz4W3s9jGqfmaRZxifKS3Zl3WrndLklbsjljscCegU 1OcY2ZdRykLgxgXg6yYIsuDWT9m+JbWVG4yidgJM4eVCWQIAxenAExkCyfD/4glT2r3uBy2WX9g v1bq07/uazZsqz/49ClrrXzaisWGO78yMrQyHu3PYebwKoxY0u/0WCrSfAkX/8TeE+6Vaw44puc s5QEA
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

arch_check_excluded_range() checks if a kexec segment overlaps an
excluded memory range.

Both ranges use inclusive end addresses, but the overlap check uses
exclusive comparisons. This skips ranges with start == ->ranges[i].end
or end == ->ranges[i].start. Use inclusive comparisons instead.

Fixes: 6e5250eaa665 ("powerpc/crash: use generic APIs to locate memory hole for kdump")
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
Sashiko found this issue when reviewing another patch:
https://sashiko.dev/#/patchset/20260809162403.18142-2-thorsten.blum%40linux.dev
---
 arch/powerpc/kexec/file_load_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
index 40b74cc4ed3e..32e2b7412a9f 100644
--- a/arch/powerpc/kexec/file_load_64.c
+++ b/arch/powerpc/kexec/file_load_64.c
@@ -58,7 +58,7 @@ int arch_check_excluded_range(struct kimage *image, unsigned long start,
 
 	emem = image->arch.exclude_ranges;
 	for (i = 0; i < emem->nr_ranges; i++)
-		if (start < emem->ranges[i].end && end > emem->ranges[i].start)
+		if (start <= emem->ranges[i].end && end >= emem->ranges[i].start)
 			return 1;
 
 	return 0;

