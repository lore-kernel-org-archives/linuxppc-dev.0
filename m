Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 23AF4DDE16
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Aug 2007 01:11:39 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l7HFBauF032023
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Aug 2007 11:11:36 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l7HFBamh212982
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Aug 2007 09:11:36 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l7HFBZ7k011340
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Aug 2007 09:11:35 -0600
Date: Fri, 17 Aug 2007 10:11:34 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: RFC: [PATCH] Fixup modpost warnings in head*.S for ppc32
Message-ID: <20070817101134.0c62bb3b@weaponx.rchland.ibm.com>
In-Reply-To: <Pine.LNX.4.64.0708170847120.29396@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0708170847120.29396@blarg.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 17 Aug 2007 08:48:40 -0500 (CDT)
Kumar Gala <galak@kernel.crashing.org> wrote:

> Addess the following modpost warnings we get out of the ppc32 head files:
> 
> WARNING: vmlinux.o(.text+0x358): Section mismatch: reference to .init.text:early_init (between 'skpinv' and 'interrupt_base')
> WARNING: vmlinux.o(.text+0x380): Section mismatch: reference to .init.text:machine_init (between 'skpinv' and 'interrupt_base')
> WARNING: vmlinux.o(.text+0x384): Section mismatch: reference to .init.text:MMU_init (between 'skpinv' and 'interrupt_base')
> WARNING: vmlinux.o(.text+0x3aa): Section mismatch: reference to .init.text:start_kernel (between 'skpinv' and 'interrupt_base')
> WARNING: vmlinux.o(.text+0x3ae): Section mismatch: reference to .init.text:start_kernel (between 'skpinv' and 'interrupt_base')
> 

Works for 44x.  For 40x, I needed the additional patch below.

josh

---
 arch/powerpc/kernel/head_40x.S |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

--- linux-2.6.orig/arch/powerpc/kernel/head_40x.S
+++ linux-2.6/arch/powerpc/kernel/head_40x.S
@@ -89,9 +89,9 @@ turn_on_mmu:
  */
 	. = 0xc0
 crit_save:
-_GLOBAL(crit_r10)
+_ENTRY(crit_r10)
 	.space	4
-_GLOBAL(crit_r11)
+_ENTRY(crit_r11)
 	.space	4
 
 /*
@@ -809,14 +809,6 @@ finish_tlb_load:
 	rfi			/* Should sync shadow TLBs */
 	b	.		/* prevent prefetch past rfi */
 
-/* extern void giveup_fpu(struct task_struct *prev)
- *
- * The PowerPC 4xx family of processors do not have an FPU, so this just
- * returns.
- */
-_GLOBAL(giveup_fpu)
-	blr
-
 /* This is where the main kernel code starts.
  */
 start_here:
@@ -961,6 +953,14 @@ initial_mmu:
 
 	blr
 
+/* extern void giveup_fpu(struct task_struct *prev)
+ *
+ * The PowerPC 4xx family of processors do not have an FPU, so this just
+ * returns.
+ */
+_GLOBAL(giveup_fpu)
+	blr
+
 _GLOBAL(abort)
         mfspr   r13,SPRN_DBCR0
         oris    r13,r13,DBCR0_RST_SYSTEM@h
