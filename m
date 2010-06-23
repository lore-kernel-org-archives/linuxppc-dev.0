Return-Path: <imunsie@au1.ibm.com>
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH 22/40] trace syscalls, PPC: Convert syscalls to SYSCALL_DEFINE
Date: Wed, 23 Jun 2010 20:03:03 +1000
Message-Id: <1277287401-28571-23-git-send-email-imunsie@au1.ibm.com>
In-Reply-To: <1277287401-28571-1-git-send-email-imunsie@au1.ibm.com>
References: <1277287401-28571-1-git-send-email-imunsie@au1.ibm.com>
Cc: Jesper Nilsson <jesper.nilsson@axis.com>, Arnd Bergmann <arnd@arndb.de>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Frederic Weisbecker <fweisbec@gmail.com>, Jason Baron <jbaron@redhat.com>,
	Chase Douglas <cndougla@linux.vnet.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Michal Simek <monstr@monstr.eu>, Ingo Molnar <mingo@redhat.com>,
	Paul Mackerras <paulus@samba.org>,
	Ian Munsie <imunsie@au1.ibm.com>, Tejun Heo <tj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ian Munsie <imunsie@au1.ibm.com>

This patch alters the trivial syscalls (with a return type of long) in
PPC to use the SYSCALL_DEFINE family of macros to record their metadata
for ftrace syscalls.

It does not alter any non-trivial syscalls with different return types.

Several of the syscalls with a ppc_ prefix are renamed by this patch to
have a sys_ppc_ prefix so that they can be used easily with the
SYSCALL_DEFINE macro.

Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
---
 arch/powerpc/include/asm/syscalls.h        |    2 +-
 arch/powerpc/include/asm/systbl.h          |    4 ++--
 arch/powerpc/kernel/pci_32.c               |    5 +++--
 arch/powerpc/kernel/pci_64.c               |    4 ++--
 arch/powerpc/kernel/syscalls.c             |    6 +++---
 arch/powerpc/platforms/cell/spu_syscalls.c |    6 +++---
 6 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/include/asm/syscalls.h b/arch/powerpc/include/asm/syscalls.h
index 4084e56..be37ef8 100644
--- a/arch/powerpc/include/asm/syscalls.h
+++ b/arch/powerpc/include/asm/syscalls.h
@@ -34,7 +34,7 @@ asmlinkage long sys_pipe2(int __user *fildes, int flags);
 asmlinkage long sys_rt_sigaction(int sig,
 		const struct sigaction __user *act,
 		struct sigaction __user *oact, size_t sigsetsize);
-asmlinkage long ppc64_personality(unsigned long personality);
+asmlinkage long sys_ppc64_personality(unsigned long personality);
 asmlinkage int ppc_rtas(struct rtas_args __user *uargs);
 asmlinkage time_t sys64_time(time_t __user * tloc);
 
diff --git a/arch/powerpc/include/asm/systbl.h b/arch/powerpc/include/asm/systbl.h
index a5ee345..dd8494a 100644
--- a/arch/powerpc/include/asm/systbl.h
+++ b/arch/powerpc/include/asm/systbl.h
@@ -139,7 +139,7 @@ COMPAT_SYS_SPU(getpgid)
 SYSCALL_SPU(fchdir)
 SYSCALL_SPU(bdflush)
 COMPAT_SYS(sysfs)
-SYSX_SPU(ppc64_personality,ppc64_personality,sys_personality)
+SYSX_SPU(sys_ppc64_personality,sys_ppc64_personality,sys_personality)
 SYSCALL(ni_syscall)
 SYSCALL_SPU(setfsuid)
 SYSCALL_SPU(setfsgid)
@@ -257,7 +257,7 @@ COMPAT_SYS_SPU(tgkill)
 COMPAT_SYS_SPU(utimes)
 COMPAT_SYS_SPU(statfs64)
 COMPAT_SYS_SPU(fstatfs64)
-SYSX(sys_ni_syscall, ppc_fadvise64_64, ppc_fadvise64_64)
+SYSX(sys_ni_syscall, sys_ppc_fadvise64_64, sys_ppc_fadvise64_64)
 PPC_SYS_SPU(rtas)
 OLDSYS(debug_setcontext)
 SYSCALL(ni_syscall)
diff --git a/arch/powerpc/kernel/pci_32.c b/arch/powerpc/kernel/pci_32.c
index e7db5b4..fb2391a 100644
--- a/arch/powerpc/kernel/pci_32.c
+++ b/arch/powerpc/kernel/pci_32.c
@@ -15,6 +15,7 @@
 #include <linux/list.h>
 #include <linux/of.h>
 #include <linux/slab.h>
+#include <linux/syscalls.h>
 
 #include <asm/processor.h>
 #include <asm/io.h>
@@ -423,8 +424,8 @@ pci_bus_to_hose(int bus)
  * root bridge.
  * Note that the returned IO or memory base is a physical address
  */
-
-long sys_pciconfig_iobase(long which, unsigned long bus, unsigned long devfn)
+SYSCALL_DEFINE3(pciconfig_iobase, long, which, unsigned long, bus,
+		unsigned long, devfn)
 {
 	struct pci_controller* hose;
 	long result = -EOPNOTSUPP;
diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
index d43fc65..1b1b846 100644
--- a/arch/powerpc/kernel/pci_64.c
+++ b/arch/powerpc/kernel/pci_64.c
@@ -211,8 +211,8 @@ void __devinit pcibios_setup_phb_io_space(struct pci_controller *hose)
 #define IOBASE_ISA_IO		3
 #define IOBASE_ISA_MEM		4
 
-long sys_pciconfig_iobase(long which, unsigned long in_bus,
-			  unsigned long in_devfn)
+SYSCALL_DEFINE3(pciconfig_iobase, long, which, unsigned long, in_bus,
+			  unsigned long, in_devfn)
 {
 	struct pci_controller* hose;
 	struct list_head *ln;
diff --git a/arch/powerpc/kernel/syscalls.c b/arch/powerpc/kernel/syscalls.c
index f2496f2..f3bce3a 100644
--- a/arch/powerpc/kernel/syscalls.c
+++ b/arch/powerpc/kernel/syscalls.c
@@ -102,7 +102,7 @@ ppc_select(int n, fd_set __user *inp, fd_set __user *outp, fd_set __user *exp, s
 #endif
 
 #ifdef CONFIG_PPC64
-long ppc64_personality(unsigned long personality)
+SYSCALL_DEFINE1(ppc64_personality, unsigned long, personality)
 {
 	long ret;
 
@@ -116,8 +116,8 @@ long ppc64_personality(unsigned long personality)
 }
 #endif
 
-long ppc_fadvise64_64(int fd, int advice, u32 offset_high, u32 offset_low,
-		      u32 len_high, u32 len_low)
+SYSCALL_DEFINE6(ppc_fadvise64_64, int, fd, int, advice, u32, offset_high,
+		u32, offset_low, u32, len_high, u32, len_low)
 {
 	return sys_fadvise64(fd, (u64)offset_high << 32 | offset_low,
 			     (u64)len_high << 32 | len_low, advice);
diff --git a/arch/powerpc/platforms/cell/spu_syscalls.c b/arch/powerpc/platforms/cell/spu_syscalls.c
index 75530d9..68ce26e 100644
--- a/arch/powerpc/platforms/cell/spu_syscalls.c
+++ b/arch/powerpc/platforms/cell/spu_syscalls.c
@@ -65,8 +65,8 @@ static inline void spufs_calls_put(struct spufs_calls *calls) { }
 
 #endif /* CONFIG_SPU_FS_MODULE */
 
-asmlinkage long sys_spu_create(const char __user *name,
-		unsigned int flags, mode_t mode, int neighbor_fd)
+SYSCALL_DEFINE4(spu_create, const char __user *, name,
+		unsigned int, flags, mode_t, mode, int, neighbor_fd)
 {
 	long ret;
 	struct file *neighbor;
@@ -91,7 +91,7 @@ asmlinkage long sys_spu_create(const char __user *name,
 	return ret;
 }
 
-asmlinkage long sys_spu_run(int fd, __u32 __user *unpc, __u32 __user *ustatus)
+SYSCALL_DEFINE3(spu_run, int, fd, __u32 __user *, unpc, __u32 __user *, ustatus)
 {
 	long ret;
 	struct file *filp;
-- 
1.7.1
