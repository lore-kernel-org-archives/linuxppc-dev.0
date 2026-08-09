Return-Path: <linuxppc-dev+bounces-25653-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 010F1C5AD4E
	for <linuxppc-dev@archiver.kernel.org>; Sun,  9 Aug 2026 16:25:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hJ3C409S1z2xyl;
	Mon, 10 Aug 2026 02:25:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=91.218.175.182
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786292719;
	cv=none; b=Nenj3zDQoM7bye+c5tU4LbPrphllVi/SEGsp6BXn6qqjSIhGhaMCQgmmpgPKXA8UoWtAZVUtGT+UyYSNvGFKODhQOFZ7E9buywUhcQmun/fNiSqrEhxX+mrz3vWkt8b974VB39w8hm1iqwitbVLKfOLs1hl6wugZilqfiKsuq53DG6inAuDBr0RuLOpJc8UO96Gxf89T0HNqOABCPpMe81PhacinbXNnIkJ/CrBzxua1U8gkvVWEuEC86wN0o3knsfDmEjY32j8kIy2zMMqteQPHcjsbTAzixG/MBPcgQbx7tkReW2PWRmtzAxUEOrWshhmCcdHimdudBezsG/82nA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786292719; c=relaxed/relaxed;
	bh=4fTW3NKCOnb0Rnw5WpgqtZWsYcNgZWfC8uC6+Vx2Iuw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=meyoeQbhCZe26GKnJmICr//KJyaykbiWVJvimUyOUGLKC3EkzYcVoqFzYFZEQSbSb7TtyseUlGUI5mqNxbMVYvS+35qmOOwL/yT8LwtMWrUHmr9A23i/Hf/zAKYjM+h+ZB8pFcp33gRjpAX0dhxyGn1D5aaY/i9QbkSVzgBwB+ZY+6e4QN4wptaCs38g5MLg5yzzCMv1AiRroHKLrJXXkDF8093fibEKMnusX6FT8d6cWwGXZX8wFa2qzeg20j/SNy5Riy/XQIDySYclQsIkpq0OlNWcXFudbuwo2oBg9v6hjfLQJbb/Yuv+qmpMv4Kzcp5ZStGjFdiVGpmzLbmHqQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=YpWjhLri; dkim-atps=neutral; spf=pass (client-ip=91.218.175.182; helo=out-182.mta0.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=YpWjhLri;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=91.218.175.182; helo=out-182.mta0.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org)
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hJ3C04csRz2xd2
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Aug 2026 02:25:14 +1000 (AEST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786292688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4fTW3NKCOnb0Rnw5WpgqtZWsYcNgZWfC8uC6+Vx2Iuw=;
	b=YpWjhLrijR2mZ1Pkdzk2PKAe73zjTpD6OPzfJ3mcWmm3lMbNWZOkcX0dKv47XfOe/xkpcD
	O0uWn55eIQMR7uccaALc1U0umAgulN4uzQ+8fXDubqwuq5q+lFP5TJd+dnK8Huw+lqGVTE
	qN2bu754u2ythKM8KBEvWEl3Xe7T7/A=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Aditya Gupta <adityag@linux.ibm.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/kexec_file: Use inclusive range checks in add_usable_mem()
Date: Sun,  9 Aug 2026 18:24:01 +0200
Message-ID: <20260809162403.18142-2-thorsten.blum@linux.dev>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1060; i=thorsten.blum@linux.dev; h=from:subject; bh=cwwb5nITHtXa2CEl8dki2kO1JkWBrSuoRMvXj5sMrbM=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFkVKxd7sS0tj7i17KRS04UXgtMuLtvdbC0d/8OnOaA++ OPafbvZOkpZGMS4GGTFFFkezPoxw7e0pnKTScROmDmsTCBDGLg4BWAiHtmMDHvPeWqaLWLeOEep V1d7A2/gH/lAG1ktbYOcE/N68+RuNzEyLEmdWLbr7LZcTXPH7/POPIk/MtV8zqtyrkN/fxy8oZ9 ozQQA
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

add_usable_mem() adds usable memory ranges for the kdump kernel.

The ranges are inclusive, but the partial overlap check uses exclusive
comparisons. This skips ranges with base == loc_end or end == loc_base.
Use inclusive comparisons instead.

Fixes: 7c64e21a1c5a ("powerpc/kexec_file: Restrict memory usage of kdump kernel")
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/powerpc/kexec/file_load_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
index 8c72e12ea44e..f9e872693ca7 100644
--- a/arch/powerpc/kexec/file_load_64.c
+++ b/arch/powerpc/kexec/file_load_64.c
@@ -113,7 +113,7 @@ static int add_usable_mem(struct umem_info *um_info, u64 base, u64 end)
 		loc_end = um_info->ranges[i].end;
 		if (loc_base >= base && loc_end <= end)
 			add = true;
-		else if (base < loc_end && end > loc_base) {
+		else if (base <= loc_end && end >= loc_base) {
 			if (loc_base < base)
 				loc_base = base;
 			if (loc_end > end)

