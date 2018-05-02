Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40bbfW6nG4zF2ST
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 May 2018 21:29:55 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: rostedt@goodmis.org,
	mingo@redhat.com
Cc: linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
Subject: [PATCH] tracing: Remove PPC32 wart from config TRACING_SUPPORT
Date: Wed,  2 May 2018 21:29:48 +1000
Message-Id: <20180502112948.1747-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

config TRACING_SUPPORT has an exception for PPC32, because PPC32
didn't have irqflags tracing support.

But that hasn't been true since commit 5d38902c4838 ("powerpc: Add
irqtrace support for 32-bit powerpc") (Jun 2009).

So remove the exception for PPC32 and the comment.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 kernel/trace/Kconfig | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index c4f0f2e4126e..dd6c0a2ad969 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -110,11 +110,7 @@ config GENERIC_TRACER
 #
 config TRACING_SUPPORT
 	bool
-	# PPC32 has no irqflags tracing support, but it can use most of the
-	# tracers anyway, they were tested to build and work. Note that new
-	# exceptions to this list aren't welcomed, better implement the
-	# irqflags tracing for your architecture.
-	depends on TRACE_IRQFLAGS_SUPPORT || PPC32
+	depends on TRACE_IRQFLAGS_SUPPORT
 	depends on STACKTRACE_SUPPORT
 	default y
 
-- 
2.14.1
