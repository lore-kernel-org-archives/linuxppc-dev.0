To: Venkatesh Rao <rpranesh@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: ZMII Code Panics on 440GP Ebony
References: <20020524155815.98552.qmail@web21402.mail.yahoo.com>
From: Roland Dreier <roland@topspin.com>
Date: 24 May 2002 09:40:53 -0700
In-Reply-To: <20020524155815.98552.qmail@web21402.mail.yahoo.com>
Message-ID: <52y9e9ebxm.fsf@topspin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>>>>> "Venkatesh" == Venkatesh Rao <rpranesh@yahoo.com> writes:

    Venkatesh> Hi, I am using a Rev B board and when i compiled the
    Venkatesh> latest kernel (pulled yesterday after Matt's
    Venkatesh> Checkin)and booted my ebony board, i got a panic in
    Venkatesh> ZMII. I am including a portion of the bootup log.

Yes, the linux_2_4_devel tree I pulled yesterday was not in a
consistent state for my 440GP Ebony board.  The problem is that the
Ebony setup code has not been updated for the new OCP handling code
yet.  To fix it, you need to edit arch/ppc/platforms/ebony.c and
delete the lines:

	/* FIXME: Remove after OCP code is updated */
	ebony_ocp_fixup_addrs(EMAC_ADDR[0], EMAC_ADDR[1], ZMII_ADDR[0]);

Then edit arch/ppc/platforms/ibm440gp.c -- change the initialization
of core_ocp[] so the EMAC and ZMII lines read:

	{EMAC, EBONY_EMAC0_ADDR, OCP_IRQ_NA},
	{EMAC, EBONY_EMAC1_ADDR, OCP_IRQ_NA},
	{ZMII, EBONY_ZMII_ADDR, OCP_IRQ_NA},

I'm including a patch at the end of this email.  Perhaps someone who
can check in to the tree and who can confirm that I've understood how
this is intended to work can get this into the linux_2_4_devel tree.

In addition, it seems to me that the EBONY_{ZMII,EMAC0,EMAC1}_{ADDR
constants should be renamed to PPC440GP_xxx constants since they are
not Ebony specific but rather apply to all IBM 440GP designs.  As
further cleanup, one can probably remove the EMAC_ADDR and ZMII_ADDR
variables.

I would be happy to help with this cleanup; however, I don't want to
step on anyone's work in progress.  However, if anyone would like
patches to do some of this cleanup I could put some together fairly
quickly.

Best,
Roland

diff -aur ebony.old/arch/ppc/platforms/ebony.c ebony/arch/ppc/platforms/ebony.c
--- ebony.old/arch/ppc/platforms/ebony.c	Fri May 24 09:23:40 2002
+++ ebony/arch/ppc/platforms/ebony.c	Fri May 24 09:13:29 2002
@@ -215,30 +215,6 @@
 TODC_ALLOC();
 #endif /* CONFIG_PPC_RTC */

-/*
- * FIXME: Remove after the OCP drivers start using
- * ioremap_native(get_ocp_paddr(...), ...)
- */
-void
-ebony_ocp_fixup_addrs(struct emac_regs *emac0_addr, struct emac_regs *emac1_addr,
-		struct zmii_regs *zmii_addr)
-{
-	int i;
-	int emac_count = 0;
-
-	for (i = 0; core_ocp[i].type != OCP_NULL_TYPE; i++) {
-		if (core_ocp[i].type == EMAC) {
-			core_ocp[i].paddr = emac_count++ ?
-				emac1_addr : emac0_addr;
-		}
-		else if (core_ocp[i].type == ZMII) {
-			core_ocp[i].paddr = zmii_addr;
-		}
-	}
-
-	return;
-}
-
 static void __init
 ebony_setup_arch(void)
 {
@@ -269,9 +245,6 @@
 	/* Setup ZMII access */
 	ZMII_ADDR[0] = (struct zmii_regs *)
 		ioremap64(EBONY_ZMII_ADDR, EBONY_ZMII_SIZE);
-
-	/* FIXME: Remove after OCP code is updated */
-	ebony_ocp_fixup_addrs(EMAC_ADDR[0], EMAC_ADDR[1], ZMII_ADDR[0]);

 	/* init to some ~sane value until calibrate_delay() runs */
         loops_per_jiffy = 50000000/HZ;
diff -aur ebony.old/arch/ppc/platforms/ibm440gp.c ebony/arch/ppc/platforms/ibm440gp.c
--- ebony.old/arch/ppc/platforms/ibm440gp.c	Fri May 24 09:23:05 2002
+++ ebony/arch/ppc/platforms/ibm440gp.c	Thu May 23 14:44:35 2002
@@ -68,9 +68,9 @@
 	{PCI, PCI0_BASE, OCP_IRQ_NA},
 	{OPB, OPB0_BASE, OCP_IRQ_NA},
 #endif
-	{EMAC, 0, OCP_IRQ_NA},
-	{EMAC, 0, OCP_IRQ_NA},
-	{ZMII, 0, OCP_IRQ_NA},
+	{EMAC, EBONY_EMAC0_ADDR, OCP_IRQ_NA},
+	{EMAC, EBONY_EMAC1_ADDR, OCP_IRQ_NA},
+	{ZMII, EBONY_ZMII_ADDR, OCP_IRQ_NA},
 	{OCP_NULL_TYPE, 0x0, OCP_IRQ_NA},

 };

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
