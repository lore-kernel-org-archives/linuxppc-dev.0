Return-Path: <marcelo.tosatti@cyclades.com>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 439BD67B4E
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  6 May 2005 07:51:39 +1000 (EST)
Date: Thu, 5 May 2005 14:20:35 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Dan Malek <dan@embeddededge.com>,
	linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Message-ID: <20050505172035.GB3339@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [PATCH] 8xx: fix usage of pinned 8Mbyte TLB entries 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

As can be seen by BDI output from previous messages, the 8Mbyte TLB 
pinned entry is not being actually used. 

The manual says, in section "9.3.2 Translation Enabled" (MMU section):

"A TLB hit in multiple entries is avoided when a TLB is being reloaded.
When TLB logic detects that a new effective page number (EPN) overlaps
one in the TLB (when taking into account pages sizes, subpage validity,
user/supervisor state, address space ID,and the SH values of the TLB
entries), the new EPN is written and the old one is invalidated."

The following patch changes "mmu_mapin_ram" (hook used by mapin_ram), to 
begin creation of pagetables after the first 8Megs, preserving the 
8Mbyte TLB entry. 

This changes the assumption that DMA allocations can start at the first
kernel address, given that those need to be marked uncached due to DMA 
cache coherency issues.

The bootmem allocator, used to allocate DMA regions at bootup,uses 
MAX_DMA_ADDRESS as its goal parameter. The algorithm searches for 
pages above 'goal' first, for then to search lower pages.

So change MAX_DMA_ADDRESS to avoid bootmem collisions with lower 8Megs. 

Drivers which allocate directly from __get_free_pages() and tweak the 
pte's directly also need to be fixed. For example

Panto: FEC currently does

        mem_addr = __get_free_page(GFP_KERNEL);
        cbd_base = (cbd_t *)mem_addr;
        /* XXX: missing check for allocation failure */
                                                                                    
        fec_uncache(mem_addr);

That needs to be changed to avoid the lower 8Megs.

We are still using v2.4 FEC driver, so this fixed it:

//      mem_addr = __get_free_page(GFP_KERNEL);
        mem_addr = dma_alloc_coherent(NULL, PAGE_SIZE, &physaddr,
                        GFP_KERNEL);
        cbd_base = (cbd_t *)mem_addr;

Allocateing from the coherent memory DMA region. Which sits at, I suppose, 
after initial 8Megs in all configurations (should be always). 

TLB miss stat output now looks like this on 2.6.11:

[root@CAS root]# time dd if=/dev/zero of=file bs=4k count=3840
3840+0 records in
3840+0 records out
                                                                                        
real    0m3.723s
user    0m0.150s
sys     0m3.560s
I-TLB userspace misses: 1904
I-TLB kernel misses: 0
D-TLB userspace misses: 160272
D-TLB kernel misses: 135098

instead of

[root@CAS root]# time dd if=/dev/zero of=file bs=4k count=3840
3840+0 records in
3840+0 records out
                                                                                        
real    0m4.328s
user    0m0.128s
sys     0m4.170s
I-TLB userspace misses: 162651
I-TLB kernel misses:    138100
D-TLB userspace misses: 255294
D-TLB kernel misses:    238129 

Dan: Maybe the pinning should be mandatory, getting rid of CONFIG_PIN_TLB?

diff -Nur --show-c-function linux-2.6.12-rc3.orig/arch/ppc/mm/mmu_decl.h linux-2.6.12-rc3/arch/ppc/mm/mmu_decl.h
--- linux-2.6.12-rc3.orig/arch/ppc/mm/mmu_decl.h	2005-05-05 17:21:55.000000000 -0300
+++ linux-2.6.12-rc3/arch/ppc/mm/mmu_decl.h	2005-05-05 17:31:20.000000000 -0300
@@ -49,7 +49,8 @@ extern unsigned long Hash_size, Hash_mas
 #if defined(CONFIG_8xx)
 #define flush_HPTE(X, va, pg)	_tlbie(va)
 #define MMU_init_hw()		do { } while(0)
-#define mmu_mapin_ram()		(0UL)
+/* There is a 8Mbyte pinned TLB entry covering the first 8Megs, so skip it */
+#define mmu_mapin_ram()		(0x00800000)
 
 #elif defined(CONFIG_4xx)
 #define flush_HPTE(X, va, pg)	_tlbie(va)
diff -Nur --show-c-function linux-2.6.12-rc3.orig/include/asm-ppc/dma.h linux-2.6.12-rc3/include/asm-ppc/dma.h
--- linux-2.6.12-rc3.orig/include/asm-ppc/dma.h	2005-05-05 17:21:59.000000000 -0300
+++ linux-2.6.12-rc3/include/asm-ppc/dma.h	2005-05-05 17:53:07.000000000 -0300
@@ -32,9 +32,16 @@
 #define MAX_DMA_CHANNELS	8
 #endif
 
+#ifdef CONFIG_8xx
+/* DMA pages are uncached on 8xx due to cache coherency issues.
+* Avoid bootmem from trying to allocate pages from first 8Megs.
+*/
+#define MAX_DMA_ADDRESS		(KERNELBASE + 	0x01000000)
+#else
 /* The maximum address that we can perform a DMA transfer to on this platform */
 /* Doesn't really apply... */
 #define MAX_DMA_ADDRESS		0xFFFFFFFF
+#endif
 
 /* in arch/ppc/kernel/setup.c -- Cort */
 extern unsigned long DMA_MODE_WRITE, DMA_MODE_READ;
