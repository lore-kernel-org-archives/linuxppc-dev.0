Return-Path: <suzuki@in.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e38.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 685C1B6F72
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Jun 2011 16:13:52 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e38.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p5F65NO5024055
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Jun 2011 00:05:23 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	p5F6Dh4U154224
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Jun 2011 00:13:43 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p5F0DgZT028336
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Jun 2011 18:13:43 -0600
Message-ID: <4DF84D92.2030803@in.ibm.com>
Date: Wed, 15 Jun 2011 11:43:38 +0530
From: Suzuki Poulose <suzuki@in.ibm.com>
MIME-Version: 1.0
To: monstr@monstr.eu
Subject: Re: Relocatable kernel for ppc44x
References: <4DF74E5D.9020908@monstr.eu>
In-Reply-To: <4DF74E5D.9020908@monstr.eu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, John Williams <john.williams@petalogix.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/14/11 17:34, Michal Simek wrote:
> Hi,
>
> have someone tried to support RELOCATABLE kernel on ppc44x?
As Josh, mentioned, I will be working on this. In fact I was trying a couple of
patches towards this on PPC440x. But, I am stuck in debugging the hang that I am
experiencing with the changes. I am setting up a RISCWatch processor probe to
debug the same.

Here is some information that I wanted to share :

The PPC440X currently uses 256M TLB entries to pin the lowmem. When we go for a
relocatable kernel we have to :

1) Restrict the kernel load address to be 256M aligned

OR

2) Use 16M TLB(the next possible TLB page size supported) entries till the first
256M and then use the 256M TLB entries for the rest of lowmem.

Option 1 is not feasible.

Towards this, I have tried a patch which uses 16M TLB entries to map the entire
lowmem on an ebony board. But that doesn't seem to work. I am setting up the JTAG
to debug the state.

I have attached the patch below for your reference. Any suggestions/comments would
be really helpful.


Thanks
Suzuki

==============================


Use 16M TLB pages to pin the lowmem on PPC440x.

---
  arch/powerpc/include/asm/mmu-44x.h |    9 +++++++++
  arch/powerpc/kernel/head_44x.S     |    2 +-
  arch/powerpc/mm/44x_mmu.c          |    2 +-
  3 files changed, 11 insertions(+), 2 deletions(-)

Index: linux-2.6.38.1/arch/powerpc/include/asm/mmu-44x.h
===================================================================
--- linux-2.6.38.1.orig/arch/powerpc/include/asm/mmu-44x.h
+++ linux-2.6.38.1/arch/powerpc/include/asm/mmu-44x.h
@@ -121,7 +121,12 @@ typedef struct {
  #endif
  
  /* Size of the TLBs used for pinning in lowmem */
+#define PPC_PIN_SIZE	(1 << 24)	/* 16M */
+#define PPC44x_TLB_PIN_SIZE	PPC44x_TLB_16M
+#if 0
  #define PPC_PIN_SIZE	(1 << 28)	/* 256M */
+#define PPC44x_TLB_PIN_SIZE	PPC44x_TLB_256M
+#endif
  
  #if (PAGE_SHIFT == 12)
  #define PPC44x_TLBE_SIZE	PPC44x_TLB_4K
@@ -142,7 +147,11 @@ typedef struct {
  #error "Unsupported PAGE_SIZE"
  #endif
  
+#if 0
  #define mmu_linear_psize	MMU_PAGE_256M
+#else
+#define mmu_linear_psize	MMU_PAGE_16M
+#endif
  
  #define PPC44x_PGD_OFF_SHIFT	(32 - PGDIR_SHIFT + PGD_T_LOG2)
  #define PPC44x_PGD_OFF_MASK_BIT	(PGDIR_SHIFT - PGD_T_LOG2)
Index: linux-2.6.38.1/arch/powerpc/kernel/head_44x.S
===================================================================
--- linux-2.6.38.1.orig/arch/powerpc/kernel/head_44x.S
+++ linux-2.6.38.1/arch/powerpc/kernel/head_44x.S
@@ -805,7 +805,7 @@ skpinv:	addi	r4,r4,1				/* Increment */
  
  	/* pageid fields */
  	clrrwi	r3,r3,10		/* Mask off the effective page number */
-	ori	r3,r3,PPC44x_TLB_VALID | PPC44x_TLB_256M
+	ori	r3,r3,PPC44x_TLB_VALID | PPC44x_TLB_PIN_SIZE
  
  	/* xlat fields */
  	clrrwi	r4,r4,10		/* Mask off the real page number */
Index: linux-2.6.38.1/arch/powerpc/mm/44x_mmu.c
===================================================================
--- linux-2.6.38.1.orig/arch/powerpc/mm/44x_mmu.c
+++ linux-2.6.38.1/arch/powerpc/mm/44x_mmu.c
@@ -84,7 +84,7 @@ static void __init ppc44x_pin_tlb(unsign
  	: "r" (PPC44x_TLB_SW | PPC44x_TLB_SR | PPC44x_TLB_SX | PPC44x_TLB_G),
  #endif
  	  "r" (phys),
-	  "r" (virt | PPC44x_TLB_VALID | PPC44x_TLB_256M),
+	  "r" (virt | PPC44x_TLB_VALID | PPC44x_TLB_PIN_SIZE),
  	  "r" (entry),
  	  "i" (PPC44x_TLB_PAGEID),
  	  "i" (PPC44x_TLB_XLAT),
