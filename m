Return-Path: <anton@samba.org>
Date: Wed, 9 Mar 2011 14:38:42 +1100
From: Anton Blanchard <anton@samba.org>
To: paulus@samba.org, a.p.zijlstra@chello.nl, mingo@elte.hu,
	acme@ghostprotocols.net, benh@kernel.crashing.org
Subject: [PATCH] powerpc: perf: Handle events that raise an exception
	without overflowing
Message-ID: <20110309143842.6c22845e@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Events on POWER7 can roll back if a speculative event doesn't
eventually complete. Unfortunately in some rare cases they will
raise a performance monitor exception. We need to catch this to
ensure we reset the PMC. In all cases the PMC will be 256 or less
cycles from overflow.

Signed-off-by: Anton Blanchard <anton@samba.org>
Cc: stable@kernel.org
---

I would prefer not to add the PVR check, but I think we want to limit
this workaround to POWER7. Would a cpu feature be preferable?

Index: linux-2.6/arch/powerpc/kernel/perf_event.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/perf_event.c	2011-03-08 20:11:38.029800971 +1100
+++ linux-2.6/arch/powerpc/kernel/perf_event.c	2011-03-09 14:19:18.756143799 +1100
@@ -1269,6 +1269,28 @@ unsigned long perf_instruction_pointer(s
 	return ip;
 }
 
+static bool pmc_overflow(unsigned long val)
+{
+	if ((int)val < 0)
+		return true;
+
+	/*
+	 * Events on POWER7 can roll back if a speculative event doesn't
+	 * eventually complete. Unfortunately in some rare cases they will
+	 * raise a performance monitor exception. We need to catch this to
+	 * ensure we reset the PMC. In all cases the PMC will be 256 or less
+	 * cycles from overflow.
+	 *
+	 * We only do this if the first pass fails to find any overflowing
+	 * PMCs because a user might set a period of less than 256 and we
+	 * don't want to mistakenly reset them.
+	 */
+	if (__is_processor(PV_POWER7) && ((0x80000000 - val) <= 256))
+		return true;
+
+	return false;
+}
+
 /*
  * Performance monitor interrupt stuff
  */
@@ -1316,7 +1338,7 @@ static void perf_event_interrupt(struct
 			if (is_limited_pmc(i + 1))
 				continue;
 			val = read_pmc(i + 1);
-			if ((int)val < 0)
+			if (pmc_overflow(val))
 				write_pmc(i + 1, 0);
 		}
 	}
Index: linux-2.6/arch/powerpc/include/asm/reg.h
===================================================================
--- linux-2.6.orig/arch/powerpc/include/asm/reg.h	2011-03-08 20:11:38.019800609 +1100
+++ linux-2.6/arch/powerpc/include/asm/reg.h	2011-03-09 14:13:56.674461835 +1100
@@ -880,6 +880,7 @@
 #define PV_970		0x0039
 #define PV_POWER5	0x003A
 #define PV_POWER5p	0x003B
+#define PV_POWER7	0x003F
 #define PV_970FX	0x003C
 #define PV_630		0x0040
 #define PV_630p	0x0041
