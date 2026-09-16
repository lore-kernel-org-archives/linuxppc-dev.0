Return-Path: <linuxppc-dev+bounces-27492-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A671C982C4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Sep 2026 15:32:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hlND865WGz2yfD;
	Thu, 17 Sep 2026 01:32:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789572728;
	cv=none; b=V/AI07ECI3vJTmpwPja/rCARsPkSEsGxXuzcLgonEES6TyaiZ5vCfyYRn6G4U8rMkjzaoKzVzolJpZuECfP1qkJyTTonPSP/oE/YvUEIGRPD5U1OiJHwHr6aAB9MOQ36ZZlZjweHkhRQcXTx8oHJ32lIAtpbapc3rEsc1c7TnMd3YMCPoAURyiG7+OKZH86/DWyydA1/s8qikH991wSDU96Avyy5bQFPqg8l0uIlEWQykY6HrQ/fA27pLsqKqcbvdF50pL4TRsmv7w+AriN8D5HHPn8don5BPebAPQ/kHy4esf9qsUtFU3u6uDqY+uiFSvybZlT/pgu3buQGmJa8bw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789572728; c=relaxed/relaxed;
	bh=r+L+gdmlejhQNmtecvJQTWNGDQdwYrl4NsxaG1tw1go=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aTy2rK/OrppClj1TwkkORC+0tdFJ8WHaf3TVFZ3XX9R999ZxMsU6ZMehil1YZY14XTQRwtcPWQ1SsroZivdAQdyLTcyPoKC9HLmTKQlDi+UNcm8PkZOyrjXVpcSdlog8iSuZvJlM3V1rIQpyw3nAwc14sC5dVy3j05u/QY8djVWI8/mQ0mTzKRAbehM8O6MFVfVM5WiZBqZe5I3fjaa9vufoCA1Hpt6TU6Utxp4w7uhLbIMe/LhvDbSgvyFDKA2sYXsnmGJd72Z1N6sloPJOtS+EYqOW4KgltF4o0j3u+W8WWhXOg0udiglyF/eAdVUbU/TDQBma1qgrGghoAde2Nw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hzhTXwDa; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=blum@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hzhTXwDa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=blum@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hlND75ZKxz2yGT
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2026 01:32:07 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 6B535602CB;
	Wed, 16 Sep 2026 15:32:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2864E1F00893;
	Wed, 16 Sep 2026 15:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789572725;
	bh=r+L+gdmlejhQNmtecvJQTWNGDQdwYrl4NsxaG1tw1go=;
	h=From:To:Cc:Subject:Date;
	b=hzhTXwDa2Qo+pmZ4YoZsP+RopMjaOH8/EFzDBkw4eb1XHwdMhB39araxeWwgADPOq
	 pYnfRc9aTr+p+ELU3hp8lvVV3Qf5GnwWsEY0+Py7rbPdrm52t2D83Qy3MwvbSvemgK
	 9NX0R3PvbM1aO6Qx6Db1XkwNRDELcXHR8WTw6Hr/EGJQAQTblRbXuHDLjNVgYmF27E
	 sjRDoqy/UBenFAbuKFw3z9obu79qycztHMaAeUW0kk6+Sce2I5z4YViwmmKFQzZJ/Z
	 F9MEqsFGzyFJx4xNzSO9ltdlMTmC+OBwLlP2V5SbhCs8MGZOPo0Eeu+XiHCNJC/5f7
	 J6eKaT8Fwwt3Q==
From: Thorsten Blum <blum@kernel.org>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Thorsten Blum <blum@kernel.org>,
	Aditya Gupta <adityag@linux.ibm.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/kexec_file: Simplify add_usable_mem()
Date: Wed, 16 Sep 2026 17:31:49 +0200
Message-ID: <20260916153149.127278-3-blum@kernel.org>
X-Mailer: git-send-email 2.55.0
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1962; i=blum@kernel.org; h=from:subject; bh=6cJZ3vF0dSDjjEMMG9H2JHANKMhOY+wqpAkHW2i9jYQ=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFmrtqW6LnzKtdX5g/DrurMLlHqd1aT1H8UVRCp4J0TM+ f6theFARykLgxgXg6yYIsuDWT9m+JbWVG4yidgJM4eVCWQIAxenAEzkbSojw623mb/NhZbminyI 2f1yddMLg/fBsx6FhZmmnCqO2sO25B3D/1CBvUZrLVZu7J0dkhrQz1FrN/HcEx2FlTzH8zasYG0 15wAA
X-Developer-Key: i=blum@kernel.org; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit

Use max() and min() to calculate loc_base and loc_end, respectively.
Skip to the next range if loc_base > loc_end and drop the now-obsolete
boolean add variable.

Signed-off-by: Thorsten Blum <blum@kernel.org>
---
 arch/powerpc/kexec/file_load_64.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
index bd80c5fb1b1f..6162afbe919a 100644
--- a/arch/powerpc/kexec/file_load_64.c
+++ b/arch/powerpc/kexec/file_load_64.c
@@ -20,6 +20,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/memblock.h>
+#include <linux/minmax.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <asm/setup.h>
@@ -104,31 +105,19 @@ static __be64 *check_realloc_usable_mem(struct umem_info *um_info, int cnt)
 static int add_usable_mem(struct umem_info *um_info, u64 base, u64 end)
 {
 	u64 loc_base, loc_end;
-	bool add;
 	int i;
 
 	for (i = 0; i < um_info->nr_ranges; i++) {
-		add = false;
-		loc_base = um_info->ranges[i].start;
-		loc_end = um_info->ranges[i].end;
-		if (loc_base >= base && loc_end <= end)
-			add = true;
-		else if (base <= loc_end && end >= loc_base) {
-			if (loc_base < base)
-				loc_base = base;
-			if (loc_end > end)
-				loc_end = end;
-			add = true;
-		}
+		loc_base = max(base, um_info->ranges[i].start);
+		loc_end = min(end, um_info->ranges[i].end);
+		if (loc_base > loc_end)
+			continue;
 
-		if (add) {
-			if (!check_realloc_usable_mem(um_info, 2))
-				return -ENOMEM;
+		if (!check_realloc_usable_mem(um_info, 2))
+			return -ENOMEM;
 
-			um_info->buf[um_info->idx++] = cpu_to_be64(loc_base);
-			um_info->buf[um_info->idx++] =
-					cpu_to_be64(loc_end - loc_base + 1);
-		}
+		um_info->buf[um_info->idx++] = cpu_to_be64(loc_base);
+		um_info->buf[um_info->idx++] = cpu_to_be64(loc_end - loc_base + 1);
 	}
 
 	return 0;

