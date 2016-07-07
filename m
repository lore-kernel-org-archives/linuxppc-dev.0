Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pa0-x242.google.com (mail-pa0-x242.google.com
 [IPv6:2607:f8b0:400e:c03::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rlVCD16BkzDqxQ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jul 2016 17:50:00 +1000 (AEST)
Received: by mail-pa0-x242.google.com with SMTP id ib6so1111423pad.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Jul 2016 00:50:00 -0700 (PDT)
From: wei.guo.simon@gmail.com
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Simon Guo <wei.guo.simon@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Kees Cook <keescook@chromium.org>,
 Rashmica Gupta <rashmicy@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Laurent Dufour <ldufour@linux.vnet.ibm.com>
Subject: [PATCH v4] powerpc: Export thread_struct.used_vr/used_vsr to user
 space
Date: Thu,  7 Jul 2016 15:49:36 +0800
Message-Id: <1467877776-5618-1-git-send-email-wei.guo.simon@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Simon Guo <wei.guo.simon@gmail.com>

These 2 fields track whether user process has used Altivec/VSX
registers or not. They are used by kernel to setup signal frame
on user stack correctly regarding vector part.

CRIU(Checkpoint and Restore In User space) builds signal frame
for restored process. It will need this export information to
setup signal frame correctly. And CRIU will need to restore these
2 fields for the restored process.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Rashmica Gupta <rashmicy@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
Cc: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
Reviewed-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
--

v3 -> v4:
-  Copying 64 bit data from/to user space using get_user/put_user
is not supported on all architectures, and may result in the
following build error on 32 bits build:
   arch/powerpc/kernel/built-in.o: In function `arch_ptrace':
   >> (.text+0xad4): undefined reference to `__get_user_bad'
using copy_from_user/copy_to_user instead.

v2 -> v3:
- enlarge reg_usage from 32 to 64 bits
- prefix ptrace API with PPC_

v1 -> v2:
- minor change for coding style
---
 arch/powerpc/include/uapi/asm/ptrace.h | 11 ++++++++
 arch/powerpc/kernel/ptrace.c           | 48 ++++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/ptrace32.c         |  2 ++
 3 files changed, 61 insertions(+)

diff --git a/arch/powerpc/include/uapi/asm/ptrace.h b/arch/powerpc/include/uapi/asm/ptrace.h
index 8036b38..b357677 100644
--- a/arch/powerpc/include/uapi/asm/ptrace.h
+++ b/arch/powerpc/include/uapi/asm/ptrace.h
@@ -176,6 +176,17 @@ struct pt_regs {
 #define PTRACE_GETREGS64	  0x16
 #define PTRACE_SETREGS64	  0x17
 
+/*
+ * Get or set some register used bit.
+ * The flags will be saved in a 64 bit data.
+ * Currently it is only used for VR/VSR usage.
+ */
+#define PPC_PTRACE_GET_REGS_USAGE	  0x97
+#define PPC_PTRACE_SET_REGS_USAGE	  0x96
+
+#define PPC_PTRACE_REGS_USAGE_VR_BIT  0x01UL
+#define PPC_PTRACE_REGS_USAGE_VSR_BIT 0x02UL
+
 /* Calls to trace a 64bit program from a 32bit program */
 #define PPC_PTRACE_PEEKTEXT_3264 0x95
 #define PPC_PTRACE_PEEKDATA_3264 0x94
diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index a9aa2a5..d00d7c0 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -3018,6 +3018,54 @@ long arch_ptrace(struct task_struct *child, long request,
 					     REGSET_SPE, 0, 35 * sizeof(u32),
 					     datavp);
 #endif
+	case PPC_PTRACE_GET_REGS_USAGE:
+		{
+			u64 *u64_datap = (u64 *)datavp;
+			u64 reg_usage = 0;
+
+			if (addr != sizeof(u64))
+				return -EINVAL;
+
+#ifdef CONFIG_ALTIVEC
+			if (child->thread.used_vr)
+				reg_usage |= PPC_PTRACE_REGS_USAGE_VR_BIT;
+#endif
+#ifdef CONFIG_VSX
+			if (child->thread.used_vsr)
+				reg_usage |= PPC_PTRACE_REGS_USAGE_VSR_BIT;
+#endif
+			ret =  copy_to_user(u64_datap,
+					&reg_usage,
+					sizeof(reg_usage)) ?
+				-EFAULT : 0;
+			break;
+		}
+
+	case PPC_PTRACE_SET_REGS_USAGE:
+		{
+			u64 *u64_datap = (u64 *)datavp;
+			u64 reg_usage = 0;
+
+			if (addr != sizeof(u64))
+				return -EINVAL;
+
+			ret = copy_from_user(&reg_usage,
+					u64_datap,
+					sizeof(reg_usage)) ?
+				-EFAULT : 0;
+
+			if (ret)
+				return ret;
+#ifdef CONFIG_ALTIVEC
+			child->thread.used_vr =
+				!!(reg_usage & PPC_PTRACE_REGS_USAGE_VR_BIT);
+#endif
+#ifdef CONFIG_VSX
+			child->thread.used_vsr =
+				!!(reg_usage & PPC_PTRACE_REGS_USAGE_VSR_BIT);
+#endif
+			break;
+		}
 
 	default:
 		ret = ptrace_request(child, request, addr, data);
diff --git a/arch/powerpc/kernel/ptrace32.c b/arch/powerpc/kernel/ptrace32.c
index f52b7db..3aaa773 100644
--- a/arch/powerpc/kernel/ptrace32.c
+++ b/arch/powerpc/kernel/ptrace32.c
@@ -305,6 +305,8 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 	case PPC_PTRACE_GETHWDBGINFO:
 	case PPC_PTRACE_SETHWDEBUG:
 	case PPC_PTRACE_DELHWDEBUG:
+	case PPC_PTRACE_GET_REGS_USAGE:
+	case PPC_PTRACE_SET_REGS_USAGE:
 		ret = arch_ptrace(child, request, addr, data);
 		break;
 
-- 
1.8.3.1
