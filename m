Return-Path: <SRS0=+N6N=S2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3881C10F11
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 15:37:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E587821773
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 15:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="tmS/Zbxu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E587821773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44q4Fs71cVzDqX6
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 01:37:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=efficios.com
 (client-ip=167.114.142.138; helo=mail.efficios.com;
 envelope-from=mathieu.desnoyers@efficios.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=efficios.com header.i=@efficios.com header.b="tmS/Zbxu";
 dkim-atps=neutral
X-Greylist: delayed 549 seconds by postgrey-1.36 at bilbo;
 Thu, 25 Apr 2019 01:35:03 AEST
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44q4Bb3s84zDqSZ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2019 01:35:03 +1000 (AEST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 5393A1D91F4;
 Wed, 24 Apr 2019 11:25:42 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
 by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
 with ESMTP id B8pzYMaloWiC; Wed, 24 Apr 2019 11:25:41 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id AB1DB1D91E6;
 Wed, 24 Apr 2019 11:25:41 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com AB1DB1D91E6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=default; t=1556119541;
 bh=wPddiBdShBppXNiDLwqz7lNkyC8NrgYYgntI0yfX9Z0=;
 h=From:To:Date:Message-Id;
 b=tmS/ZbxuL7ei/mhwDZhmwkI4wjM5IqnIQELAJFcGBGCJvIsB2ZUGG0HGBc4MUFTgp
 /C5XP2TGYWgsxLiidsEDrSec8gaN3sE1VQtmYHOhBL5Ifj9amUtQPLyXhHG/YEgsnP
 VSIcMSwuJuR0a9baitflWCWM9J8+6vNYnWBum3NJCxeTF2NPA7kZTGdQIiIZ899Y7X
 jjGyTQFPuajZpdFsaf13sh61IEPKyS92ytvIMJDVK6m0yuq8FiUhXJotWjuzsjmEBi
 7aKEZVKcxvp9GDxK20eFlxf0ZgJPAKuUxP7MMSTigq+Pq3e1c8LCNzquEKlkKYHIF4
 mOHsQmfOmz91w==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
 by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
 with ESMTP id XgDReCUcN929; Wed, 24 Apr 2019 11:25:41 -0400 (EDT)
Received: from thinkos.internal.efficios.com (192-222-157-41.qc.cable.ebox.net
 [192.222.157.41])
 by mail.efficios.com (Postfix) with ESMTPSA id 31B981D91BE;
 Wed, 24 Apr 2019 11:25:39 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Peter Zijlstra <peterz@infradead.org>,
 "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
 Boqun Feng <boqun.feng@gmail.com>
Subject: [RFC PATCH for 5.2 09/10] rseq/selftests: powerpc code signature:
 generate valid instructions
Date: Wed, 24 Apr 2019 11:25:01 -0400
Message-Id: <20190424152502.14246-10-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190424152502.14246-1-mathieu.desnoyers@efficios.com>
References: <20190424152502.14246-1-mathieu.desnoyers@efficios.com>
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Joel Fernandes <joelaf@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Dave Watson <davejwatson@fb.com>,
 Will Deacon <will.deacon@arm.com>, Andi Kleen <andi@firstfloor.org>,
 Paul Mackerras <paulus@samba.org>, "H . Peter Anvin" <hpa@zytor.com>,
 Chris Lameter <cl@linux.com>, Shuah Khan <shuah@kernel.org>,
 Russell King <linux@arm.linux.org.uk>, Ingo Molnar <mingo@redhat.com>,
 Michael Kerrisk <mtk.manpages@gmail.com>, Paul Turner <pjt@google.com>,
 Alan Modra <amodra@gmail.com>, Josh Triplett <josh@joshtriplett.org>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Maurer <bmaurer@fb.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-api@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Andy Lutomirski <luto@amacapital.net>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Use "twui" as the guard instruction for the restartable sequence abort
handler.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Paul Mackerras <paulus@samba.org>
CC: Michael Ellerman <mpe@ellerman.id.au>
CC: Boqun Feng <boqun.feng@gmail.com>
CC: Peter Zijlstra <peterz@infradead.org>
CC: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
CC: Alan Modra <amodra@gmail.com>
CC: linuxppc-dev@lists.ozlabs.org
---
 tools/testing/selftests/rseq/rseq-ppc.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rseq/rseq-ppc.h b/tools/testing/selftests/rseq/rseq-ppc.h
index 9df18487fa9f..76be90196fe4 100644
--- a/tools/testing/selftests/rseq/rseq-ppc.h
+++ b/tools/testing/selftests/rseq/rseq-ppc.h
@@ -6,7 +6,15 @@
  * (C) Copyright 2016-2018 - Boqun Feng <boqun.feng@gmail.com>
  */
 
-#define RSEQ_SIG	0x53053053
+/*
+ * RSEQ_SIG is used with the following trap instruction:
+ *
+ * powerpc-be:    0f e5 00 0b           twui   r5,11
+ * powerpc64-le:  0b 00 e5 0f           twui   r5,11
+ * powerpc64-be:  0f e5 00 0b           twui   r5,11
+ */
+
+#define RSEQ_SIG	0x0fe5000b
 
 #define rseq_smp_mb()		__asm__ __volatile__ ("sync"	::: "memory", "cc")
 #define rseq_smp_lwsync()	__asm__ __volatile__ ("lwsync"	::: "memory", "cc")
-- 
2.11.0

