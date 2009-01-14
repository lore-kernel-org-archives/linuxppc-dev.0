Return-Path: <sfr@canb.auug.org.au>
Date: Wed, 14 Jan 2009 17:10:06 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: [PATCH 11/13] powerpc/ps3: printing fixups for l64 to ll64
	conversion: drivers/ps3
Message-Id: <20090114171006.d5af608e.sfr@canb.auug.org.au>
In-Reply-To: <20090114165450.ebbc11a7.sfr@canb.auug.org.au>
References: <20090114165450.ebbc11a7.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Also some min -> mint_t conversion.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/ps3/ps3-lpm.c     |   16 ++++++++--------
 drivers/ps3/ps3-vuart.c   |    8 ++++----
 drivers/ps3/ps3stor_lib.c |   14 +++++++-------
 3 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/ps3/ps3-lpm.c b/drivers/ps3/ps3-lpm.c
index 204158c..fe96793 100644
--- a/drivers/ps3/ps3-lpm.c
+++ b/drivers/ps3/ps3-lpm.c
@@ -732,7 +732,7 @@ static u64 pm_signal_group_to_ps3_lv1_signal_group(u64 group)
 	case 8:
 		return pm_translate_signal_group_number_on_island8(subgroup);
 	default:
-		dev_dbg(sbd_core(), "%s:%u: island not found: %lu\n", __func__,
+		dev_dbg(sbd_core(), "%s:%u: island not found: %llu\n", __func__,
 			__LINE__, group);
 		BUG();
 		break;
@@ -765,7 +765,7 @@ static int __ps3_set_signal(u64 lv1_signal_group, u64 bus_select,
 				 signal_select, attr1, attr2, attr3);
 	if (ret)
 		dev_err(sbd_core(),
-			"%s:%u: error:%d 0x%lx 0x%lx 0x%lx 0x%lx 0x%lx 0x%lx\n",
+			"%s:%u: error:%d 0x%llx 0x%llx 0x%llx 0x%llx 0x%llx 0x%llx\n",
 			__func__, __LINE__, ret, lv1_signal_group, bus_select,
 			signal_select, attr1, attr2, attr3);
 
@@ -908,7 +908,7 @@ void ps3_disable_pm(u32 cpu)
 
 	lpm_priv->tb_count = tmp;
 
-	dev_dbg(sbd_core(), "%s:%u: tb_count %lu (%lxh)\n", __func__, __LINE__,
+	dev_dbg(sbd_core(), "%s:%u: tb_count %llu (%llxh)\n", __func__, __LINE__,
 		lpm_priv->tb_count, lpm_priv->tb_count);
 }
 EXPORT_SYMBOL_GPL(ps3_disable_pm);
@@ -938,7 +938,7 @@ int ps3_lpm_copy_tb(unsigned long offset, void *buf, unsigned long count,
 	if (offset >= lpm_priv->tb_count)
 		return 0;
 
-	count = min(count, lpm_priv->tb_count - offset);
+	count = min_t(u64, count, lpm_priv->tb_count - offset);
 
 	while (*bytes_copied < count) {
 		const unsigned long request = count - *bytes_copied;
@@ -993,7 +993,7 @@ int ps3_lpm_copy_tb_to_user(unsigned long offset, void __user *buf,
 	if (offset >= lpm_priv->tb_count)
 		return 0;
 
-	count = min(count, lpm_priv->tb_count - offset);
+	count = min_t(u64, count, lpm_priv->tb_count - offset);
 
 	while (*bytes_copied < count) {
 		const unsigned long request = count - *bytes_copied;
@@ -1013,7 +1013,7 @@ int ps3_lpm_copy_tb_to_user(unsigned long offset, void __user *buf,
 		result = copy_to_user(buf, lpm_priv->tb_cache, tmp);
 
 		if (result) {
-			dev_dbg(sbd_core(), "%s:%u: 0x%lx bytes at 0x%p\n",
+			dev_dbg(sbd_core(), "%s:%u: 0x%llx bytes at 0x%p\n",
 				__func__, __LINE__, tmp, buf);
 			dev_err(sbd_core(), "%s:%u: copy_to_user failed: %d\n",
 				__func__, __LINE__, result);
@@ -1148,8 +1148,8 @@ int ps3_lpm_open(enum ps3_lpm_tb_type tb_type, void *tb_cache,
 	lpm_priv->shadow.group_control = PS3_LPM_SHADOW_REG_INIT;
 	lpm_priv->shadow.debug_bus_control = PS3_LPM_SHADOW_REG_INIT;
 
-	dev_dbg(sbd_core(), "%s:%u: lpm_id 0x%lx, outlet_id 0x%lx, "
-		"tb_size 0x%lx\n", __func__, __LINE__, lpm_priv->lpm_id,
+	dev_dbg(sbd_core(), "%s:%u: lpm_id 0x%llx, outlet_id 0x%llx, "
+		"tb_size 0x%llx\n", __func__, __LINE__, lpm_priv->lpm_id,
 		lpm_priv->outlet_id, tb_size);
 
 	return 0;
diff --git a/drivers/ps3/ps3-vuart.c b/drivers/ps3/ps3-vuart.c
index 264c447..e4ad5ba 100644
--- a/drivers/ps3/ps3-vuart.c
+++ b/drivers/ps3/ps3-vuart.c
@@ -114,7 +114,7 @@ struct ports_bmp {
 static void __maybe_unused _dump_ports_bmp(
 	const struct ports_bmp *bmp, const char *func, int line)
 {
-	pr_debug("%s:%d: ports_bmp: %016lxh\n", func, line, bmp->status);
+	pr_debug("%s:%d: ports_bmp: %016llxh\n", func, line, bmp->status);
 }
 
 #define dump_port_params(_b) _dump_port_params(_b, __func__, __LINE__)
@@ -250,7 +250,7 @@ static int ps3_vuart_get_rx_bytes_waiting(struct ps3_system_bus_device *dev,
 		dev_dbg(&dev->core, "%s:%d: rx_bytes failed: %s\n",
 			__func__, __LINE__, ps3_result(result));
 
-	dev_dbg(&dev->core, "%s:%d: %lxh\n", __func__, __LINE__,
+	dev_dbg(&dev->core, "%s:%d: %llxh\n", __func__, __LINE__,
 		*bytes_waiting);
 	return result;
 }
@@ -297,7 +297,7 @@ static int ps3_vuart_get_interrupt_status(struct ps3_system_bus_device *dev,
 
 	*status = tmp & priv->interrupt_mask;
 
-	dev_dbg(&dev->core, "%s:%d: m %lxh, s %lxh, m&s %lxh\n",
+	dev_dbg(&dev->core, "%s:%d: m %llxh, s %llxh, m&s %lxh\n",
 		__func__, __LINE__, priv->interrupt_mask, tmp, *status);
 
 	return result;
@@ -594,7 +594,7 @@ static int ps3_vuart_queue_rx_bytes(struct ps3_system_bus_device *dev,
 	list_add_tail(&lb->link, &priv->rx_list.head);
 	priv->rx_list.bytes_held += bytes;
 
-	dev_dbg(&dev->core, "%s:%d: buf_%lu: queued %lxh bytes\n",
+	dev_dbg(&dev->core, "%s:%d: buf_%lu: queued %llxh bytes\n",
 		__func__, __LINE__, lb->dbg_number, bytes);
 
 	*bytes_queued = bytes;
diff --git a/drivers/ps3/ps3stor_lib.c b/drivers/ps3/ps3stor_lib.c
index 55955f1..18066d5 100644
--- a/drivers/ps3/ps3stor_lib.c
+++ b/drivers/ps3/ps3stor_lib.c
@@ -70,7 +70,7 @@ static int ps3stor_probe_access(struct ps3_storage_device *dev)
 			 __func__, __LINE__, n);
 	dev->region_idx = __ffs(dev->accessible_regions);
 	dev_info(&dev->sbd.core,
-		 "First accessible region has index %u start %lu size %lu\n",
+		 "First accessible region has index %u start %llu size %llu\n",
 		 dev->region_idx, dev->regions[dev->region_idx].start,
 		 dev->regions[dev->region_idx].size);
 
@@ -220,7 +220,7 @@ u64 ps3stor_read_write_sectors(struct ps3_storage_device *dev, u64 lpar,
 	const char *op = write ? "write" : "read";
 	int res;
 
-	dev_dbg(&dev->sbd.core, "%s:%u: %s %lu sectors starting at %lu\n",
+	dev_dbg(&dev->sbd.core, "%s:%u: %s %llu sectors starting at %llu\n",
 		__func__, __LINE__, op, sectors, start_sector);
 
 	init_completion(&dev->done);
@@ -238,7 +238,7 @@ u64 ps3stor_read_write_sectors(struct ps3_storage_device *dev, u64 lpar,
 
 	wait_for_completion(&dev->done);
 	if (dev->lv1_status) {
-		dev_dbg(&dev->sbd.core, "%s:%u: %s failed 0x%lx\n", __func__,
+		dev_dbg(&dev->sbd.core, "%s:%u: %s failed 0x%llx\n", __func__,
 			__LINE__, op, dev->lv1_status);
 		return dev->lv1_status;
 	}
@@ -268,7 +268,7 @@ u64 ps3stor_send_command(struct ps3_storage_device *dev, u64 cmd, u64 arg1,
 {
 	int res;
 
-	dev_dbg(&dev->sbd.core, "%s:%u: send device command 0x%lx\n", __func__,
+	dev_dbg(&dev->sbd.core, "%s:%u: send device command 0x%llx\n", __func__,
 		__LINE__, cmd);
 
 	init_completion(&dev->done);
@@ -277,19 +277,19 @@ u64 ps3stor_send_command(struct ps3_storage_device *dev, u64 cmd, u64 arg1,
 					      arg2, arg3, arg4, &dev->tag);
 	if (res) {
 		dev_err(&dev->sbd.core,
-			"%s:%u: send_device_command 0x%lx failed %d\n",
+			"%s:%u: send_device_command 0x%llx failed %d\n",
 			__func__, __LINE__, cmd, res);
 		return -1;
 	}
 
 	wait_for_completion(&dev->done);
 	if (dev->lv1_status) {
-		dev_dbg(&dev->sbd.core, "%s:%u: command 0x%lx failed 0x%lx\n",
+		dev_dbg(&dev->sbd.core, "%s:%u: command 0x%llx failed 0x%llx\n",
 			__func__, __LINE__, cmd, dev->lv1_status);
 		return dev->lv1_status;
 	}
 
-	dev_dbg(&dev->sbd.core, "%s:%u: command 0x%lx completed\n", __func__,
+	dev_dbg(&dev->sbd.core, "%s:%u: command 0x%llx completed\n", __func__,
 		__LINE__, cmd);
 
 	return 0;
-- 
1.6.0.5

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
