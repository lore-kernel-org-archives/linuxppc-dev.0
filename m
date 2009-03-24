Return-Path: <markn@au1.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp06.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id ABC5CDDFAC
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Mar 2009 17:28:53 +1100 (EST)
Received: from d23relay01.au.ibm.com (d23relay01.au.ibm.com [202.81.31.243])
	by e23smtp06.au.ibm.com (8.13.1/8.13.1) with ESMTP id n2O6Se7M027190
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Mar 2009 17:28:40 +1100
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay01.au.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n2O6TAJq422052
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Mar 2009 17:29:10 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n2O6Sqme023260
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Mar 2009 17:28:52 +1100
From: Mark Nelson <markn@au1.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/wdrtas: Update wdrtas_get_interval to use
	rtas_data_buf
Date: Tue, 24 Mar 2009 17:30:41 +1100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200903241730.41711.markn@au1.ibm.com>
Cc: Utz Bacher <utz.bacher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The buffer passed to the ibm,get-system-parameter RTAS call must be
in the RMA. To ensure we pass an address in the RMA use rtas_data_buf
for the actual RTAS call and then copy the result to value. We can't
just make it static because this can be compiled in as a module.

Also add the WDRTAS_SP_SPI_LEN so we don't litter '4' throughout the
function.

Signed-off-by: Mark Nelson <markn@au1.ibm.com>
---

Adrian, does this patch cause any problems for your pxcabs?

Thanks!
Mark

 drivers/watchdog/wdrtas.c |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

Index: upstream/drivers/watchdog/wdrtas.c
===================================================================
--- upstream.orig/drivers/watchdog/wdrtas.c
+++ upstream/drivers/watchdog/wdrtas.c
@@ -106,6 +106,8 @@ static int wdrtas_set_interval(int inter
 	return result;
 }
 
+#define WDRTAS_SP_SPI_LEN 4
+
 /**
  * wdrtas_get_interval - returns the current watchdog interval
  * @fallback_value: value (in seconds) to use, if the RTAS call fails
@@ -119,10 +121,17 @@ static int wdrtas_set_interval(int inter
 static int wdrtas_get_interval(int fallback_value)
 {
 	long result;
-	char value[4];
+	char value[WDRTAS_SP_SPI_LEN];
 
+	spin_lock(&rtas_data_buf_lock);
+	memset(rtas_data_buf, 0, WDRTAS_SP_SPI_LEN);
 	result = rtas_call(wdrtas_token_get_sp, 3, 1, NULL,
-			   WDRTAS_SP_SPI, (void *)__pa(&value), 4);
+			   WDRTAS_SP_SPI, __pa(rtas_data_buf),
+			   WDRTAS_SP_SPI_LEN);
+
+	memcpy(value, rtas_data_buf, WDRTAS_SP_SPI_LEN);
+	spin_unlock(&rtas_data_buf_lock);
+
 	if (value[0] != 0 || value[1] != 2 || value[3] != 0 || result < 0) {
 		printk(KERN_WARNING "wdrtas: could not get sp_spi watchdog "
 		       "timeout (%li). Continuing\n", result);
