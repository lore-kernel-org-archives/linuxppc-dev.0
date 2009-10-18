Return-Path: <anton@ozlabs.org>
Date: Sun, 18 Oct 2009 22:24:06 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org
Subject: [PATCH 2/3] powerpc: perf_event: Cleanup output by adding symbols
Message-ID: <20091018112406.GO4808@kryten>
References: <20091018112328.GN4808@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20091018112328.GN4808@kryten>
Cc: linuxppc-dev@ozlabs.org, mingo@elte.hu, paulus@samba.org,
	a.p.zijlstra@chello.nl
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Add some dummy symbols for the branches at 0xf00, 0xf20 and 0xf40,
otherwise hits end up in trap_0e which is confusing to the user.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux.trees.git/arch/powerpc/kernel/exceptions-64s.S
===================================================================
--- linux.trees.git.orig/arch/powerpc/kernel/exceptions-64s.S	2009-07-06 10:13:56.000000000 +1000
+++ linux.trees.git/arch/powerpc/kernel/exceptions-64s.S	2009-07-06 10:13:57.000000000 +1000
@@ -185,12 +185,15 @@
 	 * prolog code of the PerformanceMonitor one. A little
 	 * trickery is thus necessary
 	 */
+performance_monitor_pSeries_1:
 	. = 0xf00
 	b	performance_monitor_pSeries
 
+altivec_unavailable_pSeries_1:
 	. = 0xf20
 	b	altivec_unavailable_pSeries
 
+vsx_unavailable_pSeries_1:
 	. = 0xf40
 	b	vsx_unavailable_pSeries
 
