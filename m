Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH 28/39] powerpc/powernv: Fix endian issues in OPAL console and
 udbg backend
Date: Mon, 23 Sep 2013 12:05:02 +1000
Message-Id: <1379901913-5945-29-git-send-email-anton@samba.org>
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
 arch/powerpc/include/asm/opal.h       |  8 ++++----
 arch/powerpc/platforms/powernv/opal.c | 28 ++++++++++++++++------------
 2 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index c5cd728..6622ea4 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -537,12 +537,12 @@ typedef struct oppanel_line {
 } oppanel_line_t;
 
 /* API functions */
-int64_t opal_console_write(int64_t term_number, int64_t *length,
+int64_t opal_console_write(int64_t term_number, __be64 *length,
 			   const uint8_t *buffer);
-int64_t opal_console_read(int64_t term_number, int64_t *length,
+int64_t opal_console_read(int64_t term_number, __be64 *length,
 			  uint8_t *buffer);
 int64_t opal_console_write_buffer_space(int64_t term_number,
-					int64_t *length);
+					__be64 *length);
 int64_t opal_rtc_read(uint32_t *year_month_day,
 		      uint64_t *hour_minute_second_millisecond);
 int64_t opal_rtc_write(uint32_t year_month_day,
@@ -552,7 +552,7 @@ int64_t opal_cec_reboot(void);
 int64_t opal_read_nvram(uint64_t buffer, uint64_t size, uint64_t offset);
 int64_t opal_write_nvram(uint64_t buffer, uint64_t size, uint64_t offset);
 int64_t opal_handle_interrupt(uint64_t isn, uint64_t *outstanding_event_mask);
-int64_t opal_poll_events(uint64_t *outstanding_event_mask);
+int64_t opal_poll_events(__be64 *outstanding_event_mask);
 int64_t opal_pci_set_hub_tce_memory(uint64_t hub_id, uint64_t tce_mem_addr,
 				    uint64_t tce_mem_size);
 int64_t opal_pci_set_phb_tce_memory(uint64_t phb_id, uint64_t tce_mem_addr,
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 4ffa75e..eb7bf3b 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -164,27 +164,28 @@ void opal_notifier_disable(void)
 
 int opal_get_chars(uint32_t vtermno, char *buf, int count)
 {
-	s64 len, rc;
-	u64 evt;
+	s64 rc;
+	__be64 evt, len;
 
 	if (!opal.entry)
 		return -ENODEV;
 	opal_poll_events(&evt);
-	if ((evt & OPAL_EVENT_CONSOLE_INPUT) == 0)
+	if ((be64_to_cpu(evt) & OPAL_EVENT_CONSOLE_INPUT) == 0)
 		return 0;
-	len = count;
-	rc = opal_console_read(vtermno, &len, buf);
+	len = cpu_to_be64(count);
+	rc = opal_console_read(vtermno, &len, buf);	
 	if (rc == OPAL_SUCCESS)
-		return len;
+		return be64_to_cpu(len);
 	return 0;
 }
 
 int opal_put_chars(uint32_t vtermno, const char *data, int total_len)
 {
 	int written = 0;
+	__be64 olen;
 	s64 len, rc;
 	unsigned long flags;
-	u64 evt;
+	__be64 evt;
 
 	if (!opal.entry)
 		return -ENODEV;
@@ -199,13 +200,14 @@ int opal_put_chars(uint32_t vtermno, const char *data, int total_len)
 	 */
 	spin_lock_irqsave(&opal_write_lock, flags);
 	if (firmware_has_feature(FW_FEATURE_OPALv2)) {
-		rc = opal_console_write_buffer_space(vtermno, &len);
+		rc = opal_console_write_buffer_space(vtermno, &olen);
+		len = be64_to_cpu(olen);
 		if (rc || len < total_len) {
 			spin_unlock_irqrestore(&opal_write_lock, flags);
 			/* Closed -> drop characters */
 			if (rc)
 				return total_len;
-			opal_poll_events(&evt);
+			opal_poll_events(NULL);
 			return -EAGAIN;
 		}
 	}
@@ -216,8 +218,9 @@ int opal_put_chars(uint32_t vtermno, const char *data, int total_len)
 	rc = OPAL_BUSY;
 	while(total_len > 0 && (rc == OPAL_BUSY ||
 				rc == OPAL_BUSY_EVENT || rc == OPAL_SUCCESS)) {
-		len = total_len;
-		rc = opal_console_write(vtermno, &len, data);
+		olen = cpu_to_be64(total_len);
+		rc = opal_console_write(vtermno, &olen, data);
+		len = be64_to_cpu(olen);
 
 		/* Closed or other error drop */
 		if (rc != OPAL_SUCCESS && rc != OPAL_BUSY &&
@@ -237,7 +240,8 @@ int opal_put_chars(uint32_t vtermno, const char *data, int total_len)
 		 */
 		do
 			opal_poll_events(&evt);
-		while(rc == OPAL_SUCCESS && (evt & OPAL_EVENT_CONSOLE_OUTPUT));
+		while(rc == OPAL_SUCCESS &&
+			(be64_to_cpu(evt) & OPAL_EVENT_CONSOLE_OUTPUT));
 	}
 	spin_unlock_irqrestore(&opal_write_lock, flags);
 	return written;
-- 
1.8.1.2
