Return-Path: <linuxppc-dev+bounces-24845-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD7D2C531C9
	for <linuxppc-dev@archiver.kernel.org>; Sun, 26 Jul 2026 18:30:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h7VfN6tW8z2xyk;
	Mon, 27 Jul 2026 04:30:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=91.218.175.173
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785090652;
	cv=none; b=JiK1mmrWALUPiY7bEsBs2BtYeYFDQScduvnk0vRX13dc/8xgpHV93nwENBkBXhtfyxXE+pSJJmnVbfwLTa5paoWy2psj1M38S6/TXz0DM3P2kNh8oz+ghzHwnnzAdbymDs0JQ8MyWjRgCWV/6a+muYInzAOi/Ffzv0IG5O2LdcVd/OaXeuBLMRCphqin2iWnlYXLnAI7ozfptz4RAlKN8r7L/MpEGMXVx2QWy/Dl/kri24pLgjPXaCOgJLTVqKNzwqBbxy4FOS50TQHdycJKhaYYHEWIR192mr6YeXnxy3HhO+7wVOlBKd5fE90iRkbAGhjdm9c8suhpXTgxGprL0g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785090652; c=relaxed/relaxed;
	bh=2FapaJtArv3w0NX/NrQ1WqcO8+Jt47BumXxf9OJr+uw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NBXubm+zpB9uOgBPDijUyDFbmttN52m2pBOX4ISXfNERr/Ckp38pa3ZVCOhWgD40AxJ4jkEGwbqi4xivw+lse/z4BQ/mqid4QJEvJIduPxZnTaA/WrMUhLiGe9I6+xGy4tBJI0OBdCiySY9qb2Vn/il7m2unDBYUTM8025o5B0m/+ktTO/r3Umrkg9KHTzzjg3SUSXUqve+e1v43AkIvHF7Bve6F0VqX/azgG+Esytd39/wa99bUx5ZkPBLldxx/DBuJLyIcZsfZkY1cntQQcUMwt5OQd2weCZdKaePw0K0s0v4waEcPKpvAx54VTAs/wIkTHLSNy0P5ilfSryQ2Lw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=jD1n144V; dkim-atps=neutral; spf=pass (client-ip=91.218.175.173; helo=out-173.mta0.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=jD1n144V;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=91.218.175.173; helo=out-173.mta0.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org)
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h7VfJ44x3z2xd2
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2026 04:30:47 +1000 (AEST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785090625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2FapaJtArv3w0NX/NrQ1WqcO8+Jt47BumXxf9OJr+uw=;
	b=jD1n144VZPsULvosmbwW5AKDlw7qzAZXAJZSYbRsxjpPfiasR1WnqbeWCIgyrF3NrzTQXS
	r7kClvavsjAx7ru2JRuAwu2uFISj6c6NeqcJp66HGKii9s1RnMdT/45nr6DvnPgw4G+FTz
	oB+MSRmpGJ+R3iN6cp8W3giyUUpmJd0=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Aditya Gupta <adityag@linux.ibm.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Thorsten Blum <thorsten.blum@linux.dev>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/kexec: Remove stale comment from check_realloc_usable_mem()
Date: Sun, 26 Jul 2026 20:30:16 +0200
Message-ID: <20260726183016.372197-2-thorsten.blum@linux.dev>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=946; i=thorsten.blum@linux.dev; h=from:subject; bh=+2HKhIw9DL7XrnA/vRvYbVcnPvv1GFP9Qe/uNwdpT9Q=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFlpQRbWjWeNnttUvkxgdd/w29alnbOFU3/ySRX56p9rv pXIz+7pKGVhEONikBVTZHkw68cM39Kayk0mETth5rAygQxh4OIUgIlsOMTI0KqVLvFm7Saej3sZ nM6oaEt73Oba/Mbh1+aYmR3MWe90rjL8z/hyae8ML6dA2YM5dwtFznRHf6zjO/NMXPXKtvyajeq ZTAA=
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

check_realloc_usable_mem() does not free the buffer if memory allocation
fails - remove the misleading comment. The buffer is owned and freed by
update_usable_mem_fdt().

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/powerpc/kexec/file_load_64.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
index c3503d698428..6d0c818ac619 100644
--- a/arch/powerpc/kexec/file_load_64.c
+++ b/arch/powerpc/kexec/file_load_64.c
@@ -69,8 +69,6 @@ int arch_check_excluded_range(struct kimage *image, unsigned long start,
  * @um_info:                  Usable memory buffer and ranges info.
  * @cnt:                      No. of entries to accommodate.
  *
- * Frees up the old buffer if memory reallocation fails.
- *
  * Returns buffer on success, NULL on error.
  */
 static __be64 *check_realloc_usable_mem(struct umem_info *um_info, int cnt)

