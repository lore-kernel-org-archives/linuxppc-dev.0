Return-Path: <anton@samba.org>
Date: Thu, 22 Mar 2012 12:53:43 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH 3/6] powerpc/pseries: Use rtas_get_sensor in RAS code
Message-ID: <20120322125343.63d77e82@kryten>
In-Reply-To: <20120322124707.3cd3037f@kryten>
References: <20120322124707.3cd3037f@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


We have rtas_get_sensor so we may as well use it.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-build/arch/powerpc/platforms/pseries/ras.c
===================================================================
--- linux-build.orig/arch/powerpc/platforms/pseries/ras.c	2012-03-22 12:42:54.473140239 +1100
+++ linux-build/arch/powerpc/platforms/pseries/ras.c	2012-03-22 12:43:28.957765972 +1100
@@ -59,7 +59,6 @@ static DEFINE_SPINLOCK(ras_log_buf_lock)
 static char global_mce_data_buf[RTAS_ERROR_LOG_MAX];
 static DEFINE_PER_CPU(__u64, mce_data_buf);
 
-static int ras_get_sensor_state_token;
 static int ras_check_exception_token;
 
 #define EPOW_SENSOR_TOKEN	9
@@ -77,7 +76,6 @@ static int __init init_ras_IRQ(void)
 {
 	struct device_node *np;
 
-	ras_get_sensor_state_token = rtas_token("get-sensor-state");
 	ras_check_exception_token = rtas_token("check-exception");
 
 	/* Internal Errors */
@@ -213,8 +211,7 @@ static irqreturn_t ras_epow_interrupt(in
 	int state;
 	int critical;
 
-	status = rtas_call(ras_get_sensor_state_token, 2, 2, &state,
-			   EPOW_SENSOR_TOKEN, EPOW_SENSOR_INDEX);
+	status = rtas_get_sensor(EPOW_SENSOR_TOKEN, EPOW_SENSOR_INDEX, &state);
 
 	if (state > 3)
 		critical = 1;		/* Time Critical */
