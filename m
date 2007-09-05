Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B89F6DEA7A
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Sep 2007 05:28:09 +1000 (EST)
Date: Wed, 5 Sep 2007 14:28:00 -0500
From: Scott Wood <scottwood@freescale.com>
To: galak@kernel.crashing.org
Subject: [PATCH 5/9] 8xx: Don't call non-existent Soft_emulate_8xx from
	SoftwareEmulation.
Message-ID: <20070905192800.GD32398@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070905192727.GA32365@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
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

As:
1. soft-float toolchains are now common,
2. partial emulation could mislead someone into thinking they have
a soft-float userspace because things usually work, only to have it
fail when actual FP gets executed under unusual circumstances, and
3. full emulation is still available for those who need to run
non-soft-float userspace,

I'm deleting the call rather than moving Soft_emulate_8xx over to
arch/powerpc.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/kernel/traps.c |   16 +++-------------
 1 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index d8502e3..28ac64c 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -911,9 +911,10 @@ void performance_monitor_exception(struct pt_regs *regs)
 #ifdef CONFIG_8xx
 void SoftwareEmulation(struct pt_regs *regs)
 {
+#ifdef CONFIG_MATH_EMULATION
 	extern int do_mathemu(struct pt_regs *);
-	extern int Soft_emulate_8xx(struct pt_regs *);
 	int errcode;
+#endif
 
 	CHECK_FULL_REGS(regs);
 
@@ -944,18 +945,7 @@ void SoftwareEmulation(struct pt_regs *regs)
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
1.5.3
