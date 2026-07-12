Return-Path: <linuxppc-dev+bounces-24073-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CFB0C43458
	for <linuxppc-dev@archiver.kernel.org>; Sun, 12 Jul 2026 21:25:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gyzBC1fZDz2yll;
	Mon, 13 Jul 2026 07:25:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783891523;
	cv=none; b=Mk2qjcyuu4vwznJv1BNw1893aF/psoi+Ypn6f0vTIrM3KcowJ2gH82OGXNSGY5ik27lI6iZKUffrrW3tlim0j7kvU5IsahlNgIsB8JgMNtu53hWgQ9fALiQXw0KQpClqF79Gg4ARqNF7dIW9plzPpu378/fFv0vu46iktd9aVDcA8HD97xahIh8CBVA+F0HRwXdiuR5PUxIIuKLig/+W24Qkg9FTpGIeOyUQNnEYDAakcRrfoYHBXq5o3ILPU5ng/8pPaB/UnIjHYl6Q3DpqhNhOnmt49Cp+Y10nJxMgWnY6W/laH8jPILb+czVBNgwfTLU5mAto7IZTlZnwPXaXsg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783891523; c=relaxed/relaxed;
	bh=rQWZ8aJgOncbggueFnURmOMnwueR0POClkrjreehrRg=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=MYKPl8QvLiw878D8IYj+wicjdffWq20vv6/smBLT/9AhOSk42rYZaqh3JS+pqWhen7Ux/Z1zzeAhsYLH0kKrS3TtHvejDNS6uX7mnFM0KIPVB8QaCaoUHEvA8K123WHlHwvrzKmSIkekKDp0fJs3K0m4ZrTr9zXIcgkCGiynO+Xwq6d7g9dvz//fwdzczlOIGsDobYW69tWX4lUbrWQj7HVVpKLS2iD4ZOtN5vv4z41lgP3vHSCz4GMBeZlmhFTZyKbbQAzaO40X645VA+GI2HLF4LUrieMagWoA6KEOKH9PRzvhJDd4327NAt8DXuOug1Ws0gOLvRup2COZkdj2eQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MeR46zuk; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MeR46zuk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gyzBB6zl8z2xyj
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2026 07:25:22 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 0E77F600AE;
	Sun, 12 Jul 2026 21:25:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18F6D1F000E9;
	Sun, 12 Jul 2026 21:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783891520;
	bh=rQWZ8aJgOncbggueFnURmOMnwueR0POClkrjreehrRg=;
	h=Date:From:To:Cc:Subject:References;
	b=MeR46zuk5udFu+6sitLOWkIvT2D1oWkOX3LZL64wi0Wue7pZZoj92eYrZyCHwL6re
	 LtNulxNY9Xfv0bKY212BxpjPh6OQuqFHmkUTpzE0rrlt4QxqdZebZE1KDm4nZUEhMp
	 ZsMDsH3MWEuTn7puKH/TLmpD43nwClU5g498mnR/jpAbyFSVn7gqOikHCa1XfLi/OZ
	 AxtODzhSPI53UIID1Fh9XQID2bGnMTk5jyR9XlEl7In4QJRq8W/lVDvsymIMGYh57F
	 hQWVHq+yBg4dJ6sMKRBey0cUbgn5O4cPuwCH4e7tb62pq2ioZJr+suHGx6CzXWo5pw
	 5bSB+97HCh1VA==
Date: Sun, 12 Jul 2026 23:25:17 +0200
Message-ID: <20260712141346.576865340@kernel.org>
User-Agent: quilt/0.69
From: Thomas Gleixner <tglx@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: =?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org,
 Huacai Chen <chenhuacai@kernel.org>,
 loongarch@lists.linux.dev,
 Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 linux-riscv@lists.infradead.org,
 Sven Schnelle <svens@linux.ibm.com>,
 linux-s390@vger.kernel.org,
 x86@kernel.org,
 Mark Rutland <mark.rutland@arm.com>,
 Jinjie Ruan <ruanjinjie@huawei.com>,
 Magnus Lindholm <linmag7@gmail.com>,
 "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Radu Rendec <radu@rendec.net>
Subject: [patch 1/4] entry: Rework syscall_audit_enter()
References: <20260712134433.549076055@kernel.org>
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

Move it out of line and let it reread the syscall number on it's own. That
makes the low level entry code denser and allows to move the reread to the
call site of syscall_trace_enter() once the tracer is fixed up.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
---
 include/linux/entry-common.h  |   14 +++-----------
 kernel/entry/syscall-common.c |   10 ++++++++++
 2 files changed, 13 insertions(+), 11 deletions(-)

--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -60,16 +60,7 @@ static __always_inline bool arch_ptrace_
 
 long trace_syscall_enter(struct pt_regs *regs, long syscall);
 void trace_syscall_exit(struct pt_regs *regs, long ret);
-
-static inline void syscall_enter_audit(struct pt_regs *regs, long syscall)
-{
-	if (unlikely(audit_context())) {
-		unsigned long args[6];
-
-		syscall_get_arguments(current, regs, args);
-		audit_syscall_entry(syscall, args[0], args[1], args[2], args[3]);
-	}
-}
+void syscall_enter_audit(struct pt_regs *regs);
 
 static __always_inline long syscall_trace_enter(struct pt_regs *regs, unsigned long work,
 						long syscall)
@@ -111,7 +102,8 @@ static __always_inline long syscall_trac
 	if (unlikely(work & SYSCALL_WORK_SYSCALL_TRACEPOINT))
 		syscall = trace_syscall_enter(regs, syscall);
 
-	syscall_enter_audit(regs, syscall);
+	if (unlikely(audit_context()))
+		syscall_enter_audit(regs);
 
 	return syscall;
 }
--- a/kernel/entry/syscall-common.c
+++ b/kernel/entry/syscall-common.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include <linux/audit.h>
 #include <linux/entry-common.h>
 
 #define CREATE_TRACE_POINTS
@@ -21,3 +22,12 @@ void trace_syscall_exit(struct pt_regs *
 {
 	trace_sys_exit(regs, ret);
 }
+
+void syscall_enter_audit(struct pt_regs *regs)
+{
+	long syscall = syscall_get_nr(current, regs);
+	unsigned long args[6];
+
+	syscall_get_arguments(current, regs, args);
+	__audit_syscall_entry(syscall, args[0], args[1], args[2], args[3]);
+}


