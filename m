Return-Path: <gkurz@linux.vnet.ibm.com>
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 430B91A0EF7
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Dec 2014 02:15:19 +1100 (AEDT)
Received: from /spool/local
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gkurz@linux.vnet.ibm.com>;
 Fri, 5 Dec 2014 15:15:16 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id BE6F4219004D
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Dec 2014 15:14:45 +0000 (GMT)
Received: from d06av09.portsmouth.uk.ibm.com (d06av09.portsmouth.uk.ibm.com
 [9.149.37.250])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sB5FFEFg38797450
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Dec 2014 15:15:14 GMT
Received: from d06av09.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av09.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sB5FFDab027460
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Dec 2014 08:15:13 -0700
Subject: [PATCH 2 3/4] powerpc: drop smp_generic_cpu_bootable()
From: Greg Kurz <gkurz@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Date: Fri, 05 Dec 2014 16:15:12 +0100
Message-ID: <20141205151455.11028.573.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <20141205150405.11028.27445.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
References: <20141205150405.11028.27445.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The following assertions are always true:
- threads_per_core > 0
- cpu & (threads_per_core - 1) < threads_per_core

It means smp_generic_cpu_bootable() always returns true.

Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/smp.c |   11 -----------
 1 file changed, 11 deletions(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 9577791..8d7f114 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -89,17 +89,6 @@ static void (*crash_ipi_function_ptr)(struct pt_regs *) = NULL;
  */
 int smp_generic_cpu_bootable(unsigned int nr)
 {
-	/* Special case - we inhibit secondary thread startup
-	 * during boot if the user requests it.
-	 */
-	if (system_state == SYSTEM_BOOTING && cpu_has_feature(CPU_FTR_SMT)) {
-		if (!threads_per_core && cpu_thread_in_core(nr) != 0)
-			return 0;
-		if (threads_per_core
-		    && cpu_thread_in_core(nr) >= threads_per_core)
-			return 0;
-	}
-
 	return 1;
 }
 
