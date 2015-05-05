Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8DC051A066A
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 May 2015 01:30:30 +1000 (AEST)
Received: from /spool/local
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Tue, 5 May 2015 16:30:27 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 54CC91B0805F
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 May 2015 16:31:05 +0100 (BST)
Received: from d06av05.portsmouth.uk.ibm.com (d06av05.portsmouth.uk.ibm.com
 [9.149.37.229])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t45FUNsS49676456
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 May 2015 15:30:23 GMT
Received: from d06av05.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av05.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t45FUMZ1017674
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 May 2015 09:30:22 -0600
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
Subject: [PATCH] powerpc: Enabling sys_kcmp for CRIU
Date: Tue,  5 May 2015 17:30:21 +0200
Message-Id: <1430839821-9259-1-git-send-email-ldufour@linux.vnet.ibm.com>
Cc: paulus@samba.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The commit 8170a83f15ee ("powerpc: Wireup the kcmp syscall to sys_ni") has
disabled the kcmp syscall for powerpc.  This has been done due to the use
of unsigned long parameters which may require a dedicated wrapper to handle
32bit process on top of 64bit kernel.  However in the kcmp() case, the 2
unsigned long parameters are currently only used to carry file descriptors
from user space to the kernel.  Since such a parameter is passed through
register, and file descriptor doesn't need to get extended, there is,
today, no need for a wrapper.

In the case there will be a need to pass address in or out of this system
call, then a wrapper could be required, it will then be to care of it.

As today this is not the case, it is safe to enable kcmp() on powerpc.

Cc: Tony Breeds <tony@bakeyournoodle.com>
Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/systbl.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/systbl.h b/arch/powerpc/include/asm/systbl.h
index 91062eef582f..b257f02ab6bf 100644
--- a/arch/powerpc/include/asm/systbl.h
+++ b/arch/powerpc/include/asm/systbl.h
@@ -358,7 +358,7 @@ SYSCALL_SPU(setns)
 COMPAT_SYS(process_vm_readv)
 COMPAT_SYS(process_vm_writev)
 SYSCALL(finit_module)
-SYSCALL(ni_syscall) /* sys_kcmp */
+SYSCALL(kcmp) /* sys_kcmp */
 SYSCALL_SPU(sched_setattr)
 SYSCALL_SPU(sched_getattr)
 SYSCALL_SPU(renameat2)
-- 
1.9.1
