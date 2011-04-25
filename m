Return-Path: <ben@decadent.org.uk>
Received: from shadbolt.e.decadent.org.uk (shadbolt.e.decadent.org.uk
	[88.96.1.126]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 54BD6B6EFE
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 25 Apr 2011 11:30:25 +1000 (EST)
From: Ben Hutchings <ben@decadent.org.uk>
To: Paul Gortmaker <paul.gortmaker@windriver.com>, Benjamin Herrenschmidt
	<benh@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 25 Apr 2011 02:04:31 +0100
Message-ID: <1303693471.3032.212.camel@localhost>
Mime-Version: 1.0
Subject: [PATCH] powerpc/kexec: Fix build failure on 32-bit SMP
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit b987812b3fcaf70fdf0037589e5d2f5f2453e6ce left
crash_kexec_wait_realmode() undefined for UP.

Commit 7c7a81b53e581d727d069cc45df5510516faac31 defined it for UP but
left it undefined for 32-bit SMP.

Seems like people are getting confused by nested #ifdef's, so move the
definitions of crash_kexec_wait_realmode() after the #ifdef CONFIG_SMP
section.

Compile-tested with 32-bit UP, 32-bit SMP and 64-bit SMP configurations.

Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/powerpc/kernel/crash.c
+++ b/arch/powerpc/kernel/crash.c
@@ -162,34 +162,6 @@
 	/* Leave the IPI callback set */
 }
=20
-/* wait for all the CPUs to hit real mode but timeout if they don't come i=
n */
-#ifdef CONFIG_PPC_STD_MMU_64
-static void crash_kexec_wait_realmode(int cpu)
-{
-	unsigned int msecs;
-	int i;
-
-	msecs =3D 10000;
-	for (i=3D0; i < NR_CPUS && msecs > 0; i++) {
-		if (i =3D=3D cpu)
-			continue;
-
-		while (paca[i].kexec_state < KEXEC_STATE_REAL_MODE) {
-			barrier();
-			if (!cpu_possible(i)) {
-				break;
-			}
-			if (!cpu_online(i)) {
-				break;
-			}
-			msecs--;
-			mdelay(1);
-		}
-	}
-	mb();
-}
-#endif	/* CONFIG_PPC_STD_MMU_64 */
-
 /*
  * This function will be called by secondary cpus or by kexec cpu
  * if soft-reset is activated to stop some CPUs.
@@ -234,7 +206,6 @@
 }
=20
 #else	/* ! CONFIG_SMP */
-static inline void crash_kexec_wait_realmode(int cpu) {}
=20
 static void crash_kexec_prepare_cpus(int cpu)
 {
@@ -257,6 +228,36 @@
 }
 #endif	/* CONFIG_SMP */
=20
+/* wait for all the CPUs to hit real mode but timeout if they don't come i=
n */
+#if defined(CONFIG_SMP) && defined(CONFIG_PPC_STD_MMU_64)
+static void crash_kexec_wait_realmode(int cpu)
+{
+	unsigned int msecs;
+	int i;
+
+	msecs =3D 10000;
+	for (i=3D0; i < NR_CPUS && msecs > 0; i++) {
+		if (i =3D=3D cpu)
+			continue;
+
+		while (paca[i].kexec_state < KEXEC_STATE_REAL_MODE) {
+			barrier();
+			if (!cpu_possible(i)) {
+				break;
+			}
+			if (!cpu_online(i)) {
+				break;
+			}
+			msecs--;
+			mdelay(1);
+		}
+	}
+	mb();
+}
+#else
+static inline void crash_kexec_wait_realmode(int cpu) {}
+#endif	/* CONFIG_SMP && CONFIG_PPC_STD_MMU_64 */
+
 /*
  * Register a function to be called on shutdown.  Only use this if you
  * can't reset your device in the second kernel.

--=20
Ben Hutchings
Once a job is fouled up, anything done to improve it makes it worse.
