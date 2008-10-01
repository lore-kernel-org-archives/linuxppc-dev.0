Return-Path: <mathieu.desnoyers@polymtl.ca>
Message-Id: <20081001160425.577543958@polymtl.ca>
References: <20081001160324.889716972@polymtl.ca>
Date: Wed, 01 Oct 2008 12:03:29 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: [patch 5/5] sputrace : use marker_synchronize_unregister()
Cc: Christoph Hellwig <hch@infradead.org>, linuxppc-dev@ozlabs.org,
	Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
	Jeremy Kerr <jk@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We need a marker_synchronize_unregister() before the end of exit() to make sure
every probe callers have exited the non preemptible section and thus are not
executing the probe code anymore.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
CC: Ingo Molnar <mingo@elte.hu>
CC: Jeremy Kerr <jk@ozlabs.org>
CC: linuxppc-dev@ozlabs.org
CC: Christoph Hellwig <hch@infradead.org>
---
 arch/powerpc/platforms/cell/spufs/sputrace.c |    1 +
 1 file changed, 1 insertion(+)

Index: linux-2.6-lttng/arch/powerpc/platforms/cell/spufs/sputrace.c
===================================================================
--- linux-2.6-lttng.orig/arch/powerpc/platforms/cell/spufs/sputrace.c	2008-07-31 09:34:58.000000000 -0400
+++ linux-2.6-lttng/arch/powerpc/platforms/cell/spufs/sputrace.c	2008-07-31 09:35:15.000000000 -0400
@@ -233,6 +233,7 @@ static void __exit sputrace_exit(void)
 
 	remove_proc_entry("sputrace", NULL);
 	kfree(sputrace_log);
+	marker_synchronize_unregister();
 }
 
 module_init(sputrace_init);

-- 
Mathieu Desnoyers
Computer Engineering Ph.D. Student, Ecole Polytechnique de Montreal
OpenPGP key fingerprint: 8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68
