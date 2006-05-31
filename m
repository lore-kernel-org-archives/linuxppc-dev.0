Return-Path: <johnrose@austin.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 52A0667AC5
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Jun 2006 05:33:05 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k4VJX0af021404
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Wed, 31 May 2006 15:33:00 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k4VJWv9K142154
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Wed, 31 May 2006 13:32:57 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k4VJWuV0016125
	for <linuxppc-dev@ozlabs.org>; Wed, 31 May 2006 13:32:57 -0600
Subject: [PATCH] use msleep() for RTAS delays
From: John Rose <johnrose@austin.ibm.com>
To: External List <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1149103929.2524.8.camel@sinatra.austin.ibm.com>
Mime-Version: 1.0
Date: Wed, 31 May 2006 14:32:21 -0500
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The current use of udelay() for RTAS extended delay conditions can
result in CPU soft lockups.  The use of msleep() won't tie up the CPU.

Signed-off-by: John Rose <johnrose@austin.ibm.com>

---

Thanks-
John

diff -puN arch/powerpc/kernel/rtas.c~msleep_rtas arch/powerpc/kernel/rtas.c
--- 2_6_linus/arch/powerpc/kernel/rtas.c~msleep_rtas	2006-05-31 14:07:51.000000000 -0500
+++ 2_6_linus-johnrose/arch/powerpc/kernel/rtas.c	2006-05-31 14:10:09.000000000 -0500
@@ -447,10 +447,10 @@ int rtas_set_power_level(int powerdomain
 	while (1) {
 		rc = rtas_call(token, 2, 2, setlevel, powerdomain, level);
 		if (rc == RTAS_BUSY)
-			udelay(1);
+			msleep(1);
 		else if (rtas_is_extended_busy(rc)) {
 			wait_time = rtas_extended_busy_delay_time(rc);
-			udelay(wait_time * 1000);
+			msleep(wait_time);
 		} else
 			break;
 	}
@@ -472,10 +472,10 @@ int rtas_get_sensor(int sensor, int inde
 	while (1) {
 		rc = rtas_call(token, 2, 2, state, sensor, index);
 		if (rc == RTAS_BUSY)
-			udelay(1);
+			msleep(1);
 		else if (rtas_is_extended_busy(rc)) {
 			wait_time = rtas_extended_busy_delay_time(rc);
-			udelay(wait_time * 1000);
+			msleep(wait_time);
 		} else
 			break;
 	}
@@ -497,12 +497,11 @@ int rtas_set_indicator(int indicator, in
 	while (1) {
 		rc = rtas_call(token, 3, 1, NULL, indicator, index, new_value);
 		if (rc == RTAS_BUSY)
-			udelay(1);
+			msleep(1);
 		else if (rtas_is_extended_busy(rc)) {
 			wait_time = rtas_extended_busy_delay_time(rc);
-			udelay(wait_time * 1000);
-		}
-		else
+			msleep(wait_time);
+		} else
 			break;
 	}
 
diff -puN arch/powerpc/kernel/rtas_flash.c~msleep_rtas arch/powerpc/kernel/rtas_flash.c
--- 2_6_linus/arch/powerpc/kernel/rtas_flash.c~msleep_rtas	2006-05-31 14:10:47.000000000 -0500
+++ 2_6_linus-johnrose/arch/powerpc/kernel/rtas_flash.c	2006-05-31 14:19:30.000000000 -0500
@@ -16,7 +16,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/proc_fs.h>
-#include <asm/delay.h>
+#include <linux/delay.h>
 #include <asm/uaccess.h>
 #include <asm/rtas.h>
 #include <asm/abs_addr.h>
@@ -372,10 +372,10 @@ static void manage_flash(struct rtas_man
 		rc = rtas_call(rtas_token("ibm,manage-flash-image"), 1, 
 			       1, NULL, args_buf->op);
 		if (rc == RTAS_RC_BUSY)
-			udelay(1);
+			msleep(1);
 		else if (rtas_is_extended_busy(rc)) {
 			wait_time = rtas_extended_busy_delay_time(rc);
-			udelay(wait_time * 1000);
+			msleep(wait_time);
 		} else
 			break;
 	}
@@ -465,10 +465,10 @@ static void validate_flash(struct rtas_v
 		spin_unlock(&rtas_data_buf_lock);
 			
 		if (rc == RTAS_RC_BUSY)
-			udelay(1);
+			msleep(1);
 		else if (rtas_is_extended_busy(rc)) {
 			wait_time = rtas_extended_busy_delay_time(rc);
-			udelay(wait_time * 1000);
+			msleep(wait_time);
 		} else
 			break;
 	}

_
