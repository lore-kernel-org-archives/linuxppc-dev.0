Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 72387DDE10
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 10:49:18 +1000 (EST)
To: Paul Mackerras <paulus@samba.org>
From: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: [PATCH] POWERPC: Added RTC support for mpc8313RDB and utilize
	"clock-frequency"
Date: Tue, 17 Jul 2007 04:49:13 +0400
Message-ID: <20070717004913.21682.50282.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


This enables DS1337 embedded RTC and uses "clock-frequency"
property to configure loops_per_jiffy. Fixed spaces vs tabs issue
in couple of places.

Signed-off-by: Vitaly Bordug <vitb@kernel.crashing.org>

---

 arch/powerpc/platforms/83xx/mpc8313_rdb.c |   52 ++++++++++++++++++++++++++++-
 1 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/83xx/mpc8313_rdb.c b/arch/powerpc/platforms/83xx/mpc8313_rdb.c
index 3edfe17..b410e67 100644
--- a/arch/powerpc/platforms/83xx/mpc8313_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc8313_rdb.c
@@ -14,6 +14,8 @@
  */
 
 #include <linux/pci.h>
+#include <linux/delay.h>
+#include <linux/rtc.h>
 
 #include <asm/time.h>
 #include <asm/ipic.h>
@@ -42,6 +44,17 @@ static void __init mpc8313_rdb_setup_arch(void)
 	if (ppc_md.progress)
 		ppc_md.progress("mpc8313_rdb_setup_arch()", 0);
 
+	np = of_find_node_by_type(NULL, "cpu");
+	if (np != 0) {
+		const unsigned int *fp =
+			get_property(np, "clock-frequency", NULL);
+		if (fp != 0)
+			loops_per_jiffy = *fp / HZ;
+		else
+			loops_per_jiffy = 50000000 / HZ;
+		of_node_put(np);
+	}
+
 #ifdef CONFIG_PCI
 	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
 		mpc83xx_add_bridge(np);
@@ -67,14 +80,49 @@ void __init mpc8313_rdb_init_IRQ(void)
 	ipic_set_default_priority();
 }
 
+#if defined (CONFIG_SENSORS_DS1337) && defined (CONFIG_I2C)
+
+extern int ds1337_do_command(int id, int cmd, void *arg);
+extern spinlock_t rtc_lock;
+#define DS1337_GET_DATE		0
+#define DS1337_SET_DATE		1
+
+static void mpc8313rdb_get_rtc_time(struct rtc_time *tm)
+{
+	int result;
+
+	result = ds1337_do_command(0, DS1337_GET_DATE, tm);
+
+	if (result == 0)
+		result = mktime(tm->tm_year, tm->tm_mon, tm->tm_mday, tm->tm_hour, tm->tm_min, tm->tm_sec);
+}
+
+static int mpc8313rdb_set_rtc_time(struct rtc_time *tm)
+{
+	int result;
+
+	result = ds1337_do_command(0, DS1337_SET_DATE, tm);
+
+	return result;
+}
+
+static int __init rtc_hookup(void)
+{
+	ppc_md.get_rtc_time = mpc8313rdb_get_rtc_time;
+	ppc_md.set_rtc_time = mpc8313rdb_set_rtc_time;
+	return 0;
+}
+late_initcall(rtc_hookup);
+#endif
+
 /*
  * Called very early, MMU is off, device-tree isn't unflattened
  */
 static int __init mpc8313_rdb_probe(void)
 {
-        unsigned long root = of_get_flat_dt_root();
+	unsigned long root = of_get_flat_dt_root();
 
-        return of_flat_dt_is_compatible(root, "MPC8313ERDB");
+	return of_flat_dt_is_compatible(root, "MPC8313ERDB");
 }
 
 define_machine(mpc8313_rdb) {
