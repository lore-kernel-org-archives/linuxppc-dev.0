Return-Path: <prasad@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 052A0B7804
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 10 Jun 2009 19:08:33 +1000 (EST)
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [59.145.155.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp05.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4070DDDD1B
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Jun 2009 19:08:31 +1000 (EST)
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
	by e28smtp05.in.ibm.com (8.13.1/8.13.1) with ESMTP id n5A98R9G015470
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Jun 2009 14:38:27 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5A98RjL2248794
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Jun 2009 14:38:27 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.13.1/8.13.3) with ESMTP id n5A98Pf0026199
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Jun 2009 14:38:26 +0530
Date: Wed, 10 Jun 2009 14:38:24 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: David Gibson <dwg@au1.ibm.com>, linuxppc-dev@ozlabs.org
Subject: [Patch 5/6] Modify Data storage exception code to recognise DABR
	match first
Message-ID: <20090610090824.GF14478@in.ibm.com>
References: <20090610090316.898961359@prasadkr_t60p.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Neuling <mikey@neuling.org>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>, paulus@samba.org,
	Alan Stern <stern@rowland.harvard.edu>,
	"K.Prasad" <prasad@linux.vnet.ibm.com>, Roland McGrath <roland@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

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
@@ -136,6 +136,12 @@ int __kprobes do_page_fault(struct pt_re
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
@@ -150,14 +156,6 @@ int __kprobes do_page_fault(struct pt_re
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
