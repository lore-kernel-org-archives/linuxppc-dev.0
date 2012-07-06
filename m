Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp04.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8DFB22C01EA
 for <linuxppc-dev@ozlabs.org>; Fri,  6 Jul 2012 21:31:12 +1000 (EST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Fri, 6 Jul 2012 17:01:09 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q66BV6QR61734966
 for <linuxppc-dev@ozlabs.org>; Fri, 6 Jul 2012 17:01:06 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q66H0NtY010599
 for <linuxppc-dev@ozlabs.org>; Sat, 7 Jul 2012 03:00:24 +1000
Subject: [PATCH] PPC Hardware Breakpoints: Fix incorrect pointer access
To: fweisbec@gmail.com, benh@kernel.crashing.org, paulus@samba.org,
 prasad.krishnan@gmail.com
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Date: Fri, 06 Jul 2012 17:00:58 +0530
Message-ID: <20120706113058.8600.30142.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
 emachado@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If arch_validate_hwbkpt_settings() fails, bp->ctx won't be valid and the
kernel panics. Add a check to fix this.

Reported-by: Edjunior Barbosa Machado <emachado@linux.vnet.ibm.com>
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/hw_breakpoint.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/hw_breakpoint.c b/arch/powerpc/kernel/hw_breakpoint.c
index 2bc0584..f3a82dd 100644
--- a/arch/powerpc/kernel/hw_breakpoint.c
+++ b/arch/powerpc/kernel/hw_breakpoint.c
@@ -111,7 +111,7 @@ void arch_unregister_hw_breakpoint(struct perf_event *bp)
 	 * and the single_step_dabr_instruction(), then cleanup the breakpoint
 	 * restoration variables to prevent dangling pointers.
 	 */
-	if (bp->ctx->task)
+	if (bp->ctx && bp->ctx->task)
 		bp->ctx->task->thread.last_hit_ubp = NULL;
 }
 
