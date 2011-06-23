Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 976CAB6FA0
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Jun 2011 21:34:07 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Greg KH <greg@kroah.com>
Subject: [PATCH v3 1/3] driver core: Add ability for arch code to setup
	pdev_archdata
Date: Thu, 23 Jun 2011 06:33:57 -0500
Message-Id: <1308828839-27349-1-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1308744176-24491-1-git-send-email-galak@kernel.crashing.org>
References: <1308744176-24491-1-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On some architectures we need to setup pdev_archdata before we add the
device.  Waiting til a bus_notifier is too late since we might need the
pdev_archdata in the bus notifier.  One example is setting up of dma_mask
pointers such that it can be used in a bus_notifier.

We add noop version of arch_setup_pdev_archdata() in
<asm-generic/platform_device.h> and allow the arch code to override with
access the full definitions of struct device, struct platform_device, and
struct pdev_archdata.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
v3:
* Add more comments and add missing call to arch_setup_pdev_archdata in
  platform_device_register
v2:
* Added license, and comments about arch_setup_pdev_archdata()
  per Mike's comments

 arch/alpha/include/asm/platform_device.h      |    1 +
 arch/arm/include/asm/platform_device.h        |    1 +
 arch/avr32/include/asm/platform_device.h      |    1 +
 arch/blackfin/include/asm/platform_device.h   |    1 +
 arch/cris/include/asm/platform_device.h       |    1 +
 arch/frv/include/asm/platform_device.h        |    1 +
 arch/h8300/include/asm/platform_device.h      |    1 +
 arch/ia64/include/asm/platform_device.h       |    1 +
 arch/m32r/include/asm/platform_device.h       |    1 +
 arch/m68k/include/asm/platform_device.h       |    1 +
 arch/microblaze/include/asm/platform_device.h |    1 +
 arch/mips/include/asm/platform_device.h       |    1 +
 arch/mn10300/include/asm/platform_device.h    |    1 +
 arch/parisc/include/asm/platform_device.h     |    1 +
 arch/powerpc/include/asm/platform_device.h    |    1 +
 arch/s390/include/asm/platform_device.h       |    1 +
 arch/score/include/asm/platform_device.h      |    1 +
 arch/sh/include/asm/platform_device.h         |    1 +
 arch/sparc/include/asm/platform_device.h      |    1 +
 arch/tile/include/asm/platform_device.h       |    1 +
 arch/unicore32/include/asm/platform_device.h  |    1 +
 arch/x86/include/asm/platform_device.h        |    1 +
 arch/xtensa/include/asm/platform_device.h     |    1 +
 drivers/base/platform.c                       |    3 ++
 include/asm-generic/platform_device.h         |   41 +++++++++++++++++++++++++
 25 files changed, 67 insertions(+), 0 deletions(-)
 create mode 100644 arch/alpha/include/asm/platform_device.h
 create mode 100644 arch/arm/include/asm/platform_device.h
 create mode 100644 arch/avr32/include/asm/platform_device.h
 create mode 100644 arch/blackfin/include/asm/platform_device.h
 create mode 100644 arch/cris/include/asm/platform_device.h
 create mode 100644 arch/frv/include/asm/platform_device.h
 create mode 100644 arch/h8300/include/asm/platform_device.h
 create mode 100644 arch/ia64/include/asm/platform_device.h
 create mode 100644 arch/m32r/include/asm/platform_device.h
 create mode 100644 arch/m68k/include/asm/platform_device.h
 create mode 100644 arch/microblaze/include/asm/platform_device.h
 create mode 100644 arch/mips/include/asm/platform_device.h
 create mode 100644 arch/mn10300/include/asm/platform_device.h
 create mode 100644 arch/parisc/include/asm/platform_device.h
 create mode 100644 arch/powerpc/include/asm/platform_device.h
 create mode 100644 arch/s390/include/asm/platform_device.h
 create mode 100644 arch/score/include/asm/platform_device.h
 create mode 100644 arch/sh/include/asm/platform_device.h
 create mode 100644 arch/sparc/include/asm/platform_device.h
 create mode 100644 arch/tile/include/asm/platform_device.h
 create mode 100644 arch/unicore32/include/asm/platform_device.h
 create mode 100644 arch/x86/include/asm/platform_device.h
 create mode 100644 arch/xtensa/include/asm/platform_device.h
 create mode 100644 include/asm-generic/platform_device.h

diff --git a/arch/alpha/include/asm/platform_device.h b/arch/alpha/include/asm/platform_device.h
new file mode 100644
index 0000000..01452c3
--- /dev/null
+++ b/arch/alpha/include/asm/platform_device.h
@@ -0,0 +1 @@
+#include <asm-generic/platform_device.h>
diff --git a/arch/arm/include/asm/platform_device.h b/arch/arm/include/asm/platform_device.h
new file mode 100644
index 0000000..01452c3
--- /dev/null
+++ b/arch/arm/include/asm/platform_device.h
@@ -0,0 +1 @@
+#include <asm-generic/platform_device.h>
diff --git a/arch/avr32/include/asm/platform_device.h b/arch/avr32/include/asm/platform_device.h
new file mode 100644
index 0000000..01452c3
--- /dev/null
+++ b/arch/avr32/include/asm/platform_device.h
@@ -0,0 +1 @@
+#include <asm-generic/platform_device.h>
diff --git a/arch/blackfin/include/asm/platform_device.h b/arch/blackfin/include/asm/platform_device.h
new file mode 100644
index 0000000..01452c3
--- /dev/null
+++ b/arch/blackfin/include/asm/platform_device.h
@@ -0,0 +1 @@
+#include <asm-generic/platform_device.h>
diff --git a/arch/cris/include/asm/platform_device.h b/arch/cris/include/asm/platform_device.h
new file mode 100644
index 0000000..01452c3
--- /dev/null
+++ b/arch/cris/include/asm/platform_device.h
@@ -0,0 +1 @@
+#include <asm-generic/platform_device.h>
diff --git a/arch/frv/include/asm/platform_device.h b/arch/frv/include/asm/platform_device.h
new file mode 100644
index 0000000..01452c3
--- /dev/null
+++ b/arch/frv/include/asm/platform_device.h
@@ -0,0 +1 @@
+#include <asm-generic/platform_device.h>
diff --git a/arch/h8300/include/asm/platform_device.h b/arch/h8300/include/asm/platform_device.h
new file mode 100644
index 0000000..01452c3
--- /dev/null
+++ b/arch/h8300/include/asm/platform_device.h
@@ -0,0 +1 @@
+#include <asm-generic/platform_device.h>
diff --git a/arch/ia64/include/asm/platform_device.h b/arch/ia64/include/asm/platform_device.h
new file mode 100644
index 0000000..01452c3
--- /dev/null
+++ b/arch/ia64/include/asm/platform_device.h
@@ -0,0 +1 @@
+#include <asm-generic/platform_device.h>
diff --git a/arch/m32r/include/asm/platform_device.h b/arch/m32r/include/asm/platform_device.h
new file mode 100644
index 0000000..01452c3
--- /dev/null
+++ b/arch/m32r/include/asm/platform_device.h
@@ -0,0 +1 @@
+#include <asm-generic/platform_device.h>
diff --git a/arch/m68k/include/asm/platform_device.h b/arch/m68k/include/asm/platform_device.h
new file mode 100644
index 0000000..01452c3
--- /dev/null
+++ b/arch/m68k/include/asm/platform_device.h
@@ -0,0 +1 @@
+#include <asm-generic/platform_device.h>
diff --git a/arch/microblaze/include/asm/platform_device.h b/arch/microblaze/include/asm/platform_device.h
new file mode 100644
index 0000000..01452c3
--- /dev/null
+++ b/arch/microblaze/include/asm/platform_device.h
@@ -0,0 +1 @@
+#include <asm-generic/platform_device.h>
diff --git a/arch/mips/include/asm/platform_device.h b/arch/mips/include/asm/platform_device.h
new file mode 100644
index 0000000..01452c3
--- /dev/null
+++ b/arch/mips/include/asm/platform_device.h
@@ -0,0 +1 @@
+#include <asm-generic/platform_device.h>
diff --git a/arch/mn10300/include/asm/platform_device.h b/arch/mn10300/include/asm/platform_device.h
new file mode 100644
index 0000000..01452c3
--- /dev/null
+++ b/arch/mn10300/include/asm/platform_device.h
@@ -0,0 +1 @@
+#include <asm-generic/platform_device.h>
diff --git a/arch/parisc/include/asm/platform_device.h b/arch/parisc/include/asm/platform_device.h
new file mode 100644
index 0000000..01452c3
--- /dev/null
+++ b/arch/parisc/include/asm/platform_device.h
@@ -0,0 +1 @@
+#include <asm-generic/platform_device.h>
diff --git a/arch/powerpc/include/asm/platform_device.h b/arch/powerpc/include/asm/platform_device.h
new file mode 100644
index 0000000..01452c3
--- /dev/null
+++ b/arch/powerpc/include/asm/platform_device.h
@@ -0,0 +1 @@
+#include <asm-generic/platform_device.h>
diff --git a/arch/s390/include/asm/platform_device.h b/arch/s390/include/asm/platform_device.h
new file mode 100644
index 0000000..01452c3
--- /dev/null
+++ b/arch/s390/include/asm/platform_device.h
@@ -0,0 +1 @@
+#include <asm-generic/platform_device.h>
diff --git a/arch/score/include/asm/platform_device.h b/arch/score/include/asm/platform_device.h
new file mode 100644
index 0000000..01452c3
--- /dev/null
+++ b/arch/score/include/asm/platform_device.h
@@ -0,0 +1 @@
+#include <asm-generic/platform_device.h>
diff --git a/arch/sh/include/asm/platform_device.h b/arch/sh/include/asm/platform_device.h
new file mode 100644
index 0000000..01452c3
--- /dev/null
+++ b/arch/sh/include/asm/platform_device.h
@@ -0,0 +1 @@
+#include <asm-generic/platform_device.h>
diff --git a/arch/sparc/include/asm/platform_device.h b/arch/sparc/include/asm/platform_device.h
new file mode 100644
index 0000000..01452c3
--- /dev/null
+++ b/arch/sparc/include/asm/platform_device.h
@@ -0,0 +1 @@
+#include <asm-generic/platform_device.h>
diff --git a/arch/tile/include/asm/platform_device.h b/arch/tile/include/asm/platform_device.h
new file mode 100644
index 0000000..01452c3
--- /dev/null
+++ b/arch/tile/include/asm/platform_device.h
@@ -0,0 +1 @@
+#include <asm-generic/platform_device.h>
diff --git a/arch/unicore32/include/asm/platform_device.h b/arch/unicore32/include/asm/platform_device.h
new file mode 100644
index 0000000..01452c3
--- /dev/null
+++ b/arch/unicore32/include/asm/platform_device.h
@@ -0,0 +1 @@
+#include <asm-generic/platform_device.h>
diff --git a/arch/x86/include/asm/platform_device.h b/arch/x86/include/asm/platform_device.h
new file mode 100644
index 0000000..01452c3
--- /dev/null
+++ b/arch/x86/include/asm/platform_device.h
@@ -0,0 +1 @@
+#include <asm-generic/platform_device.h>
diff --git a/arch/xtensa/include/asm/platform_device.h b/arch/xtensa/include/asm/platform_device.h
new file mode 100644
index 0000000..01452c3
--- /dev/null
+++ b/arch/xtensa/include/asm/platform_device.h
@@ -0,0 +1 @@
+#include <asm-generic/platform_device.h>
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 1c291af..f554045 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -20,6 +20,7 @@
 #include <linux/err.h>
 #include <linux/slab.h>
 #include <linux/pm_runtime.h>
+#include <asm/platform_device.h>
 
 #include "base.h"
 
@@ -173,6 +174,7 @@ struct platform_device *platform_device_alloc(const char *name, int id)
 		pa->pdev.id = id;
 		device_initialize(&pa->pdev.dev);
 		pa->pdev.dev.release = platform_device_release;
+		arch_setup_pdev_archdata(&pa->pdev);
 	}
 
 	return pa ? &pa->pdev : NULL;
@@ -334,6 +336,7 @@ EXPORT_SYMBOL_GPL(platform_device_del);
 int platform_device_register(struct platform_device *pdev)
 {
 	device_initialize(&pdev->dev);
+	arch_setup_pdev_archdata(pdev);
 	return platform_device_add(pdev);
 }
 EXPORT_SYMBOL_GPL(platform_device_register);
diff --git a/include/asm-generic/platform_device.h b/include/asm-generic/platform_device.h
new file mode 100644
index 0000000..c03570c
--- /dev/null
+++ b/include/asm-generic/platform_device.h
@@ -0,0 +1,41 @@
+/*
+ * include/asm-generic/platform_device.h
+ *
+ * Provides a callout when we allocate a platform device to architecture code
+ * to update archdata.
+ *
+ * Copyright 2011 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * You should have received a copy of the GNU General Public License
+ * (for example /usr/src/linux/COPYING); if not, write to the Free
+ * Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+#ifndef __ASM_GENERIC_PLATFORM_DEVICE_H_
+#define __ASM_GENERIC_PLATFORM_DEVICE_H_
+
+struct platform_device;
+
+/*
+ * an architecture can override to define arch_setup_pdev_archdata
+ * 
+ * This is called before platform_device_add() such that any pdev_archdata may
+ * be setup before the platform_notifier is called.  So if a user needs to
+ * manipulate any relevant information in the pdev_archdata they can do:
+ *
+ * 	platform_devic_alloc()
+ * 	... manipulate ...
+ * 	platform_device_add()
+ *
+ * And if they don't care they can just call platform_device_register() and
+ * everything will just work out.
+ */
+#ifndef arch_setup_pdev_archdata
+static inline void arch_setup_pdev_archdata(struct platform_device *pdev) { }
+#endif
+
+#endif /* __ASM_GENERIC_PLATFORM_DEVICE_H_ */
-- 
1.7.3.4
