Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [59.145.155.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp05.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 911AEDE283
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Apr 2008 23:28:38 +1000 (EST)
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
	by e28smtp05.in.ibm.com (8.13.1/8.13.1) with ESMTP id m3EDSXug002493
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Apr 2008 18:58:33 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
	by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m3EDSU2Q1347696
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Apr 2008 18:58:30 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
	by d28av02.in.ibm.com (8.13.1/8.13.3) with ESMTP id m3EDSWXx012431
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Apr 2008 13:28:32 GMT
Message-ID: <48035C03.10104@linux.vnet.ibm.com>
Date: Mon, 14 Apr 2008 18:58:35 +0530
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [BUG] 2.6.25-rc2-git4 - Regression Kernel oops  while running
	kernbench and tbench on powerpc
References: <47BC40BC.3040405@linux.vnet.ibm.com>
	<18427.11023.8067.795279@cargo.ozlabs.ibm.com>
	<47FB5C5A.5020104@linux.vnet.ibm.com>
	<18427.65299.403151.344959@cargo.ozlabs.ibm.com>
	<47FC5227.3030501@linux.vnet.ibm.com>
	<18435.11286.201115.396713@cargo.ozlabs.ibm.com>
In-Reply-To: <18435.11286.201115.396713@cargo.ozlabs.ibm.com>
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
>> The SHA1 ID of the kernel is 0e81a8ae37687845f7cdfa2adce14ea6a5f1dd34 (2.6.25-rc8) 
>> and the source seems to have the patch 44387e9ff25267c78a99229aca55ed750e9174c7.
>>
>> The kernel was patched only the patch you gave me (http://lkml.org/lkml/2008/4/8/42). 
> 
> Please try again with both that patch and the one below.  Once again
> it won't fix the bug but will give us more information.  When the oops
> occurs, the kernel will print a lot of debug information that should
> help locate the problem.
> 
> Paul.
> 
> diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
> index e932b43..f16db50 100644
> --- a/arch/powerpc/kernel/asm-offsets.c
> +++ b/arch/powerpc/kernel/asm-offsets.c
> @@ -144,6 +144,9 @@ int main(void)
>  	DEFINE(PACA_SLBSHADOWPTR, offsetof(struct paca_struct, slb_shadow_ptr));
>  	DEFINE(PACA_DATA_OFFSET, offsetof(struct paca_struct, data_offset));
>  	DEFINE(PACA_TRAP_SAVE, offsetof(struct paca_struct, trap_save));
> +	DEFINE(PACASLBLOG, offsetof(struct paca_struct, slblog));
> +	DEFINE(PACASLBLOGIX, offsetof(struct paca_struct, slblog_ix));
> +	DEFINE(PACALASTSLB, offsetof(struct paca_struct, last_slb));
> 
>  	DEFINE(SLBSHADOW_STACKVSID,
>  	       offsetof(struct slb_shadow, save_area[SLB_NUM_BOLTED - 1].vsid));
> diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
> index 148a354..663df17 100644
> --- a/arch/powerpc/kernel/entry_64.S
> +++ b/arch/powerpc/kernel/entry_64.S
> @@ -419,6 +419,18 @@ END_FTR_SECTION_IFSET(CPU_FTR_1T_SEGMENT)
>  	slbmte	r7,r0
>  	isync
> 
> +	ld	r4,PACASLBLOGIX(r13)
> +	addi	r4,r4,1
> +	clrldi	r4,r4,64-6
> +	std	r4,PACASLBLOGIX(r13)
> +	add	r4,r4,r13
> +	addi	r4,r4,PACASLBLOG
> +	li	r5,4
> +	std	r5,0(r4)
> +	mftb	r5
> +	std	r5,8(r4)
> +	std	r6,16(r4)
> +	std	r0,24(r4)
>  2:
>  	clrrdi	r7,r8,THREAD_SHIFT	/* base of new stack */
>  	/* Note: this uses SWITCH_FRAME_SIZE rather than INT_FRAME_SIZE
> @@ -533,6 +545,17 @@ END_FW_FTR_SECTION_IFSET(FW_FEATURE_ISERIES)
> 
>  	stdcx.	r0,0,r1		/* to clear the reservation */
> 
> +	li	r4,0
> +	slbmfee	r2,r4
> +	std	r2,PACALASTSLB(r13)
> +	slbmfev	r2,r4
> +	std	r2,PACALASTSLB+8(r13)
> +	li	r4,1
> +	slbmfee	r2,r4
> +	std	r2,PACALASTSLB+16(r13)
> +	slbmfev	r2,r4
> +	std	r2,PACALASTSLB+24(r13)
> +
>  	/*
>  	 * Clear RI before restoring r13.  If we are returning to
>  	 * userspace and we take an exception after restoring r13,
> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> index 4b5b7ff..c918f33 100644
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -1141,6 +1141,40 @@ void SPEFloatingPointException(struct pt_regs *regs)
>  }
>  #endif
> 
> +static void dump_unrecov_slb(void)
> +{
> +#ifdef CONFIG_PPC64
> +	long entry, rstart;
> +	unsigned long esid, vsid;
> +
> +	printk(KERN_EMERG "SLB contents now:\n");
> +	for (entry = 0; entry < 64; ++entry) {
> +		asm volatile("slbmfee  %0,%1" : "=r" (esid) : "r" (entry));
> +		if (esid == 0)
> +			/* valid bit is clear along with everything else */
> +			continue;
> +		asm volatile("slbmfev  %0,%1" : "=r" (vsid) : "r" (entry));
> +		printk(KERN_EMERG "%d: %.16lx %.16lx\n", entry, esid, vsid);
> +	}
> +
> +	printk(KERN_EMERG "SLB 0-1 at last exception exit:\n");
> +	printk(KERN_EMERG "0: %.16lx %.16lx\n", get_paca()->last_slb[0][0],
> +	       get_paca()->last_slb[0][1]);
> +	printk(KERN_EMERG "1: %.16lx %.16lx\n", get_paca()->last_slb[1][0],
> +	       get_paca()->last_slb[1][1]);
> +	printk(KERN_EMERG "SLB update log:\n");
> +	rstart = entry = get_paca()->slblog_ix;
> +	do {
> +		printk(KERN_EMERG "%d: %lx %lx %.16lx %.16lx\n", entry,
> +		       get_paca()->slblog[entry][0],
> +		       get_paca()->slblog[entry][1],
> +		       get_paca()->slblog[entry][2],
> +		       get_paca()->slblog[entry][3]);
> +		entry = (entry + 1) % 63;
> +	} while (entry != rstart);
> +#endif
> +}
> +
>  /*
>   * We enter here if we get an unrecoverable exception, that is, one
>   * that happened at a point where the RI (recoverable interrupt) bit
> @@ -1151,6 +1185,8 @@ void unrecoverable_exception(struct pt_regs *regs)
>  {
>  	printk(KERN_EMERG "Unrecoverable exception %lx at %lx\n",
>  	       regs->trap, regs->nip);
> +	if (regs->trap == 0x4100)
> +		dump_unrecov_slb();
>  	die("Unrecoverable exception", regs, SIGABRT);
>  }
> 
> diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
> index 906daed..235edf7 100644
> --- a/arch/powerpc/mm/slb.c
> +++ b/arch/powerpc/mm/slb.c
> @@ -105,6 +105,7 @@ void slb_flush_and_rebolt(void)
>  	 * appropriately too. */
>  	unsigned long linear_llp, vmalloc_llp, lflags, vflags;
>  	unsigned long ksp_esid_data, ksp_vsid_data;
> +	long logix;
> 
>  	WARN_ON(!irqs_disabled());
> 
> @@ -144,6 +145,13 @@ void slb_flush_and_rebolt(void)
>  		        "r"(ksp_vsid_data),
>  		        "r"(ksp_esid_data)
>  		     : "memory");
> +	logix = get_paca()->slblog_ix;
> +	logix = (logix + 1) & 63;
> +	get_paca()->slblog_ix = logix;
> +	get_paca()->slblog[logix][0] = 3;
> +	get_paca()->slblog[logix][1] = mftb();
> +	get_paca()->slblog[logix][2] = ksp_esid_data;
> +	get_paca()->slblog[logix][3] = ksp_vsid_data;
>  }
> 
>  void slb_vmalloc_update(void)
> @@ -192,6 +200,7 @@ void switch_slb(struct task_struct *tsk, struct mm_struct *mm)
>  	unsigned long pc = KSTK_EIP(tsk);
>  	unsigned long stack = KSTK_ESP(tsk);
>  	unsigned long unmapped_base;
> +	long logix;
> 
>  	if (!cpu_has_feature(CPU_FTR_NO_SLBIE_B) &&
>  	    offset <= SLB_CACHE_ENTRIES) {
> @@ -204,6 +213,14 @@ void switch_slb(struct task_struct *tsk, struct mm_struct *mm)
>  				<< SLBIE_SSIZE_SHIFT;
>  			slbie_data |= SLBIE_C; /* C set for user addresses */
>  			asm volatile("slbie %0" : : "r" (slbie_data));
> +
> +			logix = get_paca()->slblog_ix;
> +			logix = (logix + 1) & 63;
> +			get_paca()->slblog_ix = logix;
> +			get_paca()->slblog[logix][0] = 2;
> +			get_paca()->slblog[logix][1] = mftb();
> +			get_paca()->slblog[logix][2] = slbie_data;
> +			get_paca()->slblog[logix][3] = 0;
>  		}
>  		asm volatile("isync" : : : "memory");
>  	} else {
> diff --git a/arch/powerpc/mm/slb_low.S b/arch/powerpc/mm/slb_low.S
> index 657f6b3..8c7ce20 100644
> --- a/arch/powerpc/mm/slb_low.S
> +++ b/arch/powerpc/mm/slb_low.S
> @@ -249,6 +249,20 @@ _GLOBAL(slb_compare_rr_to_size)
>  	 */
>  	slbmte	r11,r10
> 
> +	ld	r3,PACASLBLOGIX(r13)
> +	addi	r3,r3,1
> +	clrldi	r3,r3,64-6
> +	std	r3,PACASLBLOGIX(r13)
> +	sldi	r3,r3,5
> +	add	r3,r3,r13
> +	addi	r3,r3,PACASLBLOG
> +	li	r9,1
> +	std	r9,0(r3)
> +	mftb	r9
> +	std	r9,8(r3)
> +	std	r11,16(r3)
> +	std	r10,24(r3)
> +
>  	/* we're done for kernel addresses */
>  	crclr	4*cr0+eq		/* set result to "success" */
>  	bgelr	cr7
> diff --git a/arch/powerpc/platforms/pseries/ras.c b/arch/powerpc/platforms/pseries/ras.c
> index a1ab25c..959ef26 100644
> --- a/arch/powerpc/platforms/pseries/ras.c
> +++ b/arch/powerpc/platforms/pseries/ras.c
> @@ -325,6 +325,8 @@ static int recover_mce(struct pt_regs *regs, struct rtas_error_log * err)
> 
>  	if (err->disposition == RTAS_DISP_FULLY_RECOVERED) {
>  		/* Platform corrected itself */
> +		printk(KERN_ERR "FWNMI: platform corrected error %.16lx\n",
> +		       *(unsigned long *)err);
>  		nonfatal = 1;
>  	} else if ((regs->msr & MSR_RI) &&
>  		   user_mode(regs) &&
> diff --git a/include/asm-powerpc/paca.h b/include/asm-powerpc/paca.h
> index 748b35a..6280b82 100644
> --- a/include/asm-powerpc/paca.h
> +++ b/include/asm-powerpc/paca.h
> @@ -115,6 +115,11 @@ struct paca_struct {
>  	u64 system_time;		/* accumulated system TB ticks */
>  	u64 startpurr;			/* PURR/TB value snapshot */
>  	u64 startspurr;			/* SPURR value snapshot */
> +
> +	/* SLB update log */
> +	long slblog_ix;
> +	u64 slblog[64][4];
> +	u64 last_slb[2][2];
>  };
> 
>  extern struct paca_struct paca[];
Hi Paul,

After applying the patch above and the patch posted on http://lkml.org/lkml/2008/4/8/42
the bug had the following information,

 Unrecoverable exception 4100 at c000000000008d4c
SLB contents now:
0: c000000008000000 0000408f92c94500
1: d000000008000000 0000f09b89af5400
2: c000000020000000 0000420e6f8ca500
3: 0000000010000000 0000947fa10bac80
4: 00000000f0000000 00009ef7aa634c80
5: 0000000040000000 000096bdec30bc80
8: 00000000f0000000 00002292895c1c80
9: 0000000040000000 00001a58cb298c80
10: 0000000010000000 0000181a80047c80
12: 00000000f0000000 0000273e59afdc80
13: 0000000040000000 00001f049b7d4c80
14: 0000000010000000 00001cc650583c80
16: 00000000f0000000 00007bbb0a7b3c80
17: 0000000040000000 000073814c48ac80
18: 0000000010000000 0000714301239c80
20: 00000000f0000000 00009ef7aa634c80
21: 0000000040000000 000096bdec30bc80
22: 0000000010000000 0000947fa10bac80
23: c000000718000000 0000950f4be7f500
24: c000000728000000 000095ceba49a500
25: cf00000008000000 0000d59aca40f500
26: 0000000018000000 00004e06613b8c80
27: 00000000f8000000 0000587e6a932c80
28: 0000000048000000 00005044ac609c80
29: c000000778000000 0000998be2321500
30: 00000000f0000000 000008ad8a1b8c80
31: 0000000040000000 00000073cbe8fc80
32: 0000000010000000 0000fe3580c3dc80
33: c000000028000000 0000420e6f8ca500
34: c000000758000000 0000980d056eb500
36: 00000000f0000000 00007bbb0a7b3c80
37: 0000000040000000 000073814c48ac80
38: 0000000010000000 0000714301239c80
39: c000000038000000 000042cdddee5500
40: c000000768000000 000098cc73d06500
41: c000000738000000 0000968e28ab5500
43: 00000000f0000000 000095a009bbcc80
44: 0000000040000000 00008d664b893c80
45: 0000000010000000 00008b2800642c80
47: 00000000f0000000 00009ef7aa634c80
48: 0000000040000000 000096bdec30bc80
49: 0000000010000000 0000947fa10bac80
51: 00000000f0000000 00007bbb0a7b3c80
52: 0000000040000000 000073814c48ac80
53: cf00000018000000 0000d65a38a2a500
54: 0000000010000000 0000714301239c80
55: c000000748000000 0000974d970d0500
57: 00000000f0000000 00009ef7aa634c80
58: 0000000040000000 000096bdec30bc80
59: 0000000010000000 0000947fa10bac80
61: 00000000f0000000 0000f5fe48cc7c80
62: 0000000040000000 0000edc48a99ec80
63: 0000000010000000 0000eb863f74dc80
SLB 0-1 at last exception exit:
0: c000000008000000 0000408f92c94500
1: d000000008000000 0000f09b89af5400
SLB update log:
4: 1 1fa087dccefc17 0000998be2321500 c00000077800001d
5: 2 1fa087dbeb2091 0000000018000000 0000000000000000
6: 1 1fa087dbeb20ac 000093c032a9fc80 0000000008000038
7: 1 1fa087dbeb20bd 00009ef7aa634c80 00000000f8000039
8: 1 1fa087dbeb20d1 000096bdec30bc80 000000004800003a
9: 1 1fa087dbeb37d5 0000947fa10bac80 000000001800003b
10: 2 1fa087dc26370a 0000000008000000 0000000000000000
11: 2 1fa087dc26370f 00000000f8000000 0000000000000000
12: 2 1fa087dc26372f 0000000048000000 0000000000000000
13: 2 1fa087dc263734 0000000018000000 0000000000000000
14: 1 1fa087dc26375f 0000eac6d1132c80 000000000800003c
15: 1 1fa087dc263772 0000f5fe48cc7c80 00000000f800003d
16: 1 1fa087dc263787 0000edc48a99ec80 000000004800003e
17: 1 1fa087dc263bc6 0000eb863f74dc80 000000001800003f
18: 2 1fa087dc264698 0000000008000000 0000000000000000
19: 2 1fa087dc26469e 00000000f8000000 0000000000000000
20: 2 1fa087dc2646a3 0000000048000000 0000000000000000
21: 2 1fa087dc2646a8 0000000018000000 0000000000000000
22: 1 1fa087dc2646be 0000947fa10bac80 0000000018000003
23: 1 1fa087dc2646cd 00009ef7aa634c80 00000000f8000004
24: 1 1fa087dc2646e2 000096bdec30bc80 0000000048000005
25: 1 1fa087dc264829 000093c032a9fc80 0000000008000006
26: 2 1fa087dc7695e9 0000000018000000 0000000000000000
27: 2 1fa087dc7695ee 00000000f8000000 0000000000000000
28: 2 1fa087dc7695f6 0000000048000000 0000000000000000
29: 2 1fa087dc7695fc 0000000008000000 0000000000000000
30: 1 1fa087dc769623 0000175b11a2cc80 0000000008000007
31: 1 1fa087dc769636 00002292895c1c80 00000000f8000008
32: 1 1fa087dc76964b 00001a58cb298c80 0000000048000009
33: 1 1fa087dc76a03d 0000181a80047c80 000000001800000a
34: 2 1fa087dc7840e0 0000000008000000 0000000000000000
35: 2 1fa087dc7840e5 00000000f8000000 0000000000000000
36: 2 1fa087dc784103 0000000048000000 0000000000000000
37: 2 1fa087dc784108 0000000018000000 0000000000000000
38: 1 1fa087dc784134 00001c06e1f68c80 000000000800000b
39: 1 1fa087dc784145 0000273e59afdc80 00000000f800000c
40: 1 1fa087dc78415a 00001f049b7d4c80 000000004800000d
41: 1 1fa087dc78542a 00001cc650583c80 000000001800000e
42: 2 1fa087dc84f844 0000000008000000 0000000000000000
43: 2 1fa087dc84f849 00000000f8000000 0000000000000000
44: 2 1fa087dc84f869 0000000048000000 0000000000000000
45: 2 1fa087dc84f86e 0000000018000000 0000000000000000
46: 1 1fa087dc84f891 0000708392c1ec80 000000000800000f
47: 1 1fa087dc84f8a5 00007bbb0a7b3c80 00000000f8000010
48: 1 1fa087dc84f8c3 000073814c48ac80 0000000048000011
49: 1 1fa087dc84fb2a 0000714301239c80 0000000018000012
50: 2 1fa087dc851369 0000000008000000 0000000000000000
51: 2 1fa087dc85136f 00000000f8000000 0000000000000000
52: 2 1fa087dc851374 0000000048000000 0000000000000000
53: 2 1fa087dc851379 0000000018000000 0000000000000000
54: 1 1fa087dc8513a2 000093c032a9fc80 0000000008000013
55: 1 1fa087dc8513b5 00009ef7aa634c80 00000000f8000014
56: 1 1fa087dc8513c5 000096bdec30bc80 0000000048000015
57: 1 1fa087dc85158f 0000947fa10bac80 0000000018000016
58: 1 1fa087dc858603 0000950f4be7f500 c000000718000017
59: 1 1fa087dc85aa02 000095ceba49a500 c000000728000018
60: 1 1fa087dcb5b5ea 0000d59aca40f500 cf00000008000019
61: 2 1fa087dccefa5a 0000000008000000 0000000000000000
62: 2 1fa087dccefa5f 00000000f8000000 0000000000000000
0: 2 1fa087dccefa69 0000000018000000 0000000000000000
1: 1 1fa087dccefa8f 00004e06613b8c80 000000001800001a
2: 1 1fa087dccefaa4 0000587e6a932c80 00000000f800001b
3: 1 1fa087dccefac6 00005044ac609c80 000000004800001c
Oops: Unrecoverable exception, sig: 6 [#1]
SMP NR_CPUS=128 NUMA pSeries
Modules linked in:
NIP: c000000000008d4c LR: 00000000102e9790 CTR: 00000000102686c0
REGS: c00000077304fbb0 TRAP: 4100   Not tainted  (2.6.25-rc8-autotest)
MSR: 8000000000001030 <ME,IR,DR>  CR: 28002488  XER: 20000000
TASK = c000000774bb3200[9954] 'cc1' THREAD: c00000077304c000 CPU: 1
GPR00: 0000000000004000 c00000077304fe30 00000000102e929c 000000000000d032 
GPR04: 00000000000000bc 0000000000000000 0000000000000000 0000000000000000 
GPR08: 0000000000000037 0000000010440000 00000000f765d1c0 00000000f765c240 
GPR12: 0000000048002488 00000000105ba630 0000000010030000 0000000010030000 
GPR16: 00000000105b0000 00000000105b0000 0000000010440000 00000000ff9d92d8 
GPR20: 000000001043b8f4 00000000102686c0 00000000ff9d91d8 0000000000000000 
GPR24: 0000000000000000 0000000010071140 0000000000000000 0000000000000000 
GPR28: 00000000105b39bc 00000000f765c530 00000000f7653770 00000000f764fbe0 
NIP [c000000000008d4c] restore+0xcc/0xe8
LR [00000000102e9790] 0x102e9790
Call Trace:
[c00000077304fe30] [c000000000008d7c] do_work+0x14/0x2c (unreliable)
Instruction dump:
e88d01f0 f84d01f0 7c841050 e84d01e8 7c422214 f84d01e8 e9a100d8 7c7b03a6 
e84101a0 7c4ff120 e8410170 7c5a03a6 <e8010070> e8410080 e8610088 e8810090 
---[ end trace 1d1912fbf2b044ad ]---

-- 
Thanks & Regards,
Kamalesh Babulal,
Linux Technology Center,
IBM, ISTL.
