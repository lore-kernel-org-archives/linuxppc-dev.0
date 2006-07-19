Return-Path: <mgreer@mvista.com>
Date: Wed, 19 Jul 2006 16:14:21 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: linuxppc-dev <Linuxppc-dev@ozlabs.org>
Subject: [PATCH 5/6] bootwrapper: Add support for the DINK firmware
Message-ID: <20060719231421.GF3887@mag.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds the firmware operations that support the DINK firmware
from Freescale.

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
--

 dink.c |   56 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 56 insertions(+)
--

diff --git a/arch/powerpc/boot/dink.c b/arch/powerpc/boot/dink.c
new file mode 100644
index 0000000..aa446e2
--- /dev/null
+++ b/arch/powerpc/boot/dink.c
@@ -0,0 +1,56 @@
+/*
+ * Sandpoint specific fixups.
+ *
+ * Author: Mark A. Greer <mgreer@mvista.com>
+ *
+ * 2006 (c) MontaVista, Software, Inc.  This file is licensed under
+ * the terms of the GNU General Public License version 2.  This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#include <stdarg.h>
+#include <stddef.h>
+#include "types.h"
+#include "string.h"
+#include "stdio.h"
+#include "page.h"
+#include "ops.h"
+
+#define	MB	(1024*1024)
+
+extern char _end[];
+
+static u32	cur_base;
+static u32	end_of_ram = 32 * MB;
+
+static void *
+dink_malloc(u32 size)
+{
+	void *area = NULL;
+	static u8 first_time = 1;
+
+	if (first_time) {
+		cur_base = _ALIGN_UP((unsigned long)_end, MB);
+		first_time = 0;
+	}
+
+	if ((cur_base + size) < end_of_ram) {
+		area = (void *)cur_base;
+		cur_base += _ALIGN_UP(size, MB);
+	}
+
+	return area;
+}
+
+static struct fw_ops dink_fw_ops;
+
+struct fw_ops *
+dink_init(void)
+{
+	dink_fw_ops.malloc = dink_malloc;
+	dink_fw_ops.free = NULL;
+	dink_fw_ops.exit = NULL;
+
+	return &dink_fw_ops;
+}
