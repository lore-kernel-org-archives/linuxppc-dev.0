Return-Path: <mostrows@watson.ibm.com>
Received: from igw2.watson.ibm.com (igw2.watson.ibm.com [129.34.20.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 90A8967B23
	for <linuxppc-dev@ozlabs.org>; Tue, 30 May 2006 06:42:13 +1000 (EST)
Received: from sp1n294en1.watson.ibm.com (sp1n294en1.watson.ibm.com
	[129.34.20.40])
	by igw2.watson.ibm.com (8.12.11.20060308/8.13.1/8.13.1-2005-04-25 igw)
	with ESMTP id k4TKggim014931
	for <linuxppc-dev@ozlabs.org>; Mon, 29 May 2006 16:42:42 -0400
Received: from sp1n294en1.watson.ibm.com (localhost [127.0.0.1])
	by sp1n294en1.watson.ibm.com (8.11.7-20030924/8.11.7/01-14-2004_2) with
	ESMTP id k4TKg8H376046
	for <linuxppc-dev@ozlabs.org>; Mon, 29 May 2006 16:42:08 -0400
Received: from mgsmtp00.watson.ibm.com (mgsmtp00.watson.ibm.com [9.2.40.58])
	by sp1n294en1.watson.ibm.com (8.11.7-20030924/8.11.7/01-14-2004_1) with
	ESMTP id k4TKg83305700
	for <linuxppc-dev@ozlabs.org>; Mon, 29 May 2006 16:42:08 -0400
Received: from kitch0.watson.ibm.com (kitch0.watson.ibm.com [9.2.224.107])
	by mgsmtp00.watson.ibm.com (8.12.11/8.12.11/2005/09/01) with ESMTP id
	k4TLZrAi002617
	for <linuxppc-dev@ozlabs.org>; Mon, 29 May 2006 17:35:53 -0400
Subject: [PATCH 7/8] Cleaner checks for MPIC on pSeries.
In-Reply-To: <1148935262.25048.31.camel@brick>
Date: Mon, 29 May 2006 16:42:06 -0400
Message-Id: <11489353263834-git-send-email-mostrows@watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
To: linuxppc-dev@ozlabs.org
From: mostrows@watson.ibm.com
Reply-To: mostrows@watson.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Instead of checking the pSeries_mpic pointer, use a wrapper
(pSeries_uses_mpic()) that tells us what we want to know.

--
Signed-off-by: Michal Ostrowski <mostrows@watson.ibm.com>

---

 arch/powerpc/kernel/rtas_pci.c         |    2 +-
 arch/powerpc/platforms/pseries/setup.c |    2 +-
 include/asm-powerpc/mpic.h             |    6 ++++++
 3 files changed, 8 insertions(+), 2 deletions(-)

082a93566e954ce0cc945b89aced0b28feb7ee60
diff --git a/arch/powerpc/kernel/rtas_pci.c b/arch/powerpc/kernel/rtas_pci.c
index e1dbd53..2a6b729 100644
--- a/arch/powerpc/kernel/rtas_pci.c
+++ b/arch/powerpc/kernel/rtas_pci.c
@@ -322,7 +322,7 @@ unsigned long __init find_and_init_phbs(
 		pci_setup_phb_io(phb, index == 0);
 #ifdef CONFIG_PPC_PSERIES
 		/* XXX This code need serious fixing ... --BenH */
-		if (pSeries_mpic) {
+		if (pSeries_uses_mpic()) {
 			int addr = root_size_cells * (index + 2) - 1;
 			mpic_assign_isu(pSeries_mpic, index, opprop[addr]);
 		}
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 4ff127b..551da6a 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -536,7 +536,7 @@ static void pseries_kexec_cpu_down(int c
 		}
 	}
 
-	if (pSeries_mpic)
+	if (pSeries_uses_mpic())
 		mpic_teardown_this_cpu(secondary);
 	else
 		xics_teardown_cpu(secondary);
diff --git a/include/asm-powerpc/mpic.h b/include/asm-powerpc/mpic.h
index 6b9e781..1f1b2eb 100644
--- a/include/asm-powerpc/mpic.h
+++ b/include/asm-powerpc/mpic.h
@@ -287,5 +287,11 @@ extern int mpic_get_irq(struct pt_regs *
 /* global mpic for pSeries */
 extern struct mpic *pSeries_mpic;
 
+#ifdef CONFIG_MPIC
+#define pSeries_uses_mpic() (pSeries_mpic != NULL)
+#else
+#define pSeries_uses_mpic() 0
+#endif
+
 #endif /* __KERNEL__ */
 #endif	/* _ASM_POWERPC_MPIC_H */
-- 
1.1.4.g0b63-dirty
