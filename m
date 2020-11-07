Return-Path: <SRS0=O+98=EN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93CC8C388F7
	for <linuxppc-dev@archiver.kernel.org>; Sat,  7 Nov 2020 10:51:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88725206F9
	for <linuxppc-dev@archiver.kernel.org>; Sat,  7 Nov 2020 10:51:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88725206F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CSvFX5F0qzDrTM
	for <linuxppc-dev@archiver.kernel.org>; Sat,  7 Nov 2020 21:51:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=csgroup.eu
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CSvCT19JNzDrFS
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Nov 2020 21:49:36 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4CSvCH4mgVz9txn0;
 Sat,  7 Nov 2020 11:49:31 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 2Grg8kzGSVl2; Sat,  7 Nov 2020 11:49:31 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4CSvCH3HCnz9txmy;
 Sat,  7 Nov 2020 11:49:31 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id B90DC8B776;
 Sat,  7 Nov 2020 11:49:31 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id YUFhAuKDMxe3; Sat,  7 Nov 2020 11:49:31 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id E07C38B75B;
 Sat,  7 Nov 2020 11:49:30 +0100 (CET)
Subject: Re: [RFC PATCH] powerpc: show registers when unwinding interrupt
 frames
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
References: <20201107023305.2384874-1-npiggin@gmail.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <56626531-8d57-c8d4-336c-12ce4d2c47ea@csgroup.eu>
Date: Sat, 7 Nov 2020 11:49:27 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201107023305.2384874-1-npiggin@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 07/11/2020 à 03:33, Nicholas Piggin a écrit :
> It's often useful to know the register state for interrupts in
> the stack frame. In the below example (with this patch applied),
> the important information is the state of the page fault.
> 
> A blatant case like this probably rather should have the page
> fault regs passed down to the warning, but quite often there are
> less obvious cases where an interrupt shows up that might give
> some more clues.

I like it.

I was wondering about interrupts that do not save NV registers, but that seems to be handled:

[    0.455489] --- interrupt: 301 at cmpxchg_futex_value_locked+0x2c/0x58
[    0.461886] NIP:  c0089c08 LR: c0755df0 CTR: c02e59a4
[    0.466889] REGS: c9023db0 TRAP: 0301   Not tainted  (5.10.0-rc2-s3k-dev-01371-gfb45a2414e96-dirty)
[    0.475815] MSR:  00009032 <EE,ME,IR,DR,RI>  CR: 28000244  XER: 00000000
[    0.482450] DAR: 00000000 DSISR: c0000000
[    0.482450] GPR00: c0755dc8 c9023e68 c2100000 c9023e78 00000000 00000000 00000000 00000000
[    0.482450] GPR08: 00001032 00000000 80000000 00000003 42000242
[    0.500988] NIP [c0089c08] cmpxchg_futex_value_locked+0x2c/0x58
[    0.506842] LR [c0755df0] futex_init+0x74/0xd0
[    0.511194] --- interrupt: 301

Christophe

> 
> The downside is longer and more complex bug output.
> 
>    Bug: Write fault blocked by AMR!
>    WARNING: CPU: 0 PID: 72 at arch/powerpc/include/asm/book3s/64/kup-radix.h:164 __do_page_fault+0x880/0xa90
>    Modules linked in:
>    CPU: 0 PID: 72 Comm: systemd-gpt-aut Not tainted
>    NIP:  c00000000006e2f0 LR: c00000000006e2ec CTR: 0000000000000000
>    REGS: c00000000a4f3420 TRAP: 0700
>    MSR:  8000000000021033 <SF,ME,IR,DR,RI,LE>  CR: 28002840  XER: 20040000
>    CFAR: c000000000128be0 IRQMASK: 3
>    GPR00: c00000000006e2ec c00000000a4f36c0 c0000000014f0700 0000000000000020
>    GPR04: 0000000000000001 c000000001290f50 0000000000000001 c000000001290f80
>    GPR08: c000000001612b08 0000000000000000 0000000000000000 00000000ffffe0f7
>    GPR12: 0000000048002840 c0000000016e0000 c00c000000021c80 c000000000fd6f60
>    GPR16: 0000000000000000 c00000000a104698 0000000000000003 c0000000087f0000
>    GPR20: 0000000000000100 c0000000070330b8 0000000000000000 0000000000000004
>    GPR24: 0000000002000000 0000000000000300 0000000002000000 c00000000a5b0c00
>    GPR28: 0000000000000000 000000000a000000 00007fffb2a90038 c00000000a4f3820
>    NIP [c00000000006e2f0] __do_page_fault+0x880/0xa90
>    LR [c00000000006e2ec] __do_page_fault+0x87c/0xa90
>    Call Trace:
>    [c00000000a4f36c0] [c00000000006e2ec] __do_page_fault+0x87c/0xa90 (unreliable)
>    [c00000000a4f3780] [c000000000e1c034] do_page_fault+0x34/0x90
>    [c00000000a4f37b0] [c000000000008908] data_access_common_virt+0x158/0x1b0
>    --- interrupt: 300 at __copy_tofrom_user_base+0x9c/0x5a4
>    NIP:  c00000000009b028 LR: c000000000802978 CTR: 0000000000000800
>    REGS: c00000000a4f3820 TRAP: 0300
>    MSR:  800000000280b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 24004840  XER: 00000000
>    CFAR: c00000000009aff4 DAR: 00007fffb2a90038 DSISR: 0a000000 IRQMASK: 0
>    GPR00: 0000000000000000 c00000000a4f3ac0 c0000000014f0700 00007fffb2a90028
>    GPR04: c000000008720010 0000000000010000 0000000000000000 0000000000000000
>    GPR08: 0000000000000000 0000000000000000 0000000000000000 0000000000000001
>    GPR12: 0000000000004000 c0000000016e0000 c00c000000021c80 c000000000fd6f60
>    GPR16: 0000000000000000 c00000000a104698 0000000000000003 c0000000087f0000
>    GPR20: 0000000000000100 c0000000070330b8 0000000000000000 0000000000000004
>    GPR24: c00000000a4f3c80 c000000008720000 0000000000010000 0000000000000000
>    GPR28: 0000000000010000 0000000008720000 0000000000010000 c000000001515b98
>    NIP [c00000000009b028] __copy_tofrom_user_base+0x9c/0x5a4
>    LR [c000000000802978] copyout+0x68/0xc0
>    --- interrupt: 300
>    [c00000000a4f3af0] [c0000000008074b8] copy_page_to_iter+0x188/0x540
>    [c00000000a4f3b50] [c00000000035c678] generic_file_buffered_read+0x358/0xd80
>    [c00000000a4f3c40] [c0000000004c1e90] blkdev_read_iter+0x50/0x80
>    [c00000000a4f3c60] [c00000000045733c] new_sync_read+0x12c/0x1c0
>    [c00000000a4f3d00] [c00000000045a1f0] vfs_read+0x1d0/0x240
>    [c00000000a4f3d50] [c00000000045a7f4] ksys_read+0x84/0x140
>    [c00000000a4f3da0] [c000000000033a60] system_call_exception+0x100/0x280
>    [c00000000a4f3e10] [c00000000000c508] system_call_common+0xf8/0x2f8
>    Instruction dump:
>    eae10078 3be0000b 4bfff890 60420000 792917e1 4182ff18 3c82ffab 3884a5e0
>    3c62ffab 3863a6e8 480ba891 60000000 <0fe00000> 3be0000b 4bfff860 e93c0938
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   arch/powerpc/kernel/process.c | 20 ++++++++++++++------
>   1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index ea36a29c8b01..799f00b32f74 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -1475,12 +1475,10 @@ static void print_msr_bits(unsigned long val)
>   #define LAST_VOLATILE	12
>   #endif
>   
> -void show_regs(struct pt_regs * regs)
> +static void __show_regs(struct pt_regs *regs)
>   {
>   	int i, trap;
>   
> -	show_regs_print_info(KERN_DEFAULT);
> -
>   	printk("NIP:  "REG" LR: "REG" CTR: "REG"\n",
>   	       regs->nip, regs->link, regs->ctr);
>   	printk("REGS: %px TRAP: %04lx   %s  (%s)\n",
> @@ -1522,6 +1520,12 @@ void show_regs(struct pt_regs * regs)
>   		printk("NIP ["REG"] %pS\n", regs->nip, (void *)regs->nip);
>   		printk("LR ["REG"] %pS\n", regs->link, (void *)regs->link);
>   	}
> +}
> +
> +void show_regs(struct pt_regs *regs)
> +{
> +	show_regs_print_info(KERN_DEFAULT);
> +	__show_regs(regs);
>   	show_stack(current, (unsigned long *) regs->gpr[1], KERN_DEFAULT);
>   	if (!user_mode(regs))
>   		show_instructions(regs);
> @@ -2192,10 +2196,14 @@ void show_stack(struct task_struct *tsk, unsigned long *stack,
>   		    && stack[STACK_FRAME_MARKER] == STACK_FRAME_REGS_MARKER) {
>   			struct pt_regs *regs = (struct pt_regs *)
>   				(sp + STACK_FRAME_OVERHEAD);
> +
>   			lr = regs->link;
> -			printk("%s--- interrupt: %lx at %pS\n    LR = %pS\n",
> -			       loglvl, regs->trap,
> -			       (void *)regs->nip, (void *)lr);
> +			printk("%s--- interrupt: %lx at %pS\n",
> +			       loglvl, regs->trap, (void *)regs->nip);
> +			__show_regs(regs);
> +			printk("%s--- interrupt: %lx\n",
> +			       loglvl, regs->trap);
> +
>   			firstframe = 1;
>   		}
>   
> 
