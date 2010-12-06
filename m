Return-Path: <dirk.brandewie@gmail.com>
From: dirk.brandewie@gmail.com
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] x86/of: Add building device tree blob(s) into image.
Date: Mon,  6 Dec 2010 09:36:00 -0800
Message-Id: <b5a8dfa4d580d8637132f81317390a535ab98511.1291656753.git.dirk.brandewie@gmail.com>
In-Reply-To: <cover.1291656753.git.dirk.brandewie@gmail.com>
References: <cover.1291656753.git.dirk.brandewie@gmail.com>
Cc: linux-arch@vger.kernel.org, mmarek@suse.cz,
	microblaze-uclinux@itee.uq.edu.au,
	devicetree-discuss@lists.ozlabs.org, sodaville@linutronix.de,
	Dirk Brandewie <dirk.brandewie@gmail.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Dirk Brandewie <dirk.brandewie@gmail.com>

This patch adds linking device tree blob into vmlinux. DTB's are
added by adding the blob object name to list of objects to be linked
into the image.

Signed-off-by: Dirk Brandewie <dirk.brandewie@gmail.com>
---
 arch/x86/platform/ce4100/Makefile |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/x86/platform/ce4100/Makefile b/arch/x86/platform/ce4100/Makefile
index 91fc929..3b49187 100644
--- a/arch/x86/platform/ce4100/Makefile
+++ b/arch/x86/platform/ce4100/Makefile
@@ -1 +1,11 @@
 obj-$(CONFIG_X86_INTEL_CE)	+= ce4100.o
+clean-files := *dtb.S
+
+ifdef CONFIG_X86_OF
+###
+# device tree blob
+obj-$(CONFIG_X86_INTEL_CE) += ce4100.dtb.o
+
+$(obj)/%.dtb: $(src)/%.dts
+	$(call if_changed,dtc)
+endif
-- 
1.7.2.3
