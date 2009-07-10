Return-Path: <whitebox@nefkom.net>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 623C8B7067
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 11 Jul 2009 07:17:41 +1000 (EST)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 04293DDDF0
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Jul 2009 07:17:39 +1000 (EST)
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id F1D8E1C1581C
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Jul 2009 23:17:37 +0200 (CEST)
Received: from localhost (dynscan2.mnet-online.de [192.168.1.215])
	by mail.m-online.net (Postfix) with ESMTP id EBB46902D0
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Jul 2009 23:17:37 +0200 (CEST)
Received: from mail.mnet-online.de ([192.168.3.149])
	by localhost (dynscan2.mnet-online.de [192.168.1.215]) (amavisd-new,
	port 10024) with ESMTP id G89puIVFCw7c for <linuxppc-dev@ozlabs.org>;
	Fri, 10 Jul 2009 23:17:36 +0200 (CEST)
Received: from igel.home (DSL01.83.171.178.173.ip-pool.NEFkom.net
	[83.171.178.173]) by mail.mnet-online.de (Postfix) with ESMTP
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Jul 2009 23:17:36 +0200 (CEST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Fix another bug in move of altivec code to vector.S
Date: Fri, 10 Jul 2009 23:17:36 +0200
Message-ID: <m2iqi0w83z.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When moving load_up_altivec to vector.S a typo in a comment caused a
thinko setting the wrong variable.

Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
---
diff --git a/arch/powerpc/kernel/vector.S b/arch/powerpc/kernel/vector.S
index ef36cbb..ea4d646 100644
--- a/arch/powerpc/kernel/vector.S
+++ b/arch/powerpc/kernel/vector.S
@@ -80,10 +80,10 @@ _GLOBAL(load_up_altivec)
 	mtvscr	vr0
 	REST_32VRS(0,r4,r5)
 #ifndef CONFIG_SMP
-	/* Update last_task_used_math to 'current' */
+	/* Update last_task_used_altivec to 'current' */
 	subi	r4,r5,THREAD		/* Back to 'current' */
 	fromreal(r4)
-	PPC_STL	r4,ADDROFF(last_task_used_math)(r3)
+	PPC_STL	r4,ADDROFF(last_task_used_altivec)(r3)
 #endif /* CONFIG_SMP */
 	/* restore registers and return */
 	blr
@@ -172,7 +172,7 @@ _GLOBAL(load_up_vsx)
 	oris	r12,r12,MSR_VSX@h
 	std	r12,_MSR(r1)
 #ifndef CONFIG_SMP
-	/* Update last_task_used_math to 'current' */
+	/* Update last_task_used_vsx to 'current' */
 	ld	r4,PACACURRENT(r13)
 	std	r4,0(r3)
 #endif /* CONFIG_SMP */

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
