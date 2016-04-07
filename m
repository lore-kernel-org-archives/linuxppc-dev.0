Return-Path: <hbathini@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qgxPm20PMzDq6b
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Apr 2016 08:01:32 +1000 (AEST)
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3qgxPm0SCzz9s5J
 for <linuxppc-dev@ozlabs.org>; Fri,  8 Apr 2016 08:01:32 +1000 (AEST)
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Fri, 8 Apr 2016 08:01:31 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 6221F357805A
 for <linuxppc-dev@ozlabs.org>; Fri,  8 Apr 2016 08:01:26 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u37M1HE831588458
 for <linuxppc-dev@ozlabs.org>; Fri, 8 Apr 2016 08:01:26 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u37M0qKN032098
 for <linuxppc-dev@ozlabs.org>; Fri, 8 Apr 2016 08:00:53 +1000
Subject: [PATCH v4 3/3] ppc64/book3s: remove __end_handlers marker
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Cc: Michael Neuling <mikey@neuling.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Fri, 08 Apr 2016 03:30:34 +0530
Message-ID: <20160407215914.8404.10459.stgit@hbathini.in.ibm.com>
In-Reply-To: <20160407215541.8404.15022.stgit@hbathini.in.ibm.com>
References: <20160407215541.8404.15022.stgit@hbathini.in.ibm.com>
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

__end_handlers marker was intended to mark down upto code that gets
called from exception prologs. But that hasn't kept pace with code
changes. Case in point, slb_miss_realmode being called from exception
prolog code but isn't below __end_handlers marker. So, __end_handlers
marker is as good as a comment but could be misleading at times if
it isn't in sync with the code, as is the case now. So, let us avoid
this confusion by having a better comment and removing __end_handlers
marker altogether.

Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/exceptions-64s.S |   13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index c193ebd..80f9fc4 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -764,11 +764,10 @@ kvmppc_skip_Hinterrupt:
 #endif
 
 /*
- * Code from here down to __end_handlers is invoked from the
- * exception prologs above.  Because the prologs assemble the
- * addresses of these handlers using the LOAD_HANDLER macro,
- * which uses an ori instruction, these handlers must be in
- * the first 64k of the kernel image.
+ * Ensure that any handlers that get invoked from the exception prologs
+ * above are below the first 64KB (0x10000) of the kernel image because
+ * the prologs assemble the addresses of these handlers using the
+ * LOAD_HANDLER macro, which uses an ori instruction.
  */
 
 /*** Common interrupt handlers ***/
@@ -1243,10 +1242,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX)
 	bl	vsx_unavailable_exception
 	b	ret_from_except
 
-	.align	7
-	.globl	__end_handlers
-__end_handlers:
-
 #if defined(CONFIG_PPC_PSERIES) || defined(CONFIG_PPC_POWERNV)
 /*
  * Data area reserved for FWNMI option.
