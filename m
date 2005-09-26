Return-Path: <rolandd@cisco.com>
Received: from ams-iport-1.cisco.com (ams-iport-1.cisco.com [144.254.224.140])
	by ozlabs.org (Postfix) with ESMTP id 1AF2268391
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Sep 2005 08:56:18 +1000 (EST)
To: paulus@samba.org, linuxppc-dev@ozlabs.org
From: Roland Dreier <rolandd@cisco.com>
Date: Mon, 26 Sep 2005 15:56:12 -0700
Message-ID: <523bnrsak3.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Subject: [PATCH] Change #if CONFIG_6xx -> #if defined(CONFIG_6xx) in
 perfmon.c
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This trivial change fixes the warning

    arch/ppc/kernel/perfmon.c:48:7: warning: "CONFIG_6xx" is not defined

Signed-off-by: Roland Dreier <rolandd@cisco.com>

diff --git a/arch/ppc/kernel/perfmon.c b/arch/ppc/kernel/perfmon.c
--- a/arch/ppc/kernel/perfmon.c
+++ b/arch/ppc/kernel/perfmon.c
@@ -45,7 +45,7 @@ static void dummy_perf(struct pt_regs *r
 	mtpmr(PMRN_PMGC0, pmgc0);
 }
 
-#elif CONFIG_6xx
+#elif defined (CONFIG_6xx)
 /* Ensure exceptions are disabled */
 
 static void dummy_perf(struct pt_regs *regs)
