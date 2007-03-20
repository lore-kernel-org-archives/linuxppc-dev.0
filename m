Return-Path: <anton@ozlabs.org>
Date: Tue, 20 Mar 2007 09:48:34 -0500
From: Anton Blanchard <anton@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Fix WARN_ON when entering xmon
Message-ID: <20070320144834.GG31173@kryten>
References: <20070320143405.GD31173@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070320143405.GD31173@kryten>
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

[ this time with a Signed-off-by ]
 
Whenever we enter xmon we get a WARN_ON out of the rtas code since it
thinks interrupts are still on:


Unable to handle kernel paging request for data at address 0x00000000
Faulting instruction address: 0xd000000000080008
cpu 0x3: Vector: 300 (Data Access) at [c0000000075dba00]
    pc: d000000000080008: .doit+0x8/0x40 [oopser]
    lr: c000000000077704: .sys_init_module+0x1664/0x1824
    sp: c0000000075dbc80
   msr: 9000000000009032
   dar: 0
 dsisr: 42000000
  current = 0xc000000003fa64b0
  paca    = 0xc000000000694280
    pid   = 2260, comm = insmod

------------[ cut here ]------------
Badness at arch/powerpc/kernel/entry_64.S:651
Call Trace:
[C0000000075DAE70] [C00000000000EB64] .show_stack+0x68/0x1b0 (unreliable)
[C0000000075DAF10] [C000000000216254] .report_bug+0x94/0xe8
[C0000000075DAFA0] [C00000000047B140] __kprobes_text_start+0x178/0x584
[C0000000075DB040] [C0000000000044F4] program_check_common+0xf4/0x100
--- Exception: 700 at .enter_rtas+0xa0/0x10c
    LR = .xmon_core+0x584/0x934
[C0000000075DB330] [C0000000006CD900] proc_mounts_operations+0x88/0xd8 (unreliable)
[C0000000075DB510] [C0000000000418A0] .xmon_core+0x584/0x934
[C0000000075DB6A0] [C000000000041DF0] .xmon+0x38/0x4c
[C0000000075DB880] [C0000000000234D0] .die+0x50/0x204
[C0000000075DB910] [C00000000002B698] .bad_page_fault+0xb8/0xd4
[C0000000075DB990] [C000000000004918] handle_page_fault+0x3c/0x58


The xmon code is playing with the msr directly, which doesnt interact
well with the new irq soft disable code. Switch to using the standard
macros.

If we are really paranoid we could think about doing a hard disable (to
avoid a potential irq + reject).

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-2.6/arch/powerpc/xmon/xmon.c
===================================================================
--- linux-2.6.orig/arch/powerpc/xmon/xmon.c	2007-03-12 07:53:59.000000000 -0500
+++ linux-2.6/arch/powerpc/xmon/xmon.c	2007-03-12 07:56:50.000000000 -0500
@@ -330,18 +330,17 @@
 static int xmon_core(struct pt_regs *regs, int fromipi)
 {
 	int cmd = 0;
-	unsigned long msr;
 	struct bpt *bp;
 	long recurse_jmp[JMP_BUF_LEN];
 	unsigned long offset;
+	unsigned long flags;
 #ifdef CONFIG_SMP
 	int cpu;
 	int secondary;
 	unsigned long timeout;
 #endif
 
-	msr = mfmsr();
-	mtmsr(msr & ~MSR_EE);	/* disable interrupts */
+	local_irq_save(flags);
 
 	bp = in_breakpoint_table(regs->nip, &offset);
 	if (bp != NULL) {
@@ -516,7 +515,7 @@
 
 	insert_cpu_bpts();
 
-	mtmsr(msr);		/* restore interrupt enable */
+	local_irq_restore(flags);
 
 	return cmd != 'X' && cmd != EOF;
 }
