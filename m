Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2F760B7C59
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Feb 2010 11:04:51 +1100 (EST)
Date: Thu, 25 Feb 2010 18:04:33 -0600
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/2] perf_event: Build callchain code regardless of
	hardware event support.
Message-ID: <20100226000433.GA17033@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It's also useful for software events, as well as future support for
other types of hardware counters.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/kernel/Makefile |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index c002b04..93fd162 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -98,7 +98,8 @@ obj64-$(CONFIG_AUDIT)		+= compat_audit.o
 
 obj-$(CONFIG_DYNAMIC_FTRACE)	+= ftrace.o
 obj-$(CONFIG_FUNCTION_GRAPH_TRACER)	+= ftrace.o
-obj-$(CONFIG_PPC_PERF_CTRS)	+= perf_event.o perf_callchain.o
+obj-$(CONFIG_PERF_EVENTS)	+= perf_callchain.o
+obj-$(CONFIG_PPC_PERF_CTRS)	+= perf_event.o
 obj64-$(CONFIG_PPC_PERF_CTRS)	+= power4-pmu.o ppc970-pmu.o power5-pmu.o \
 				   power5+-pmu.o power6-pmu.o power7-pmu.o
 obj32-$(CONFIG_PPC_PERF_CTRS)	+= mpc7450-pmu.o
-- 
1.6.4.4
