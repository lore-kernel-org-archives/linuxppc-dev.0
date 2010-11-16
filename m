Return-Path: <dirk.brandewie@gmail.com>
From: dirk.brandewie@gmail.com
To: devicetree-discuss@lists.ozlabs.org
Subject: [PATCH 3/5] x86/of:  Add building device tree blob(s) into image.
Date: Tue, 16 Nov 2010 14:41:38 -0800
Message-Id: <35263573f57fd7e780dede628cf489212bfa1400.1289943240.git.dirk.brandewie@gmail.com>
In-Reply-To: <cover.1289943240.git.dirk.brandewie@gmail.com>
References: <cover.1289943240.git.dirk.brandewie@gmail.com>
Cc: linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	sodaville@linutronix.de, microblaze-uclinux@itee.uq.edu.au,
	dirk.brandewie@gmail.com, arjan@linux.intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Dirk Brandewie <dirk.brandewie@gmail.com>

This patch adds linking device tree blobs into vmlinux. DTB's are
added by adding the blob object name to list of objects to be linked
into the image.
e.g:
  obj-$(CONFIG_TEST_DTB) += test.dtb.o

The set of DTB linked into the image is controlled the Kconfig file
in arch/x86/kernel/dts/Kconfig

Signed-off-by: Dirk Brandewie <dirk.brandewie@gmail.com>
---
 arch/x86/Kconfig            |    6 +++++-
 arch/x86/kernel/Makefile    |    6 ++++++
 arch/x86/kernel/dts/Kconfig |    7 +++++++
 3 files changed, 18 insertions(+), 1 deletions(-)
 create mode 100644 arch/x86/kernel/dts/Kconfig

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 5904f38..f2f516a 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -299,13 +299,17 @@ config X86_BIGSMP
 	---help---
 	  This option is needed for the systems that have more than 8 CPUs
 
-config X86_OF
+menuconfig X86_OF
 	bool "Support for device tree"
 	select OF
 	select OF_FLATTREE
 	---help---
 	  Device tree support on X86.
 
+if X86_OF
+source arch/x86/kernel/dts/Kconfig
+endif
+
 if X86_32
 config X86_EXTENDED_PLATFORM
 	bool "Support for extended (non-PC) x86 platforms"
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 586df14..49e017d 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -114,6 +114,12 @@ obj-$(CONFIG_SWIOTLB)			+= pci-swiotlb.o
 obj-$(CONFIG_X86_OF)			+= prom.o
 
 ###
+# device tree blobs
+obj-$(CONFIG_CE4100_DTB) += ce4100.dtb.o
+obj-$(CONFIG_TEST_DTB) += test.dtb.o
+
+
+###
 # 64 bit specific files
 ifeq ($(CONFIG_X86_64),y)
 	obj-$(CONFIG_AUDIT)		+= audit_64.o
diff --git a/arch/x86/kernel/dts/Kconfig b/arch/x86/kernel/dts/Kconfig
new file mode 100644
index 0000000..d3e5cd4
--- /dev/null
+++ b/arch/x86/kernel/dts/Kconfig
@@ -0,0 +1,7 @@
+config CE4100_DTB
+       bool "Intel CE4100"
+
+config TEST_DTB
+       bool "Test DTS"
+
+
-- 
1.7.2.3
