Return-Path: <labbott@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id ABB171A0023
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Oct 2015 11:40:01 +1100 (AEDT)
Subject: Re: Missing operand for tlbie instruction on Power7
To: Segher Boessenkool <segher@kernel.crashing.org>,
 Peter Bergner <bergner@vnet.ibm.com>
References: <560EA623.1040300@redhat.com>
 <CAOJe8K1gQFRakYVWPYe0j9+Zc+s9hqB7uFF_aZh9NwCZSfTB_w@mail.gmail.com>
 <1443816930.13186.214.camel@otta>
 <CAOJe8K2GOsBk=CcWaZqq9KN=McLad97BP6ZhEdRB7i2Ag4csOg@mail.gmail.com>
 <20151002220051.GA26712@gate.crashing.org> <1443839086.13186.219.camel@otta>
 <20151004000009.GA10997@gate.crashing.org>
Cc: Denis Kirjanov <kda@linux-powerpc.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Paul Mackerras <paulus@samba.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Laura Abbott <labbott@redhat.com>
Message-ID: <5613185B.6070501@redhat.com>
Date: Mon, 5 Oct 2015 17:39:55 -0700
MIME-Version: 1.0
In-Reply-To: <20151004000009.GA10997@gate.crashing.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/03/2015 05:00 PM, Segher Boessenkool wrote:
> On Fri, Oct 02, 2015 at 09:24:46PM -0500, Peter Bergner wrote:
>>>> Ok, than we can just zero out r5 for example and use it in tlbie as RS,
>>>> right?
>>>
>>> That won't assemble _unless_ your assembler is in POWER7 mode.  It also
>>> won't do the right thing at run time on older machines.
>>
>> Correct, getting this to work on both pre-power7 and power7 and later
>> is tricky.  One really horrible hack would be to do:
>>
>>    li r0,0
>>    tlbie r4,0
>>
>> On pre-power7, the "0" will be taken as a zero L operand and on
>> power7 and later, it'll be r0, but with a zero value we loaded in
>> the insn before.  I know, really ugly. :-)
>
> Hide the "li 0,0" somewhere earlier, and write it as "tlbie 4,0", and
> don't write a comment -- we *like* tricky!
>
> It should really be a separate macro define for power7 and 4xx etc.;
> and the macro should not be called "tlbia", but something that makes
> it obvious at the usage sites that it is in fact a macro; and why a
> macro anyway, a function call might be better here?
>
>
> Segher
>

I can't speculate on why it is a macro but would something such as the
following work?

Alternatively, we could move the assembly into swusp_asm64.S which appears to be
the only 64-bit caller of tlbia

diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
index dd0fc18..53e5f59 100644
--- a/arch/powerpc/include/asm/ppc_asm.h
+++ b/arch/powerpc/include/asm/ppc_asm.h
@@ -434,14 +434,30 @@ END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,945)
  #endif
  
  /*
- * This instruction is not implemented on the PPC 603 or 601; however, on
+ * tlbia is not implemented on the PPC 603 or 601; however, on
   * the 403GCX and 405GP tlbia IS defined and tlbie is not.
   * All of these instructions exist in the 8xx, they have magical powers,
   * and they must be used.
+ *
+ * The ISA 2.06 update for POWER7 changed the number of arguments to tlbie
+ * so it gets its own special case as well as any config that may set
+ * mtune=power7 such as CONFIG_PPC_BOOK3S_64
   */
  
-#if !defined(CONFIG_4xx) && !defined(CONFIG_8xx)
-#define tlbia					\
+#if defined(CONFIG_4xx) || defined(CONFIG_8xx)
+#define TLBIA_ACTION	tlbia
+#elif defined(CONFIG_POWER7_CPU) || defined(CONFIG_PPC_BOOK3S_64)
+#define TLBIA_ACTION				\
+	li	r4,1024;			\
+	mtctr	r4;				\
+	lis	r4,KERNELBASE@h;		\
+	li	r0,0;				\
+0:	tlbie	r4,r0;				\
+	addi	r4,r4,0x1000;			\
+	bdnz	0b
+
+#else
+#define TLBIA_ACTION				\
  	li	r4,1024;			\
  	mtctr	r4;				\
  	lis	r4,KERNELBASE@h;		\
diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index dc0488b..40c3b33 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -901,7 +901,7 @@ _ENTRY(__restore_cpu_setup)
  load_up_mmu:
  	sync			/* Force all PTE updates to finish */
  	isync
-	tlbia			/* Clear all TLB entries */
+	TLBIA_ACTION		/* Clear all TLB entries */
  	sync			/* wait for tlbia/tlbie to finish */
  	TLBSYNC			/* ... on all CPUs */
  	/* Load the SDR1 register (hash table base & size) */
diff --git a/arch/powerpc/kernel/head_40x.S b/arch/powerpc/kernel/head_40x.S
index 7d7d863..6a83ec2 100644
--- a/arch/powerpc/kernel/head_40x.S
+++ b/arch/powerpc/kernel/head_40x.S
@@ -869,7 +869,7 @@ start_here:
  /* Load up the kernel context */
  2:
  	sync			/* Flush to memory before changing TLB */
-	tlbia
+	TLBIA_ACTION
  	isync			/* Flush shadow TLBs */
  
  	/* set up the PTE pointers for the Abatron bdiGDB.
@@ -897,7 +897,7 @@ start_here:
   * virtual to physical and more importantly sets the cache mode.
   */
  initial_mmu:
-	tlbia			/* Invalidate all TLB entries */
+	TLBIA_ACTION		/* Invalidate all TLB entries */
  	isync
  
  	/* We should still be executing code at physical address 0x0000xxxx
diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 78c1eba..533d736 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -711,7 +711,7 @@ start_here:
  /* Load up the kernel context */
  2:
  	SYNC			/* Force all PTE updates to finish */
-	tlbia			/* Clear all TLB entries */
+	TLBIA_ACTION		/* Clear all TLB entries */
  	sync			/* wait for tlbia/tlbie to finish */
  	TLBSYNC			/* ... on all CPUs */
  
@@ -741,7 +741,7 @@ start_here:
   * these mappings is mapped by page tables.
   */
  initial_mmu:
-	tlbia			/* Invalidate all TLB entries */
+	TLBIA_ACTION		/* Invalidate all TLB entries */
  /* Always pin the first 8 MB ITLB to prevent ITLB
     misses while mucking around with SRR0/SRR1 in asm
  */
diff --git a/arch/powerpc/kernel/swsusp_asm64.S b/arch/powerpc/kernel/swsusp_asm64.S
index 988f38d..2bcc49e 100644
--- a/arch/powerpc/kernel/swsusp_asm64.S
+++ b/arch/powerpc/kernel/swsusp_asm64.S
@@ -185,7 +185,7 @@ nothing_to_copy:
  
  	sync
  
-	tlbia
+	TLBIA_ACTION
  #endif
  
  	ld	r11,swsusp_save_area_ptr@toc(r2)
diff --git a/arch/powerpc/mm/hash_low_32.S b/arch/powerpc/mm/hash_low_32.S
index 115347f..9805c4c 100644
--- a/arch/powerpc/mm/hash_low_32.S
+++ b/arch/powerpc/mm/hash_low_32.S
@@ -696,7 +696,7 @@ _GLOBAL(_tlbia)
  	stwcx.	r8,0,r9
  	bne-	10b
  	sync
-	tlbia
+	TLBIA_ACTION
  	sync
  	TLBSYNC
  	li	r0,0
@@ -706,7 +706,7 @@ _GLOBAL(_tlbia)
  	isync
  #else /* CONFIG_SMP */
  	sync
-	tlbia
+	TLBIA_ACTION
  	sync
  #endif /* CONFIG_SMP */
  	blr
-- 
2.4.3
