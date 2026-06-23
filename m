Return-Path: <linuxppc-dev+bounces-22931-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E10EBCDB46F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Jun 2026 15:35:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gl8K46Z3mz2yVZ;
	Wed, 24 Jun 2026 01:35:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a11:7980:1::2:0"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782228920;
	cv=none; b=jxDQKTsoh7coZVsPCx45meaF4zMKOLykPDLl2buap8OnnLlYfOtJRAvPnLhTQsvw8xFmns8JWNgqVDRqRqxzCU56wosGjGhX3xqi00pY1P3toORIWQU1d+txKsqTl0+IuOfsXWHAEUDjKIrKrTqGpILZ2l2RaIlyjoQIJ/G3UkmBv0P8gU1TGs9REVqOC61WT6Mo3m6XPCIRLJyvRh5/td4HnVE9Nv/mFDBLE+2DFd5D0HXaQZWa7lYPkDyyZUOf13nGW+RSC7hstNUZ0l6r0uRvN8DLZVwUdvihrnWwhNYcsKXSxy+OrMaU0bVA+eHOMXqT+g8gET4Q0W08OiFssQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782228920; c=relaxed/relaxed;
	bh=yJvoIA1fO2feDg/kwex0Po7ylI4GiWcadD1slikx9OE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XgRgObUHiIu9mClecxItbBhKsVwM6KXQCJSDzFND3JeXVCZ6sKYq8O1OXG53yuV9bn3sBbDeI7jGfs8DCv3jCEe8nBEl1hgURCzQEjbm5cgA7dH87U3AOIHqp4LrkYoi0oaJ60+BjCoJiOGMJpLurDV8C9qvuMcmTbGlEeK6sdqsz+tSMW684OLWs1JUCe7SpQjBQiiZ5uV30/oEAr9MbKF03yJE9Q7YT25ns60DBtu39+kOErszLxhF9o3s/wESYKEfpnqAfADShcK9Jx+5spb6uvVbm5alfAuBhoqLn+ojNZQ9BnETZCcKUXonuewFFdZZkdz5XM5cbuw8QvoUZQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; dkim=pass (1024-bit key; secure) header.d=grrlz.net header.i=@grrlz.net header.a=rsa-sha256 header.s=stigmate header.b=YWQ63Pqr; dkim-atps=neutral; spf=pass (client-ip=2a11:7980:1::2:0; helo=confino.investici.org; envelope-from=include@grrlz.net; receiver=lists.ozlabs.org) smtp.mailfrom=grrlz.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; secure) header.d=grrlz.net header.i=@grrlz.net header.a=rsa-sha256 header.s=stigmate header.b=YWQ63Pqr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=grrlz.net (client-ip=2a11:7980:1::2:0; helo=confino.investici.org; envelope-from=include@grrlz.net; receiver=lists.ozlabs.org)
Received: from confino.investici.org (confino.investici.org [IPv6:2a11:7980:1::2:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gl8K20jl7z2yT0
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jun 2026 01:35:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1782228911;
	bh=yJvoIA1fO2feDg/kwex0Po7ylI4GiWcadD1slikx9OE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YWQ63PqrZA6fHb8qsiiZDoFe8MfB9mrdyJNeNo70YVy2vjDtftfvhU4iMf/0NMZTl
	 Rr6cmR0Pic59edq6R/aHn1RQm+BOmvPs1Yy4a6UpumqBRscME5k1uJj10kJW1t8FDF
	 4E9tmGrDQ8GfP2ptybXd6OHZwo30tkIyAsf+LS+s=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4gl8Jv4hBZz10yw;
	Tue, 23 Jun 2026 15:35:11 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4gl8Jt3GQrz10xZ;
	Tue, 23 Jun 2026 15:35:10 +0000 (UTC)
From: Bradley Morgan <include@grrlz.net>
To: Petr Mladek <pmladek@suse.com>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jinchao Wang <wangjinchao600@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Rio <rioo.tsukatsukii@gmail.com>,
	Joel Granados <joel.granados@kernel.org>,
	Pnina Feder <pnina.feder@mobileye.com>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Douglas Anderson <dianders@chromium.org>,
	Mayank Rungta <mrungta@google.com>,
	Tejun Heo <tj@kernel.org>,
	Zhenguo Yao <yaozhenguo1@gmail.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bradley Morgan <include@grrlz.net>
Subject: [PATCH v2 4/4] panic: avoid duplicate all CPU backtraces from sys_info
Date: Tue, 23 Jun 2026 15:35:01 +0000
Message-ID: <2199a8b4da8700b9f27e61486293e9c26ab107ef.1782228656.git.include@grrlz.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <9b8c96e291696815d3c7de5d3e199298dee0279d.1782228656.git.include@grrlz.net>
References: <9b8c96e291696815d3c7de5d3e199298dee0279d.1782228656.git.include@grrlz.net>
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
Content-Transfer-Encoding: 8bit

panic_other_cpus_shutdown() handles SYS_INFO_ALL_BT before stopping the
other CPUs. Do not ask sys_info() to handle that bit again later in the
panic path.

Use sys_info_without_all_bt() so panic_print=all_bt does not request more
output after the CPUs are stopped.

Fixes: b76e89e50fc3 ("panic: generalize panic_print's function to show sys info")
Cc: stable@vger.kernel.org
Signed-off-by: Bradley Morgan <include@grrlz.net>
---
Changes since v1:
- New patch using the same helper for panic.

 kernel/panic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index d030f88ad4ef..2cf229c7c0cf 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -683,7 +683,7 @@ void vpanic(const char *fmt, va_list args)
 	 */
 	atomic_notifier_call_chain(&panic_notifier_list, 0, buf);
 
-	sys_info(panic_print);
+	sys_info_without_all_bt(panic_print);
 
 	kmsg_dump_desc(KMSG_DUMP_PANIC, buf);
 
-- 
2.53.0

