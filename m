Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [59.145.155.3])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp03.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2A02BDDEEA
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Apr 2008 21:52:01 +1000 (EST)
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
	by e28smtp03.in.ibm.com (8.13.1/8.13.1) with ESMTP id m38Bptcl007522
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Apr 2008 17:21:55 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
	by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m38Bpse11433844
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Apr 2008 17:21:54 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
	by d28av02.in.ibm.com (8.13.1/8.13.3) with ESMTP id m38BptQN026648
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Apr 2008 11:51:55 GMT
Message-ID: <47FB5C5A.5020104@linux.vnet.ibm.com>
Date: Tue, 08 Apr 2008 17:21:54 +0530
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [BUG] 2.6.25-rc2-git4 - Regression Kernel oops  while running
	kernbench and tbench on powerpc
References: <47BC40BC.3040405@linux.vnet.ibm.com>
	<18427.11023.8067.795279@cargo.ozlabs.ibm.com>
In-Reply-To: <18427.11023.8067.795279@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii
Cc: kernel list <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	linux-next@vger.kernel.org, nacc@us.ibm.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Balbir Singh <balbir@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Mackerras wrote:
> Kamalesh Babulal writes:
> 
>> The Kernel oopses is seen while running the kernbench followed by tbench with 2.6.25-rc2-git4 
>> kernel on powerpc, this oops was reported for the 2.6.24-rc8-mm1 kernel (http://lkml.org/lkml/2008/1/18/71)
>> and is visible with almost all of the main line ,rc(s) and their git(s) release from then.
>>
>> This oops is visible in the linux-next-20080220 kernel also.The machine is power4+ box with four cpus and 
>> has 30 GB RAM.
> 
> Please try to replicate the oops with the patch below applied.  It
> doesn't solve the cause of the oops but it should mean the kernel
> prints out more useful information about the cause of the oops.
> 
> I assume you can replicate the oops easily on this machine - is that
> right?
> 
> Paul.
> 
> diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
> index 11b4f6d..a3ac72a 100644
> --- a/arch/powerpc/kernel/head_64.S
> +++ b/arch/powerpc/kernel/head_64.S
> @@ -621,7 +621,7 @@ END_FW_FTR_SECTION_IFSET(FW_FEATURE_ISERIES)
>  	mtlr	r10
> 
>  	andi.	r10,r12,MSR_RI	/* check for unrecoverable exception */
> -	beq-	unrecov_slb
> +	beq-	2f
> 
>  .machine	push
>  .machine	"power4"
> @@ -643,6 +643,22 @@ END_FW_FTR_SECTION_IFSET(FW_FEATURE_ISERIES)
>  	rfid
>  	b	.	/* prevent speculative execution */
> 
> +2:
> +#ifdef CONFIG_PPC_ISERIES
> +BEGIN_FW_FTR_SECTION
> +	b	unrecov_slb
> +END_FW_FTR_SECTION_IFSET(FW_FEATURE_ISERIES)
> +#endif /* CONFIG_PPC_ISERIES */
> +	mfspr	r11,SPRN_SRR0
> +	clrrdi	r10,r13,32
> +	LOAD_HANDLER(r10,unrecov_slb)
> +	mtspr	SPRN_SRR0,r10
> +	mfmsr	r10
> +	ori	r10,r10,MSR_IR|MSR_DR|MSR_RI
> +	mtspr	SPRN_SRR1,r10
> +	rfid
> +	b	.
> +
>  unrecov_slb:
>  	EXCEPTION_PROLOG_COMMON(0x4100, PACA_EXSLB)
>  	DISABLE_INTS
Hi Paul,

The kernel oops after applying the patch. Some time it takes more than
one run to reproduce it, it was reproducible in the second run this
time.

 Unrecoverable exception 4100 at c000000000008c8c
Oops: Unrecoverable exception, sig: 6 [#1]
SMP NR_CPUS=128 NUMA pSeries
Modules linked in:
NIP: c000000000008c8c LR: 000000000ff0135c CTR: 000000000ff012f0
REGS: c000000772343bb0 TRAP: 4100   Not tainted  (2.6.25-rc8-autotest)
MSR: 8000000000001030 <ME,IR,DR>  CR: 44044228  XER: 00000000
TASK = c00000077cfa0900[13437] 'cc1' THREAD: c000000772340000 CPU: 2
GPR00: 0000000000004000 c000000772343e30 00000000000000bb 000000000000d032 
GPR04: 00000000000000bb 0000000000000400 000000000000000a 0000000000000002 
GPR08: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
GPR12: 0000000000000000 c000000000734000 0000000000000064 00000000ffe6df08 
GPR16: 00000000105b0000 00000000105b0000 0000000010440000 00000000105b0000 
GPR20: 00000000ffe6e008 00000000105b0000 00000000105b0000 000000000000000a 
GPR24: 000000000ffec408 0000000000000001 00000000ffe6ddca 0000000000000400 
GPR28: 000000000ffec408 00000000f7ff8000 000000000ffebff4 0000000000000400 
NIP [c000000000008c8c] restore+0x8c/0xc0
LR [000000000ff0135c] 0xff0135c
Call Trace:
[c000000772343e30] [c000000000008cd4] do_work+0x14/0x2c (unreliable)
Instruction dump:
7c840078 7c810164 70604000 41820028 60000000 7c4c42e6 e88d01f0 f84d01f0 
7c841050 e84d01e8 7c422214 f84d01e8 <e9a100d8> 7c7b03a6 e84101a0 7c4ff120 

(gdb) l *0xc000000000008cdc
0xc000000000008cdc is at arch/powerpc/kernel/entry_64.S:608.
603             mtmsrd  r10,1
604
605             andi.   r0,r4,_TIF_NEED_RESCHED
606             beq     1f
607             bl      .schedule
608             b       .ret_from_except_lite
609
610     1:      bl      .save_nvgprs
611             li      r3,0
612             addi    r4,r1,STACK_FRAME_OVERHEAD

please let me know if you need more information.
-- 
Thanks & Regards,
Kamalesh Babulal,
Linux Technology Center,
IBM, ISTL.
