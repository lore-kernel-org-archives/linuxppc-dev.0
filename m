Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp08.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DA9902C00EF
 for <linuxppc-dev@ozlabs.org>; Tue, 27 Aug 2013 05:32:02 +1000 (EST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Tue, 27 Aug 2013 05:28:45 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id E1CDA357804E
 for <linuxppc-dev@ozlabs.org>; Tue, 27 Aug 2013 05:31:59 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r7QJFkmX9175490
 for <linuxppc-dev@ozlabs.org>; Tue, 27 Aug 2013 05:15:46 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r7QJVx5B029557
 for <linuxppc-dev@ozlabs.org>; Tue, 27 Aug 2013 05:31:59 +1000
Subject: [RFC PATCH v3 05/12] powerpc/book3s: Introduce a early machine check
 hook in cpu_spec.
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Tue, 27 Aug 2013 01:01:56 +0530
Message-ID: <20130826193156.2855.85412.stgit@mars>
In-Reply-To: <20130826192616.2855.18749.stgit@mars>
References: <20130826192616.2855.18749.stgit@mars>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Jeremy Kerr <jeremy.kerr@au1.ibm.com>, Paul Mackerras <paulus@samba.org>,
 Anton Blanchard <anton@samba.org>
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
will be called in real mode to handle SLB and TLB errors. This patch just
sets up a mechanism invoke CPU specific handler. The subsequent patches
will populate the function pointer.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/cputable.h |    7 +++++++
 arch/powerpc/kernel/traps.c         |    7 +++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index 6f3887d..d8c098e 100644
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
index e8d6bf1..8b0a946 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -292,8 +292,11 @@ void system_reset_exception(struct pt_regs *regs)
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
