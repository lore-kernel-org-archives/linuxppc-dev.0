Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 58FA2DDE35
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 23:01:24 +1000 (EST)
Date: Fri, 19 Oct 2007 08:00:36 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [POWERPC v2] powerpc: Add -mno-spe for ARCH=powerpc builds 
In-Reply-To: <E1IirI4-0004Ch-3P@jdl.com>
Message-ID: <Pine.LNX.4.64.0710190758570.11164@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0710181655270.28684@blarg.am.freescale.net>
	<18199.59909.763111.810973@cargo.ozlabs.ibm.com>
	<12EA14AC-6A3E-4322-9083-0C18996EC227@kernel.crashing.org>
	<E1IirI4-0004Ch-3P@jdl.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Newer GCC's are capable of autovectorization for ISA extensions like
AltiVec and SPE.  If we happen to build with one of those compilers we
will get SPE instructions in random kernel code.  Today we only allow
basic interger code in the kernel and FP, AltiVec, or SPE in special
explicit locations that have handled the proper saving and restoring of
the register state (since on uniprocessor we lazy context switch the
register state for FP, AltiVec, and SPE).

-mno-spe disables the compiler for automatically generating SPE
instructions without our knowledge.

---
Hopefully this is up to Paul's double standard :)

(as normal, its in my git tree, posted here for review).

 arch/powerpc/Makefile |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 4e16534..bd87626 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -107,6 +107,9 @@ endif
 # No AltiVec instruction when building kernel
 KBUILD_CFLAGS += $(call cc-option,-mno-altivec)

+# No SPE instruction when building kernel
+KBUILD_CFLAGS += $(call cc-option,-mno-spe)
+
 # Enable unit-at-a-time mode when possible. It shrinks the
 # kernel considerably.
 KBUILD_CFLAGS += $(call cc-option,-funit-at-a-time)
-- 
1.5.2.4
