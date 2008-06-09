Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 78646DE2F9
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jun 2008 09:26:46 +1000 (EST)
Message-Id: <200806092326.m59NQA9c014230@imap1.linux-foundation.org>
Subject: [patch 5/5] arch/powerpc/platforms/pseries/eeh_driver.c: fix warning
To: paulus@samba.org
From: akpm@linux-foundation.org
Date: Mon, 09 Jun 2008 16:26:10 -0700
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Andrew Morton <akpm@linux-foundation.org>

Fix this:

/usr/src/devel/arch/powerpc/platforms/pseries/eeh_driver.c: In function 'print_device_node_tree':
/usr/src/devel/arch/powerpc/platforms/pseries/eeh_driver.c:55: warning: ISO C90 forbids mixed declarations and code

also make that function look like it's part of Linux.  I mean, wtf are you
guys up to down there??

[akpm@linux-foundation.org: coding-style fixes]
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/powerpc/platforms/pseries/eeh_driver.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff -puN arch/powerpc/platforms/pseries/eeh_driver.c~arch-powerpc-platforms-pseries-eeh_driverc-fix-warning arch/powerpc/platforms/pseries/eeh_driver.c
--- a/arch/powerpc/platforms/pseries/eeh_driver.c~arch-powerpc-platforms-pseries-eeh_driverc-fix-warning
+++ a/arch/powerpc/platforms/pseries/eeh_driver.c
@@ -42,17 +42,20 @@ static inline const char * pcid_name (st
 }
 
 #ifdef DEBUG
-static void print_device_node_tree (struct pci_dn *pdn, int dent)
+static void print_device_node_tree(struct pci_dn *pdn, int dent)
 {
 	int i;
-	if (!pdn) return;
-	for (i=0;i<dent; i++)
+	struct device_node *pc;
+
+	if (!pdn)
+		return;
+	for (i = 0; i < dent; i++)
 		printk(" ");
 	printk("dn=%s mode=%x \tcfg_addr=%x pe_addr=%x \tfull=%s\n",
 		pdn->node->name, pdn->eeh_mode, pdn->eeh_config_addr,
 		pdn->eeh_pe_config_addr, pdn->node->full_name);
 	dent += 3;
-	struct device_node *pc = pdn->node->child;
+	pc = pdn->node->child;
 	while (pc) {
 		print_device_node_tree(PCI_DN(pc), dent);
 		pc = pc->sibling;
_
