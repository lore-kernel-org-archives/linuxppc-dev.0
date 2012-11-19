Return-Path: <wfp5p@viridian.itc.virginia.edu>
Received: from viridian.itc.virginia.edu (viridian.itc.Virginia.EDU
 [128.143.12.139]) by ozlabs.org (Postfix) with ESMTP id E33CE2C00A3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Nov 2012 05:32:59 +1100 (EST)
From: Bill Pemberton <wfp5p@virginia.edu>
To: gregkh@linuxfoundation.org
Subject: [PATCH 215/493] drivers/macintosh: remove use of __devinit
Date: Mon, 19 Nov 2012 13:22:44 -0500
Message-Id: <1353349642-3677-215-git-send-email-wfp5p@virginia.edu>
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Cc: linuxppc-dev@lists.ozlabs.org
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
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org> 
Cc: linuxppc-dev@lists.ozlabs.org 
---
 drivers/macintosh/macio_asic.c             |  2 +-
 drivers/macintosh/mediabay.c               |  2 +-
 drivers/macintosh/rack-meter.c             |  6 +++---
 drivers/macintosh/windfarm_ad7417_sensor.c |  8 ++++----
 drivers/macintosh/windfarm_fcu_controls.c  | 14 +++++++-------
 5 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/macintosh/macio_asic.c b/drivers/macintosh/macio_asic.c
index ef87310..2cdbd47 100644
--- a/drivers/macintosh/macio_asic.c
+++ b/drivers/macintosh/macio_asic.c
@@ -679,7 +679,7 @@ void macio_release_resources(struct macio_dev *dev)
 
 #ifdef CONFIG_PCI
 
-static int __devinit macio_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
+static int macio_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	struct device_node* np;
 	struct macio_chip* chip;
diff --git a/drivers/macintosh/mediabay.c b/drivers/macintosh/mediabay.c
index 3f8d032..7d2422a 100644
--- a/drivers/macintosh/mediabay.c
+++ b/drivers/macintosh/mediabay.c
@@ -556,7 +556,7 @@ static int media_bay_task(void *x)
 	return 0;
 }
 
-static int __devinit media_bay_attach(struct macio_dev *mdev, const struct of_device_id *match)
+static int media_bay_attach(struct macio_dev *mdev, const struct of_device_id *match)
 {
 	struct media_bay_info* bay;
 	u32 __iomem *regbase;
diff --git a/drivers/macintosh/rack-meter.c b/drivers/macintosh/rack-meter.c
index 18cd177..3b4453f 100644
--- a/drivers/macintosh/rack-meter.c
+++ b/drivers/macintosh/rack-meter.c
@@ -253,7 +253,7 @@ static void rackmeter_do_timer(struct work_struct *work)
 				 msecs_to_jiffies(CPU_SAMPLING_RATE));
 }
 
-static void __devinit rackmeter_init_cpu_sniffer(struct rackmeter *rm)
+static void rackmeter_init_cpu_sniffer(struct rackmeter *rm)
 {
 	unsigned int cpu;
 
@@ -287,7 +287,7 @@ static void rackmeter_stop_cpu_sniffer(struct rackmeter *rm)
 	cancel_delayed_work_sync(&rm->cpu[1].sniffer);
 }
 
-static int __devinit rackmeter_setup(struct rackmeter *rm)
+static int rackmeter_setup(struct rackmeter *rm)
 {
 	pr_debug("rackmeter: setting up i2s..\n");
 	rackmeter_setup_i2s(rm);
@@ -362,7 +362,7 @@ static irqreturn_t rackmeter_irq(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
-static int __devinit rackmeter_probe(struct macio_dev* mdev,
+static int rackmeter_probe(struct macio_dev* mdev,
 				     const struct of_device_id *match)
 {
 	struct device_node *i2s = NULL, *np = NULL;
diff --git a/drivers/macintosh/windfarm_ad7417_sensor.c b/drivers/macintosh/windfarm_ad7417_sensor.c
index ac3f243..d0aa631 100644
--- a/drivers/macintosh/windfarm_ad7417_sensor.c
+++ b/drivers/macintosh/windfarm_ad7417_sensor.c
@@ -177,7 +177,7 @@ static const struct wf_sensor_ops wf_ad7417_adc_ops = {
 	.owner		= THIS_MODULE,
 };
 
-static void __devinit wf_ad7417_add_sensor(struct wf_ad7417_priv *pv,
+static void wf_ad7417_add_sensor(struct wf_ad7417_priv *pv,
 					   int index, const char *name,
 					   const struct wf_sensor_ops *ops)
 {
@@ -188,7 +188,7 @@ static void __devinit wf_ad7417_add_sensor(struct wf_ad7417_priv *pv,
 		kref_get(&pv->ref);
 }
 
-static void __devinit wf_ad7417_init_chip(struct wf_ad7417_priv *pv)
+static void wf_ad7417_init_chip(struct wf_ad7417_priv *pv)
 {
 	int rc;
 	u8 buf[2];
@@ -230,7 +230,7 @@ static void __devinit wf_ad7417_init_chip(struct wf_ad7417_priv *pv)
 	pv->config = config;
 }
 
-static int __devinit wf_ad7417_probe(struct i2c_client *client,
+static int wf_ad7417_probe(struct i2c_client *client,
 				     const struct i2c_device_id *id)
 {
 	struct wf_ad7417_priv *pv;
@@ -322,7 +322,7 @@ static struct i2c_driver wf_ad7417_driver = {
 	.id_table	= wf_ad7417_id,
 };
 
-static int __devinit wf_ad7417_init(void)
+static int wf_ad7417_init(void)
 {
 	/* This is only supported on these machines */
 	if (!of_machine_is_compatible("PowerMac7,2") &&
diff --git a/drivers/macintosh/windfarm_fcu_controls.c b/drivers/macintosh/windfarm_fcu_controls.c
index fd6ed15..84354d5 100644
--- a/drivers/macintosh/windfarm_fcu_controls.c
+++ b/drivers/macintosh/windfarm_fcu_controls.c
@@ -282,7 +282,7 @@ static const struct wf_control_ops wf_fcu_fan_pwm_ops = {
 	.owner		= THIS_MODULE,
 };
 
-static void __devinit wf_fcu_get_pump_minmax(struct wf_fcu_fan *fan)
+static void wf_fcu_get_pump_minmax(struct wf_fcu_fan *fan)
 {
 	const struct mpu_data *mpu = wf_get_mpu(0);
 	u16 pump_min = 0, pump_max = 0xffff;
@@ -317,7 +317,7 @@ static void __devinit wf_fcu_get_pump_minmax(struct wf_fcu_fan *fan)
 	    fan->ctrl.name, pump_min, pump_max);
 }
 
-static void __devinit wf_fcu_get_rpmfan_minmax(struct wf_fcu_fan *fan)
+static void wf_fcu_get_rpmfan_minmax(struct wf_fcu_fan *fan)
 {
 	struct wf_fcu_priv *pv = fan->fcu_priv;
 	const struct mpu_data *mpu0 = wf_get_mpu(0);
@@ -359,7 +359,7 @@ static void __devinit wf_fcu_get_rpmfan_minmax(struct wf_fcu_fan *fan)
 	    fan->ctrl.name, fan->min, fan->max);
 }
 
-static void __devinit wf_fcu_add_fan(struct wf_fcu_priv *pv,
+static void wf_fcu_add_fan(struct wf_fcu_priv *pv,
 				     const char *name,
 				     int type, int id)
 {
@@ -399,7 +399,7 @@ static void __devinit wf_fcu_add_fan(struct wf_fcu_priv *pv,
 	kref_get(&pv->ref);
 }
 
-static void __devinit wf_fcu_lookup_fans(struct wf_fcu_priv *pv)
+static void wf_fcu_lookup_fans(struct wf_fcu_priv *pv)
 {
 	/* Translation of device-tree location properties to
 	 * windfarm fan names
@@ -481,7 +481,7 @@ static void __devinit wf_fcu_lookup_fans(struct wf_fcu_priv *pv)
 	}
 }
 
-static void __devinit wf_fcu_default_fans(struct wf_fcu_priv *pv)
+static void wf_fcu_default_fans(struct wf_fcu_priv *pv)
 {
 	/* We only support the default fans for PowerMac7,2 */
 	if (!of_machine_is_compatible("PowerMac7,2"))
@@ -496,7 +496,7 @@ static void __devinit wf_fcu_default_fans(struct wf_fcu_priv *pv)
 	wf_fcu_add_fan(pv, "cpu-rear-fan-1",	FCU_FAN_RPM, 6);
 }
 
-static int __devinit wf_fcu_init_chip(struct wf_fcu_priv *pv)
+static int wf_fcu_init_chip(struct wf_fcu_priv *pv)
 {
 	unsigned char buf = 0xff;
 	int rc;
@@ -518,7 +518,7 @@ static int __devinit wf_fcu_init_chip(struct wf_fcu_priv *pv)
 	return 0;
 }
 
-static int __devinit wf_fcu_probe(struct i2c_client *client,
+static int wf_fcu_probe(struct i2c_client *client,
 				  const struct i2c_device_id *id)
 {
 	struct wf_fcu_priv *pv;
-- 
1.8.0
