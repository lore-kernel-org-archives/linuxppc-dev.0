Return-Path: <aravinda@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e1.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8EDBC2C00D0
 for <linuxppc-dev@ozlabs.org>; Mon,  5 Nov 2012 19:16:02 +1100 (EST)
Received: from /spool/local
 by e1.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aravinda@linux.vnet.ibm.com>;
 Mon, 5 Nov 2012 03:15:58 -0500
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id DF9BB38C8026
 for <linuxppc-dev@ozlabs.org>; Mon,  5 Nov 2012 03:15:34 -0500 (EST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 qA58FYst285222
 for <linuxppc-dev@ozlabs.org>; Mon, 5 Nov 2012 03:15:34 -0500
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 qA58FX12005614
 for <linuxppc-dev@ozlabs.org>; Mon, 5 Nov 2012 01:15:33 -0700
Subject: [PATCH] Enable hardware breakpoint upon re-registering
To: linuxppc-dev@ozlabs.org, mikey@neuling.org, linux-kernel@vger.kernel.org,
 fweisbec@redhat.com, benh@kernel.crashing.org
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Date: Mon, 05 Nov 2012 13:45:28 +0530
Message-ID: <20121105081527.29141.11384.stgit@aravinda>
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

On powerpc, ptrace will disable hardware breakpoint request once the
breakpoint is hit. It is the responsibility of the caller to set it
again. However, when the caller sets the hardware breakpoint again
using ptrace(PTRACE_SET_DEBUGREG, child_pid, 0, addr), the hardware
breakpoint is not enabled.

While gdb's approach is to unregister and re-register the hardware
breakpoint every time the breakpoint is hit - which is working fine,
this could affect other programs trying to re-register hardware
breakpoint without unregistering.

This patch enables hardware breakpoint if the caller is re-registering.

Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/ptrace.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 79d8e56..09371d0 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -952,6 +952,10 @@ int ptrace_set_debugreg(struct task_struct *task, unsigned long addr,
 		arch_bp_generic_fields(data &
 					(DABR_DATA_WRITE | DABR_DATA_READ),
 							&attr.bp_type);
+
+		/* Enable breakpoint */
+		attr.disabled = false;
+
 		ret =  modify_user_hw_breakpoint(bp, &attr);
 		if (ret) {
 			ptrace_put_breakpoints(task);
