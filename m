Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EF410DDF45
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 11:33:09 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l6I1X4q2018466
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 18:33:04 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.83.16.18])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l6I1X3fr001161
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:33:04 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l6I18M6i007829
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:08:23 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id 13B7EAEFC9
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:33:03 -0500 (CDT)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l6I1X2Sj015263
	for linuxppc-dev@ozlabs.org; Tue, 17 Jul 2007 20:33:02 -0500
Date: Tue, 17 Jul 2007 20:33:02 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 06/61] 8xx: Don't call non-existent Soft_emulate_8xx from
	SoftwareEmulation.
Message-ID: <20070718013302.GE15238@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070718013137.GA15217@ld0162-tx32.am.freescale.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On arch/ppc, Soft_emulate_8xx was used when full math emulation was
turned off to emulate a minimal subset of floating point load/store
instructions, to avoid needing a soft-float toolchain.  This function
is called, but not present, on arch/powerpc, causing a build error
if floating point emulation is turned off.

As soft-float toolchains are now common, I'm deleting the call rather
than moving Soft_emulate_8xx over to arch/powerpc.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/kernel/traps.c |   16 +++-------------
 1 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index bf6445a..312fb67 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -912,9 +912,10 @@ void performance_monitor_exception(struct pt_regs *regs)
 #ifdef CONFIG_8xx
 void SoftwareEmulation(struct pt_regs *regs)
 {
+#ifdef CONFIG_MATH_EMULATION
 	extern int do_mathemu(struct pt_regs *);
-	extern int Soft_emulate_8xx(struct pt_regs *);
 	int errcode;
+#endif
 
 	CHECK_FULL_REGS(regs);
 
@@ -945,18 +946,7 @@ void SoftwareEmulation(struct pt_regs *regs)
 	}
 
 #else
-	errcode = Soft_emulate_8xx(regs);
-	switch (errcode) {
-	case 0:
-		emulate_single_step(regs);
-		return;
-	case 1:
-		_exception(SIGILL, regs, ILL_ILLOPC, regs->nip);
-		return;
-	case -EFAULT:
-		_exception(SIGSEGV, regs, SEGV_MAPERR, regs->nip);
-		return;
-	}
+	_exception(SIGILL, regs, ILL_ILLOPC, regs->nip);
 #endif
 }
 #endif /* CONFIG_8xx */
-- 
1.5.0.3
