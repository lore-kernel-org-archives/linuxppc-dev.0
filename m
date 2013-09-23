Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH 34/39] tty/hvc_opal: powerpc: Make OPAL HVC device tree
 accesses endian safe
Date: Mon, 23 Sep 2013 12:05:08 +1000
Message-Id: <1379901913-5945-35-git-send-email-anton@samba.org>
In-Reply-To: <1379901913-5945-1-git-send-email-anton@samba.org>
References: <1379901913-5945-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/tty/hvc/hvc_opal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/hvc/hvc_opal.c b/drivers/tty/hvc/hvc_opal.c
index cd69b48..6496872 100644
--- a/drivers/tty/hvc/hvc_opal.c
+++ b/drivers/tty/hvc/hvc_opal.c
@@ -329,7 +329,7 @@ static void udbg_init_opal_common(void)
 void __init hvc_opal_init_early(void)
 {
 	struct device_node *stdout_node = NULL;
-	const u32 *termno;
+	const __be32 *termno;
 	const char *name = NULL;
 	const struct hv_ops *ops;
 	u32 index;
@@ -371,7 +371,7 @@ void __init hvc_opal_init_early(void)
 	if (!stdout_node)
 		return;
 	termno = of_get_property(stdout_node, "reg", NULL);
-	index = termno ? *termno : 0;
+	index = termno ? be32_to_cpup(termno) : 0;
 	if (index >= MAX_NR_HVC_CONSOLES)
 		return;
 	hvc_opal_privs[index] = &hvc_opal_boot_priv;
-- 
1.8.1.2
