Return-Path: <sfr@canb.auug.org.au>
Date: Sun, 11 Sep 2005 02:04:37 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Message-Id: <20050911020437.1a690e1d.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc64-dev <linuxppc64-dev@ozlabs.org>, ppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc: Move arch/ppc*/oprofile/Kconfig to arch/powerpc
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

These files are identical.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---

 arch/powerpc/oprofile/Kconfig |   23 +++++++++++++++++++++++
 arch/ppc/Kconfig              |    2 +-
 arch/ppc/oprofile/Kconfig     |   23 -----------------------
 arch/ppc64/Kconfig            |    2 +-
 arch/ppc64/oprofile/Kconfig   |   23 -----------------------
 5 files changed, 25 insertions(+), 48 deletions(-)
 create mode 100644 arch/powerpc/oprofile/Kconfig
 delete mode 100644 arch/ppc/oprofile/Kconfig
 delete mode 100644 arch/ppc64/oprofile/Kconfig

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

8e32b39f684cae2125255e8c93faa2b45f8ffc58
diff --git a/arch/powerpc/oprofile/Kconfig b/arch/powerpc/oprofile/Kconfig
new file mode 100644
--- /dev/null
+++ b/arch/powerpc/oprofile/Kconfig
@@ -0,0 +1,23 @@
+
+menu "Profiling support"
+	depends on EXPERIMENTAL
+
+config PROFILING
+	bool "Profiling support (EXPERIMENTAL)"
+	help
+	  Say Y here to enable the extended profiling support mechanisms used
+	  by profilers such as OProfile.
+
+
+config OPROFILE
+	tristate "OProfile system profiling (EXPERIMENTAL)"
+	depends on PROFILING
+	help
+	  OProfile is a profiling system capable of profiling the
+	  whole system, include the kernel, kernel modules, libraries,
+	  and applications.
+
+	  If unsure, say N.
+
+endmenu
+
diff --git a/arch/ppc/Kconfig b/arch/ppc/Kconfig
--- a/arch/ppc/Kconfig
+++ b/arch/ppc/Kconfig
@@ -1363,7 +1363,7 @@ endmenu
 
 source "lib/Kconfig"
 
-source "arch/ppc/oprofile/Kconfig"
+source "arch/powerpc/oprofile/Kconfig"
 
 source "arch/ppc/Kconfig.debug"
 
diff --git a/arch/ppc/oprofile/Kconfig b/arch/ppc/oprofile/Kconfig
deleted file mode 100644
--- a/arch/ppc/oprofile/Kconfig
+++ /dev/null
@@ -1,23 +0,0 @@
-
-menu "Profiling support"
-	depends on EXPERIMENTAL
-
-config PROFILING
-	bool "Profiling support (EXPERIMENTAL)"
-	help
-	  Say Y here to enable the extended profiling support mechanisms used
-	  by profilers such as OProfile.
-
-
-config OPROFILE
-	tristate "OProfile system profiling (EXPERIMENTAL)"
-	depends on PROFILING
-	help
-	  OProfile is a profiling system capable of profiling the
-	  whole system, include the kernel, kernel modules, libraries,
-	  and applications.
-
-	  If unsure, say N.
-
-endmenu
-
diff --git a/arch/ppc64/Kconfig b/arch/ppc64/Kconfig
--- a/arch/ppc64/Kconfig
+++ b/arch/ppc64/Kconfig
@@ -465,7 +465,7 @@ config VIOPATH
 	depends on VIOCONS || VIODASD || VIOCD || VIOTAPE || VETH
 	default y
 
-source "arch/ppc64/oprofile/Kconfig"
+source "arch/powerpc/oprofile/Kconfig"
 
 source "arch/ppc64/Kconfig.debug"
 
diff --git a/arch/ppc64/oprofile/Kconfig b/arch/ppc64/oprofile/Kconfig
deleted file mode 100644
--- a/arch/ppc64/oprofile/Kconfig
+++ /dev/null
@@ -1,23 +0,0 @@
-
-menu "Profiling support"
-	depends on EXPERIMENTAL
-
-config PROFILING
-	bool "Profiling support (EXPERIMENTAL)"
-	help
-	  Say Y here to enable the extended profiling support mechanisms used
-	  by profilers such as OProfile.
-	  
-
-config OPROFILE
-	tristate "OProfile system profiling (EXPERIMENTAL)"
-	depends on PROFILING
-	help
-	  OProfile is a profiling system capable of profiling the
-	  whole system, include the kernel, kernel modules, libraries,
-	  and applications.
-
-	  If unsure, say N.
-
-endmenu
-
