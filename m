Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qbx7J2ctQzDq6y
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Apr 2016 20:35:08 +1100 (AEDT)
Received: from localhost
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 1 Apr 2016 15:05:05 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u319YED015335712
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Apr 2016 15:04:14 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u319Ytke005511
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Apr 2016 15:04:58 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, benh@kernel.crashing.org,
 paulus@samba.org, distroguy@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 65/65] powerpc/mm/radix: Cputable update for radix
In-Reply-To: <1459491908.10334.8.camel@ellerman.id.au>
References: <1459067053-10835-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1459067053-10835-65-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1459491908.10334.8.camel@ellerman.id.au>
Date: Fri, 01 Apr 2016 15:04:44 +0530
Message-ID: <8760w165aj.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman <mpe@ellerman.id.au> writes:

> [ text/plain ]
> On Sun, 2016-03-27 at 13:54 +0530, Aneesh Kumar K.V wrote:
>
>> This patch move the existing p9 hash to a different PVR and add
>> radix feature with p9 PVR. That implies we will not be able to
>> runtime select P9 hash. With P9 Radix we need to do
>> 
>> * set UPRT = 0 in cpu setup
>> * set different TLB set count
>> 
>> We ideally want to use ibm,pa-features to enable disable radix. But
>> we have already done setup cpu by the time we reach pa-features check.
>> 
>> So for now use this hack.
>> 
>> Not-Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ...
>> diff --git a/arch/powerpc/kernel/cpu_setup_power.S b/arch/powerpc/kernel/cpu_setup_power.S
>> index 584e119fa8b0..e9b76c651bd1 100644
>> --- a/arch/powerpc/kernel/cpu_setup_power.S
>> +++ b/arch/powerpc/kernel/cpu_setup_power.S
>> @@ -117,6 +117,41 @@ _GLOBAL(__restore_cpu_power9)
>>  	mtlr	r11
>>  	blr
>>  
>> +_GLOBAL(__setup_cpu_power9_uprt)
>> +	mflr	r11
>> +	bl	__init_FSCR
>> +	bl	__init_hvmode_206
>> +	mtlr	r11
>> +	beqlr
>> +	li	r0,0
>> +	mtspr	SPRN_LPID,r0
>> +	mfspr	r3,SPRN_LPCR
>> +	ori	r3, r3, LPCR_PECEDH
>> +	oris	r3,r3,(LPCR_UPRT >> 16)
>> +	bl	__init_LPCR
>
> I don't see why we *have* to initialise this here.
>
> ie. could we do it later in early_init_mmu() or similar ?

That helped. This works for me.

commit 9c9d8b4f6a2c2210c90cbb3f5c6d33b2a642e8d2
Author: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Date:   Mon Feb 15 13:44:01 2016 +0530

    powerpc/mm/radix: Cputable update for radix
    
    With P9 Radix we need to do
    
    * set UPRT = 1
    * set different TLB set count
    
    In this patch we delay the UPRT=1 to early mmu init. We also update
    other cpu_spec callback there. The restore cpu callback is used to
    init secondary cpus and also during opal init. So we do a full
    radix variant for that, even though the only difference is UPRT=1
    
    Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index b546e6f28d44..3400ed884f10 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -347,6 +347,10 @@
 #define   LPCR_LPES_SH	2
 #define   LPCR_RMI     0x00000002      /* real mode is cache inhibit */
 #define   LPCR_HDICE   0x00000001      /* Hyp Decr enable (HV,PR,EE) */
+/*
+ * Used in asm code, hence we don't want to use PPC_BITCOUNT
+ */
+#define	  LPCR_UPRT	(ASM_CONST(0x1) << 22)
 #ifndef SPRN_LPID
 #define SPRN_LPID	0x13F	/* Logical Partition Identifier */
 #endif
diff --git a/arch/powerpc/kernel/cpu_setup_power.S b/arch/powerpc/kernel/cpu_setup_power.S
index 584e119fa8b0..8d717954d0ca 100644
--- a/arch/powerpc/kernel/cpu_setup_power.S
+++ b/arch/powerpc/kernel/cpu_setup_power.S
@@ -117,6 +117,24 @@ _GLOBAL(__restore_cpu_power9)
 	mtlr	r11
 	blr
 
+_GLOBAL(__restore_cpu_power9_uprt)
+	mflr	r11
+	bl	__init_FSCR
+	mfmsr	r3
+	rldicl.	r0,r3,4,63
+	mtlr	r11
+	beqlr
+	li	r0,0
+	mtspr	SPRN_LPID,r0
+	mfspr   r3,SPRN_LPCR
+	ori	r3, r3, LPCR_PECEDH
+	oris	r3,r3,LPCR_UPRT@h
+	bl	__init_LPCR
+	bl	__init_HFSCR
+	bl	__init_tlb_power7
+	mtlr	r11
+	blr
+
 __init_hvmode_206:
 	/* Disable CPU_FTR_HVMODE and exit if MSR:HV is not set */
 	mfmsr	r3
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 6c662b8de90d..e009722d5914 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -514,7 +514,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_features		= CPU_FTRS_POWER9,
 		.cpu_user_features	= COMMON_USER_POWER9,
 		.cpu_user_features2	= COMMON_USER2_POWER9,
-		.mmu_features		= MMU_FTRS_POWER9,
+		.mmu_features		= MMU_FTRS_POWER9 | MMU_FTR_RADIX,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 6,
diff --git a/arch/powerpc/kernel/mce_power.c b/arch/powerpc/kernel/mce_power.c
index 92a66a2a9b85..f902ede263ab 100644
--- a/arch/powerpc/kernel/mce_power.c
+++ b/arch/powerpc/kernel/mce_power.c
@@ -75,6 +75,10 @@ void __flush_tlb_power9(unsigned int action)
 	flush_tlb_206(POWER9_TLB_SETS_HASH, action);
 }
 
+void __flush_tlb_power9_radix(unsigned int action)
+{
+	flush_tlb_206(POWER9_TLB_SETS_RADIX, action);
+}
 
 /* flush SLBs and reload */
 #ifdef CONFIG_PPC_MMU_STD_64
diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index bb1eb7d0911c..6e56051bf825 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -294,8 +294,20 @@ found:
 	return;
 }
 
+extern void __restore_cpu_power9_uprt(void);
+extern void __flush_tlb_power9_radix(unsigned int action);
 void __init rearly_init_mmu(void)
 {
+	unsigned long lpcr;
+	/*
+	 * setup LPCR UPRT based on mmu_features
+	 */
+	lpcr = mfspr(SPRN_LPCR);
+	mtspr(SPRN_LPCR, lpcr | LPCR_UPRT);
+	/* update cpu_spec to point to radix enabled callbacks */
+	cur_cpu_spec->cpu_restore = __restore_cpu_power9_uprt;
+	cur_cpu_spec->flush_tlb   = __flush_tlb_power9_radix;
+
 #ifdef CONFIG_PPC_64K_PAGES
 	/* PAGE_SIZE mappings */
 	mmu_virtual_psize = MMU_PAGE_64K;
