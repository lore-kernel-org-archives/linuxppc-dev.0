Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A6F606A31A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Oct 2026 11:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gKRE898b
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j89Ty2d6Pz2xwL;
	Tue, 20 Oct 2026 22:41:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792496470;
	cv=none; b=Cbu/nuJYE2OPR+9gP97ZDaCOK1941JAGNCfJnmaTYHue7H96fIo3ZFoFQ43FSXRKvhYg1ngoXhhYe3QLqFDtNqqNT7F+PNXfsqFXI8E7kJMHYlEexUM+PhbmBe395UZIVQH1g7p/o9tVNCjq2elHhMID4ETBIoU22IQW97wFOKpjLELkX+RM8pKfj+rm1mAu1HcFXRDgMHqfDBA6T05wi6m3G/36NUDeOcUFlpfukjxLMBJT7SEqkqIk+cE2+KP5gapBU81WIgk33FH4/D5Chbtj9r3Vgl1TRuFlVuxfjeXowkScoWEYPM5ZPV3zhzVm4r7Ub/hALD+IL1H0egYpQA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792496470; c=relaxed/relaxed;
	bh=eZ7l6S6Y5XERFk+DP+CPdXSj9bbGmqqxbTw6qag+4S0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gIEQRwYmRByK5wuPA/ao3Dx9qm2V8w78A4DGJCPfD/S3QUCBPykhvyS7z913eCgHwL/mvI1a5pUuwApfrTGeXJB3iZKbGs/QdnUhAx+7UeFaAhhtzLfr+nTOPnzCJdHbZ6tcLpR2BnhFlJfu1OZdnpxmP0/FT3SRgQdA3J7jXH8x+WyJFcYMeE4i3OHkR5P+520xYX1KV6XidFjKvuosC0uGG257MIMw4GhfK7ERDR+S/rONuEGsDT/Uy7+G5Nf3kv5ZqdhinSjxux9MDG//9WAl15eNC5CqX7fnPND3rZjHFAJilCT3M7NekfCrtmt0Ya7OaPbXnzq1spxfBp54Kw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gKRE898b; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=blum@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gKRE898b;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=blum@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j89Tx33dcz2xmk
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Oct 2026 22:41:09 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 6F320605ED;
	Tue, 20 Oct 2026 11:41:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA7A21F000C4;
	Tue, 20 Oct 2026 11:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792496466;
	bh=eZ7l6S6Y5XERFk+DP+CPdXSj9bbGmqqxbTw6qag+4S0=;
	h=From:To:Cc:Subject:Date;
	b=gKRE898bArSX8Etly/VakmhY8hCrxf+2CH1sK4V/HXH6YG4nCq16Ar98Rkvd1+k24
	 Heundw7PkPXrInmF7lrJAw8lsz8Tmc+6ZWhO23NYyWZ6T7WQ9XiEGPu4Iz6Gdftqpc
	 MV5z0D286Th91AT6lZJwuQh1u9+3lMnE8062qT+hgDA+n+6OH9/rWcxDn12/aA1bSK
	 2Qov8dZbYwrnW/5AIYCXIbe/R/lGxLDTxw37iropVTF4yZPWD7L/GXdp2filFsprOI
	 /c6UjYB1TR0HUD0GEMGSOVJmwT1kKJFgSijJ21nRV/nHJfDcMPt8xUSi3rcCzCNjJg
	 viSm1m0cBTlzQ==
From: Thorsten Blum <blum@kernel.org>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Thorsten Blum <blum@kernel.org>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Aditya Gupta <adityag@linux.ibm.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2] powerpc/kexec: Annotate umem_info members with __counted_by_ptr()
Date: Tue, 20 Oct 2026 13:40:28 +0200
Message-ID: <20261020114029.200922-2-blum@kernel.org>
X-Mailer: git-send-email 2.56.0
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2467; i=blum@kernel.org; h=from:subject; bh=pzIMtJPYfw+P/r4Q1/Ce4+BOcaaNx/LjPyiQ5HFapz8=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFnXg3W/bsnb9axt65U0UbVUvc7MFu9vnpvCCxnurV5k2 3ua90VaRykLgxgXg6yYIsuDWT9m+JbWVG4yidgJM4eVCWQIAxenAEzEZC3D/6TzEyM3fd8vncoo aR7vEKa4afq3KeUNb482HWvoViv/ycLIsPpltc4Fju1/V+4+N/Hl3MdZZulc85wLDlYeOBvf57/ yKi8A
X-Developer-Key: i=blum@kernel.org; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add __counted_by_ptr() to umem_info::buf and umem_info::ranges to
improve access bounds checking via CONFIG_UBSAN_BOUNDS and
CONFIG_FORTIFY_SOURCE.

In check_realloc_usable_mem(), return early on krealloc() failure and
use sizeof(*buf) when deriving max_entries from the allocation size.

Signed-off-by: Thorsten Blum <blum@kernel.org>
---
Changes in v2:
- Preserve the original pointer/count assignment order (Sourabh Jain)
- v1: https://lore.kernel.org/r/20260730130248.597249-2-thorsten.blum@linux.dev/
---
 arch/powerpc/kexec/file_load_64.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
index bd80c5fb1b1f..7f45493e7c7a 100644
--- a/arch/powerpc/kexec/file_load_64.c
+++ b/arch/powerpc/kexec/file_load_64.c
@@ -34,14 +34,14 @@
 #include <asm/cputhreads.h>
 
 struct umem_info {
-	__be64 *buf;		/* data buffer for usable-memory property */
+	__be64 *buf __counted_by_ptr(max_entries); /* data buffer for usable-memory property */
 	u32 size;		/* size allocated for the data buffer */
 	u32 max_entries;	/* maximum no. of entries */
 	u32 idx;		/* index of current entry */
 
 	/* usable memory ranges to look up */
 	unsigned int nr_ranges;
-	const struct range *ranges;
+	const struct range *ranges __counted_by_ptr(nr_ranges);
 };
 
 const struct kexec_file_ops * const kexec_file_loaders[] = {
@@ -83,11 +83,12 @@ static __be64 *check_realloc_usable_mem(struct umem_info *um_info, int cnt)
 
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
+	um_info->buf = tbuf;
+	um_info->size = new_size;
+	um_info->max_entries = um_info->size / sizeof(*um_info->buf);
 
 	return tbuf;
 }
@@ -288,12 +289,12 @@ static int update_usable_mem_fdt(void *fdt, struct crash_mem *usable_mem)
 		return -EINVAL;
 	}
 
-	um_info.buf  = NULL;
+	um_info.buf = NULL;
 	um_info.size = 0;
 	um_info.max_entries = 0;
-	um_info.idx  = 0;
+	um_info.idx = 0;
 	/* Memory ranges to look up */
-	um_info.ranges = &(usable_mem->ranges[0]);
+	um_info.ranges = usable_mem->ranges;
 	um_info.nr_ranges = usable_mem->nr_ranges;
 
 	dn = of_find_node_by_path("/ibm,dynamic-reconfiguration-memory");

