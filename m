Return-Path: <jbaron@akamai.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vRn3z1cgyzDqC0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 02:05:03 +1100 (AEDT)
Received: from prod-mail-xrelay07.akamai.com (prod-mail-xrelay07.akamai.com
 [23.79.238.175])
 by ozlabs.org (Postfix) with ESMTP id 3vRn3y2XRDz9sDC
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Feb 2017 02:05:01 +1100 (AEDT)
Subject: Re: next-20170217 boot on POWER8 LPAR : WARNING
 @kernel/jump_label.c:287
To: Sachin Sant <sachinp@linux.vnet.ibm.com>, linux-next@vger.kernel.org
References: <E6A8A7A8-6A55-4989-BAE9-39274876CA3C@linux.vnet.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org,
 Michael Ellerman <mpe@ellerman.id.au>, Steven Rostedt <rostedt@goodmis.org>
From: Jason Baron <jbaron@akamai.com>
Message-ID: <1dffdaac-be8b-0052-52d4-a65fed39f894@akamai.com>
Date: Mon, 20 Feb 2017 09:57:34 -0500
MIME-Version: 1.0
In-Reply-To: <E6A8A7A8-6A55-4989-BAE9-39274876CA3C@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On 02/19/2017 09:07 AM, Sachin Sant wrote:
> While booting next-20170217 on a POWER8 LPAR following
> warning is displayed.
> 
> Reverting the following commit helps boot cleanly.
> commit 3821fd35b5 :  jump_label: Reduce the size of struct static_key
> 
> [   11.393008] ------------[ cut here ]------------
> [   11.393031] WARNING: CPU: 5 PID: 2890 at kernel/jump_label.c:287 static_key_set_entries.isra.10+0x3c/0x50

Thanks for the report. So this is saying that the jump_entry table is
not at least 4-byte aligned. I wonder if this fixes it up?


diff --git a/arch/powerpc/include/asm/jump_label.h
b/arch/powerpc/include/asm/jump_label.h
index 9a287e0ac8b1..f870a85bac46 100644
--- a/arch/powerpc/include/asm/jump_label.h
+++ b/arch/powerpc/include/asm/jump_label.h
@@ -24,6 +24,7 @@ static __always_inline bool arch_static_branch(struct
static_key *key, bool bran
 	asm_volatile_goto("1:\n\t"
 		 "nop # arch_static_branch\n\t"
 		 ".pushsection __jump_table,  \"aw\"\n\t"
+		 ".balign 4 \n\t"
 		 JUMP_ENTRY_TYPE "1b, %l[l_yes], %c0\n\t"
 		 ".popsection \n\t"
 		 : :  "i" (&((char *)key)[branch]) : : l_yes);
@@ -38,6 +39,7 @@ static __always_inline bool
arch_static_branch_jump(struct static_key *key, bool
 	asm_volatile_goto("1:\n\t"
 		 "b %l[l_yes] # arch_static_branch_jump\n\t"
 		 ".pushsection __jump_table,  \"aw\"\n\t"
+		 ".balign 4 \n\t"
 		 JUMP_ENTRY_TYPE "1b, %l[l_yes], %c0\n\t"
 		 ".popsection \n\t"
 		 : :  "i" (&((char *)key)[branch]) : : l_yes);
@@ -63,6 +65,7 @@ struct jump_entry {
 #define ARCH_STATIC_BRANCH(LABEL, KEY)		\
 1098:	nop;					\
 	.pushsection __jump_table, "aw";	\
+	.balign 4;				\
 	FTR_ENTRY_LONG 1098b, LABEL, KEY;	\
 	.popsection
 #endif


Thanks,

-Jason

> [   11.393035] Modules linked in: nfsd(+) ip_tables x_tables autofs4
> [   11.393043] CPU: 5 PID: 2890 Comm: modprobe Not tainted 4.10.0-rc8-next-20170217-autotest #1
> [   11.393047] task: c0000003a5692500 task.stack: c0000003a7774000
> [   11.393051] NIP: c0000000017bcffc LR: c0000000017bd46c CTR: 0000000000000000
> [   11.393054] REGS: c0000003a7777800 TRAP: 0700   Not tainted  (4.10.0-rc8-next-20170217-autotest)
> [   11.393058] MSR: 800000000282b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>
> [   11.393065]   CR: 48248282  XER: 00000001
> [   11.393070] CFAR: c0000000017bcfcc SOFTE: 1
> GPR00: c0000000017bd42c c0000003a7777a80 c00000000262ce00 d000000003fdd580
> GPR04: d000000003fe07df 0000000100000017 c0000000017bcd50 0000000000000000
> GPR08: 0000000000053a09 0000000000000001 c00000000254ce00 0000000000000001
> GPR12: c000000001b56c40 c00000000ea81400 0000000000000020 d000000005081098
> GPR16: c0000003a7777da0 c0000003a7777dec 0000000000000000 00000000000084a8
> GPR20: d000000003fef000 d000000003fe2b28 c00000000252dc90 0000000000000001
> GPR24: c00000000254d314 0000000000000000 c0000000025338f8 d000000003fe089f
> GPR28: 0000000000000000 d000000003fe1400 d000000003fdd578 d000000003fe07df
> [   11.393115] NIP [c0000000017bcffc] static_key_set_entries.isra.10+0x3c/0x50
> [   11.393119] LR [c0000000017bd46c] jump_label_module_notify+0x20c/0x420
> [   11.393122] Call Trace:
> [   11.393125] [c0000003a7777a80] [c0000000017bd42c] jump_label_module_notify+0x1cc/0x420 (unreliable)
> [   11.393132] [c0000003a7777b40] [c0000000016b38e0] notifier_call_chain+0x90/0x100
> [   11.393137] [c0000003a7777b90] [c0000000016b3db0] __blocking_notifier_call_chain+0x60/0x90
> [   11.393142] [c0000003a7777be0] [c0000000017357bc] load_module+0x1c1c/0x2750
> [   11.393147] [c0000003a7777d70] [c000000001736550] SyS_finit_module+0xc0/0xf0
> [   11.393152] [c0000003a7777e30] [c0000000015cb8e0] system_call+0x38/0xfc
> [   11.393156] Instruction dump:
> [   11.393158] 40c20018 e9230000 792907a0 7c844b78 f8830000 4e800020 3d42fff2 892a0514
> [   11.393166] 2f890000 40feffe0 39200001 992a0514 <0fe00000> 4bffffd0 60000000 60000000
> [   11.393173] ---[ end trace a5f8fbc5d8226aec ]---
> 
> Have attached boot log.
> 
> Thanks
> -Sachin
> 
