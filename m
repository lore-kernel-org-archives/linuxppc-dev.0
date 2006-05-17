Return-Path: <jimix@watson.ibm.com>
Received: from igw2.watson.ibm.com (igw2.watson.ibm.com [129.34.20.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F40C2679EB
	for <linuxppc-dev@ozlabs.org>; Thu, 18 May 2006 04:48:32 +1000 (EST)
Received: from sp1n294en1.watson.ibm.com (sp1n294en1.watson.ibm.com
	[129.34.20.40])
	by igw2.watson.ibm.com (8.12.11.20060308/8.13.1/8.13.1-2005-04-25 igw)
	with ESMTP id k4HImvSE026859
	for <linuxppc-dev@ozlabs.org>; Wed, 17 May 2006 14:48:57 -0400
Received: from sp1n294en1.watson.ibm.com (localhost [127.0.0.1])
	by sp1n294en1.watson.ibm.com (8.11.7-20030924/8.11.7/01-14-2004_2) with
	ESMTP id k4HImSH31882
	for <linuxppc-dev@ozlabs.org>; Wed, 17 May 2006 14:48:28 -0400
Received: from mgsmtp00.watson.ibm.com (mgsmtp00.watson.ibm.com [9.2.40.58])
	by sp1n294en1.watson.ibm.com (8.11.7-20030924/8.11.7/01-14-2004_1) with
	ESMTP id k4HImR372518
	for <linuxppc-dev@ozlabs.org>; Wed, 17 May 2006 14:48:27 -0400
Received: from kitch0.watson.ibm.com (kitch0.watson.ibm.com [9.2.224.107])
	by mgsmtp00.watson.ibm.com (8.12.11/8.12.11/2005/09/01) with ESMTP id
	k4HGqku7028316
	for <linuxppc-dev@ozlabs.org>; Wed, 17 May 2006 12:52:46 -0400
Received: from heater.watson.ibm.com (heater.watson.ibm.com [9.2.222.55])
	by kitch0.watson.ibm.com (AIX5.1/8.11.6p2/8.11.0/03-06-2002) with ESMTP
	id k4HFwQm37636
	for <linuxppc-dev@ozlabs.org>; Wed, 17 May 2006 11:58:26 -0400
Received: from jimix by heater.watson.ibm.com with local (Exim 4.60)
	(envelope-from <jimix@watson.ibm.com>) id 1FgORv-0001dS-Hu
	for linuxppc-dev@ozlabs.org; Wed, 17 May 2006 12:00:35 -0400
To: linuxppc-dev@ozlabs.org
Subject: [PATCH][resend] udbg_printf() formatting attribute
Message-Id: <E1FgORv-0001dS-Hu@heater.watson.ibm.com>
From: jimix@watson.ibm.com
Date: Wed, 17 May 2006 12:00:35 -0400
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sorry, Previous patch was munged by MTA.

This patch allows the compiler to catch any printf-like mismatches for
udbg_printf().  After some brute force building I've only found issues
with my own code and lparcfg.c It could break some developers, but
IMHO that would be goodness.

Signed-off-by: Jimi Xenidis <jimix@watson.ibm.com>

---

diff -r 0163968f7fce arch/powerpc/kernel/lparcfg.c
--- a/arch/powerpc/kernel/lparcfg.c	Tue May 16 15:55:19 2006 -0400
+++ b/arch/powerpc/kernel/lparcfg.c	Wed May 17 11:55:21 2006 -0400
@@ -521,10 +521,10 @@ static ssize_t lparcfg_write(struct file
 
 	current_weight = (resource >> 5 * 8) & 0xFF;
 
-	pr_debug("%s: current_entitled = %lu, current_weight = %lu\n",
+	pr_debug("%s: current_entitled = %lu, current_weight = %u\n",
 		 __FUNCTION__, current_entitled, current_weight);
 
-	pr_debug("%s: new_entitled = %lu, new_weight = %lu\n",
+	pr_debug("%s: new_entitled = %lu, new_weight = %u\n",
 		 __FUNCTION__, *new_entitled_ptr, *new_weight_ptr);
 
 	retval = plpar_hcall_norets(H_SET_PPP, *new_entitled_ptr,
diff -r 0163968f7fce include/asm-powerpc/udbg.h
--- a/include/asm-powerpc/udbg.h	Tue May 16 15:55:19 2006 -0400
+++ b/include/asm-powerpc/udbg.h	Wed May 17 11:55:21 2006 -0400
@@ -23,7 +23,8 @@ extern int udbg_read(char *buf, int bufl
 extern int udbg_read(char *buf, int buflen);
 
 extern void register_early_udbg_console(void);
-extern void udbg_printf(const char *fmt, ...);
+extern void udbg_printf(const char *fmt, ...)
+	__attribute__ ((format (printf, 1, 2)));
 extern void udbg_progress(char *s, unsigned short hex);
 
 extern void udbg_init_uart(void __iomem *comport, unsigned int speed,
