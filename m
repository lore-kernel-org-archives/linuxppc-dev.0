Return-Path: <jwboyer@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.177])
	by ozlabs.org (Postfix) with ESMTP id A445BDE3BF
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Apr 2008 10:50:34 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id z59so2249444pyg.27
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Apr 2008 17:50:32 -0700 (PDT)
Subject: [PATCH 2/2] [PPC] Add strncmp to arch/ppc
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <1208825276.6654.41.camel@vader.jdub.homelinux.org>
References: <1208825276.6654.41.camel@vader.jdub.homelinux.org>
Content-Type: text/plain
Date: Mon, 21 Apr 2008 19:50:27 -0500
Message-Id: <1208825427.6654.46.camel@vader.jdub.homelinux.org>
Mime-Version: 1.0
Sender: Josh Boyer <jwboyer@gmail.com>
Cc: paulus@samba.org
Reply-To: jwboyer@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Commit 0119536cd314ef95553604208c25bc35581f7f0a added an assembly version
of strncmp to PowerPC.  However, it changed a common header file between
arch/ppc and arch/powerpc without adding strncmp to arch/ppc.  This fixes
that omission so that arch/ppc links again.

Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

---
 arch/ppc/kernel/ppc_ksyms.c |    1 +
 arch/ppc/lib/string.S       |   14 ++++++++++++++
 2 files changed, 15 insertions(+)

--- linux-2.6.orig/arch/ppc/kernel/ppc_ksyms.c
+++ linux-2.6/arch/ppc/kernel/ppc_ksyms.c
@@ -89,6 +89,7 @@ EXPORT_SYMBOL(strncpy);
 EXPORT_SYMBOL(strcat);
 EXPORT_SYMBOL(strlen);
 EXPORT_SYMBOL(strcmp);
+EXPORT_SYMBOL(strncmp);
 
 EXPORT_SYMBOL(csum_partial);
 EXPORT_SYMBOL(csum_partial_copy_generic);
--- linux-2.6.orig/arch/ppc/lib/string.S
+++ linux-2.6/arch/ppc/lib/string.S
@@ -121,6 +121,20 @@ _GLOBAL(strcmp)
 	beq	1b
 	blr
 
+_GLOBAL(strncmp)
+	PPC_LCMPI r5,0
+	beqlr
+	mtctr	r5
+	addi	r5,r3,-1
+	addi	r4,r4,-1
+1:	lbzu	r3,1(r5)
+	cmpwi	1,r3,0
+	lbzu	r0,1(r4)
+	subf.	r3,r0,r3
+	beqlr	1
+	bdnzt	eq,1b
+	blr
+
 _GLOBAL(strlen)
 	addi	r4,r3,-1
 1:	lbzu	r0,1(r4)
