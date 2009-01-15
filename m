Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <3922453a668745466cb291f889d2c067932e4894.1232001793.git.michael@ellerman.id.au>
In-Reply-To: <e3520e2f9806d4f6e4b30587b6d29176e583833d.1232001793.git.michael@ellerman.id.au>
References: <e3520e2f9806d4f6e4b30587b6d29176e583833d.1232001793.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 2/4] powerpc: Add ppc_progress() wrapper
Date: Thu, 15 Jan 2009 17:43:17 +1100 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

There's quite a lot of code that does:

if (ppc_md.progress)
	ppc_md.progress(...)

So move that idiom into a wrapper. Having a wrapper also allows us
to have a fallback to printk if no progress routine is specified.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/include/asm/machdep.h |    2 ++
 arch/powerpc/kernel/setup-common.c |    8 ++++++++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index 6c34a0d..9e4ab07 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -328,6 +328,8 @@ extern void __devinit smp_generic_take_timebase(void);
 /* Print a boot progress message. */
 void ppc64_boot_msg(unsigned int src, const char *msg);
 
+extern void ppc_progress(char *msg, unsigned short code);
+
 static inline void log_error(char *buf, unsigned int err_type, int fatal)
 {
 	if (ppc_md.log_error)
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 705fc4b..cc4997b 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -669,3 +669,11 @@ static int powerpc_debugfs_init(void)
 }
 arch_initcall(powerpc_debugfs_init);
 #endif
+
+void ppc_progress(char *msg, unsigned short code)
+{
+	if (ppc_md.progress)
+		ppc_md.progress(msg, code);
+	else
+		printk(KERN_DEBUG "*** %04x : %s\n", code, msg ? msg : "");
+}
-- 
1.5.5
