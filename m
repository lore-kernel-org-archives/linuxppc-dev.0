Return-Path: <joakim.tjernlund@transmode.com>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BBADFB7BB8
	for <linuxppc-dev@ozlabs.org>; Mon,  5 Oct 2009 23:16:49 +1100 (EST)
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
To: Scott Wood <scottwood@freescale.com>, Rex Feany <RFeany@mrv.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 2/6] 8xx, fault: Add some debug code to do_page_fault()
Date: Mon, 5 Oct 2009 14:16:35 +0200
Message-Id: <1254744999-3158-3-git-send-email-Joakim.Tjernlund@transmode.se>
In-Reply-To: <1254744999-3158-2-git-send-email-Joakim.Tjernlund@transmode.se>
References: <1254744999-3158-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<1254744999-3158-2-git-send-email-Joakim.Tjernlund@transmode.se>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

---
 arch/powerpc/mm/fault.c |   82 +++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 82 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 7699394..c33c6de 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -139,6 +139,88 @@ int __kprobes do_page_fault(struct pt_regs *regs, unsigned long address,
 #else
 	is_write = error_code & ESR_DST;
 #endif /* CONFIG_4xx || CONFIG_BOOKE */
+#if 1 /* defined(CONFIG_8xx)*/
+#define DEBUG_DCBX
+/*
+ Work around DTLB Miss/Error, as these do not update
+ DAR for dcbf, dcbi, dcbst, dcbz and icbi instructions
+ This relies on every exception tagging DAR with 0xf0
+ before returning (rfi)
+ DAR is passed as 'address' to this function.
+ */
+	{
+		unsigned long ra, rb, dar, insn;
+#ifdef DEBUG_DCBX
+		const char *istr = NULL;
+
+		insn = *((unsigned long *)regs->nip);
+		if (((insn >> (31-5)) & 0x3f) == 31) {
+			if (((insn >> 1) & 0x3ff) == 1014) /* dcbz ? 0x3f6 */
+				istr = "dcbz";
+			if (((insn >> 1) & 0x3ff) == 86) /* dcbf ? 0x56 */
+				istr = "dcbf";
+			if (((insn >> 1) & 0x3ff) == 470) /* dcbi ? 0x1d6 */
+				istr = "dcbi";
+			if (((insn >> 1) & 0x3ff) == 54) /* dcbst ? 0x36 */
+				istr = "dcbst";
+			if (((insn >> 1) & 0x3ff) == 982) /* icbi ? 0x3d6 */
+				istr = "icbi";
+			if (istr) {
+				ra = (insn >> (31-15)) & 0x1f; /* Reg RA */
+				rb = (insn >> (31-20)) & 0x1f; /* Reg RB */
+				dar = regs->gpr[rb];
+				if (ra)
+					dar += regs->gpr[ra];
+				if (dar != address && address != 0x00f0 && trap == 0x300)
+					printk(KERN_CRIT "%s: address:%lx, dar:%lx!\n", istr, address, dar);
+				if (!strcmp(istr, "dcbst") && is_write) {
+					printk(KERN_CRIT "dcbst R%ld,R%ld = %lx as a store, fixing!\n",
+					       ra, rb, dar);
+					is_write = 0;
+				}
+
+				if (trap == 0x300 && address != dar) {
+					__asm__ ("mtdar %0" : : "r" (dar));
+					return 0;
+				}
+			}
+		}
+#endif
+		if (address == 0x00f0 && trap == 0x300) {
+			pte_t *ptep;
+
+			/* This is from a dcbX or icbi insn gone bad, these
+			 * insn do not set DAR so we have to do it here instead */
+			insn = *((unsigned long *)regs->nip);
+
+			ra = (insn >> (31-15)) & 0x1f; /* Reg RA */
+			rb = (insn >> (31-20)) & 0x1f; /* Reg RB */
+			dar = regs->gpr[rb];
+			if (ra)
+				dar += regs->gpr[ra];
+			/* Set DAR to correct address for the DTLB Miss/Error handler
+			 * to redo the TLB exception. This time with correct address */
+			__asm__ ("mtdar %0" : : "r" (dar));
+#ifdef DEBUG_DCBX
+			printk(KERN_CRIT "trap:%x address:%lx, dar:%lx,err:%lx %s\n",
+			       trap, address, dar, error_code, istr);
+#endif
+			address = dar;
+#if 1
+			if (is_write && get_pteptr(mm, dar, &ptep, NULL)) {
+				pte_t my_pte = *ptep;
+
+				if (pte_present(my_pte) && pte_write(my_pte)) {
+					pte_val(my_pte) |= _PAGE_DIRTY|_PAGE_ACCESSED|_PAGE_HWWRITE;
+					set_pte_at(mm, dar, ptep, my_pte);
+				}
+			}
+#else
+			return 0;
+#endif
+		}
+	}
+#endif
 
 	if (notify_page_fault(regs))
 		return 0;
-- 
1.6.4.4
