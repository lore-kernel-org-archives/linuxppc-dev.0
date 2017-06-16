Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wprmB0F90zDq9P
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jun 2017 16:57:46 +1000 (AEST)
Received: by mail-pg0-x243.google.com with SMTP id f127so4279611pgc.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jun 2017 23:57:45 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Don Zickus <dzickus@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, Babu Moger <babu.moger@oracle.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 4/5] watchdog: provide watchdog_reconfigure() for arch
 watchdogs
Date: Fri, 16 Jun 2017 16:57:14 +1000
Message-Id: <20170616065715.18390-5-npiggin@gmail.com>
In-Reply-To: <20170616065715.18390-1-npiggin@gmail.com>
References: <20170616065715.18390-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

After reconfiguring watchdog sysctls etc., architecture specific
watchdogs may not get all their parameters updated.

watchdog_reconfigure() can be implemented to pull the new values
in and set the arch NMI watchdog.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 kernel/watchdog.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 1fba9c3d66dc..06cd965f64d2 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -123,6 +123,11 @@ void __weak watchdog_nmi_disable(unsigned int cpu)
 {
 }
 
+void __weak watchdog_nmi_reconfigure(void)
+{
+}
+
+
 #ifdef CONFIG_SOFTLOCKUP_DETECTOR
 
 /* Helper for online, unparked cpus. */
@@ -600,6 +605,12 @@ static void watchdog_disable_all_cpus(void)
 	}
 }
 
+static int watchdog_update_cpus(void)
+{
+	return smpboot_update_cpumask_percpu_thread(
+		    &watchdog_threads, &watchdog_cpumask);
+}
+
 #else /* SOFTLOCKUP */
 static int watchdog_park_threads(void)
 {
@@ -619,6 +630,11 @@ static void watchdog_disable_all_cpus(void)
 {
 }
 
+static int watchdog_update_cpus(void)
+{
+	return 0;
+}
+
 static void set_sample_period(void)
 {
 }
@@ -651,6 +667,8 @@ int lockup_detector_suspend(void)
 		watchdog_enabled = 0;
 	}
 
+	watchdog_nmi_reconfigure();
+
 	mutex_unlock(&watchdog_proc_mutex);
 
 	return ret;
@@ -671,6 +689,8 @@ void lockup_detector_resume(void)
 	if (watchdog_running && !watchdog_suspended)
 		watchdog_unpark_threads();
 
+	watchdog_nmi_reconfigure();
+
 	mutex_unlock(&watchdog_proc_mutex);
 	put_online_cpus();
 }
@@ -696,6 +716,8 @@ static int proc_watchdog_update(void)
 	else
 		watchdog_disable_all_cpus();
 
+	watchdog_nmi_reconfigure();
+
 	return err;
 
 }
@@ -881,12 +903,11 @@ int proc_watchdog_cpumask(struct ctl_table *table, int write,
 			 * a temporary cpumask, so we are likely not in a
 			 * position to do much else to make things better.
 			 */
-#ifdef CONFIG_SOFTLOCKUP_DETECTOR
-			if (smpboot_update_cpumask_percpu_thread(
-				    &watchdog_threads, &watchdog_cpumask) != 0)
+			if (watchdog_update_cpus() != 0)
 				pr_err("cpumask update failed\n");
-#endif
 		}
+
+		watchdog_nmi_reconfigure();
 	}
 out:
 	mutex_unlock(&watchdog_proc_mutex);
-- 
2.11.0
