Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C64606A330
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Nov 2026 20:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bA6Yc7y7
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jT0Gm288wz2xwP;
	Tue, 17 Nov 2026 07:44:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794861888;
	cv=none; b=TRjY1ARZFW7Zn8KssJUt6BlKnLfxHuc0xe9eYThrl6v4AVjfY/pMlMTAgjgEagk2b+hnfKTf+/qG+kmIvNbWpRXavSOxtADFkYvzy/4Yd4T1c31h5+r0go1rSqvi/GdsDPum26JXhqrM0GVgOUWuK8LuFYigxQd+vj4buiCTSiKkxbubsAJ0MgfPAgZxDt6w7WWHgYLR2Gcup9fl8I6F5UWeNyaB0M+F7JOyPl/mOdk8IBqY5zWu4SMtlBS2Uh/Vhly9HES+9EmT0TM8oM7+XkRxXS6+np3girICWWpfeieK7PNdtqDJQTn6m8ueE9qkWtKzMg5k1J0yu36zrxLbGw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794861888; c=relaxed/relaxed;
	bh=/extzcJil/STyxo/f0U+n9eeeyv6WwXbxkpnizZU2uQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DH7YF0rNDd3rl9iYguAuinib6dj2LNTrqUisJ7oGJTHW4jB57E5+87c/Wde3blfgUvrdUV52/hQFX43INxw7SIZDXF8ZFG0X4ciHorilUsUE0wHf6p6hB4CrfLxsr9/u73ExJvQ1YsfvlkQEnDNUc0aC7mnDcsURhbqP2HYx7wS3Kd8rKbt10KOQB5PxSBTEiNqL2n13+3iy4pRF9gqYI9g7jshn1jwoijRmAzZizQNt+mq96KhlEEuxRlkw9g6KPOjXc1B8vH5avRriFzusaDvZ7FOa1Er4+BFVcQ8/vDqe0dURgpV4b60NJkzgzss9ZnUVC/R2wJUs/WjerpsyuA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bA6Yc7y7; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=blum@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bA6Yc7y7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=blum@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jT0Gl555Zz2xjM
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2026 07:44:47 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D4E0642B6D;
	Mon, 16 Nov 2026 20:44:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A92931F000C4;
	Mon, 16 Nov 2026 20:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794861885;
	bh=/extzcJil/STyxo/f0U+n9eeeyv6WwXbxkpnizZU2uQ=;
	h=From:To:Cc:Subject:Date;
	b=bA6Yc7y7BhGrYXL3P25bUMES9tRYeOsevxR5glZe2N+ao03qwnTlnza1CwSKWLcTg
	 NLgxzty+FZ/rtmm71D7gR9ptnoNPpPdlylSJd1QhD5q8s6E9jeNH1A6NliGv4sM6Rk
	 aeKhXcuVaXUaLGtxP/r4ezQ3/5Pb/O9wML7vICoOasQ+Acy/OwyQmSkYGdgh6dsaEH
	 2VjJG1dmlyEWmK9oZjdiGEp2NZmhaL4N3/ky2V8jrhO8Po6+RrUGmAcyRZnA7F9ZE2
	 1oTdQ3gAKFRUOl2RzH8gqFp4JzvEPJENkH7tcOxLx3MAMAKZ5/cOaBTw7ZMyXD4iFC
	 LxsMc0QA9DG6A==
From: Thorsten Blum <blum@kernel.org>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Thorsten Blum <blum@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/boot: Use the compiler's stdbool.h
Date: Mon, 16 Nov 2026 21:44:29 +0100
Message-ID: <20261116204433.420205-2-blum@kernel.org>
X-Mailer: git-send-email 2.56.1
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1775; i=blum@kernel.org; h=from:subject; bh=edu57q4XW/8e+HLck/8OCAPfW7bMbwmob20ECUxpF4M=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFm/sw1XfzobdUaYU6Br22zRhtxMwRLViblrC6cf/CMkL cxx5dO6jlIWBjEuBlkxRZYHs37M8C2tqdxkErETZg4rE8gQBi5OAZgIPw/DfydBOf2snG9c7J2d yveecD70X5Lx8d29Kce8ruuk5Nky3GFkOP3uXpT2iw0GUhda7su+yCopkDU0C+F6Y3Xtxt3Du1Q S+AA=
X-Developer-Key: i=blum@kernel.org; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Commit c762c69e106f ("powerpc/boot: Add support for XZ compression")
added custom boolean definitions to types.h and a local stdbool.h that
only includes types.h.

However, the boot wrapper already adds the compiler's header directory
to the include path. Remove the local header and the custom boolean
definitions so the existing include in types.h uses the compiler's
stdbool.h instead.

This changes bool from int to _Bool and its size from 4 bytes to 1 byte.

Signed-off-by: Thorsten Blum <blum@kernel.org>
---
This patch applies on top of:
https://lore.kernel.org/r/20260828130622.576064-3-blum@kernel.org/

 arch/powerpc/boot/stdbool.h | 9 ---------
 arch/powerpc/boot/types.h   | 9 ---------
 2 files changed, 18 deletions(-)
 delete mode 100644 arch/powerpc/boot/stdbool.h

diff --git a/arch/powerpc/boot/stdbool.h b/arch/powerpc/boot/stdbool.h
deleted file mode 100644
index 2dfe247ede80..000000000000
--- a/arch/powerpc/boot/stdbool.h
+++ /dev/null
@@ -1,9 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Copyright (C) IBM Corporation 2016.
- *
- * This file is only necessary because some of the pre-boot decompressors
- * expect stdbool.h to be available.
- */
-
-#include "types.h"
diff --git a/arch/powerpc/boot/types.h b/arch/powerpc/boot/types.h
index c5085c2632bf..08529138c524 100644
--- a/arch/powerpc/boot/types.h
+++ b/arch/powerpc/boot/types.h
@@ -37,13 +37,4 @@ typedef s64 int64_t;
 	(void) (&_x == &_y);	\
 	_x > _y ? _x : _y; })
 
-typedef int bool;
-
-#ifndef true
-#define true 1
-#endif
-
-#ifndef false
-#define false 0
-#endif
 #endif /* _TYPES_H_ */

base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
prerequisite-patch-id: 068c3f1381513a18034f0a88224c0bf37db8cfa3

