Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: benh@kernel.crashing.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@ozlabs.org, sfr@canb.auug.org.au,
 Paul Gortmaker <paul.gortmaker@windriver.com>,
 torvalds@linux-foundation.org
Subject: [PATCH] powerpc: fix building hvc_opal.c
In-reply-to: <26327.1320645941@neuling.org>
References: <26327.1320645941@neuling.org>
Date: Mon, 07 Nov 2011 17:12:28 +1100
Message-ID: <26601.1320646348@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fix building following build error:
drivers/tty/hvc/hvc_opal.c:244:12: error: 'THIS_MODULE' undeclared here (not in a function)

Signed-off-by: Michael Neuling <mikey@neuling.org>
--
Actually, this is the right fix.

sfr says this was a merge conflict between the module.h split up and the
powerpc tree, which were both merged by Linus today.

diff --git a/drivers/tty/hvc/hvc_opal.c b/drivers/tty/hvc/hvc_opal.c
index 7b38512..ced26c8 100644
--- a/drivers/tty/hvc/hvc_opal.c
+++ b/drivers/tty/hvc/hvc_opal.c
@@ -28,6 +28,7 @@
 #include <linux/console.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
+#include <linux/export.h>
 
 #include <asm/hvconsole.h>
 #include <asm/prom.h>
