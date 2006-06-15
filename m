Return-Path: <johnrose@austin.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D4BBE67B54
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Jun 2006 08:33:10 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e36.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k5FMX7po008491
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jun 2006 18:33:07 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by westrelay02.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k5FMWqNe293994
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jun 2006 16:32:52 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k5FMX7Dv002337
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jun 2006 16:33:07 -0600
Subject: [PATCH] powerpc: RTAS delay, fix module build breaks
From: John Rose <johnrose@austin.ibm.com>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17553.4390.79327.634945@cargo.ozlabs.ibm.com>
References: <1149103929.2524.8.camel@sinatra.austin.ibm.com>
	<1149139866.28307.32.camel@localhost.localdomain>
	<1149177349.9812.16.camel@sinatra.austin.ibm.com>
	<1149200718.15158.0.camel@sinatra.austin.ibm.com>
	<1149280229.18052.3.camel@sinatra.austin.ibm.com>
	<20060602213308.GP8934@localdomain>
	<1149543108.17307.6.camel@sinatra.austin.ibm.com>
	<20060610020453.GF23891@krispykreme>
	<20060610020805.GG23891@krispykreme>
	<1150129100.26374.5.camel@sinatra.austin.ibm.com>
	<17553.4390.79327.634945@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Message-Id: <1150410735.3164.4.camel@sinatra.austin.ibm.com>
Mime-Version: 1.0
Date: Thu, 15 Jun 2006 17:32:15 -0500
Cc: External List <linuxppc-dev@ozlabs.org>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Export both news RTAS delay functions, and change the scanlog module to
use the new delay functions.

Signed-off-by: John Rose <johnrose@austin.ibm.com>

---

Respun against the powerpc git tree.  Thanks Paul.

 2_6_ppc-johnrose/arch/powerpc/kernel/rtas.c               |    1 +
 2_6_ppc-johnrose/arch/powerpc/platforms/pseries/scanlog.c |    6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff -puN arch/powerpc/kernel/rtas.c~finish_delay_reorg arch/powerpc/kernel/rtas.c
--- 2_6_ppc/arch/powerpc/kernel/rtas.c~finish_delay_reorg	2006-06-15 17:27:20.000000000 -0500
+++ 2_6_ppc-johnrose/arch/powerpc/kernel/rtas.c	2006-06-15 17:28:11.000000000 -0500
@@ -797,6 +797,7 @@ EXPORT_SYMBOL(rtas_call);
 EXPORT_SYMBOL(rtas_data_buf);
 EXPORT_SYMBOL(rtas_data_buf_lock);
 EXPORT_SYMBOL(rtas_busy_delay_time);
+EXPORT_SYMBOL(rtas_busy_delay);
 EXPORT_SYMBOL(rtas_get_sensor);
 EXPORT_SYMBOL(rtas_get_power_level);
 EXPORT_SYMBOL(rtas_set_power_level);
diff -puN arch/powerpc/platforms/pseries/scanlog.c~finish_delay_reorg arch/powerpc/platforms/pseries/scanlog.c
--- 2_6_ppc/arch/powerpc/platforms/pseries/scanlog.c~finish_delay_reorg	2006-06-15 17:28:30.000000000 -0500
+++ 2_6_ppc-johnrose/arch/powerpc/platforms/pseries/scanlog.c	2006-06-15 17:29:30.000000000 -0500
@@ -107,9 +107,9 @@ static ssize_t scanlog_read(struct file 
 			/* Break to sleep default time */
 			break;
 		    default:
-			if (status > 9900 && status <= 9905) {
-				wait_time = rtas_extended_busy_delay_time(status);
-			} else {
+			/* Assume extended busy */
+			wait_time = rtas_busy_delay_time(status);
+			if (!wait_time) {
 				printk(KERN_ERR "scanlog: unknown error from rtas: %d\n", status);
 				return -EIO;
 			}

_
