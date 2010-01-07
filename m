Return-Path: <jk@ozlabs.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Subject: [PATCH] proc_devtree: fix THIS_MODULE without module.h
Message-Id: <1262830753.577814.127040702434.1.gpush@pororo>
To: linuxppc-dev@lists.ozlabs.org
From: Jeremy Kerr <jeremy.kerr@canonical.com>
Date: Thu, 07 Jan 2010 13:19:13 +1100
Cc: Alexey Dobriyan <adobriyan@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit e22f628395432b967f2f505858c64450f7835365 introduced a build
breakage for ARM devtree work: the THIS_MODULE macro was added, but we
don't have module.h

This change adds the necessary #include to get THIS_MODULE defined.
While we could just replace it with NULL (PROC_FS is a bool, not a
tristate), using THIS_MODULE will prevent unexpected breakage if we
ever do compile this as a module.

Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>

---
 fs/proc/proc_devtree.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/proc/proc_devtree.c b/fs/proc/proc_devtree.c
index 0ec4511..f8650dc 100644
--- a/fs/proc/proc_devtree.c
+++ b/fs/proc/proc_devtree.c
@@ -11,6 +11,7 @@
 #include <linux/stat.h>
 #include <linux/string.h>
 #include <linux/of.h>
+#include <linux/module.h>
 #include <asm/prom.h>
 #include <asm/uaccess.h>
 #include "internal.h"
