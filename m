Return-Path: <anton@ozlabs.org>
Date: Wed, 10 Feb 2010 22:10:25 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org
Subject: [PATCH 6/6] powerpc: Use lwsync for acquire barrier if CPU supports it
Message-ID: <20100210111025.GF3399@kryten>
References: <20100210105728.GA3399@kryten> <20100210110236.GB3399@kryten>
	<20100210110306.GC3399@kryten> <20100210110406.GD3399@kryten>
	<20100210110719.GE3399@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100210110719.GE3399@kryten>
Cc: npiggin@suse.de, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Nick Piggin discovered that lwsync barriers around locks were faster than isync
on 970. That was a long time ago and I completely dropped the ball in testing
his patches across other ppc64 processors.

Turns out the idea helps on other chips. Using a microbenchmark that
uses a lot of threads to contend on a global pthread mutex (and therefore a
global futex), POWER6 improves 8% and POWER7 improves 2%. I checked POWER5
and while I couldn't measure an improvement, there was no regression.

This patch uses the lwsync patching code to replace the isyncs with lwsyncs
on CPUs that support the instruction. We were marking POWER3 and RS64 as lwsync
capable but in reality they treat it as a full sync (ie slow). Remove the
CPU_FTR_LWSYNC bit from these CPUs so they continue to use the faster isync
method.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: powerpc.git/arch/powerpc/include/asm/synch.h
===================================================================
--- powerpc.git.orig/arch/powerpc/include/asm/synch.h	2010-02-10 17:16:44.666823141 +1100
+++ powerpc.git/arch/powerpc/include/asm/synch.h	2010-02-10 17:16:45.123073249 +1100
@@ -37,7 +37,11 @@ static inline void isync(void)
 #endif
 
 #ifdef CONFIG_SMP
-#define PPC_ACQUIRE_BARRIER	"\n\tisync\n"
+#define __PPC_ACQUIRE_BARRIER				\
+	START_LWSYNC_SECTION(97);			\
+	isync;						\
+	MAKE_LWSYNC_SECTION_ENTRY(97, __lwsync_fixup);
+#define PPC_ACQUIRE_BARRIER	"\n" stringify_in_c(__PPC_ACQUIRE_BARRIER)
 #define PPC_RELEASE_BARRIER	stringify_in_c(LWSYNC) "\n"
 #else
 #define PPC_ACQUIRE_BARRIER
Index: powerpc.git/arch/powerpc/include/asm/cputable.h
===================================================================
--- powerpc.git.orig/arch/powerpc/include/asm/cputable.h	2010-02-10 17:15:59.816823326 +1100
+++ powerpc.git/arch/powerpc/include/asm/cputable.h	2010-02-10 17:16:45.123073249 +1100
@@ -381,9 +381,9 @@ extern const char *powerpc_base_platform
 #define CPU_FTRS_GENERIC_32	(CPU_FTR_COMMON | CPU_FTR_NODSISRALIGN)
 
 /* 64-bit CPUs */
-#define CPU_FTRS_POWER3	(CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
+#define CPU_FTRS_POWER3	(CPU_FTR_USE_TB | \
 	    CPU_FTR_IABR | CPU_FTR_PPC_LE)
-#define CPU_FTRS_RS64	(CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
+#define CPU_FTRS_RS64	(CPU_FTR_USE_TB | \
 	    CPU_FTR_IABR | \
 	    CPU_FTR_MMCRA | CPU_FTR_CTRL)
 #define CPU_FTRS_POWER4	(CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
