Return-Path: <will_schmidt@vnet.ibm.com>
Received: from over.co.us.ibm.com (over.co.us.ibm.com [32.97.110.157])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "over.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 84039679EB
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Mar 2006 09:06:29 +1100 (EST)
Received: from e3.ny.us.ibm.com ([9.56.232.143])
	by bldfb.esmtp.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k2UL5MRF008796
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Mar 2006 16:05:22 -0500
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k2UL5BLs003106
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Mar 2006 16:05:11 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k2UL56HP203732
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Mar 2006 16:05:06 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11/8.13.3) with ESMTP id k2UL564R029172
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Mar 2006 16:05:06 -0500
Subject: [PATCH] misc lparcfg fixes
From: Will Schmidt <will_schmidt@vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, paulus@samba.org
Content-Type: multipart/mixed; boundary="=-A1YQtvKvaqwzgp377Dui"
Date: Thu, 30 Mar 2006 15:05:01 -0600
Message-Id: <1143752701.2101.30.camel@localhost.localdomain>
Mime-Version: 1.0
Reply-To: will_schmidt@vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-A1YQtvKvaqwzgp377Dui
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Please apply.

This patch fixed several problems with the lparcfg code.  In case
someone gets a sense of deja-vu, part of this was submitted last Sep, I
thought the changes went in, but either got backed out, or just got
lost. 

First, change the local_buffer declaration to be unsigned char *.  We
had a bad-math problem in a 2.4 tree which was built with a
"-fsigned-char" parm.  I dont believe we ever build with that parm
now-a-days, but to be safe, I'd prefer the declaration be explicit.

Second, fix a bad math calculation for splpar_strlen.   

Third, on the rtas_call for get-system-parameter, pass in
RTAS_DATA_BUF_SIZE for the rtas_data_buf size, instead of letting random
data determine the size.   Until recently, we've had a sufficiently
large 'random data' value get passed in, so the function just happens to
have worked OK.   Now it's getting passed a '0', which causes the
rtas_call to return success, but no data shows up in the buffer.
(oops!).   This was found by the LTC test org.  

This is in a branch of code that only gets run on SPLPAR systems.
Tested on power5 Lpar.  

Signed-off-by: Will Schmidt <willschm@us.ibm.com>



--=-A1YQtvKvaqwzgp377Dui
Content-Disposition: attachment; filename=22746.diff
Content-Type: text/x-patch; name=22746.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -Naur 2.6/arch/powerpc/kernel/lparcfg.c 2.6.mar30/arch/powerpc/kernel/lparcfg.c
--- 2.6/arch/powerpc/kernel/lparcfg.c	2006-03-20 02:15:57.000000000 -0800
+++ 2.6.mar30/arch/powerpc/kernel/lparcfg.c	2006-03-30 12:06:34.323023840 -0800
@@ -37,7 +37,7 @@
 #include <asm/prom.h>
 #include <asm/vdso_datapage.h>
 
-#define MODULE_VERS "1.6"
+#define MODULE_VERS "1.7"
 #define MODULE_NAME "lparcfg"
 
 /* #define LPARCFG_DEBUG */
@@ -242,7 +242,7 @@
 {
 	int call_status;
 
-	char *local_buffer = kmalloc(SPLPAR_MAXLENGTH, GFP_KERNEL);
+	unsigned char *local_buffer = kmalloc(SPLPAR_MAXLENGTH, GFP_KERNEL);
 	if (!local_buffer) {
 		printk(KERN_ERR "%s %s kmalloc failure at line %d \n",
 		       __FILE__, __FUNCTION__, __LINE__);
@@ -254,7 +254,8 @@
 	call_status = rtas_call(rtas_token("ibm,get-system-parameter"), 3, 1,
 				NULL,
 				SPLPAR_CHARACTERISTICS_TOKEN,
-				__pa(rtas_data_buf));
+				__pa(rtas_data_buf),
+				RTAS_DATA_BUF_SIZE);
 	memcpy(local_buffer, rtas_data_buf, SPLPAR_MAXLENGTH);
 	spin_unlock(&rtas_data_buf_lock);
 
@@ -275,7 +276,7 @@
 #ifdef LPARCFG_DEBUG
 		printk(KERN_INFO "success calling get-system-parameter \n");
 #endif
-		splpar_strlen = local_buffer[0] * 16 + local_buffer[1];
+		splpar_strlen = local_buffer[0] * 256 + local_buffer[1];
 		local_buffer += 2;	/* step over strlen value */
 
 		memset(workbuffer, 0, SPLPAR_MAXLENGTH);

--=-A1YQtvKvaqwzgp377Dui--
