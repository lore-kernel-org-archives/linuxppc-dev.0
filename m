Return-Path: <anton@samba.org>
Date: Mon, 18 Nov 2013 13:19:17 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, mikey@neuling.org
Subject: [PATCH] powerpc: Only print PACATMSCRATCH in oops when TM is active
Message-ID: <20131118131917.6718ff5b@kryten>
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


If TM is not active there is no need to print PACATMSCRATCH
so we can save ourselves a line.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: b/arch/powerpc/kernel/process.c
===================================================================
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -871,7 +871,8 @@ void show_regs(struct pt_regs * regs)
 	printk("SOFTE: %ld ", regs->softe);
 #endif
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
-	printk("\nPACATMSCRATCH: %016llx ", get_paca()->tm_scratch);
+	if (MSR_TM_ACTIVE(regs->msr))
+		printk("\nPACATMSCRATCH: %016llx ", get_paca()->tm_scratch);
 #endif
 
 	for (i = 0;  i < 32;  i++) {
