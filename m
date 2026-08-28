Return-Path: <linuxppc-dev+bounces-26175-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA333C61DD6
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Aug 2026 01:53:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hWyvP0Z9kz2xd5;
	Sat, 29 Aug 2026 11:53:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787922437;
	cv=none; b=O4nzvSYEeOncbixhXT33xf6rfBOogIvBh5P4aHbMy5LoTD09VbZ4Z7PVs27SDkVrEWFtvdtJAmzoJQ/vJBb6fj1cPrTjYLPr08+KcV5SdN4f4/mQl5/vpRWBX1Cf75Y5taKCA09Sy8+WEGgGc8Uz9EmFzDSzuUafA3ofsa8LfQf9VK8ausdSku/YqaoTsbf/waEnJYUlvfiqJl1a57xPE21mdfrOZNDX2IXDWFO572uTNJhclS2CbkDvD/PTLogY44+oKM4u7Q8uMkN6kAbgquFd7PhQaE4qhvwdWfoI2tS5/krd2dYlpPKTaqMp1XqYihXnYKFUY/CdBfj7YESwhA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787922437; c=relaxed/relaxed;
	bh=XbB8bJchpwVej8+6VwD7bhn6TGJcGlHjfQ3aJtltKu4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xu3hvkAGJ2hz2HaZV2RAzOjg7INodr2JgF6b/MYNnoqA/Rp7GTKcrQkbUriOyfZxn7BFgXfDGZIRR9Ie8QHxufWHtQvTfzSypDCbPAhVcbIwbbpXbcYMButy/8HQ0x7rONC6LN6yDdLGgJX1uzfBGmg49Rk8+FHU9gp8XfLtBIZJVzV6SivIjtjU58hCgNfRUVFofpS4Po233zmm9+j4c2HzdO13JP3B2PbM0NBIctw2b7nJF/BpKfGb9G0w+nJJcYQRhJGiHQ3lO7k8YETfGhbYEwnU4althfA9U0aicYtGeOnw8Gxiu8laUva1D38ZSLI1d1dht2rYTZaEd552Gw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MWhMTG3W; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=blum@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MWhMTG3W;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=blum@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hWdvn0hpmz2y2T
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Aug 2026 23:07:17 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 9F641436E2;
	Fri, 28 Aug 2026 13:07:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDC9C1F000E9;
	Fri, 28 Aug 2026 13:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787922434;
	bh=XbB8bJchpwVej8+6VwD7bhn6TGJcGlHjfQ3aJtltKu4=;
	h=From:To:Cc:Subject:Date;
	b=MWhMTG3WCd5WRvev5dyliQKARDov5RzGYzWhyAw/akPSfZm4AYpL5+oUJhbszTwFG
	 D1UiqTBKUUQe9hMiQLHtoIpHfWVW8dS3+efTotkAGBuCbqnPd1qFQZ3Y+XlpdZqYkW
	 fkEibUOIazmKhR/SH/x1u1+8gDPDd33mlUqn0vXUqxJ2qmHBE+bm5qRgygWCDf76N5
	 272rGEyFnvwkJ4XJ+o0P4pdd8W/EOgWJIiFIux2vevF/VhefoLhklAd3YsokgVcnT1
	 RCLyLuhD6MXP2dclr+rRFQpUqRQ2S4FVAPUWkqhyUnXHM9irDpLZPK8b5EySVehRsC
	 jyDidrtCOTsmw==
From: Thorsten Blum <blum@kernel.org>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Thorsten Blum <blum@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] powerpc/boot: Drop unused min_t()/max_t() helpers
Date: Fri, 28 Aug 2026 15:06:22 +0200
Message-ID: <20260828130622.576064-3-blum@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1033; i=blum@kernel.org; h=from:subject; bh=BXlGGfFc4xNUVoxlXaVPVB6HQRIEjQwWXFXLWSoHGGI=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFkT28+VsRgd2FPwzjV16sRNexXFZmrcWiQbZXr01aU/m gVvGV4Gd5SyMIhxMciKKbI8mPVjhm9pTeUmk4idMHNYmUCGMHBxCsBEtmgwMuzy8zHn2pqnoxz4 Ruea1o35qolBfp4cCb+90xWfhUc32TAybF8n36f4mCvHcFvC+uT4SVfzdmdz6QeIr/4Y66mktH4 9BwA=
X-Developer-Key: i=blum@kernel.org; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit

Commit c762c69e106f ("powerpc/boot: Add support for XZ compression")
added min_t() and max_t() to support XZ in the boot wrapper. However,
since commit 9f121705503a ("lib/xz: replace min_t with min") XZ no
longer depends on these helpers. Remove them from the boot wrapper.

Signed-off-by: Thorsten Blum <blum@kernel.org>
---
Changes in v2:
- Mention the commit that removed XZ's dependency on min_t(), fixing the
  build failure seen with v1
- v1: https://lore.kernel.org/r/20260525091839.817778-3-thorsten.blum@linux.dev/
---
 arch/powerpc/boot/types.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/powerpc/boot/types.h b/arch/powerpc/boot/types.h
index 8a4c418b7260..c5085c2632bf 100644
--- a/arch/powerpc/boot/types.h
+++ b/arch/powerpc/boot/types.h
@@ -37,9 +37,6 @@ typedef s64 int64_t;
 	(void) (&_x == &_y);	\
 	_x > _y ? _x : _y; })
 
-#define min_t(type, a, b) min(((type) a), ((type) b))
-#define max_t(type, a, b) max(((type) a), ((type) b))
-
 typedef int bool;
 
 #ifndef true

