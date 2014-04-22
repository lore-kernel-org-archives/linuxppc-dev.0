Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, hegdevasant@linux.vnet.ibm.com,
 stewart@linux.vnet.ibm.com
Subject: [PATCH 2/6] powerpc/powernv: Remove some OPAL function declaration
 duplication
Date: Tue, 22 Apr 2014 15:01:23 +1000
Message-Id: <1398142887-24109-2-git-send-email-anton@samba.org>
In-Reply-To: <1398142887-24109-1-git-send-email-anton@samba.org>
References: <1398142887-24109-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We had some duplication of the internal OPAL functions.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/include/asm/opal.h | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 2a34485..cb7d52e 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -884,7 +884,8 @@ int64_t opal_set_param(uint64_t token, uint32_t param_id, uint64_t buffer,
 int64_t opal_sensor_read(uint32_t sensor_hndl, int token, __be32 *sensor_data);
 
 /* Internal functions */
-extern int early_init_dt_scan_opal(unsigned long node, const char *uname, int depth, void *data);
+extern int early_init_dt_scan_opal(unsigned long node, const char *uname,
+				   int depth, void *data);
 extern int early_init_dt_scan_recoverable_ranges(unsigned long node,
 				 const char *uname, int depth, void *data);
 
@@ -893,10 +894,6 @@ extern int opal_put_chars(uint32_t vtermno, const char *buf, int total_len);
 
 extern void hvc_opal_init_early(void);
 
-/* Internal functions */
-extern int early_init_dt_scan_opal(unsigned long node, const char *uname,
-				   int depth, void *data);
-
 extern int opal_notifier_register(struct notifier_block *nb);
 extern int opal_notifier_unregister(struct notifier_block *nb);
 
@@ -906,9 +903,6 @@ extern void opal_notifier_enable(void);
 extern void opal_notifier_disable(void);
 extern void opal_notifier_update_evt(uint64_t evt_mask, uint64_t evt_val);
 
-extern int opal_get_chars(uint32_t vtermno, char *buf, int count);
-extern int opal_put_chars(uint32_t vtermno, const char *buf, int total_len);
-
 extern int __opal_async_get_token(void);
 extern int opal_async_get_token_interruptible(void);
 extern int __opal_async_release_token(int token);
@@ -916,8 +910,6 @@ extern int opal_async_release_token(int token);
 extern int opal_async_wait_response(uint64_t token, struct opal_msg *msg);
 extern int opal_get_sensor_data(u32 sensor_hndl, u32 *sensor_data);
 
-extern void hvc_opal_init_early(void);
-
 struct rtc_time;
 extern int opal_set_rtc_time(struct rtc_time *tm);
 extern void opal_get_rtc_time(struct rtc_time *tm);
-- 
1.8.3.2
