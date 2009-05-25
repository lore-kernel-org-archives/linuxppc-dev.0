Return-Path: <prasad@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [59.145.155.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp06.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 58F04DEB31
	for <linuxppc-dev@ozlabs.org>; Mon, 25 May 2009 11:17:26 +1000 (EST)
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
	by e28smtp06.in.ibm.com (8.13.1/8.13.1) with ESMTP id n4P1HM3C006038
	for <linuxppc-dev@ozlabs.org>; Mon, 25 May 2009 06:47:22 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
	by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n4P1HMo92605228
	for <linuxppc-dev@ozlabs.org>; Mon, 25 May 2009 06:47:22 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
	by d28av05.in.ibm.com (8.13.1/8.13.3) with ESMTP id n4P1HLwF004356
	for <linuxppc-dev@ozlabs.org>; Mon, 25 May 2009 11:17:22 +1000
Date: Mon, 25 May 2009 06:47:18 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [Patch 5/6] Modify Data storage exception code to recognise DABR
	match first
Message-ID: <20090525011718.GF11078@in.ibm.com>
References: <20090525004730.944465878@prasadkr_t60p.in.ibm.com>
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
