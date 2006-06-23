Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Fri, 23 Jun 2006 18:20:11 +1000
Subject: [PATCH 4/8] Move RTAS exports next to their declarations
Message-Id: <20060623082010.102D667B24@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd.bergmann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Move RTAS exports next to their declarations.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/kernel/rtas.c |   27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

Index: to-merge/arch/powerpc/kernel/rtas.c
===================================================================
--- to-merge.orig/arch/powerpc/kernel/rtas.c
+++ to-merge/arch/powerpc/kernel/rtas.c
@@ -38,16 +38,19 @@
 struct rtas_t rtas = {
 	.lock = SPIN_LOCK_UNLOCKED
 };
+EXPORT_SYMBOL(rtas);
 
 struct rtas_suspend_me_data {
 	long waiting;
 	struct rtas_args *args;
 };
 
-EXPORT_SYMBOL(rtas);
-
 DEFINE_SPINLOCK(rtas_data_buf_lock);
+EXPORT_SYMBOL(rtas_data_buf_lock);
+
 char rtas_data_buf[RTAS_DATA_BUF_SIZE] __cacheline_aligned;
+EXPORT_SYMBOL(rtas_data_buf);
+
 unsigned long rtas_rmo_buf;
 
 /*
@@ -236,6 +239,7 @@ int rtas_token(const char *service)
 	tokp = (int *) get_property(rtas.dev, service, NULL);
 	return tokp ? *tokp : RTAS_UNKNOWN_SERVICE;
 }
+EXPORT_SYMBOL(rtas_token);
 
 #ifdef CONFIG_RTAS_ERROR_LOGGING
 /*
@@ -369,6 +373,7 @@ int rtas_call(int token, int nargs, int 
 	}
 	return ret;
 }
+EXPORT_SYMBOL(rtas_call);
 
 /* For RTAS_BUSY (-2), delay for 1 millisecond.  For an extended busy status
  * code of 990n, perform the hinted delay of 10^n (last digit) milliseconds.
@@ -388,6 +393,7 @@ unsigned int rtas_busy_delay_time(int st
 
 	return ms;
 }
+EXPORT_SYMBOL(rtas_busy_delay_time);
 
 /* For an RTAS busy status code, perform the hinted delay. */
 unsigned int rtas_busy_delay(int status)
@@ -401,6 +407,7 @@ unsigned int rtas_busy_delay(int status)
 
 	return ms;
 }
+EXPORT_SYMBOL(rtas_busy_delay);
 
 int rtas_error_rc(int rtas_rc)
 {
@@ -446,6 +453,7 @@ int rtas_get_power_level(int powerdomain
 		return rtas_error_rc(rc);
 	return rc;
 }
+EXPORT_SYMBOL(rtas_get_power_level);
 
 int rtas_set_power_level(int powerdomain, int level, int *setlevel)
 {
@@ -463,6 +471,7 @@ int rtas_set_power_level(int powerdomain
 		return rtas_error_rc(rc);
 	return rc;
 }
+EXPORT_SYMBOL(rtas_set_power_level);
 
 int rtas_get_sensor(int sensor, int index, int *state)
 {
@@ -480,6 +489,7 @@ int rtas_get_sensor(int sensor, int inde
 		return rtas_error_rc(rc);
 	return rc;
 }
+EXPORT_SYMBOL(rtas_get_sensor);
 
 int rtas_set_indicator(int indicator, int index, int new_value)
 {
@@ -497,6 +507,7 @@ int rtas_set_indicator(int indicator, in
 		return rtas_error_rc(rc);
 	return rc;
 }
+EXPORT_SYMBOL(rtas_set_indicator);
 
 void rtas_restart(char *cmd)
 {
@@ -790,15 +801,3 @@ void __init rtas_initialize(void)
 	rtas_last_error_token = rtas_token("rtas-last-error");
 #endif
 }
-
-
-EXPORT_SYMBOL(rtas_token);
-EXPORT_SYMBOL(rtas_call);
-EXPORT_SYMBOL(rtas_data_buf);
-EXPORT_SYMBOL(rtas_data_buf_lock);
-EXPORT_SYMBOL(rtas_busy_delay_time);
-EXPORT_SYMBOL(rtas_busy_delay);
-EXPORT_SYMBOL(rtas_get_sensor);
-EXPORT_SYMBOL(rtas_get_power_level);
-EXPORT_SYMBOL(rtas_set_power_level);
-EXPORT_SYMBOL(rtas_set_indicator);
