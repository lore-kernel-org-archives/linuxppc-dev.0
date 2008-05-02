Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CC7F6DDFC5
	for <linuxppc-dev@ozlabs.org>; Sat,  3 May 2008 06:35:32 +1000 (EST)
Message-Id: <200805022034.m42KY3Wn013261@imap1.linux-foundation.org>
Subject: [patch 2/5] macintosh: qindfarm_smu_sat: semaphore to mutex
To: paulus@samba.org
From: akpm@linux-foundation.org
Date: Fri, 02 May 2008 13:34:02 -0700
Cc: akpm@linux-foundation.org, dwalker@mvista.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Daniel Walker <dwalker@mvista.com>

Signed-off-by: Daniel Walker <dwalker@mvista.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/macintosh/windfarm_smu_sat.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff -puN drivers/macintosh/windfarm_smu_sat.c~macintosh-qindfarm_smu_sat-semaphore-to-mutex drivers/macintosh/windfarm_smu_sat.c
--- a/drivers/macintosh/windfarm_smu_sat.c~macintosh-qindfarm_smu_sat-semaphore-to-mutex
+++ a/drivers/macintosh/windfarm_smu_sat.c
@@ -13,7 +13,7 @@
 #include <linux/init.h>
 #include <linux/wait.h>
 #include <linux/i2c.h>
-#include <linux/semaphore.h>
+#include <linux/mutex.h>
 #include <asm/prom.h>
 #include <asm/smu.h>
 #include <asm/pmac_low_i2c.h>
@@ -36,7 +36,7 @@
 struct wf_sat {
 	int			nr;
 	atomic_t		refcnt;
-	struct semaphore	mutex;
+	struct mutex		mutex;
 	unsigned long		last_read; /* jiffies when cache last updated */
 	u8			cache[16];
 	struct i2c_client	i2c;
@@ -163,7 +163,7 @@ static int wf_sat_get(struct wf_sensor *
 	if (sat->i2c.adapter == NULL)
 		return -ENODEV;
 
-	down(&sat->mutex);
+	mutex_lock(&sat->mutex);
 	if (time_after(jiffies, (sat->last_read + MAX_AGE))) {
 		err = wf_sat_read_cache(sat);
 		if (err)
@@ -182,7 +182,7 @@ static int wf_sat_get(struct wf_sensor *
 	err = 0;
 
  fail:
-	up(&sat->mutex);
+	mutex_unlock(&sat->mutex);
 	return err;
 }
 
@@ -233,7 +233,7 @@ static void wf_sat_create(struct i2c_ada
 	sat->nr = -1;
 	sat->node = of_node_get(dev);
 	atomic_set(&sat->refcnt, 0);
-	init_MUTEX(&sat->mutex);
+	mutex_init(&sat->mutex);
 	sat->i2c.addr = (addr >> 1) & 0x7f;
 	sat->i2c.adapter = adapter;
 	sat->i2c.driver = &wf_sat_driver;
_
