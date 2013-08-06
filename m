Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH 22/63] powerpc: Make device tree accesses in HVC VIO console
 endian safe
Date: Wed,  7 Aug 2013 02:01:39 +1000
Message-Id: <1375804940-22050-23-git-send-email-anton@samba.org>
In-Reply-To: <1375804940-22050-1-git-send-email-anton@samba.org>
References: <1375804940-22050-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 drivers/tty/hvc/hvc_vio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/hvc/hvc_vio.c b/drivers/tty/hvc/hvc_vio.c
index 0c62980..c791b18 100644
--- a/drivers/tty/hvc/hvc_vio.c
+++ b/drivers/tty/hvc/hvc_vio.c
@@ -404,7 +404,7 @@ module_exit(hvc_vio_exit);
 void __init hvc_vio_init_early(void)
 {
 	struct device_node *stdout_node;
-	const u32 *termno;
+	const __be32 *termno;
 	const char *name;
 	const struct hv_ops *ops;
 
@@ -429,7 +429,7 @@ void __init hvc_vio_init_early(void)
 	termno = of_get_property(stdout_node, "reg", NULL);
 	if (termno == NULL)
 		goto out;
-	hvterm_priv0.termno = *termno;
+	hvterm_priv0.termno = of_read_number(termno, 1);
 	spin_lock_init(&hvterm_priv0.buf_lock);
 	hvterm_privs[0] = &hvterm_priv0;
 
-- 
1.8.1.2
