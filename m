Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40wDKQ5sQKzDqGD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 May 2018 22:57:46 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org,
	viro@zeniv.linux.org.uk
Cc: malat@debian.org
Subject: [PATCH] powerpc/ptrace: Use copy_{from,
 to}_user() rather than open-coding
Date: Tue, 29 May 2018 22:57:38 +1000
Message-Id: <20180529125738.24271-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Al Viro <viro@ZenIV.linux.org.uk>

In PPC_PTRACE_GETHWDBGINFO and PPC_PTRACE_SETHWDEBUG we do an
access_ok() check and then __copy_{from,to}_user().

Instead we should just use copy_{from,to}_user() which does all that
for us and is less error prone.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/ptrace.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 0f63dd5972e9..9667666eb18e 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -3082,27 +3082,19 @@ long arch_ptrace(struct task_struct *child, long request,
 #endif /* CONFIG_HAVE_HW_BREAKPOINT */
 #endif /* CONFIG_PPC_ADV_DEBUG_REGS */
 
-		if (!access_ok(VERIFY_WRITE, datavp,
-			       sizeof(struct ppc_debug_info)))
+		if (copy_to_user(datavp, &dbginfo,
+				 sizeof(struct ppc_debug_info)))
 			return -EFAULT;
-		ret = __copy_to_user(datavp, &dbginfo,
-				     sizeof(struct ppc_debug_info)) ?
-		      -EFAULT : 0;
-		break;
+		return 0;
 	}
 
 	case PPC_PTRACE_SETHWDEBUG: {
 		struct ppc_hw_breakpoint bp_info;
 
-		if (!access_ok(VERIFY_READ, datavp,
-			       sizeof(struct ppc_hw_breakpoint)))
+		if (copy_from_user(&bp_info, datavp,
+				   sizeof(struct ppc_hw_breakpoint)))
 			return -EFAULT;
-		ret = __copy_from_user(&bp_info, datavp,
-				       sizeof(struct ppc_hw_breakpoint)) ?
-		      -EFAULT : 0;
-		if (!ret)
-			ret = ppc_set_hwdebug(child, &bp_info);
-		break;
+		return ppc_set_hwdebug(child, &bp_info);
 	}
 
 	case PPC_PTRACE_DELHWDEBUG: {
-- 
2.14.1
