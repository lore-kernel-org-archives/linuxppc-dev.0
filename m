Return-Path: <James.Hogan@imgtec.com>
Received: from multi.imgtec.com (multi.imgtec.com [194.200.65.239])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "*.imgtec.com",
 Issuer "DigiCert High Assurance CA-3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7435D2C02A5
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Feb 2013 21:10:26 +1100 (EST)
From: James Hogan <james.hogan@imgtec.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND 1/1] arch Kconfig: remove references to IRQ_PER_CPU
Date: Mon, 4 Feb 2013 10:09:43 +0000
Message-ID: <1359972583-17134-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linux-arch@vger.kernel.org, linux-mips@linux-mips.org,
 James Hogan <james.hogan@imgtec.com>, linux-ia64@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-hexagon@vger.kernel.org, Helge Deller <deller@gmx.de>, "James E.J.
 Bottomley" <jejb@parisc-linux.org>, Fenghua Yu <fenghua.yu@intel.com>,
 Paul Mundt <lethal@linux-sh.org>, Mike Frysinger <vapier@gentoo.org>,
 Ralf Baechle <ralf@linux-mips.org>, uclinux-dist-devel@blackfin.uclinux.org,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
 Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The IRQ_PER_CPU Kconfig symbol was removed in the following commit:

Commit 6a58fb3bad099076f36f0f30f44507bc3275cdb6 ("genirq: Remove
CONFIG_IRQ_PER_CPU") merged in v2.6.39-rc1.

But IRQ_PER_CPU wasn't removed from any of the architecture Kconfig
files where it was defined or selected. It's completely unused so remove
the remaining references.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Mike Frysinger <vapier@gentoo.org>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: "James E.J. Bottomley" <jejb@parisc-linux.org>
Cc: Helge Deller <deller@gmx.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Paul Mundt <lethal@linux-sh.org>
Acked-by: Tony Luck <tony.luck@intel.com>
Acked-by: Richard Kuo <rkuo@codeaurora.org>
---

Does anybody want to pick this patch up?

 arch/blackfin/Kconfig |    1 -
 arch/hexagon/Kconfig  |    1 -
 arch/ia64/Kconfig     |    1 -
 arch/mips/Kconfig     |    1 -
 arch/parisc/Kconfig   |    1 -
 arch/powerpc/Kconfig  |    1 -
 arch/sh/Kconfig       |    3 ---
 7 files changed, 0 insertions(+), 9 deletions(-)

diff --git a/arch/blackfin/Kconfig b/arch/blackfin/Kconfig
index b6f3ad5..c709715 100644
--- a/arch/blackfin/Kconfig
+++ b/arch/blackfin/Kconfig
@@ -38,7 +38,6 @@ config BLACKFIN
 	select HAVE_GENERIC_HARDIRQS
 	select GENERIC_ATOMIC64
 	select GENERIC_IRQ_PROBE
-	select IRQ_PER_CPU if SMP
 	select USE_GENERIC_SMP_HELPERS if SMP
 	select HAVE_NMI_WATCHDOG if NMI_WATCHDOG
 	select GENERIC_SMP_IDLE_THREAD
diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
index 0744f7d..800dd9c 100644
--- a/arch/hexagon/Kconfig
+++ b/arch/hexagon/Kconfig
@@ -12,7 +12,6 @@ config HEXAGON
 	# select ARCH_WANT_OPTIONAL_GPIOLIB
 	# select ARCH_REQUIRE_GPIOLIB
 	# select HAVE_CLK
-	# select IRQ_PER_CPU
 	# select GENERIC_PENDING_IRQ if SMP
 	select HAVE_IRQ_WORK
 	select GENERIC_ATOMIC64
diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index 3279646..00c2e88 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -29,7 +29,6 @@ config IA64
 	select ARCH_DISCARD_MEMBLOCK
 	select GENERIC_IRQ_PROBE
 	select GENERIC_PENDING_IRQ if SMP
-	select IRQ_PER_CPU
 	select GENERIC_IRQ_SHOW
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 2ac626a..451c2e7 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2161,7 +2161,6 @@ source "mm/Kconfig"
 config SMP
 	bool "Multi-Processing support"
 	depends on SYS_SUPPORTS_SMP
-	select IRQ_PER_CPU
 	select USE_GENERIC_SMP_HELPERS
 	help
 	  This enables support for systems with more than one CPU. If you have
diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index b77feff..8525be4 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -16,7 +16,6 @@ config PARISC
 	select BROKEN_RODATA
 	select GENERIC_IRQ_PROBE
 	select GENERIC_PCI_IOMAP
-	select IRQ_PER_CPU
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_STRNCPY_FROM_USER
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 17903f1..f3d7090a 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -125,7 +125,6 @@ config PPC
 	select HAVE_GENERIC_HARDIRQS
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select SPARSE_IRQ
-	select IRQ_PER_CPU
 	select IRQ_DOMAIN
 	select GENERIC_IRQ_SHOW
 	select GENERIC_IRQ_SHOW_LEVEL
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index babc2b8..6f799ec 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -91,9 +91,6 @@ config GENERIC_CSUM
 config GENERIC_HWEIGHT
 	def_bool y
 
-config IRQ_PER_CPU
-	def_bool y
-
 config GENERIC_GPIO
 	def_bool n
 
-- 
1.7.7.6
