Return-Path: <linuxppc-dev+bounces-23506-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0359BC43458
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Jul 2026 16:59:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gsKjS0vchz2xdb;
	Sat, 04 Jul 2026 02:59:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::b5"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783097963;
	cv=none; b=bUH1kEESB0w91/jksVSV+ItwNhHrekb9zITwwOxbGBT8i8x7NSqerxaRzb1mfNm+s44bfs9V/oPwn48TaAjCb4zWNzCDUOFFqR/4SaOXs16uJh+kgvRFbmXy7M9UHJdTiJA7JxMyexkkIFwBnn3bP0uRd6ICUqQtlRnAyp8TcBlWxrECDf+CDHEc5KgQXeuGpIWOLoJhK+DA7MuCKvkGSb2gNHAWivsgbhnyKUEd5hlwRxxTHe9/fkoxAgDOueUs/b2xtrV/WW2Z2gKiXVqKqPAFUEGB9fl5ptLJPSQB9o117flh6trS7HKrti1gwTO1/Eui+KZMPsjLo7wDM0amCg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783097963; c=relaxed/relaxed;
	bh=Q4FgBAGOtVqoAkgaBXGYo/0h+uTit4LUDfTjDWMATQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=D855lUAvcpHjcc7TuHXO7Z8WYm6etczdx6lWLxaA2pAEfcgQsaJ+7SzqX/svN/qhV8rLXPhqqVFqSFznNO6uMg2Pm8DZP3/O8a7tsA97qqOB+d1aabas87Au5qkOo5CfmXy+xQcr0V6K97WtWdZxOObCs8P/gd1XNe+K0SNEmPFMU86J6FkWr/rFPjw0Pc1gRQNfYjzLjbiBNtlqCpfbzNFAFr9kSRoza97yescw76eQYO7Ttd9QFj5grPn982kWEg8RgV0VDrISffrp7feW8k2dDa5FL4zYBWWcCMRN6IohWRcVhY88AUctfqn4+XiDy4klwGCSuVUHmt1mnr6q2w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=iaNmMNlX; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::b5; helo=out-181.mta0.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=iaNmMNlX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::b5; helo=out-181.mta0.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org)
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gsKjM56DXz2xLq
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 04 Jul 2026 02:59:17 +1000 (AEST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783097932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Q4FgBAGOtVqoAkgaBXGYo/0h+uTit4LUDfTjDWMATQQ=;
	b=iaNmMNlXIEED9kIXU6PpvwnZkav0b57801IIiImrQyKbHL0nVWWrXO9H/Nw2E7oeY6Qm1x
	gLMZEX634nh1ino0Btv5Z169gTAILFomD8qgMqCrf75Q5rznqLZiGsO4FORBroqWJgBWOD
	x5KwJwRG4hBHTWRbA1nCFiaCEFqI9ls=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Geoff Levand <geoff@infradead.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Justin Stitt <justinstitt@google.com>,
	Kees Cook <kees@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	stable@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/ps3: Fix repository.c build failure
Date: Fri,  3 Jul 2026 18:58:35 +0200
Message-ID: <20260703165834.137242-2-thorsten.blum@linux.dev>
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
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2088; i=thorsten.blum@linux.dev; h=from:subject; bh=8Sh0ZapBO5HhbmK4razIBjbrZy74H3yVffS4gyHeCZw=; b=kA0DAAoWXqtxINjMdS4ByyZiAGpH6jui18HJkbScRPepAnHtvHj3W/d5KSuRwpr7dc0afx8Aa 4h1BAAWCgAdFiEE4Jr4mE11fHmyNFi5XqtxINjMdS4FAmpH6jsACgkQXqtxINjMdS6ijgD+LFmq TZ5L2ZMYVnIAec2nci4G4Ot/KT5LRhXOBex8CRQA/j4GER9ut3jGx9ghyxZalV/D5Py2EHh346r rYGcHUFIM
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

GCC fails to build ps3_defconfig with the following errors:

  arch/powerpc/platforms/ps3/repository.c: In function ‘make_first_field.constprop’:
  arch/powerpc/platforms/ps3/repository.c:78:9: error: ‘strnlen’ specified bound 8 exceeds source size 3 [-Werror=stringop-overread]
     78 |         memcpy((char *)&n, text, strnlen(text, sizeof(n)));
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  arch/powerpc/platforms/ps3/repository.c: In function ‘make_first_field.constprop’:
  arch/powerpc/platforms/ps3/repository.c:78:9: error: ‘strnlen’ specified bound 8 exceeds source size 4 [-Werror=stringop-overread]
     78 |         memcpy((char *)&n, text, strnlen(text, sizeof(n)));
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The current use of strnlen(text, sizeof(n)) triggers -Wstringop-overread
when text is a short string literal that is smaller than sizeof(n), such
as "bi" or "bus". Use strlen(text) instead and clamp the copy length to
sizeof(n) before memcpy().

Drop the redundant char * cast while at it.

Fixes: f94a84a09148 ("powerpc/ps3: refactor strncpy usage")
Cc: stable@vger.kernel.org
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/powerpc/platforms/ps3/repository.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/ps3/repository.c b/arch/powerpc/platforms/ps3/repository.c
index b8c030eab138..0cc755ac3e7f 100644
--- a/arch/powerpc/platforms/ps3/repository.c
+++ b/arch/powerpc/platforms/ps3/repository.c
@@ -6,6 +6,8 @@
  *  Copyright 2006 Sony Corp.
  */
 
+#include <linux/minmax.h>
+
 #include <asm/lv1call.h>
 
 #include "platform.h"
@@ -74,8 +76,9 @@ static void _dump_node(unsigned int lpar_id, u64 n1, u64 n2, u64 n3, u64 n4,
 static u64 make_first_field(const char *text, u64 index)
 {
 	u64 n = 0;
+	size_t len = min(strlen(text), sizeof(n));
 
-	memcpy((char *)&n, text, strnlen(text, sizeof(n)));
+	memcpy(&n, text, len);
 	return PS3_VENDOR_ID_NONE + (n >> 32) + index;
 }
 

