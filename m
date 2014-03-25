Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, rusty@rustcorp.com.au,
 ulrich.weigand@de.ibm.com, amodra@gmail.com, mikey@neuling.org,
 mjw@linux.vnet.ibm.com
Subject: [PATCH 07/33] powerpc: Create DOTSYM to wrap dot symbol usage
Date: Tue, 25 Mar 2014 22:44:13 +1100
Message-Id: <1395747879-5948-8-git-send-email-anton@samba.org>
In-Reply-To: <1395747879-5948-1-git-send-email-anton@samba.org>
References: <1395747879-5948-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There are a few places we have to use dot symbols with the
current ABI - the syscall table and the kvm hcall table.

Wrap both of these with a new macro called DOTSYM so it will
be easy to transition away from dot symbols in a future ABI.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/include/asm/ppc_asm.h      |  2 ++
 arch/powerpc/include/asm/systbl.h       |  6 +++---
 arch/powerpc/kernel/systbl.S            | 12 ++++++------
 arch/powerpc/kvm/book3s_hv_rmhandlers.S | 26 +++++++++++++-------------
 4 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
index 35b23a6..61992d8 100644
--- a/arch/powerpc/include/asm/ppc_asm.h
+++ b/arch/powerpc/include/asm/ppc_asm.h
@@ -223,6 +223,8 @@ name: \
 	.type GLUE(.,name),@function; \
 GLUE(.,name):
 
+#define DOTSYM(a)	GLUE(.,a)
+
 #else /* 32-bit */
 
 #define _ENTRY(n)	\
diff --git a/arch/powerpc/include/asm/systbl.h b/arch/powerpc/include/asm/systbl.h
index 3ddf702..ac062f5 100644
--- a/arch/powerpc/include/asm/systbl.h
+++ b/arch/powerpc/include/asm/systbl.h
@@ -62,7 +62,7 @@ COMPAT_SYS_SPU(fcntl)
 SYSCALL(ni_syscall)
 SYSCALL_SPU(setpgid)
 SYSCALL(ni_syscall)
-SYSX(sys_ni_syscall,sys_olduname, sys_olduname)
+SYSX(sys_ni_syscall,sys_olduname,sys_olduname)
 SYSCALL_SPU(umask)
 SYSCALL_SPU(chroot)
 COMPAT_SYS(ustat)
@@ -258,7 +258,7 @@ SYSCALL_SPU(tgkill)
 COMPAT_SYS_SPU(utimes)
 COMPAT_SYS_SPU(statfs64)
 COMPAT_SYS_SPU(fstatfs64)
-SYSX(sys_ni_syscall, ppc_fadvise64_64, ppc_fadvise64_64)
+SYSX(sys_ni_syscall,ppc_fadvise64_64,ppc_fadvise64_64)
 PPC_SYS_SPU(rtas)
 OLDSYS(debug_setcontext)
 SYSCALL(ni_syscall)
@@ -295,7 +295,7 @@ SYSCALL_SPU(mkdirat)
 SYSCALL_SPU(mknodat)
 SYSCALL_SPU(fchownat)
 COMPAT_SYS_SPU(futimesat)
-SYSX_SPU(sys_newfstatat, sys_fstatat64, sys_fstatat64)
+SYSX_SPU(sys_newfstatat,sys_fstatat64,sys_fstatat64)
 SYSCALL_SPU(unlinkat)
 SYSCALL_SPU(renameat)
 SYSCALL_SPU(linkat)
diff --git a/arch/powerpc/kernel/systbl.S b/arch/powerpc/kernel/systbl.S
index 75822f9..895c50c 100644
--- a/arch/powerpc/kernel/systbl.S
+++ b/arch/powerpc/kernel/systbl.S
@@ -17,12 +17,12 @@
 #include <asm/ppc_asm.h>
 
 #ifdef CONFIG_PPC64
-#define SYSCALL(func)		.llong	.sys_##func,.sys_##func
-#define COMPAT_SYS(func)	.llong	.sys_##func,.compat_sys_##func
-#define PPC_SYS(func)		.llong	.ppc_##func,.ppc_##func
-#define OLDSYS(func)		.llong	.sys_ni_syscall,.sys_ni_syscall
-#define SYS32ONLY(func)		.llong	.sys_ni_syscall,.compat_sys_##func
-#define SYSX(f, f3264, f32)	.llong	.f,.f3264
+#define SYSCALL(func)		.llong	DOTSYM(sys_##func),DOTSYM(sys_##func)
+#define COMPAT_SYS(func)	.llong	DOTSYM(sys_##func),DOTSYM(compat_sys_##func)
+#define PPC_SYS(func)		.llong	DOTSYM(ppc_##func),DOTSYM(ppc_##func)
+#define OLDSYS(func)		.llong	DOTSYM(sys_ni_syscall),DOTSYM(sys_ni_syscall)
+#define SYS32ONLY(func)		.llong	DOTSYM(sys_ni_syscall),DOTSYM(compat_sys_##func)
+#define SYSX(f, f3264, f32)	.llong	DOTSYM(f),DOTSYM(f3264)
 #else
 #define SYSCALL(func)		.long	sys_##func
 #define COMPAT_SYS(func)	.long	sys_##func
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index bb5faff..da59454 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -1752,16 +1752,16 @@ hcall_real_fallback:
 	.globl	hcall_real_table
 hcall_real_table:
 	.long	0		/* 0 - unused */
-	.long	.kvmppc_h_remove - hcall_real_table
-	.long	.kvmppc_h_enter - hcall_real_table
-	.long	.kvmppc_h_read - hcall_real_table
+	.long	DOTSYM(kvmppc_h_remove) - hcall_real_table
+	.long	DOTSYM(kvmppc_h_enter) - hcall_real_table
+	.long	DOTSYM(kvmppc_h_read) - hcall_real_table
 	.long	0		/* 0x10 - H_CLEAR_MOD */
 	.long	0		/* 0x14 - H_CLEAR_REF */
-	.long	.kvmppc_h_protect - hcall_real_table
+	.long	DOTSYM(kvmppc_h_protect) - hcall_real_table
 	.long	0		/* 0x1c - H_GET_TCE */
-	.long	.kvmppc_h_put_tce - hcall_real_table
+	.long	DOTSYM(kvmppc_h_put_tce) - hcall_real_table
 	.long	0		/* 0x24 - H_SET_SPRG0 */
-	.long	.kvmppc_h_set_dabr - hcall_real_table
+	.long	DOTSYM(kvmppc_h_set_dabr) - hcall_real_table
 	.long	0		/* 0x2c */
 	.long	0		/* 0x30 */
 	.long	0		/* 0x34 */
@@ -1777,11 +1777,11 @@ hcall_real_table:
 	.long	0		/* 0x5c */
 	.long	0		/* 0x60 */
 #ifdef CONFIG_KVM_XICS
-	.long	.kvmppc_rm_h_eoi - hcall_real_table
-	.long	.kvmppc_rm_h_cppr - hcall_real_table
-	.long	.kvmppc_rm_h_ipi - hcall_real_table
+	.long	DOTSYM(kvmppc_rm_h_eoi) - hcall_real_table
+	.long	DOTSYM(kvmppc_rm_h_cppr) - hcall_real_table
+	.long	DOTSYM(kvmppc_rm_h_ipi) - hcall_real_table
 	.long	0		/* 0x70 - H_IPOLL */
-	.long	.kvmppc_rm_h_xirr - hcall_real_table
+	.long	DOTSYM(kvmppc_rm_h_xirr) - hcall_real_table
 #else
 	.long	0		/* 0x64 - H_EOI */
 	.long	0		/* 0x68 - H_CPPR */
@@ -1815,7 +1815,7 @@ hcall_real_table:
 	.long	0		/* 0xd4 */
 	.long	0		/* 0xd8 */
 	.long	0		/* 0xdc */
-	.long	.kvmppc_h_cede - hcall_real_table
+	.long	DOTSYM(kvmppc_h_cede) - hcall_real_table
 	.long	0		/* 0xe4 */
 	.long	0		/* 0xe8 */
 	.long	0		/* 0xec */
@@ -1832,11 +1832,11 @@ hcall_real_table:
 	.long	0		/* 0x118 */
 	.long	0		/* 0x11c */
 	.long	0		/* 0x120 */
-	.long	.kvmppc_h_bulk_remove - hcall_real_table
+	.long	DOTSYM(kvmppc_h_bulk_remove) - hcall_real_table
 	.long	0		/* 0x128 */
 	.long	0		/* 0x12c */
 	.long	0		/* 0x130 */
-	.long	.kvmppc_h_set_xdabr - hcall_real_table
+	.long	DOTSYM(kvmppc_h_set_xdabr) - hcall_real_table
 hcall_real_table_end:
 
 ignore_hdec:
-- 
1.8.3.2
