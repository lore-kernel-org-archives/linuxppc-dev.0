Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e9.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3C436B7B79
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 23 Sep 2009 23:51:10 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e9.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n8NDmNQU011908
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2009 09:48:23 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8NDp7r3237022
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2009 09:51:07 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n8NDp7q4002648
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2009 09:51:07 -0400
Received: from zod.rchland.ibm.com ([9.49.202.222])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	n8NDp5SI002394
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO)
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2009 09:51:07 -0400
Date: Wed, 23 Sep 2009 09:51:04 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] powerpc/4xx: Fix erroneous xmon warning on PowerPC 4xx
Message-ID: <20090923135104.GG14261@zod.rchland.ibm.com>
References: <20090923134844.GF14261@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090923134844.GF14261@zod.rchland.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The xmon code relies on MSR_RI being non-zero to indicate that an exception
is recoverable.  If it is not, it prints a warning message.  However, the
PowerPC 4xx cores do not have an MSR_RI bit and this warning is produced for
every xmon event.

This introduces an unrecoverable_excp function to determine if an exception
is recoverable or not.  This gets rid of the erroneous warnings on 4xx.

Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
---
 arch/powerpc/xmon/xmon.c |   16 +++++++++++++---
 1 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 0e09a45..c6f0a71 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -335,6 +335,16 @@ int cpus_are_in_xmon(void)
 }
 #endif
 
+static inline int unrecoverable_excp(struct pt_regs *regs)
+{
+#ifdef CONFIG_4xx
+	/* We have no MSR_RI bit on 4xx, so we simply return false */
+	return 0;
+#else
+	return ((regs->msr & MSR_RI) == 0);
+#endif
+}
+
 static int xmon_core(struct pt_regs *regs, int fromipi)
 {
 	int cmd = 0;
@@ -388,7 +398,7 @@ static int xmon_core(struct pt_regs *regs, int fromipi)
 	bp = NULL;
 	if ((regs->msr & (MSR_IR|MSR_PR|MSR_SF)) == (MSR_IR|MSR_SF))
 		bp = at_breakpoint(regs->nip);
-	if (bp || (regs->msr & MSR_RI) == 0)
+	if (bp || unrecoverable_excp(regs))
 		fromipi = 0;
 
 	if (!fromipi) {
@@ -399,7 +409,7 @@ static int xmon_core(struct pt_regs *regs, int fromipi)
 			       cpu, BP_NUM(bp));
 			xmon_print_symbol(regs->nip, " ", ")\n");
 		}
-		if ((regs->msr & MSR_RI) == 0)
+		if (unrecoverable_excp(regs))
 			printf("WARNING: exception is not recoverable, "
 			       "can't continue\n");
 		release_output_lock();
@@ -490,7 +500,7 @@ static int xmon_core(struct pt_regs *regs, int fromipi)
 			printf("Stopped at breakpoint %x (", BP_NUM(bp));
 			xmon_print_symbol(regs->nip, " ", ")\n");
 		}
-		if ((regs->msr & MSR_RI) == 0)
+		if (unrecoverable_excp(regs))
 			printf("WARNING: exception is not recoverable, "
 			       "can't continue\n");
 		remove_bpts();
-- 
1.5.5.6
