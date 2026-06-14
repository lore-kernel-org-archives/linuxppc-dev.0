Return-Path: <linuxppc-dev+bounces-22611-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04CECCD98C5
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Jun 2026 14:24:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gdb9v6fF8z2xtC;
	Mon, 15 Jun 2026 00:24:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.186
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781447091;
	cv=none; b=a2Cyd/MY2Wi2fKFis/ot21uNASrKMB0ssdt+AlYq8K+w0gOq4JZ0rVOb77TXfw0dYvJRLEC/x5s4G3YIIi2EzskDg1vYYviqFfLC/F9mD1eA8Q5/wq5MhLjYaafT7fiBcDjsonYa3gvrCm9SYEWJAnHL9qtGt3V5YLNoWQoIJaAM+8I7oNWzihzRANS5WB8sJLKO7lZCcITiKjLTf5b2U6owGGtLWyfKt7Sf0XPJ2AX/Ryq+QTMbkrbtoZ2z02f6kYWtHRF+v5JfBvZ8j8C85/iuioqXztPrg9sYqZDeC5omNa2/6ssdj6lfXqL10gAF8MRn4YLbd68qZ1neegGHUw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781447091; c=relaxed/relaxed;
	bh=XqWPcBKIxm+6NGwzWSu2glLIgf4cePonbI2GNDG/mss=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m9abmmgZ1QvLCc4ofMW/5FVdgXL+r75kHXwabF3Q9n7Dao6BYHTaeZ6/wpyL4ShrjOwG8Atiq024IuCyxWAfU+tl/kjGl1WXtOsUgoro9WL6+AqoLkSu3jofBysYva+TUg509fXXIf5U05nu8rFKDIrUJs69XP4t+5bHbUHmlr8FQ6T/sNq79IJfMhoZ8h48f1w7eT3ZieYkiBvFBNp/M5dUrtPmwjEZMYlPR26iakDoDUPiEYvHLLQhNztE4iiuFdTDgGsO+jPR5ZPcxxrERFSI8WVPJx5BBotFQjZxBIB9J2r6CPgdcLhHErXsarPPtKYvDZOPwM5DJCd3xUtprA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=hdpIUGhP; dkim-atps=neutral; spf=pass (client-ip=95.215.58.186; helo=out-186.mta1.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=hdpIUGhP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.186; helo=out-186.mta1.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org)
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gdb9r1220z2xjd
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jun 2026 00:24:48 +1000 (AEST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781447061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XqWPcBKIxm+6NGwzWSu2glLIgf4cePonbI2GNDG/mss=;
	b=hdpIUGhPeL6MJSvX4DcbFF5ZC3OJoYFvSbJHB2JJHNC7iZ2uVFWezHp/sX62wLyqrUrzs6
	7H8UlX0FQLeWkw3rQNfOT/px7kG0n8aC8FvPJA8U2t+GfDSE8DlVoo0Tgy/8Y1FfWpMmsS
	UrG61GJ0BsbpeQRUE1HdBeJN51IB3vI=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Pratik R. Sampat" <psampat@linux.ibm.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	stable@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/pseries: fix memory leak on krealloc failure in papr_init
Date: Sun, 14 Jun 2026 16:23:56 +0200
Message-ID: <20260614142356.658212-2-thorsten.blum@linux.dev>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1083; i=thorsten.blum@linux.dev; h=from:subject; bh=snD3V6hpHN72HjYbqTmiGvKtA0J3xAZ2znA1CV42hbc=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFl6O2vEdIOL/m/wNnfeHz1F9Ou+1emSVsuNPO/8qMrND VjLc9O8o5SFQYyLQVZMkeXBrB8zfEtrKjeZROyEmcPKBDKEgYtTACbyZA3DX4F5QsyLAi8K62yo 6XvFZhTxY6H4fhsfw4LbjFHeV99rXGb4H3bppvRzwxuz+0LerDA8v3jNh8mTXnz7K3f+r88Hf/5 Ydh4A
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

When krealloc() fails, free the original esi_buf before returning to
avoid a memory leak.

Fixes: 3c14b73454cf ("powerpc/pseries: Interface to represent PAPR firmware attributes")
Cc: stable@vger.kernel.org
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/powerpc/platforms/pseries/papr_platform_attributes.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/papr_platform_attributes.c b/arch/powerpc/platforms/pseries/papr_platform_attributes.c
index ff8adda02341..aacdaa1ebf63 100644
--- a/arch/powerpc/platforms/pseries/papr_platform_attributes.c
+++ b/arch/powerpc/platforms/pseries/papr_platform_attributes.c
@@ -271,11 +271,9 @@ static int __init papr_init(void)
 		esi_buf_size = ESI_HDR_SIZE + (CURR_MAX_ESI_ATTRS * max_esi_attrs);
 
 		temp_esi_buf = krealloc(esi_buf, esi_buf_size, GFP_KERNEL);
-		if (temp_esi_buf)
-			esi_buf = temp_esi_buf;
-		else
-			return -ENOMEM;
-
+		if (!temp_esi_buf)
+			goto out_free_esi_buf;
+		esi_buf = temp_esi_buf;
 		goto retry;
 	}
 

