Return-Path: <linuxppc-dev+bounces-21464-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17392CD5BBF
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 May 2026 09:19:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gP9Lw34tmz2xnK;
	Mon, 25 May 2026 19:19:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=91.218.175.171
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779700776;
	cv=none; b=WIxo24aui2K7gyhkORZUPVRskBs5gGsGyin6AsTSkVkJlsaubql19c2Iz7G4kZk+GetHVnehMcRai4IK5yOeRsR4UzOZLc1BhXyH+Mh3kAtS1LKw6CNtoJMNZCc+bTCzNh8C4WedG20XW7FRrOMIQHTGTNzvqL9hGbPMBPPdNB4aIk+iv0+Rlq7CXzhOYX6MR8f5w4+micxw5INDMtlJLgE+s13jRiBLJFnO9mr0vEGyqn5numLPw1WrPMAJN+QsY5BwgZ4EveL3K/Em57L7+3n0qKBlPFygrlWluiSMruWZUxvC7ddRDMTj/KqSOkmffp+4qKmVfqn60Ui8uQ4yPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779700776; c=relaxed/relaxed;
	bh=VrOW/I0AhnH98RpVRFWb314iNXmV5hytIroWWKpv2so=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jx6/pv38ul0m4CjLER6qv2N6Z5wRKvdLGAHpjwU2QmmJDw7K4VyKZTjFfZV8Barsm1R1N2Q0Yb9IBmYjq91LxXZ0eHKgzGqFr7fBlWXP5Z2FkzAG3H5vjhgPSNL7j91Xrt36bE1LrB6jNpqe12qCg45wm8WTl3Hv/KkYq2wGHbglNZcrbInGfd28YWXkVfgWqM0fgJf81qePqrZqhhZ9L3Z2o7zKlSwzj/Z8oWaUTzVw6nmU6AHssvTDeNcTuD0kdwFqr7lRCIVNeiYyxgomxvY4g0POumO/dp8lPh2d2XtGfWJyMNB/IENl3MwBbvv30NQJX5lNTS5uroLhIwWDew==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Nov3CBo5; dkim-atps=neutral; spf=pass (client-ip=91.218.175.171; helo=out-171.mta0.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Nov3CBo5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=91.218.175.171; helo=out-171.mta0.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org)
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gP9Ls4mhLz2xYg
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 May 2026 19:19:31 +1000 (AEST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779700752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VrOW/I0AhnH98RpVRFWb314iNXmV5hytIroWWKpv2so=;
	b=Nov3CBo5ZL4DGpFXKFhALDSqH4W2gYoyfnZYGyO+8AP9bWqTgrGnQrsdyIgjERCnj3dXRy
	N3Y+6be52L0rIGkyNkZ2Jb1ac/0n1uNgocfkPNterm/fJREIBlaiAHAin6btCRETle1PM7
	efufVOPViP/Eux1JEMFDsdoOv+mKtvI=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/boot: remove unused min_t/max_t macros
Date: Mon, 25 May 2026 11:18:39 +0200
Message-ID: <20260525091839.817778-3-thorsten.blum@linux.dev>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=642; i=thorsten.blum@linux.dev; h=from:subject; bh=bYTr7dMFvw0f5ETNnXjiH8BkSD8Vt3/LaGhBaWmrUK4=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFkiwu9Pqax9/0/oGPOaU9MDe0ynaL2QC85n7dPo2pg4j +n5Vz6RjlIWBjEuBlkxRZYHs37M8C2tqdxkErETZg4rE8gQBi5OAZiI0mtGht3LmmK+bnJyDdhS +WDTtKM3jr+O1Ns7YfYcD5f0xF2RfMsZGdqzlofJ/xDqfPUs65P+44fv7juXHn14evXh3fob7f+ HbuEDAA==
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The min_t() and max_t() macros are no longer used by the boot wrapper,
remove them.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
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

