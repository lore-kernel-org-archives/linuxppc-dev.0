Return-Path: <mgreer@mvista.com>
Date: Thu, 7 Sep 2006 20:40:36 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: linuxppc-dev <Linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH 5/6] bootwrapper: Add simple memory allocator
Message-ID: <20060908034036.GE5203@mag.az.mvista.com>
References: <20060719231421.GF3887@mag.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060719231421.GF3887@mag.az.mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds a simple memory allocator to the bootwrapper.

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
--

 simple_alloc.c |   48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 48 insertions(+)
--

diff --git a/arch/powerpc/boot/simple_alloc.c b/arch/powerpc/boot/simple_alloc.c
new file mode 100644
index 0000000..ccf61b2
--- /dev/null
+++ b/arch/powerpc/boot/simple_alloc.c
@@ -0,0 +1,48 @@
+/*
+ * Simple memory allocator.
+ *
+ * Author: Mark A. Greer <mgreer@mvista.com>
+ *
+ * 2006 (c) MontaVista, Software, Inc.  This file is licensed under
+ * the terms of the GNU General Public License version 2.  This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+/* Some day, put in a real memory allocator */
+
+#include <stddef.h>
+#include "types.h"
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
+static void *simple_malloc(u32 size)
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
+void simple_alloc_init(void)
+{
+	platform_ops.malloc = simple_malloc;
+	platform_ops.free = NULL;
+}
