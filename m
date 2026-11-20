Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E1460A2624
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Nov 2026 17:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=XaH2XKGU
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jWMmX5Pnhz2yQl;
	Sat, 21 Nov 2026 04:30:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.45
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795195820;
	cv=none; b=GwYSE+JGE3kOeGPDfhwFdqxsZiTNzKHWZnEogtTwt5ctkyxUwyslF882GTF4YQK83EeB2nPMeOUFkHx2cizomqwgLaZ3XXzy0fYmt6xAuMnmVeHI6qBPlRF39gqSJ1Yl0N/nsXkYiqEu2sTTRuqpwAZj9fVDsXaF8vZWU5hMKMM5PvamT4ddRTT/ljc3ni3z45mIHG2kDs/h5zDnJXQ5R59vls3kKPP0mSaLLeORJuMq1HhySvQJwViPxpFND7SiM1oh/lH3IetyKNtFi0paGvxEXuZ1NUMHvtewORtusOP+bPiZSqYldIS7QLzDsKsZE1aMGWu5wTs2w1gmd6BuQg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795195820; c=relaxed/relaxed;
	bh=UufVZfwgbCp92kFZnwng07BVnO7E58HSMy79wKEDlQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=daaS5iLq1JAU4qi3q0uuee0uaMZ5Q+ucBnnr8RUG7AFfNay4IaWc4jJfT/wHtouQE1S7N3rbldTzGmcmJbA12BQGyO5bjMDCkSzMf5xLFAXpAZ7WoD+tt8gGUmq4vmcGb3uiG3/KyyLAZvp8l+m4CCLXeU706GQM/XrtO4LtCgRcjd3OX/IEXiWfOUPwiRPs0Rk2xkOh8cSfU9fjeNH6xEEq0+CPLKWg533N1KtKSrE7lBMACT1R1Sm1rlSLBx/lS8UB4VVt/wCFxiFF3DpWjmPeM0R8ShkJjbhJWiyyetLNl9SKMvJOL/r/PM7lmDpgt+WrsUyKuIUNjSejNRQ0jQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=XaH2XKGU; dkim-atps=neutral; spf=pass (client-ip=95.215.58.45; helo=mta1.migadu.com; envelope-from=bradley.morgan@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=XaH2XKGU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.45; helo=mta1.migadu.com; envelope-from=bradley.morgan@linux.dev; receiver=lists.ozlabs.org)
Received: from mta1.migadu.com (out-45.mta1.migadu.com [95.215.58.45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jWMmT3yQWz2xqJ
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Nov 2026 04:30:17 +1100 (AEDT)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=nCbmDgNV7wby3LpZePh1npWx21ru0gynBSaNnpEAK/w=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795195798; v=1; x=1795800598;
 b=XaH2XKGUfbfslLCrh/VW4GNjswwMdzZlfBaS8casedBelYBruue+ZxhTqBTPvwoSZv++t6lK
 5rx/0kd1PqeAjf0MhoIQw0XuV5DL3y2yKeWUS3lTW5aq/PNznVmUC8riS/ub0sMpvztwsuqWX7u
 AsJSfGUn9FWlMu8DixMobTwE=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by mta10.migadu.com with ESMTPS id cd7cd70153efb88e;
	Fri, 20 Nov 2026 17:29:58 +0000
X-Mizu-Trace-ID: cd7cd70153efb88e
X-Migadu-Flow: FLOW_OUT
From: Bradley Morgan <bradley.morgan@linux.dev>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>
Cc: Ritesh Harjani <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bradley Morgan <bradley.morgan@linux.dev>
Subject: [PATCH 2/2] powerpc/64: Set r3 to physical CPU ID before kexec_wait on !SMP
Date: Fri, 20 Nov 2026 17:29:49 +0000
Message-ID: <20261120172949.3494131-3-bradley.morgan@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261120172949.3494131-1-bradley.morgan@linux.dev>
References: <20261120172949.3494131-1-bradley.morgan@linux.dev>
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
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In generic_secondary_common_init(), secondary processors on
non SMP kernels branch directly to kexec_wait without copying
their physical CPU ID from r24 into r3.

kexec_wait() assumes r3 contains the physical CPU ID and
passes it along to __secondary_hold at 0x60 once the next
kernel starts. This is bad because secondary processors end up
acknowledging the next kernel with garbage, which can hang
the boot or report the wrong CPU number.

To fix this, copy r24 into r3 before branching to kexec_wait,
matching what the PACA lookup failure path already does.

Fixes: 768d18ad6d5e ("powerpc: Don't search for paca in freed memory")
Cc: stable@vger.kernel.org
Signed-off-by: Bradley Morgan <bradley.morgan@linux.dev>
---
 arch/powerpc/kernel/head_64.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index 0077ce148a5a6..6219f474d00bd 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -401,6 +401,7 @@ generic_secondary_common_init:
 	 * which logical id maps to our physical one.
 	 */
 #ifndef CONFIG_SMP
+	mr	r3,r24
 	b	kexec_wait		/* wait for next kernel if !SMP	 */
 #else
 	LOAD_REG_ADDR(r8, paca_ptrs)	/* Load paca_ptrs pointe	 */
-- 
2.53.0


