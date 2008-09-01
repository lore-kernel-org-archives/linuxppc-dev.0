Return-Path: <bigeasy@www.tglx.de>
Received: from www.tglx.de (www.tglx.de [62.245.132.106])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4DA7DDDE08
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Sep 2008 00:23:12 +1000 (EST)
Date: Mon, 1 Sep 2008 16:23:02 +0200
From: Sebastian Siewior <bigeasy@linutronix.de>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH] powerpc: enforce a non-spe kernel build even on broken
	compilers
Message-ID: <20080901142302.GA13754@www.tglx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Cc: linuxppc-dev@ozlabs.org, ths@linutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Thiemo Seufer <ths@linutronix.de>

those two are requried on my fresh gcc 4.3.1

Signed-off-by: Thiemo Seufer <ths@linutronix.de>
Signed-off-by: Sebastian Siewior <bigeasy@linutronix.de>
---
Not sure if this is intendent or a gcc bug but with -mno-spe
the spe opcodes were not used floating point anymore but
for 64bit save/restore for instance.

 arch/powerpc/Makefile |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index b7d4c4c..3727e4f 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -108,7 +108,10 @@ endif
 KBUILD_CFLAGS += $(call cc-option,-mno-altivec)
 
 # No SPE instruction when building kernel
+# (We use all available options to help semi-broken compilers)
 KBUILD_CFLAGS += $(call cc-option,-mno-spe)
+KBUILD_CFLAGS += $(call cc-option,-mspe=no)
+KBUILD_CFLAGS += $(call cc-option,-mabi=no-spe)
 
 # Enable unit-at-a-time mode when possible. It shrinks the
 # kernel considerably.
-- 
1.5.6.5
