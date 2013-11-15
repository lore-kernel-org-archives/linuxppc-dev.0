Return-Path: <anton@samba.org>
Date: Fri, 15 Nov 2013 15:48:38 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, mikey@neuling.org
Subject: [PATCH] powerpc: Remove a few lines of oops output
Message-ID: <20131115154838.313ebf66@kryten>
In-Reply-To: <20131115154119.3614ed43@kryten>
References: <20131115154119.3614ed43@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


We waste quite a few lines in our oops output:

...
MSR: 8000000000009032 <SF,EE,ME,IR,DR,RI>  CR: 28044024  XER: 00000000
SOFTE: 0
CFAR: 0000000000009088
DAR: 000000000000001c, DSISR: 40000000

GPR00: c0000000000c74f0 c00000037cc1b010 c000000000d2bb30 0000000000000000 
...

We can do a better job here and remove 3 lines:

MSR: 8000000000009032 <SF,EE,ME,IR,DR,RI>  CR: 28044024  XER: 00000000
CFAR: 0000000000009088 DAR: 0000000000000010, DSISR: 40000000 SOFTE: 1 
GPR00: c0000000000e3d10 c00000037cc2fda0 c000000000d2c3a8 0000000000000001 

Also move PACATMSCRATCH up, it doesn't really belong in the stack
trace section.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

PACATMSCRATCH is a long and not very descriptive name. It appears to be
an MSR so should it instead be called TM_MSR?

Also, could we save a line and only print it if MSR_TM_ACTIVE()?

Index: b/arch/powerpc/kernel/process.c
===================================================================
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -858,17 +858,20 @@ void show_regs(struct pt_regs * regs)
 	printk("MSR: "REG" ", regs->msr);
 	printbits(regs->msr, msr_bits);
 	printk("  CR: %08lx  XER: %08lx\n", regs->ccr, regs->xer);
-#ifdef CONFIG_PPC64
-	printk("SOFTE: %ld\n", regs->softe);
-#endif
 	trap = TRAP(regs);
 	if ((regs->trap != 0xc00) && cpu_has_feature(CPU_FTR_CFAR))
-		printk("CFAR: "REG"\n", regs->orig_gpr3);
+		printk("CFAR: "REG" ", regs->orig_gpr3);
 	if (trap == 0x200 || trap == 0x300 || trap == 0x600)
 #if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
-		printk("DEAR: "REG", ESR: "REG"\n", regs->dar, regs->dsisr);
+		printk("DEAR: "REG" ESR: "REG" ", regs->dar, regs->dsisr);
 #else
-		printk("DAR: "REG", DSISR: %08lx\n", regs->dar, regs->dsisr);
+		printk("DAR: "REG" DSISR: %08lx ", regs->dar, regs->dsisr);
+#endif
+#ifdef CONFIG_PPC64
+	printk("SOFTE: %ld ", regs->softe);
+#endif
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+	printk("\nPACATMSCRATCH: %016llx ", get_paca()->tm_scratch);
 #endif
 
 	for (i = 0;  i < 32;  i++) {
@@ -887,9 +890,6 @@ void show_regs(struct pt_regs * regs)
 	printk("NIP ["REG"] %pS\n", regs->nip, (void *)regs->nip);
 	printk("LR ["REG"] %pS\n", regs->link, (void *)regs->link);
 #endif
-#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
-	printk("PACATMSCRATCH [%llx]\n", get_paca()->tm_scratch);
-#endif
 	show_stack(current, (unsigned long *) regs->gpr[1]);
 	if (!user_mode(regs))
 		show_instructions(regs);
