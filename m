Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pa0-x241.google.com (mail-pa0-x241.google.com
 [IPv6:2607:f8b0:400e:c03::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qfxSM0DM2zDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Apr 2016 17:00:19 +1000 (AEST)
Received: by mail-pa0-x241.google.com with SMTP id zy2so3268877pac.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 Apr 2016 00:00:18 -0700 (PDT)
Date: Wed, 6 Apr 2016 15:00:12 +0800
From: Simon Guo <wei.guo.simon@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Kees Cook <keescook@chromium.org>,
 Rashmica Gupta <rashmicy@gmail.com>,
 Simon Guo <simonguo@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>,
 Simon Guo <wei.guo.simon@gmail.com>
Subject: [RESEND][PATCH v2] powerpc: Export thread_struct.used_vr/used_vsr to
 user space
Message-ID: <20160406070012.GA11647@simonLocalRHEL7.x64>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These 2 fields track whether user process has used Altivec/VSX
registers or not. They are used by kernel to setup signal frame
on user stack correctly regarding vector part.

CRIU(Checkpoint and Restore In User space) builds signal frame
for restored process. It will need this export information to
setup signal frame correctly. And CRIU will need to restore these
2 fields for the restored process.

Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
Reviewed-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
---
 arch/powerpc/include/uapi/asm/ptrace.h | 11 ++++++++++
 arch/powerpc/kernel/ptrace.c           | 39 ++++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/ptrace32.c         |  2 ++
 3 files changed, 52 insertions(+)

diff --git a/arch/powerpc/include/uapi/asm/ptrace.h b/arch/powerpc/include/uapi/asm/ptrace.h
index 8036b38..d5afe95 100644
--- a/arch/powerpc/include/uapi/asm/ptrace.h
+++ b/arch/powerpc/include/uapi/asm/ptrace.h
@@ -176,6 +176,17 @@ struct pt_regs {
 #define PTRACE_GETREGS64	  0x16
 #define PTRACE_SETREGS64	  0x17
 
+/*
+ * Get or set some register used bit.
+ * The flags will be saved in a 32 bit data.
+ * Currently it is only used for VR/VSR usage.
+ */
+#define PTRACE_GET_REGS_USAGE	  0x1e
+#define PTRACE_SET_REGS_USAGE	  0x1f
+
+#define PTRACE_REGS_USAGE_VR_BIT  0x00000001
+#define PTRACE_REGS_USAGE_VSR_BIT 0x00000002
+
 /* Calls to trace a 64bit program from a 32bit program */
 #define PPC_PTRACE_PEEKTEXT_3264 0x95
 #define PPC_PTRACE_PEEKDATA_3264 0x94
diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 30a03c0..39b8ff2 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -1755,6 +1755,45 @@ long arch_ptrace(struct task_struct *child, long request,
 					     REGSET_SPE, 0, 35 * sizeof(u32),
 					     datavp);
 #endif
+	case PTRACE_GET_REGS_USAGE:
+		{
+			u32 *u32_datap = (u32 *)datavp;
+			u32 reg_usage = 0;
+
+			if (addr != sizeof(u32))
+				return -EINVAL;
+
+#ifdef CONFIG_ALTIVEC
+			if (child->thread.used_vr)
+				reg_usage |= PTRACE_REGS_USAGE_VR_BIT;
+#endif
+#ifdef CONFIG_VSX
+			if (child->thread.used_vsr)
+				reg_usage |= PTRACE_REGS_USAGE_VSR_BIT;
+#endif
+			return put_user(reg_usage, u32_datap);
+		}
+	case PTRACE_SET_REGS_USAGE:
+		{
+			u32 *u32_datap = (u32 *)datavp;
+			u32 reg_usage = 0;
+
+			if (addr != sizeof(u32))
+				return -EINVAL;
+
+			ret = get_user(reg_usage, u32_datap);
+			if (ret)
+				return ret;
+#ifdef CONFIG_ALTIVEC
+			child->thread.used_vr =
+				!!(reg_usage & PTRACE_REGS_USAGE_VR_BIT);
+#endif
+#ifdef CONFIG_VSX
+			child->thread.used_vsr =
+				!!(reg_usage & PTRACE_REGS_USAGE_VSR_BIT);
+#endif
+			break;
+		}
 
 	default:
 		ret = ptrace_request(child, request, addr, data);
diff --git a/arch/powerpc/kernel/ptrace32.c b/arch/powerpc/kernel/ptrace32.c
index f52b7db..ff359a1 100644
--- a/arch/powerpc/kernel/ptrace32.c
+++ b/arch/powerpc/kernel/ptrace32.c
@@ -305,6 +305,8 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 	case PPC_PTRACE_GETHWDBGINFO:
 	case PPC_PTRACE_SETHWDEBUG:
 	case PPC_PTRACE_DELHWDEBUG:
+	case PTRACE_GET_REGS_USAGE:
+	case PTRACE_SET_REGS_USAGE:
 		ret = arch_ptrace(child, request, addr, data);
 		break;
 
-- 
2.7.0
