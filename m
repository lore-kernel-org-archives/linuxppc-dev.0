Return-Path: <geoff@white.local.net>
Message-Id: <20070912084314.190886340@am.sony.com>
References: <20070912084314.057513210@am.sony.com>
Date: Wed, 12 Sep 2007 01:43:15 -0700
From: geoffrey.levand@am.sony.com
To: paulus@samba.org
Subject: [patch 1/3] PS3: Fix CONFIG_SMP=n, CONFIG_KEXEC=y build
Cc: linuxppc-dev@ozlabs.org, Jeremy Kerr <jk@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Jeremy Kerr <jk@ozlabs.org>

Currently, the ps3 kernel fails to build without smp but with kexec, as
ps3_kexec_cpu_down needs ps3_smp_cleanup_cpu, which isn't defined on UP
kernels. This change adds an empty ps3_smp_cleanup_cpu for UP kernels.

Booted on ps3.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
 arch/powerpc/platforms/ps3/platform.h |    4 ++++
 1 file changed, 4 insertions(+)

--- a/arch/powerpc/platforms/ps3/platform.h
+++ b/arch/powerpc/platforms/ps3/platform.h
@@ -47,7 +47,11 @@ void __init ps3_register_ipi_debug_brk(u
 /* smp */
 
 void smp_init_ps3(void);
+#ifdef CONFIG_SMP
 void ps3_smp_cleanup_cpu(int cpu);
+#else
+static inline void ps3_smp_cleanup_cpu(int cpu) { }
+#endif
 
 /* time */
 

-- 
