Return-Path: <romeo.cane.ext@coriant.com>
Received: from emea01-db3-obe.outbound.protection.outlook.com
 (mail-db3on0089.outbound.protection.outlook.com [157.55.234.89])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5D0641A0A1B
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Oct 2014 02:15:22 +1000 (EST)
Date: Thu, 2 Oct 2014 15:41:39 +0100
From: Romeo Cane <romeo.cane.ext@coriant.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH] powerpc: fix sys_call_table declaration
Message-ID: <20141002144131.GA3855@rcane-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Declaring sys_call_table as a pointer causes the compiler to generate the wrong lookup code in arch_syscall_addr

Signed-off-by: Romeo Cane <romeo.cane.ext@coriant.com>
---
 arch/powerpc/include/asm/syscall.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/syscall.h b/arch/powerpc/include/asm/syscall.h
index b54b2ad..528ba9d 100644
--- a/arch/powerpc/include/asm/syscall.h
+++ b/arch/powerpc/include/asm/syscall.h
@@ -17,7 +17,7 @@
 
 /* ftrace syscalls requires exporting the sys_call_table */
 #ifdef CONFIG_FTRACE_SYSCALLS
-extern const unsigned long *sys_call_table;
+extern const unsigned long sys_call_table[];
 #endif /* CONFIG_FTRACE_SYSCALLS */
 
 static inline long syscall_get_nr(struct task_struct *task,
-- 
1.8.3.2
