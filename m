Return-Path: <sfr@canb.auug.org.au>
Date: Mon, 19 Sep 2005 23:13:24 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Message-Id: <20050919231324.426e3dae.sfr@canb.auug.org.au>
In-Reply-To: <20050919231051.28fcdf30.sfr@canb.auug.org.au>
References: <20050919231051.28fcdf30.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc64-dev <linuxppc64-dev@ozlabs.org>, ppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH 1/6] powerpc: Move arch/ppc*/oprofile/Kconfig to arch/powerpc
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

51b2e663af2bae454a5e4737dfb0b7e0c4898b2f
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
@@ -1370,7 +1370,7 @@ endmenu
 
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
@@ -461,7 +461,7 @@ config VIOPATH
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
