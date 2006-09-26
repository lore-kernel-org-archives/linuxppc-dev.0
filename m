Return-Path: <olaf@ibook.aepfle.de>
Received: from natlemon.rzone.de (natlemon.rzone.de [81.169.145.170])
	by ozlabs.org (Postfix) with ESMTP id 8C97867A33
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Sep 2006 06:16:24 +1000 (EST)
Date: Tue, 26 Sep 2006 22:15:54 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Paul Mackeras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org
Subject: [PATCH] move drivers/macintosh variables to BSS
Message-ID: <20060926201554.GA886@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Move all the initialized variables to bss and init them at runtime if needed.
Mark a version string as const.

Signed-off-by: Olaf Hering <olaf@aepfle.de>

---
 drivers/macintosh/adbhid.c                |    4 ++--
 drivers/macintosh/ans-lcd.c               |    6 ++++--
 drivers/macintosh/apm_emu.c               |    2 +-
 drivers/macintosh/mac_hid.c               |   10 ++++++----
 drivers/macintosh/therm_adt746x.c         |    6 +++---
 drivers/macintosh/via-cuda.c              |    2 +-
 drivers/macintosh/via-macii.c             |   10 +++++-----
 drivers/macintosh/via-maciisi.c           |    6 +++---
 drivers/macintosh/via-pmu.c               |   22 ++++++++++++----------
 drivers/macintosh/via-pmu68k.c            |    7 ++++---
 drivers/macintosh/windfarm_pm112.c        |    3 ++-
 drivers/macintosh/windfarm_smu_controls.c |    3 ++-
 12 files changed, 45 insertions(+), 36 deletions(-)

Index: linux-2.6.18/drivers/macintosh/adbhid.c
===================================================================
--- linux-2.6.18.orig/drivers/macintosh/adbhid.c
+++ linux-2.6.18/drivers/macintosh/adbhid.c
@@ -580,8 +580,8 @@ static struct adb_request led_request;
 static int leds_pending[16];
 static int leds_req_pending;
 static int pending_devs[16];
-static int pending_led_start=0;
-static int pending_led_end=0;
+static int pending_led_start;
+static int pending_led_end;
 static DEFINE_SPINLOCK(leds_lock);
 
 static void leds_done(struct adb_request *req)
Index: linux-2.6.18/drivers/macintosh/ans-lcd.c
===================================================================
--- linux-2.6.18.orig/drivers/macintosh/ans-lcd.c
+++ linux-2.6.18/drivers/macintosh/ans-lcd.c
@@ -21,8 +21,8 @@
 #define ANSLCD_CTRL_IX 0x00
 #define ANSLCD_DATA_IX 0x10
 
-static unsigned long anslcd_short_delay = 80;
-static unsigned long anslcd_long_delay = 3280;
+static unsigned long anslcd_short_delay;
+static unsigned long anslcd_long_delay;
 static volatile unsigned char __iomem *anslcd_ptr;
 
 #undef DEBUG
@@ -164,6 +164,8 @@ anslcd_init(void)
 	printk(KERN_DEBUG "LCD: init\n");
 #endif
 
+	anslcd_short_delay = 80;
+	anslcd_long_delay = 3280;
 	anslcd_write_byte_ctrl ( 0x38 );
 	anslcd_write_byte_ctrl ( 0x0c );
 	anslcd_write_byte_ctrl ( 0x06 );
Index: linux-2.6.18/drivers/macintosh/apm_emu.c
===================================================================
--- linux-2.6.18.orig/drivers/macintosh/apm_emu.c
+++ linux-2.6.18/drivers/macintosh/apm_emu.c
@@ -102,7 +102,7 @@ static struct pmu_sleep_notifier apm_sle
 	SLEEP_LEVEL_USERLAND,
 };
 
-static char			driver_version[] = "0.5";	/* no spaces */
+static const char driver_version[] = "0.5";	/* no spaces */
 
 #ifdef DEBUG
 static char *	apm_event_name[] = {
Index: linux-2.6.18/drivers/macintosh/mac_hid.c
===================================================================
--- linux-2.6.18.orig/drivers/macintosh/mac_hid.c
+++ linux-2.6.18/drivers/macintosh/mac_hid.c
@@ -17,10 +17,10 @@
 
 static struct input_dev *emumousebtn;
 static int emumousebtn_input_register(void);
-static int mouse_emulate_buttons = 0;
-static int mouse_button2_keycode = KEY_RIGHTCTRL;	/* right control key */
-static int mouse_button3_keycode = KEY_RIGHTALT;	/* right option key */
-static int mouse_last_keycode = 0;
+static int mouse_emulate_buttons;
+static int mouse_button2_keycode;
+static int mouse_button3_keycode;
+static int mouse_last_keycode;
 
 #if defined(CONFIG_SYSCTL)
 /* file(s) in /proc/sys/dev/mac_hid */
@@ -133,6 +133,8 @@ int __init mac_hid_init(void)
 	if (err)
 		return err;
 
+	mouse_button2_keycode = KEY_RIGHTCTRL;	/* right control key */
+	mouse_button3_keycode = KEY_RIGHTALT;	/* right option key */
 #if defined(CONFIG_SYSCTL)
 	mac_hid_sysctl_header = register_sysctl_table(mac_hid_root_dir, 1);
 #endif /* CONFIG_SYSCTL */
Index: linux-2.6.18/drivers/macintosh/therm_adt746x.c
===================================================================
--- linux-2.6.18.orig/drivers/macintosh/therm_adt746x.c
+++ linux-2.6.18/drivers/macintosh/therm_adt746x.c
@@ -47,11 +47,11 @@ static u8 FAN_SPD_SET[2] = {0x30, 0x31};
 
 static u8 default_limits_local[3] = {70, 50, 70};    /* local, sensor1, sensor2 */
 static u8 default_limits_chip[3] = {80, 65, 80};    /* local, sensor1, sensor2 */
-static char *sensor_location[3] = {NULL, NULL, NULL};
+static char *sensor_location[3];
 
-static int limit_adjust = 0;
+static int limit_adjust;
 static int fan_speed = -1;
-static int verbose = 0;
+static int verbose;
 
 MODULE_AUTHOR("Colin Leroy <colin@colino.net>");
 MODULE_DESCRIPTION("Driver for ADT746x thermostat in iBook G4 and "
Index: linux-2.6.18/drivers/macintosh/via-cuda.c
===================================================================
--- linux-2.6.18.orig/drivers/macintosh/via-cuda.c
+++ linux-2.6.18/drivers/macintosh/via-cuda.c
@@ -86,7 +86,7 @@ static int data_index;
 #ifdef CONFIG_PPC
 static struct device_node *vias;
 #endif
-static int cuda_fully_inited = 0;
+static int cuda_fully_inited;
 
 #ifdef CONFIG_ADB
 static int cuda_probe(void);
Index: linux-2.6.18/drivers/macintosh/via-macii.c
===================================================================
--- linux-2.6.18.orig/drivers/macintosh/via-macii.c
+++ linux-2.6.18/drivers/macintosh/via-macii.c
@@ -107,10 +107,10 @@ static enum macii_state {
 	awaiting_reply
 } macii_state;
 
-static int need_poll    = 0;
-static int command_byte = 0;
-static int last_reply   = 0;
-static int last_active  = 0;
+static int need_poll;
+static int command_byte;
+static int last_reply;
+static int last_active;
 
 static struct adb_request *current_req;
 static struct adb_request *last_req;
@@ -124,7 +124,7 @@ static int first_byte;
 static int prefix_len;
 static int status = ST_IDLE|TREQ;
 static int last_status;
-static int driver_running = 0;
+static int driver_running;
 
 /* debug level 10 required for ADB logging (should be && debug_adb, ideally) */
 
Index: linux-2.6.18/drivers/macintosh/via-maciisi.c
===================================================================
--- linux-2.6.18.orig/drivers/macintosh/via-maciisi.c
+++ linux-2.6.18/drivers/macintosh/via-maciisi.c
@@ -63,10 +63,10 @@ static volatile unsigned char *via;
 
 #undef DEBUG_MACIISI_ADB
 
-static struct adb_request* current_req = NULL;
-static struct adb_request* last_req = NULL;
+static struct adb_request* current_req;
+static struct adb_request* last_req;
 static unsigned char maciisi_rbuf[16];
-static unsigned char *reply_ptr = NULL;
+static unsigned char *reply_ptr;
 static int data_index;
 static int reading_reply;
 static int reply_len;
Index: linux-2.6.18/drivers/macintosh/via-pmu.c
===================================================================
--- linux-2.6.18.orig/drivers/macintosh/via-pmu.c
+++ linux-2.6.18/drivers/macintosh/via-pmu.c
@@ -139,14 +139,14 @@ static int data_len;
 static volatile int adb_int_pending;
 static volatile int disable_poll;
 static struct device_node *vias;
-static int pmu_kind = PMU_UNKNOWN;
-static int pmu_fully_inited = 0;
+static int pmu_kind;
+static int pmu_fully_inited;
 static int pmu_has_adb;
 static struct device_node *gpio_node;
-static unsigned char __iomem *gpio_reg = NULL;
-static int gpio_irq = NO_IRQ;
-static int gpio_irq_enabled = -1;
-static volatile int pmu_suspended = 0;
+static unsigned char __iomem *gpio_reg;
+static int gpio_irq;
+static int gpio_irq_enabled;
+static volatile int pmu_suspended;
 static spinlock_t pmu_lock;
 static u8 pmu_intr_mask;
 static int pmu_version;
@@ -170,7 +170,7 @@ int pmu_battery_count;
 int pmu_cur_battery;
 unsigned int pmu_power_flags;
 struct pmu_battery_info pmu_batteries[PMU_MAX_BATTERIES];
-static int query_batt_timer = BATTERY_POLLING_COUNT;
+static int query_batt_timer;
 static struct adb_request batt_req;
 static struct proc_dir_entry *proc_pmu_batt[PMU_MAX_BATTERIES];
 
@@ -179,7 +179,7 @@ int asleep;
 BLOCKING_NOTIFIER_HEAD(sleep_notifier_list);
 
 #ifdef CONFIG_ADB
-static int adb_dev_map = 0;
+static int adb_dev_map;
 static int pmu_adb_flags;
 
 static int pmu_probe(void);
@@ -361,6 +361,7 @@ int __init find_via_pmu(void)
 	       PMU_DRIVER_VERSION, pbook_type[pmu_kind], pmu_version);
 	       
 	sys_ctrler = SYS_CTRLER_PMU;
+	query_batt_timer = BATTERY_POLLING_COUNT;
 	
 	return 1;
  fail:
@@ -414,10 +415,12 @@ static int __init via_pmu_start(void)
 		if (gpio_node == NULL)
 			gpio_node = of_find_node_by_name(NULL,
 							 "pmu-interrupt");
+		gpio_irq = NO_IRQ;
 		if (gpio_node)
 			gpio_irq = irq_of_parse_and_map(gpio_node, 0);
 
 		if (gpio_irq != NO_IRQ) {
+			gpio_irq_enabled = -1;
 			if (request_irq(gpio_irq, gpio1_interrupt, 0,
 					"GPIO1 ADB", (void *)0))
 				printk(KERN_ERR "pmu: can't get irq %d"
@@ -2767,7 +2770,7 @@ pmu_polled_request(struct adb_request *r
 
 #if defined(CONFIG_PM) && defined(CONFIG_PPC32)
 
-static int pmu_sys_suspended = 0;
+static int pmu_sys_suspended;
 
 static int pmu_sys_suspend(struct sys_device *sysdev, pm_message_t state)
 {
@@ -2807,7 +2810,6 @@ static struct sysdev_class pmu_sysclass 
 };
 
 static struct sys_device device_pmu = {
-	.id		= 0,
 	.cls		= &pmu_sysclass,
 };
 
Index: linux-2.6.18/drivers/macintosh/via-pmu68k.c
===================================================================
--- linux-2.6.18.orig/drivers/macintosh/via-pmu68k.c
+++ linux-2.6.18/drivers/macintosh/via-pmu68k.c
@@ -96,10 +96,10 @@ static int data_index;
 static int data_len;
 static int adb_int_pending;
 static int pmu_adb_flags;
-static int adb_dev_map = 0;
+static int adb_dev_map;
 static struct adb_request bright_req_1, bright_req_2, bright_req_3;
-static int pmu_kind = PMU_UNKNOWN;
-static int pmu_fully_inited = 0;
+static int pmu_kind;
+static int pmu_fully_inited;
 
 int asleep;
 BLOCKING_NOTIFIER_HEAD(sleep_notifier_list);
@@ -184,6 +184,7 @@ int pmu_probe(void)
 	} else if (macintosh_config->adb_type == MAC_ADB_PB2) {
 		pmu_kind = PMU_68K_V2;
 	} else {
+		pmu_kind = PMU_UNKNOWN;
 		return -ENODEV;
 	}
 
Index: linux-2.6.18/drivers/macintosh/windfarm_pm112.c
===================================================================
--- linux-2.6.18.orig/drivers/macintosh/windfarm_pm112.c
+++ linux-2.6.18/drivers/macintosh/windfarm_pm112.c
@@ -91,7 +91,7 @@ static struct wf_cpu_pid_state cpu_pid[N
 static u32 cpu_thist[CPU_TEMP_HIST_SIZE];
 static int cpu_thist_pt;
 static s64 cpu_thist_total;
-static s32 cpu_all_tmax = 100 << 16;
+static s32 cpu_all_tmax;
 static int cpu_last_target;
 static struct wf_pid_state backside_pid;
 static int backside_tick;
@@ -683,6 +683,7 @@ static int __init wf_pm112_init(void)
 		++nr_cores;
 
 	printk(KERN_INFO "windfarm: initializing for dual-core desktop G5\n");
+	cpu_all_tmax = 100 << 16;
 	driver_register(&wf_pm112_driver);
 	return 0;
 }
Index: linux-2.6.18/drivers/macintosh/windfarm_smu_controls.c
===================================================================
--- linux-2.6.18.orig/drivers/macintosh/windfarm_smu_controls.c
+++ linux-2.6.18/drivers/macintosh/windfarm_smu_controls.c
@@ -34,7 +34,7 @@
 #define DBG(args...)	do { } while(0)
 #endif
 
-static int smu_supports_new_fans_ops = 1;
+static int smu_supports_new_fans_ops;
 
 /*
  * SMU fans control object
@@ -259,6 +259,7 @@ static int __init smu_controls_init(void
 	if (smu == NULL)
 		return -ENODEV;
 
+	smu_supports_new_fans_ops = 1;
 	/* Look for RPM fans */
 	for (fans = NULL; (fans = of_get_next_child(smu, fans)) != NULL;)
 		if (!strcmp(fans->name, "rpm-fans") ||
