Return-Path: <anton@samba.org>
Date: Thu, 27 Mar 2014 16:19:42 +1100
From: Anton Blanchard <anton@samba.org>
To: stewart@linux.vnet.ibm.com, benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH 2/4] powerpc/powernv: Remove some OPAL function declaration
 duplication
Message-ID: <20140327161942.795916f6@kryten>
In-Reply-To: <20140327161849.791432d0@kryten>
References: <20140327161849.791432d0@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

Index: b/arch/powerpc/include/asm/opal.h
===================================================================
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -877,7 +877,8 @@ int64_t opal_sensor_read(uint32_t sensor
 		uint32_t *sensor_data);
 
 /* Internal functions */
-extern int early_init_dt_scan_opal(unsigned long node, const char *uname, int depth, void *data);
+extern int early_init_dt_scan_opal(unsigned long node, const char *uname,
+				   int depth, void *data);
 extern int early_init_dt_scan_recoverable_ranges(unsigned long node,
 				 const char *uname, int depth, void *data);
 
@@ -886,10 +887,6 @@ extern int opal_put_chars(uint32_t vterm
 
 extern void hvc_opal_init_early(void);
 
-/* Internal functions */
-extern int early_init_dt_scan_opal(unsigned long node, const char *uname,
-				   int depth, void *data);
-
 extern int opal_notifier_register(struct notifier_block *nb);
 extern int opal_message_notifier_register(enum OpalMessageType msg_type,
 						struct notifier_block *nb);
@@ -897,9 +894,6 @@ extern void opal_notifier_enable(void);
 extern void opal_notifier_disable(void);
 extern void opal_notifier_update_evt(uint64_t evt_mask, uint64_t evt_val);
 
-extern int opal_get_chars(uint32_t vtermno, char *buf, int count);
-extern int opal_put_chars(uint32_t vtermno, const char *buf, int total_len);
-
 extern int __opal_async_get_token(void);
 extern int opal_async_get_token_interruptible(void);
 extern int __opal_async_release_token(int token);
@@ -907,8 +901,6 @@ extern int opal_async_release_token(int
 extern int opal_async_wait_response(uint64_t token, struct opal_msg *msg);
 extern int opal_get_sensor_data(u32 sensor_hndl, u32 *sensor_data);
 
-extern void hvc_opal_init_early(void);
-
 struct rtc_time;
 extern int opal_set_rtc_time(struct rtc_time *tm);
 extern void opal_get_rtc_time(struct rtc_time *tm);
