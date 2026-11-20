Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED10860A260E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Nov 2026 17:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=vvqzDiTq
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jWMp150t6z2xqJ;
	Sat, 21 Nov 2026 04:31:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::5f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795195897;
	cv=none; b=QsAc9JmUTiYelxmCmJ8AjhtVufFCPuJjf75VQMdq8FKX/nqCH8ung5m55DTTZvtis1jxYy4fUAnAy8WTMcK21YNb82W9usZhAGcsvxd6sEhvqlpXtcdiAV/ygq5RCohrpw9WM6klwvtbM++Dob1hEDzMnJR7oHrvoccttG2u2ahsz10MxoPXUnwzzKuV+XDdTDCaU/yDwAdCGKxSSzm0xLRVH6DmyLqKUNIALYIG+dGOC3i7wH/OYwCAojj9xR6+ceRSvO4e33cRJrPHJHYE6TAkikxug3Qi3nB482s+VJQxavMiNTHUk8oNOu4hxc+D3fNiX5oNoIbpXv8zsmO7Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795195897; c=relaxed/relaxed;
	bh=oW/PveCuQ5JM7ohOUMNi3qcUSCoWuYEn+oLybhF/xoA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CjHsZlNGG36TDAIBJtGnocZ0S18zdW8ud5P6+4klUjTvfJDcu9Zm/sW41E60+BSkk6YngXC2rAlTSHJree5qexSLpqnbqG8UzFqIulFOrndhIt32a23q4aV83Zle1JGN6eydlxZIBsnVMBHLK0shzfUAeYkeqs3lIroWNxEv3E9MIDxWC2XvacykKb1xrSc4nWrLNPyIszbV471iO/4uxDHDEI+ajv8EZujeTC2qRTFQf7YKs+hmtfgL9MzZ/TXaI0W6HhwPbj4uTmuvCOgjIaVKxYQcHQjMuO9Q2Ox8Muo2fH9Mj+Z4381WJ5awK40fGelVVU6sk9Skm4j/rpWspg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=vvqzDiTq; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::5f; helo=mta0.migadu.com; envelope-from=bradley.morgan@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=vvqzDiTq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::5f; helo=mta0.migadu.com; envelope-from=bradley.morgan@linux.dev; receiver=lists.ozlabs.org)
X-Greylist: delayed 78 seconds by postgrey-1.37 at boromir; Sat, 21 Nov 2026 04:31:36 AEDT
Received: from mta0.migadu.com (out-95.mta0.migadu.com [IPv6:2001:41d0:1004:224b::5f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jWMp05KXKz2xpt
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Nov 2026 04:31:36 +1100 (AEDT)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=/HPVnKLrKCABmIOGSs3z7lVqaFWbyhWILXjO2++VUa4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795195878; v=1; x=1795800678;
 b=vvqzDiTq7rRR0ZXdI7nJ7/QQb6lRfuUry9YUY0hHr2Na4PrlGXH530/NH2D57O4d0t7eoB5a
 tXGovdlgn6NXMZfmaJUqmvFC9yLSI/RxGJhCuQwAkXesO45pJ04GhfTOjv4DMAHAGHuq8O3Ctsc
 SLbgMfXvncofdS7JYE2rlqE8=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by mta10.migadu.com with ESMTPS id 8733609d355f8002;
	Fri, 20 Nov 2026 17:29:54 +0000
X-Mizu-Trace-ID: 8733609d355f8002
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
Subject: [PATCH 0/2] powerpc/64: Fix some snafus in head_64.S
Date: Fri, 20 Nov 2026 17:29:47 +0000
Message-ID: <20261120172949.3494131-1-bradley.morgan@linux.dev>
X-Mailer: git-send-email 2.53.0
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

While reading through head_64.S, I noticed two bugs in early
secondary processor startup.

The first patch fixes a register mismatch on Book3E where the
secondary thread entry point was loaded into r5 instead of r4
when thread switching is required, which jumps to data and
traps immediately.

The second patch fixes non SMP kernels where secondary processors
jump to kexec_wait without copying their physical CPU ID into r3,
leaving the next kernel with garbage during kexec.

Tested on ppc64.

Bradley Morgan (2):
  powerpc/64e: Pass entry point in r4 to book3e_start_thread()
  powerpc/64: Set r3 to physical CPU ID before kexec_wait on !SMP

 arch/powerpc/kernel/head_64.S | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.53.0


