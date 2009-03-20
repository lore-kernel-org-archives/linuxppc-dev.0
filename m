Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 1CA07DDEE2
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Mar 2009 02:09:17 +1100 (EST)
Date: Fri, 20 Mar 2009 18:09:14 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Steven Rostedt <srostedt@redhat.com>, Ingo Molnar <mingo@elte.hu>
Subject: [PATCH] tracing: Fix TRACING_SUPPORT dependency
Message-ID: <20090320150914.GA22769@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

commit 40ada30f9621fbd831ac2437b9a2a399aad34b00 ("tracing: clean up
menu"), despite the "clean up" in its purpose, introduced behavioural
change for Kconfig symbols: we no longer able to select tracing
support on PPC32 (because IRQFLAGS_SUPPORT isn't yet implemented).

The IRQFLAGS_SUPPORT is not mandatory for most tracers, tracing core
has a special case for platforms w/o irqflags (which, by the way, has
become useless as of the commit above).

This patch restores the old behaviour, and thus brings the tracing
back on PPC32.

p.s.
The IRQSOFF_TRACER (which is the only tracer that requires IRQFLAGS
support) still depends on TRACE_IRQFLAGS_SUPPORT Kconfig symbol.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 kernel/trace/Kconfig |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index ee70841..774aba7 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -63,7 +63,6 @@ config TRACING
 #
 config TRACING_SUPPORT
 	bool
-	depends on TRACE_IRQFLAGS_SUPPORT
 	depends on STACKTRACE_SUPPORT
 	default y
 
-- 
1.5.6.5
