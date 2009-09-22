Return-Path: <anton@ozlabs.org>
Date: Tue, 22 Sep 2009 12:56:10 +1000
From: Anton Blanchard <anton@samba.org>
To: paulus@samba.org, benh@kernel.crashing.org, a.p.zijlstra@chello.nl,
	mingo@elte.hu
Subject: [PATCH] powerpc/perf_counter: Log invalid data addresses as all 1s
Message-ID: <20090922025610.GE31801@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


When we take an exception and the SDAR isn't synchronised we currently
log 0 as the address. Unfortunately this is a pretty common value, so
use ~OUL instead.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux.trees.git/arch/powerpc/kernel/perf_event.c
===================================================================
--- linux.trees.git.orig/arch/powerpc/kernel/perf_event.c	2009-09-22 11:54:32.000000000 +1000
+++ linux.trees.git/arch/powerpc/kernel/perf_event.c	2009-09-22 11:59:33.000000000 +1000
@@ -1162,7 +1162,7 @@ static void record_and_restart(struct pe
 	 */
 	if (record) {
 		struct perf_sample_data data = {
-			.addr	= 0,
+			.addr	= ~0ULL,
 			.period	= event->hw.last_period,
 		};
 
