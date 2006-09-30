Return-Path: <olaf@ibook.aepfle.de>
Received: from natklopstock.rzone.de (natklopstock.rzone.de [81.169.145.174])
	by ozlabs.org (Postfix) with ESMTP id 6959A679F0
	for <linuxppc-dev@ozlabs.org>; Sat, 30 Sep 2006 17:29:51 +1000 (EST)
Date: Sat, 30 Sep 2006 09:29:31 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] move drivers/macintosh variables to BSS
Message-ID: <20060930072931.GA6728@aepfle.de>
References: <20060926201554.GA886@aepfle.de>
	<17693.48421.91877.327347@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <17693.48421.91877.327347@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Move all the initialized variables to bss.
Mark a version string as const.

Signed-off-by: Olaf Hering <olaf@aepfle.de>

---
 drivers/macintosh/adbhid.c        |    4 ++--
 drivers/macintosh/apm_emu.c       |    2 +-
 drivers/macintosh/mac_hid.c       |    4 ++--
 drivers/macintosh/therm_adt746x.c |    6 +++---
 drivers/macintosh/via-cuda.c      |    2 +-
 drivers/macintosh/via-macii.c     |   10 +++++-----
 drivers/macintosh/via-maciisi.c   |    6 +++---
 drivers/macintosh/via-pmu.c       |   11 +++++------
 drivers/macintosh/via-pmu68k.c    |    4 ++--
 9 files changed, 24 insertions(+), 25 deletions(-)

Index: linux-2.6/drivers/macintosh/adbhid.c
===================================================================
--- linux-2.6.orig/drivers/macintosh/adbhid.c
+++ linux-2.6/drivers/macintosh/adbhid.c
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
Index: linux-2.6/drivers/macintosh/apm_emu.c
===================================================================
--- linux-2.6.orig/drivers/macintosh/apm_emu.c
+++ linux-2.6/drivers/macintosh/apm_emu.c
@@ -102,7 +102,7 @@ static struct pmu_sleep_notifier apm_sle
 	SLEEP_LEVEL_USERLAND,
 };
 
-static char			driver_version[] = "0.5";	/* no spaces */
+static const char driver_version[] = "0.5";	/* no spaces */
 
 #ifdef DEBUG
 static char *	apm_event_name[] = {
Index: linux-2.6/drivers/macintosh/mac_hid.c
===================================================================
--- linux-2.6.orig/drivers/macintosh/mac_hid.c
+++ linux-2.6/drivers/macintosh/mac_hid.c
@@ -17,10 +17,10 @@
 
 static struct input_dev *emumousebtn;
 static int emumousebtn_input_register(void);
-static int mouse_emulate_buttons = 0;
+static int mouse_emulate_buttons;
 static int mouse_button2_keycode = KEY_RIGHTCTRL;	/* right control key */
 static int mouse_button3_keycode = KEY_RIGHTALT;	/* right option key */
-static int mouse_last_keycode = 0;
+static int mouse_last_keycode;
 
 #if defined(CONFIG_SYSCTL)
 /* file(s) in /proc/sys/dev/mac_hid */
Index: linux-2.6/drivers/macintosh/therm_adt746x.c
===================================================================
--- linux-2.6.orig/drivers/macintosh/therm_adt746x.c
+++ linux-2.6/drivers/macintosh/therm_adt746x.c
@@ -47,11 +47,11 @@ static u8 FAN_SPD_SET[2] = {0x30, 0x31};
 
 static u8 default_limits_local[3] = {70, 50, 70};    /* local, sensor1, sensor2 */
 static u8 default_limits_chip[3] = {80, 65, 80};    /* local, sensor1, sensor2 */
-static const char *sensor_location[3] = {NULL, NULL, NULL};
+static const char *sensor_location[3];
 
-static int limit_adjust = 0;
+static int limit_adjust;
 static int fan_speed = -1;
-static int verbose = 0;
+static int verbose;
 
 MODULE_AUTHOR("Colin Leroy <colin@colino.net>");
 MODULE_DESCRIPTION("Driver for ADT746x thermostat in iBook G4 and "
Index: linux-2.6/drivers/macintosh/via-cuda.c
===================================================================
--- linux-2.6.orig/drivers/macintosh/via-cuda.c
+++ linux-2.6/drivers/macintosh/via-cuda.c
@@ -86,7 +86,7 @@ static int data_index;
 #ifdef CONFIG_PPC
 static struct device_node *vias;
 #endif
-static int cuda_fully_inited = 0;
+static int cuda_fully_inited;
 
 #ifdef CONFIG_ADB
 static int cuda_probe(void);
Index: linux-2.6/drivers/macintosh/via-macii.c
===================================================================
--- linux-2.6.orig/drivers/macintosh/via-macii.c
+++ linux-2.6/drivers/macintosh/via-macii.c
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
 
Index: linux-2.6/drivers/macintosh/via-maciisi.c
===================================================================
--- linux-2.6.orig/drivers/macintosh/via-maciisi.c
+++ linux-2.6/drivers/macintosh/via-maciisi.c
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
Index: linux-2.6/drivers/macintosh/via-pmu.c
===================================================================
--- linux-2.6.orig/drivers/macintosh/via-pmu.c
+++ linux-2.6/drivers/macintosh/via-pmu.c
@@ -140,13 +140,13 @@ static volatile int adb_int_pending;
 static volatile int disable_poll;
 static struct device_node *vias;
 static int pmu_kind = PMU_UNKNOWN;
-static int pmu_fully_inited = 0;
+static int pmu_fully_inited;
 static int pmu_has_adb;
 static struct device_node *gpio_node;
-static unsigned char __iomem *gpio_reg = NULL;
+static unsigned char __iomem *gpio_reg;
 static int gpio_irq = NO_IRQ;
 static int gpio_irq_enabled = -1;
-static volatile int pmu_suspended = 0;
+static volatile int pmu_suspended;
 static spinlock_t pmu_lock;
 static u8 pmu_intr_mask;
 static int pmu_version;
@@ -179,7 +179,7 @@ int asleep;
 BLOCKING_NOTIFIER_HEAD(sleep_notifier_list);
 
 #ifdef CONFIG_ADB
-static int adb_dev_map = 0;
+static int adb_dev_map;
 static int pmu_adb_flags;
 
 static int pmu_probe(void);
@@ -2767,7 +2767,7 @@ pmu_polled_request(struct adb_request *r
 
 #if defined(CONFIG_PM) && defined(CONFIG_PPC32)
 
-static int pmu_sys_suspended = 0;
+static int pmu_sys_suspended;
 
 static int pmu_sys_suspend(struct sys_device *sysdev, pm_message_t state)
 {
@@ -2807,7 +2807,6 @@ static struct sysdev_class pmu_sysclass 
 };
 
 static struct sys_device device_pmu = {
-	.id		= 0,
 	.cls		= &pmu_sysclass,
 };
 
Index: linux-2.6/drivers/macintosh/via-pmu68k.c
===================================================================
--- linux-2.6.orig/drivers/macintosh/via-pmu68k.c
+++ linux-2.6/drivers/macintosh/via-pmu68k.c
@@ -96,10 +96,10 @@ static int data_index;
 static int data_len;
 static int adb_int_pending;
 static int pmu_adb_flags;
-static int adb_dev_map = 0;
+static int adb_dev_map;
 static struct adb_request bright_req_1, bright_req_2, bright_req_3;
 static int pmu_kind = PMU_UNKNOWN;
-static int pmu_fully_inited = 0;
+static int pmu_fully_inited;
 
 int asleep;
 BLOCKING_NOTIFIER_HEAD(sleep_notifier_list);
