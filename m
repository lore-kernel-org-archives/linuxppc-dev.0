Return-Path: <wfp5p@viridian.itc.virginia.edu>
From: Bill Pemberton <wfp5p@virginia.edu>
To: gregkh@linuxfoundation.org
Subject: [PATCH 244/493] ps3: remove use of __devinit
Date: Mon, 19 Nov 2012 13:23:13 -0500
Message-Id: <1353349642-3677-244-git-send-email-wfp5p@virginia.edu>
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Cc: Geoff Levand <geoff@infradead.org>, cbe-oss-dev@lists.ozlabs.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

CONFIG_HOTPLUG is going away as an option so __devinit is no longer
needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Geoff Levand <geoff@infradead.org> 
Cc: linuxppc-dev@lists.ozlabs.org 
Cc: cbe-oss-dev@lists.ozlabs.org 
---
 drivers/ps3/ps3-lpm.c         | 2 +-
 drivers/ps3/ps3-sys-manager.c | 2 +-
 drivers/ps3/ps3av.c           | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ps3/ps3-lpm.c b/drivers/ps3/ps3-lpm.c
index 643697f..b139b77 100644
--- a/drivers/ps3/ps3-lpm.c
+++ b/drivers/ps3/ps3-lpm.c
@@ -1185,7 +1185,7 @@ int ps3_lpm_close(void)
 }
 EXPORT_SYMBOL_GPL(ps3_lpm_close);
 
-static int __devinit ps3_lpm_probe(struct ps3_system_bus_device *dev)
+static int ps3_lpm_probe(struct ps3_system_bus_device *dev)
 {
 	dev_dbg(&dev->core, " -> %s:%u\n", __func__, __LINE__);
 
diff --git a/drivers/ps3/ps3-sys-manager.c b/drivers/ps3/ps3-sys-manager.c
index 1b98367..f2ab435 100644
--- a/drivers/ps3/ps3-sys-manager.c
+++ b/drivers/ps3/ps3-sys-manager.c
@@ -706,7 +706,7 @@ static void ps3_sys_manager_work(struct ps3_system_bus_device *dev)
 	ps3_vuart_read_async(dev, PS3_SM_RX_MSG_LEN_MIN);
 }
 
-static int __devinit ps3_sys_manager_probe(struct ps3_system_bus_device *dev)
+static int ps3_sys_manager_probe(struct ps3_system_bus_device *dev)
 {
 	int result;
 	struct ps3_sys_manager_ops ops;
diff --git a/drivers/ps3/ps3av.c b/drivers/ps3/ps3av.c
index 93d0a8b..437fc35 100644
--- a/drivers/ps3/ps3av.c
+++ b/drivers/ps3/ps3av.c
@@ -932,7 +932,7 @@ int ps3av_audio_mute(int mute)
 }
 EXPORT_SYMBOL_GPL(ps3av_audio_mute);
 
-static int __devinit ps3av_probe(struct ps3_system_bus_device *dev)
+static int ps3av_probe(struct ps3_system_bus_device *dev)
 {
 	int res;
 	int id;
-- 
1.8.0
