Return-Path: <markn@au1.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp06.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AF530B7D06
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  8 Feb 2010 13:41:43 +1100 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp06.au.ibm.com (8.14.3/8.13.1) with ESMTP id o182fWTx020116
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 8 Feb 2010 13:41:32 +1100
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o182fdvN1540318
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 8 Feb 2010 13:41:39 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o182fc13005261
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 8 Feb 2010 13:41:39 +1100
From: Mark Nelson <markn@au1.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: powerpc/pseries: Fix kexec regression caused by CPPR tracking
Date: Mon, 8 Feb 2010 13:45:12 +1100
References: <201002011712.58684.markn@au1.ibm.com>
In-Reply-To: <201002011712.58684.markn@au1.ibm.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201002081345.12033.markn@au1.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The code to track the CPPR values added by commit
49bd3647134ea47420067aea8d1401e722bf2aac ("powerpc/pseries: Track previous
CPPR values to correctly EOI interrupts") broke kexec on pseries because
the kexec code in xics.c calls xics_set_cpu_priority() before the IPI has
been EOI'ed. This wasn't a problem previously but it now triggers a BUG_ON
in xics_set_cpu_priority() because os_cppr->index isn't 0:

Oops: Exception in kernel mode, sig: 5 [#1]             
SMP NR_CPUS=128 NUMA                                    
kernel BUG at arch/powerpc/platforms/pseries/xics.c:791!
pSeries                                                 
Modules linked in: ehea dm_mirror dm_region_hash dm_log dm_zero dm_snapshot parport_pc parport dm_multipath autofs4
NIP: c0000000000461bc LR: c000000000046260 CTR: c00000000004bc08                                                   
REGS: c00000000fffb770 TRAP: 0700   Not tainted  (2.6.33-rc6-autokern1)                                            
MSR: 8000000000021032 <ME,CE,IR,DR>  CR: 48000022  XER: 00000001                                                   
TASK = c000000000aef700[0] 'swapper' THREAD: c000000000bcc000 CPU: 0                                               
GPR00: 0000000000000001 c00000000fffb9f0 c000000000bcc9e8 0000000000000000                                         
GPR04: 0000000000000000 0000000000000000 00000000000000dc 0000000000000002                                         
GPR08: c0000000040036e8 c000000004002e40 0000000000000898 0000000000000000                                         
GPR12: 0000000000000002 c000000000bf8480 0000000003500000 c000000000792f28                                         
GPR16: c0000000007915e0 0000000000000000 0000000000419000 0000000003da8990                                         
GPR20: c0000000008a8990 0000000000000010 c000000000ae92c0 0000000000000010                                         
GPR24: 0000000000000000 c000000000be2380 0000000000000000 0000000000200200                                         
GPR28: 0000000000000001 0000000000000001 c000000000b249e8 0000000000000000                                         
NIP [c0000000000461bc] .xics_set_cpu_priority+0x38/0xb8                                                            
LR [c000000000046260] .xics_teardown_cpu+0x24/0xa4                                                                 
Call Trace:                                                                                                        
[c00000000fffb9f0] [00000000ffffebf3] 0xffffebf3 (unreliable)                                                      
[c00000000fffba60] [c000000000046260] .xics_teardown_cpu+0x24/0xa4                                                 
[c00000000fffbae0] [c000000000046330] .xics_kexec_teardown_cpu+0x18/0xb4                                           
[c00000000fffbb60] [c00000000004a150] .pseries_kexec_cpu_down_xics+0x20/0x38                                       
[c00000000fffbbf0] [c00000000002e5b8] .kexec_smp_down+0x48/0x7c                                                    
[c00000000fffbc70] [c0000000000b2dd0] .generic_smp_call_function_interrupt+0xf4/0x1b4                              
[c00000000fffbd20] [c00000000002aed0] .smp_message_recv+0x48/0x100                                                 
[c00000000fffbda0] [c000000000046ae0] .xics_ipi_dispatch+0x84/0x148                                                
[c00000000fffbe30] [c0000000000d62dc] .handle_IRQ_event+0xc8/0x248                                                 
[c00000000fffbf00] [c0000000000d8eb4] .handle_percpu_irq+0x80/0xf4                                                 
[c00000000fffbf90] [c000000000029048] .call_handle_irq+0x1c/0x2c                                                   
[c000000000bcfa30] [c00000000000ec84] .do_IRQ+0x1b8/0x2a4                                                          
[c000000000bcfae0] [c000000000004804] hardware_interrupt_entry+0x1c/0x98

Fix this problem by setting the index on the CPPR stack to 0 before calling
xics_set_cpu_priority() in xics_teardown_cpu().

Also make it clear that we only want to set the priority when there's just
one CPPR value in the stack, and enforce it by updating the value of
os_cppr->stack[0] rather than os_cppr->stack[os_cppr->index].

While we're at it change the BUG_ON to a WARN_ON.

Reported-by: Anton Blanchard <anton@samba.org>
Signed-off-by: Mark Nelson <markn@au1.ibm.com>
---
Ben, if it's not too late for 2.6.33 this would be really nice to have
as without it we can't kexec on pseries.

 arch/powerpc/platforms/pseries/xics.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

Index: upstream/arch/powerpc/platforms/pseries/xics.c
===================================================================
--- upstream.orig/arch/powerpc/platforms/pseries/xics.c
+++ upstream/arch/powerpc/platforms/pseries/xics.c
@@ -784,9 +784,13 @@ static void xics_set_cpu_priority(unsign
 {
 	struct xics_cppr *os_cppr = &__get_cpu_var(xics_cppr);
 
-	BUG_ON(os_cppr->index != 0);
+	/*
+	 * we only really want to set the priority when there's
+	 * just one cppr value on the stack
+	 */
+	WARN_ON(os_cppr->index != 0);
 
-	os_cppr->stack[os_cppr->index] = cppr;
+	os_cppr->stack[0] = cppr;
 
 	if (firmware_has_feature(FW_FEATURE_LPAR))
 		lpar_cppr_info(cppr);
@@ -821,8 +825,14 @@ void xics_setup_cpu(void)
 
 void xics_teardown_cpu(void)
 {
+	struct xics_cppr *os_cppr = &__get_cpu_var(xics_cppr);
 	int cpu = smp_processor_id();
 
+	/*
+	 * we have to reset the cppr index to 0 because we're
+	 * not going to return from the IPI
+	 */
+	os_cppr->index = 0;
 	xics_set_cpu_priority(0);
 
 	/* Clear any pending IPI request */
