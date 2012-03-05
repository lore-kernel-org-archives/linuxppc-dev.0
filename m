Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp01.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A1B80B6FF9
 for <linuxppc-dev@ozlabs.org>; Mon,  5 Mar 2012 13:53:19 +1100 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <benh@kernel.crashing.org>;
 Mon, 5 Mar 2012 02:46:41 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q252kp0u3125288
 for <linuxppc-dev@ozlabs.org>; Mon, 5 Mar 2012 13:46:54 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q252qRel007522
 for <linuxppc-dev@ozlabs.org>; Mon, 5 Mar 2012 13:52:27 +1100
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 09/13] powerpc/xmon: Add display of soft & hard irq states
Date: Mon,  5 Mar 2012 13:51:27 +1100
Message-Id: <1330915891-19523-10-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1330915891-19523-1-git-send-email-benh@kernel.crashing.org>
References: <1330915891-19523-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Also use local_paca instead of get_paca() to avoid getting into
the smp_processor_id() debugging code from the debugger

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/xmon/xmon.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index cb95eea..63846eb 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -1437,7 +1437,8 @@ static void excprint(struct pt_regs *fp)
 
 	printf("  current = 0x%lx\n", current);
 #ifdef CONFIG_PPC64
-	printf("  paca    = 0x%lx\n", get_paca());
+	printf("  paca    = 0x%lx\t softe: %d\t harde: %d\n",
+	       local_paca, local_paca->soft_enabled, local_paca->hard_enabled);
 #endif
 	if (current) {
 		printf("    pid   = %ld, comm = %s\n",
@@ -1641,7 +1642,7 @@ static void super_regs(void)
 
 			/* Dump out relevant Paca data areas. */
 			printf("Paca: \n");
-			ptrPaca = get_paca();
+			ptrPaca = local_paca;
 
 			printf("  Local Processor Control Area (LpPaca): \n");
 			ptrLpPaca = ptrPaca->lppaca_ptr;
@@ -2644,7 +2645,7 @@ static void dump_slb(void)
 static void dump_stab(void)
 {
 	int i;
-	unsigned long *tmp = (unsigned long *)get_paca()->stab_addr;
+	unsigned long *tmp = (unsigned long *)local_paca->stab_addr;
 
 	printf("Segment table contents of cpu %x\n", smp_processor_id());
 
-- 
1.7.9
