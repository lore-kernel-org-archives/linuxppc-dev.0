Return-Path: <SRS0=lRG+=MW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D1EC43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 19:31:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82B6520870
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 19:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="mOr5w9Et"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82B6520870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42VkjS5Lk2zDqCB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Oct 2018 06:31:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=efficios.com header.i=@efficios.com header.b="mOr5w9Et";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=efficios.com
 (client-ip=167.114.142.138; helo=mail.efficios.com;
 envelope-from=mathieu.desnoyers@efficios.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=efficios.com header.i=@efficios.com header.b="mOr5w9Et";
 dkim-atps=neutral
X-Greylist: delayed 500 seconds by postgrey-1.36 at bilbo;
 Thu, 11 Oct 2018 06:28:50 AEDT
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Vkfp2jmYzDrq6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Oct 2018 06:28:50 +1100 (AEDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id E368A183BF1;
 Wed, 10 Oct 2018 15:20:13 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
 by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
 with ESMTP id ky2TAVeCcoQl; Wed, 10 Oct 2018 15:20:13 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id F24C4183BDC;
 Wed, 10 Oct 2018 15:20:12 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com F24C4183BDC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=default; t=1539199213;
 bh=gM7Kec0aqOSc74Mk9mz7nq5+r7lpkxUKvOiAtaED5o0=;
 h=From:To:Date:Message-Id;
 b=mOr5w9EtYsUtIRY5FBAiobynq3lzAho2YoIMkPXb/9L/iKKsrbx79jGeSBMFo6TJP
 1LN9j7rW7IxEl5j9zrLIwllt3N1tmbPHEPAK8ZK3kRIMuCLcGr/PstRzZwrIf3G3L2
 4RhdHr4miuVHpTphamsvS20guvpeZa5y+UQcMrV+zyKJAt8isgDs4rv6lnmM374ydt
 v8nT4MZMqzBLachGuezbrHXDgxOGZfYRLrH6Y8oFNWFZx1ieCDTS2qqtbBAeJENW0u
 6bF8XKYAPTedZqOEWA134ilHnNaaPaeuxEqu5wj26Fpio32GmRo+9l4n5LkVvlaRt4
 h4QyvyUIYon8A==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
 by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
 with ESMTP id W84UtxXEPABK; Wed, 10 Oct 2018 15:20:12 -0400 (EDT)
Received: from thinkos.internal.efficios.com (192-222-157-41.qc.cable.ebox.net
 [192.222.157.41])
 by mail.efficios.com (Postfix) with ESMTPSA id 78D02183BC4;
 Wed, 10 Oct 2018 15:20:12 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Peter Zijlstra <peterz@infradead.org>,
 "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
 Boqun Feng <boqun.feng@gmail.com>
Subject: [RFC PATCH for 4.21 09/16] powerpc: Wire up cpu_opv system call
Date: Wed, 10 Oct 2018 15:19:29 -0400
Message-Id: <20181010191936.7495-10-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181010191936.7495-1-mathieu.desnoyers@efficios.com>
References: <20181010191936.7495-1-mathieu.desnoyers@efficios.com>
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

