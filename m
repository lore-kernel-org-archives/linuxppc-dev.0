Return-Path: <prasad@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp01.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C3382DEB95
	for <linuxppc-dev@ozlabs.org>; Thu, 21 May 2009 17:18:42 +1000 (EST)
Received: from d23relay02.au.ibm.com (d23relay02.au.ibm.com [202.81.31.244])
	by e23smtp01.au.ibm.com (8.13.1/8.13.1) with ESMTP id n4L7HsAw001886
	for <linuxppc-dev@ozlabs.org>; Thu, 21 May 2009 17:17:54 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay02.au.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n4L7Ib4i1540228
	for <linuxppc-dev@ozlabs.org>; Thu, 21 May 2009 17:18:37 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n4L7IaO1026683
	for <linuxppc-dev@ozlabs.org>; Thu, 21 May 2009 17:18:37 +1000
Date: Thu, 21 May 2009 12:48:27 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [RFC Patch 5/6] Modify Data storage exception code to recognise
	DABR match first
Message-ID: <20090521071827.GF693@in.ibm.com>
References: <20090521070751.156865078@prasadkr_t60p.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Neuling <mikey@neuling.org>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>,
	Alan Stern <stern@rowland.harvard.edu>, paulus@samba.org,
	"K.Prasad" <prasad@linux.vnet.ibm.com>, Roland McGrath <roland@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Modify Data storage exception code to first lookout for a DABR match before
recognising a kprobe or xmon exception.

Signed-off-by: K.Prasad <prasad@linux.vnet.ibm.com>
---
 arch/powerpc/mm/fault.c |   14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

Index: linux-2.6-tip.hbkpt/arch/powerpc/mm/fault.c
===================================================================
--- linux-2.6-tip.hbkpt.orig/arch/powerpc/mm/fault.c
+++ linux-2.6-tip.hbkpt/arch/powerpc/mm/fault.c
@@ -137,6 +137,12 @@ int __kprobes do_page_fault(struct pt_re
 		error_code &= 0x48200000;
 	else
 		is_write = error_code & DSISR_ISSTORE;
+
+	if (error_code & DSISR_DABRMATCH) {
+		/* DABR match */
+		do_dabr(regs, address, error_code);
+		return 0;
+	}
 #else
 	is_write = error_code & ESR_DST;
 #endif /* CONFIG_4xx || CONFIG_BOOKE */
@@ -151,14 +157,6 @@ int __kprobes do_page_fault(struct pt_re
 	if (!user_mode(regs) && (address >= TASK_SIZE))
 		return SIGSEGV;
 
-#if !(defined(CONFIG_4xx) || defined(CONFIG_BOOKE))
-  	if (error_code & DSISR_DABRMATCH) {
-		/* DABR match */
-		do_dabr(regs, address, error_code);
-		return 0;
-	}
-#endif /* !(CONFIG_4xx || CONFIG_BOOKE)*/
-
 	if (in_atomic() || mm == NULL) {
 		if (!user_mode(regs))
 			return SIGSEGV;
