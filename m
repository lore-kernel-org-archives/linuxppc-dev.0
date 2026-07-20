Return-Path: <linuxppc-dev+bounces-24557-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F83EC44515
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 23:15:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3xFX5wstz2ySg;
	Tue, 21 Jul 2026 09:15:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::ac"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784589328;
	cv=none; b=U6HEyBqHAhxrBPFamarAJ6bH5FdxLMf7Gi+K2mTDCg9hc+Cl6NTEx/SMsNhcwwF5XF5zYYq/wl1uQv5aRsiL39Z51GfdP08ceySV4t/i/W+won4eNjLFVDijj5T6SdGHQ4/WuW/Hb7PqNHCeEMSmwELpVE2Ua2Urv30ZaCTaGKP8kBqxSiE3yJlUdqK2eueXXMTohF0pvVN9VSE6X5gh3/kbhu9UPI0LvbC+al3pljVIbjnGW2WUONcUaEWL3OGIAn+s6LH4a9ZDCcBr4TJIL1VZvk0Q7lv1FMv/bT3hQqYrjbwxRO9KS+p4UkW9yXTjVzeidR1RfHQuPnRTh0OU+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784589328; c=relaxed/relaxed;
	bh=YilFWh6vGNtSfSoKR79nDYQvUrO3SKkqHlW7M3OMFcI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kmoazaBhXbF0y4+tZoAvEkYTI6uFIpwDMrrfs9BD0690An/Qae8i+ROmuj4Efkffd2KewKBOWMGuK7Z/bzKhqy7mfk9QH248MiPFXRWLtw6S93vg6+MzrpaHtrzAEcvlEJ9BxxiyFQ/3cv91wkSjmeryruBjog0DtQggirpSNhXUV7nLUq+usznF+YIh6doKwMHWyRYNXzMo0rWF67LtKziYqEH7EJxrXrYfS2KEKy7L0gbpvmgY7WoJ/8m1cdx1SYNIoYpLeFx2ylcnYZ/7vy8UtteTIFvWnfgWgJI0eFIly8LFZVtwOlAtDGgKi43GJWvYGECIRCqEnI8YCAKgOA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=cZE9GjBs; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::ac; helo=out-172.mta0.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=cZE9GjBs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::ac; helo=out-172.mta0.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org)
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [IPv6:2001:41d0:1004:224b::ac])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3xFW75Qvz2y7Y
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2026 09:15:27 +1000 (AEST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784589302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YilFWh6vGNtSfSoKR79nDYQvUrO3SKkqHlW7M3OMFcI=;
	b=cZE9GjBsZgk3PwlMuMHfrAdgE+JEs8RyLLx9h1mX+3wefYnkETK5jjNynoysPwdBvloXEj
	VaLCLFxQomoBr42X1vk42R+OJDsEESsKQbjBLotkjpR/+nvJ3hNeyZtLSbD8imEi4QC0cM
	q1fjlhzAyngqYNip2yEBCl0eaizHf+E=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/powermac: Simplify bootx_scan_dt_build_struct()
Date: Tue, 21 Jul 2026 01:14:52 +0200
Message-ID: <20260720231453.117271-2-thorsten.blum@linux.dev>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=888; i=thorsten.blum@linux.dev; h=from:subject; bh=1/fplfuBCFAI7iqSY9aYaNFDDnGOlCRaE1nfG2FRfbI=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFlxq98+PfPxNft5/kVqnWteXNn6Is3qNo/E6mK91aqRq wKamtwdOkpZGMS4GGTFFFkezPoxw7e0pnKTScROmDmsTCBDGLg4BWAiPIoM/8u6Hgsp1DA1f7/d VLsn6NHc0qXM8Vx/t5t85T6+vzTZ+z3DH651Niwxas+5Q60iXv96f2qim1HcgukLAo5r/Th193O SBxcA
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Assign the empty string directly instead of NULL checking namep again.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/powerpc/platforms/powermac/bootx_init.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/powermac/bootx_init.c b/arch/powerpc/platforms/powermac/bootx_init.c
index 72eb99aba40f..abceae91dfde 100644
--- a/arch/powerpc/platforms/powermac/bootx_init.c
+++ b/arch/powerpc/platforms/powermac/bootx_init.c
@@ -284,9 +284,7 @@ static void __init bootx_scan_dt_build_struct(unsigned long base,
 	dt_push_token(OF_DT_BEGIN_NODE, mem_end);
 
 	/* get the node's full name */
-	namep = np->full_name ? (char *)(base + np->full_name) : NULL;
-	if (namep == NULL)
-		namep = "";
+	namep = np->full_name ? (char *)(base + np->full_name) : "";
 	l = strlen(namep);
 
 	DBG("* struct: %s\n", namep);

