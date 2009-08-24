Return-Path: <mohan@in.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id D4EDBB708C
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 24 Aug 2009 13:13:07 +1000 (EST)
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [59.145.155.3])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp03.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 104A7DDD0C
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Aug 2009 13:13:06 +1000 (EST)
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
	by e28smtp03.in.ibm.com (8.14.3/8.13.1) with ESMTP id n7O3CsVG001535
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Aug 2009 08:42:54 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
	by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7O3CsWQ2556034
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Aug 2009 08:42:54 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
	by d28av02.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	n7O3CsP7028471
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Aug 2009 13:12:54 +1000
Date: Mon, 24 Aug 2009 08:42:44 +0530
From: "M. Mohan Kumar" <mohan@in.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH] powerpc: Invoke kdump for system reset exception
Message-ID: <20090824031244.GA3590@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, kamalesh@linux.vnet.ibm.com
Reply-To: mohan@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Invoke kdump for system reset exception

Dump restart operation from HMC raises system reset exception
(0x100) and xmon is invoked(even if kdump kernel is loaded). User has to
exit from xmon by saying 'Don't recover' to invoke kdump. Modify this
behaviour so that xmon will return immediately for system reset
exception and kdump kernel will be invoked (if its loaded). If kdump
kernel is not loaded, proceed with xmon

Signed-off-by: M. Mohan Kumar <mohan@in.ibm.com>
---
 arch/powerpc/xmon/xmon.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index e1f33a8..6847334 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -23,6 +23,7 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/bug.h>
+#include <linux/kexec.h>
 
 #include <asm/ptrace.h>
 #include <asm/string.h>
@@ -348,6 +349,14 @@ static int xmon_core(struct pt_regs *regs, int fromipi)
 	unsigned long timeout;
 #endif
 
+	/*
+	 * If the exception is 0x100 and if kexec crash image is loaded,
+	 * continue with kexec_crash
+	 */
+	if (kexec_should_crash(current) && kexec_crash_image &&
+					regs->trap == 0x100)
+		return 0;
+
 	local_irq_save(flags);
 
 	bp = in_breakpoint_table(regs->nip, &offset);
-- 
1.6.2.5
