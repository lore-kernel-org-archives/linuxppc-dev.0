Return-Path: <mohan@in.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0FB59DE90C
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 05:26:44 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m6LJQfA1011865
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jul 2008 15:26:41 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m6LJQfGJ231834
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jul 2008 15:26:41 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m6LJQeL4023781
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jul 2008 15:26:41 -0400
Message-ID: <4884E2E9.6050108@in.ibm.com>
Date: Tue, 22 Jul 2008 00:56:33 +0530
From: Mohan Kumar M <mohan@in.ibm.com>
MIME-Version: 1.0
To: Milton Miller <miltonm@bga.com>
Subject: Re: [RFC v3 PATCH 6/4] Use LOAD_REG_IMMEDIATE macros
References: <20080717183339.GA25070@in.ibm.com>
	<20080717184055.GB25070@in.ibm.com>
	<1216325187.7740.353.camel@pasglop> <48802AE0.30105@in.ibm.com>
	<d8d07a180aaf59d25936ad03c7287f5a@bga.com>
In-Reply-To: <d8d07a180aaf59d25936ad03c7287f5a@bga.com>
Content-Type: multipart/mixed; boundary="------------040803020704040606020208"
Cc: paulus@samba.org, naren@linux.vnet.ibm.com,
	ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------040803020704040606020208
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit



--------------040803020704040606020208
Content-Type: text/x-patch;
 name="0006-Use-LOAD_REG_IMMEDIATE-macros.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0006-Use-LOAD_REG_IMMEDIATE-macros.patch"

Use LOAD_REG_IMMEDIATE macros

This patch changes all LOAD_REG_ADDR macro calls to LOAD_REG_IMMEDIATE
to make sure that we load the correct address.

Signed-off-by: Mohan Kumar M <mohan@in.ibm.com>
---
 arch/powerpc/kernel/entry_64.S          |    4 ++--
 arch/powerpc/mm/hash_low_64.S           |    8 ++++----
 arch/powerpc/mm/slb_low.S               |    2 +-
 arch/powerpc/platforms/pseries/hvCall.S |    2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 12eb95a..37e5d95 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -714,7 +714,7 @@ _GLOBAL(enter_rtas)
         std	r6,PACASAVEDMSR(r13)
 
 	/* Setup our real return addr */	
-	LOAD_REG_ADDR(r4,.rtas_return_loc)
+	LOAD_REG_IMMEDIATE(r4,.rtas_return_loc)
 	clrldi	r4,r4,2			/* convert to realmode address */
        	mtlr	r4
 
@@ -730,7 +730,7 @@ _GLOBAL(enter_rtas)
 	sync				/* disable interrupts so SRR0/1 */
 	mtmsrd	r0			/* don't get trashed */
 
-	LOAD_REG_ADDR(r4, rtas)
+	LOAD_REG_IMMEDIATE(r4, rtas)
 	ld	r5,RTASENTRY(r4)	/* get the rtas->entry value */
 	ld	r4,RTASBASE(r4)		/* get the rtas->base value */
 	
diff --git a/arch/powerpc/mm/hash_low_64.S b/arch/powerpc/mm/hash_low_64.S
index a719f53..e9ba872 100644
--- a/arch/powerpc/mm/hash_low_64.S
+++ b/arch/powerpc/mm/hash_low_64.S
@@ -83,7 +83,7 @@ _GLOBAL(__hash_page_4K)
 	std	r29,STK_REG(r29)(r1)
 	std	r30,STK_REG(r30)(r1)
 	std	r31,STK_REG(r31)(r1)
-	
+
 	/* Step 1:
 	 *
 	 * Check permissions, atomically mark the linux PTE busy
@@ -168,7 +168,7 @@ END_FTR_SECTION(CPU_FTR_NOEXECUTE|CPU_FTR_COHERENT_ICACHE, CPU_FTR_NOEXECUTE)
 	std	r3,STK_PARM(r4)(r1)
 
 	/* Get htab_hash_mask */
-	ld	r4,htab_hash_mask@got(2)
+	LOAD_REG_IMMEDIATE(r4, htab_hash_mask)
 	ld	r27,0(r4)	/* htab_hash_mask -> r27 */
 
 	/* Check if we may already be in the hashtable, in this case, we
@@ -461,7 +461,7 @@ END_FTR_SECTION(CPU_FTR_NOEXECUTE|CPU_FTR_COHERENT_ICACHE, CPU_FTR_NOEXECUTE)
 	std	r3,STK_PARM(r4)(r1)
 
 	/* Get htab_hash_mask */
-	ld	r4,htab_hash_mask@got(2)
+	LOAD_REG_IMMEDIATE(r4, htab_hash_mask)
 	ld	r27,0(r4)	/* htab_hash_mask -> r27 */
 
 	/* Check if we may already be in the hashtable, in this case, we
@@ -792,7 +792,7 @@ END_FTR_SECTION(CPU_FTR_NOEXECUTE|CPU_FTR_COHERENT_ICACHE, CPU_FTR_NOEXECUTE)
 	std	r3,STK_PARM(r4)(r1)
 
 	/* Get htab_hash_mask */
-	ld	r4,htab_hash_mask@got(2)
+	LOAD_REG_IMMEDIATE(r4, htab_hash_mask)
 	ld	r27,0(r4)	/* htab_hash_mask -> r27 */
 
 	/* Check if we may already be in the hashtable, in this case, we
diff --git a/arch/powerpc/mm/slb_low.S b/arch/powerpc/mm/slb_low.S
index bc44dc4..502099e 100644
--- a/arch/powerpc/mm/slb_low.S
+++ b/arch/powerpc/mm/slb_low.S
@@ -128,7 +128,7 @@ END_FTR_SECTION_IFCLR(CPU_FTR_1T_SEGMENT)
 	/* Now get to the array and obtain the sllp
 	 */
 	ld	r11,PACATOC(r13)
-	ld	r11,mmu_psize_defs@got(r11)
+	LOAD_REG_IMMEDIATE(r11, mmu_psize_defs)
 	add	r11,r11,r9
 	ld	r11,MMUPSIZESLLP(r11)
 	ori	r11,r11,SLB_VSID_USER
diff --git a/arch/powerpc/platforms/pseries/hvCall.S b/arch/powerpc/platforms/pseries/hvCall.S
index c1427b3..43c18f0 100644
--- a/arch/powerpc/platforms/pseries/hvCall.S
+++ b/arch/powerpc/platforms/pseries/hvCall.S
@@ -55,7 +55,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_PURR);				\
 	/* calculate address of stat structure r4 = opcode */	\
 	srdi	r4,r4,2;		/* index into array */	\
 	mulli	r4,r4,HCALL_STAT_SIZE;				\
-	LOAD_REG_ADDR(r7, per_cpu__hcall_stats);		\
+	LOAD_REG_IMMEDIATE(r7, per_cpu__hcall_stats);		\
 	add	r4,r4,r7;					\
 	ld	r7,PACA_DATA_OFFSET(r13); /* per cpu offset */	\
 	add	r4,r4,r7;					\
-- 
1.5.4


--------------040803020704040606020208--
