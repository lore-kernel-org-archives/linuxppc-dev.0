Return-Path: <SRS0=OEx3=NM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC3CC6786F
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Nov 2018 10:03:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03CC4205F4
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Nov 2018 10:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="LQJsPRvk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03CC4205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42m1423WYZzF3N0
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Nov 2018 21:03:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=efficios.com header.i=@efficios.com header.b="LQJsPRvk";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=efficios.com
 (client-ip=167.114.142.138; helo=mail.efficios.com;
 envelope-from=mathieu.desnoyers@efficios.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=efficios.com header.i=@efficios.com header.b="LQJsPRvk";
 dkim-atps=neutral
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42m10Y1tNZzF3MC
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Nov 2018 21:00:13 +1100 (AEDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 73B6F22771A;
 Thu,  1 Nov 2018 06:00:06 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
 by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
 with ESMTP id U7cbJwXUbdjq; Thu,  1 Nov 2018 06:00:05 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 14C3F227716;
 Thu,  1 Nov 2018 06:00:05 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 14C3F227716
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=default; t=1541066405;
 bh=gM7Kec0aqOSc74Mk9mz7nq5+r7lpkxUKvOiAtaED5o0=;
 h=From:To:Date:Message-Id;
 b=LQJsPRvkx4KNc3y8OvP02BzWos1dzII9+Tkm2bvJX98dTyJtkxN2B1kpUVTGlb4qr
 Wg0JMrv5XMLSvvK0UN7gDFS3qNRZmNChXSQ6JAfII1FoFGa3r+NyNFcaOO2byNsTii
 8Kbxcy5diwscLEAMGtg3Cc7W7zNJh4SaKyGM50rghVJEYL8mXikyWynUx4YPtv8HIL
 sQzATFuvZ1VMf83anB87YZaMHBjNxTHcDCiBI5dY36yF1kJxXqD5gBAftGmG8Q7aJc
 Bh4sOIEsf8maFZtD3YJS+w/pfm3wavjkufO32mJic+k3R+HFs1COpXcjV61hP+diSi
 ekjSAGr3X0RxQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
 by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
 with ESMTP id xJbU_vLP5yGr; Thu,  1 Nov 2018 06:00:04 -0400 (EDT)
Received: from thinkos.etherlink (sessfw99-sesbfw99-92.ericsson.net
 [192.176.1.92])
 by mail.efficios.com (Postfix) with ESMTPSA id DF8B92276B4;
 Thu,  1 Nov 2018 05:59:53 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Peter Zijlstra <peterz@infradead.org>,
 "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
 Boqun Feng <boqun.feng@gmail.com>
Subject: [RFC PATCH for 4.21 09/16] powerpc: Wire up cpu_opv system call
Date: Thu,  1 Nov 2018 10:58:37 +0100
Message-Id: <20181101095844.24462-10-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181101095844.24462-1-mathieu.desnoyers@efficios.com>
References: <20181101095844.24462-1-mathieu.desnoyers@efficios.com>
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
Cc: Joel Fernandes <joelaf@google.com>, Dave Watson <davejwatson@fb.com>,
 Will Deacon <will.deacon@arm.com>, Andi Kleen <andi@firstfloor.org>,
 Paul Mackerras <paulus@samba.org>, "H . Peter Anvin" <hpa@zytor.com>,
 Chris Lameter <cl@linux.com>, Russell King <linux@arm.linux.org.uk>,
 Ingo Molnar <mingo@redhat.com>, Michael Kerrisk <mtk.manpages@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Paul Turner <pjt@google.com>,
 Josh Triplett <josh@joshtriplett.org>, Steven Rostedt <rostedt@goodmis.org>,
 Ben Maurer <bmaurer@fb.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-api@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Andy Lutomirski <luto@amacapital.net>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Paul Mackerras <paulus@samba.org>
CC: Michael Ellerman <mpe@ellerman.id.au>
CC: Boqun Feng <boqun.feng@gmail.com>
CC: Peter Zijlstra <peterz@infradead.org>
CC: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
CC: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/include/asm/systbl.h      | 1 +
 arch/powerpc/include/uapi/asm/unistd.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/powerpc/include/asm/systbl.h b/arch/powerpc/include/asm/systbl.h
index 01b5171ea189..8f58710f5e8b 100644
--- a/arch/powerpc/include/asm/systbl.h
+++ b/arch/powerpc/include/asm/systbl.h
@@ -394,3 +394,4 @@ SYSCALL(pkey_free)
 SYSCALL(pkey_mprotect)
 SYSCALL(rseq)
 COMPAT_SYS(io_pgetevents)
+SYSCALL(cpu_opv)
diff --git a/arch/powerpc/include/uapi/asm/unistd.h b/arch/powerpc/include/uapi/asm/unistd.h
index 985534d0b448..112e2c54750a 100644
--- a/arch/powerpc/include/uapi/asm/unistd.h
+++ b/arch/powerpc/include/uapi/asm/unistd.h
@@ -400,5 +400,6 @@
 #define __NR_pkey_mprotect	386
 #define __NR_rseq		387
 #define __NR_io_pgetevents	388
+#define __NR_cpu_opv		389
 
 #endif /* _UAPI_ASM_POWERPC_UNISTD_H_ */
-- 
2.11.0

