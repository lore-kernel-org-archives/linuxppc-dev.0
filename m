Return-Path: <olh@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 44C4F689FD
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Jan 2006 08:19:11 +1100 (EST)
Date: Sun, 22 Jan 2006 22:19:02 +0100
From: Olaf Hering <olh@suse.de>
To: Paul Mackeras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Subject: [PATCH] cleanup pmac_newworld variable usage
Message-ID: <20060122211902.GA27709@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


remove extern declarations of pmac_newworld
move pmac_newworld to bss
if there is any "interrupt-controller" device, then it is newworld.

Signed-off-by: Olaf Hering <olh@suse.de>

 arch/powerpc/kernel/ppc_ksyms.c         |    1 -
 arch/powerpc/platforms/powermac/setup.c |    8 ++++----
 2 files changed, 4 insertions(+), 5 deletions(-)

Index: linux-2.6.16-rc1-olh/arch/powerpc/kernel/ppc_ksyms.c
===================================================================
--- linux-2.6.16-rc1-olh.orig/arch/powerpc/kernel/ppc_ksyms.c
+++ linux-2.6.16-rc1-olh/arch/powerpc/kernel/ppc_ksyms.c
@@ -57,7 +57,6 @@ extern void machine_check_exception(stru
 extern void alignment_exception(struct pt_regs *regs);
 extern void program_check_exception(struct pt_regs *regs);
 extern void single_step_exception(struct pt_regs *regs);
-extern int pmac_newworld;
 extern int sys_sigreturn(struct pt_regs *regs);
 
 EXPORT_SYMBOL(clear_pages);
Index: linux-2.6.16-rc1-olh/arch/powerpc/platforms/powermac/setup.c
===================================================================
--- linux-2.6.16-rc1-olh.orig/arch/powerpc/platforms/powermac/setup.c
+++ linux-2.6.16-rc1-olh/arch/powerpc/platforms/powermac/setup.c
@@ -88,11 +88,10 @@ int ppc_override_l2cr = 0;
 int ppc_override_l2cr_value;
 int has_l2cache = 0;
 
-int pmac_newworld = 1;
+int pmac_newworld;
 
 static int current_root_goodness = -1;
 
-extern int pmac_newworld;
 extern struct machdep_calls pmac_md;
 
 #define DEFAULT_ROOT_DEVICE Root_SDA1	/* sda1 - slightly silly choice */
@@ -310,9 +309,10 @@ static void __init pmac_setup_arch(void)
 	for (ic = NULL; (ic = of_find_all_nodes(ic)) != NULL; )
 		if (get_property(ic, "interrupt-controller", NULL))
 			break;
-	pmac_newworld = (ic != NULL);
-	if (ic)
+	if (ic) {
+		pmac_newworld = 1;
 		of_node_put(ic);
+	}
 
 	/* Lookup PCI hosts */
 	pmac_pci_init();
-- 
short story of a lazy sysadmin:
 alias appserv=wotan
