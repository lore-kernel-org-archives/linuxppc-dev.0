Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp08.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4CF612C0694
 for <linuxppc-dev@ozlabs.org>; Thu, 31 Oct 2013 01:34:54 +1100 (EST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Thu, 31 Oct 2013 00:34:54 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 7945C3578040
 for <linuxppc-dev@ozlabs.org>; Thu, 31 Oct 2013 01:34:51 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r9UEHTnD12583044
 for <linuxppc-dev@ozlabs.org>; Thu, 31 Oct 2013 01:17:29 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r9UEYoW1010528
 for <linuxppc-dev@ozlabs.org>; Thu, 31 Oct 2013 01:34:50 +1100
Subject: [RFC PATCH v5 05/12] powerpc/book3s: Introduce a early machine check
 hook in cpu_spec.
To: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Wed, 30 Oct 2013 20:04:40 +0530
Message-ID: <20131030143440.26643.90529.stgit@mars>
In-Reply-To: <20131030143219.26643.24782.stgit@mars>
References: <20131030143219.26643.24782.stgit@mars>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Jeremy Kerr <jeremy.kerr@au1.ibm.com>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

This patch adds the early machine check function pointer in cputable for
CPU specific early machine check handling. The early machine handle routine
will be called in real mode to handle SLB and TLB errors. We can not reuse
the existing machine_check hook because it is always invoked in kernel
virtual mode and we would already be in trouble if we get SLB or TLB errors.
This patch just sets up a mechanism to invoke CPU specific handler. The
subsequent patches will populate the function pointer.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
Acked-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/include/asm/cputable.h |    7 +++++++
 arch/powerpc/kernel/traps.c         |    7 +++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index 0d4939b..c5b107a 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -90,6 +90,13 @@ struct cpu_spec {
 	 * if the error is fatal, 1 if it was fully recovered and 0 to
 	 * pass up (not CPU originated) */
 	int		(*machine_check)(struct pt_regs *regs);
+
+	/*
+	 * Processor specific early machine check handler which is
+	 * called in real mode to handle SLB and TLB errors.
+	 */
+	long		(*machine_check_early)(struct pt_regs *regs);
+
 };
 
 extern struct cpu_spec		*cur_cpu_spec;
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 0c32fa0..008e5c5 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -293,8 +293,11 @@ void system_reset_exception(struct pt_regs *regs)
  */
 long machine_check_early(struct pt_regs *regs)
 {
-	/* TODO: handle/decode machine check reason */
-	return 0;
+	long handled = 0;
+
+	if (cur_cpu_spec && cur_cpu_spec->machine_check_early)
+		handled = cur_cpu_spec->machine_check_early(regs);
+	return handled;
 }
 
 #endif
