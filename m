Date: Sun, 11 Mar 2001 16:03:08 -0600 (CST)
From: Grant Erickson <erick205@umn.edu>
To: David Blythe <blythe@routefree.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MMU_init buglet in 2.4.0-mvista_010216
In-Reply-To: <3AAB06CC.F5E5A5BA@routefree.com>
Message-Id: <Pine.SOL.4.20.0103111550220.7189-100000@garnet.tc.umn.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Sat, 10 Mar 2001, David Blythe wrote:
> memory sizes > 16M but not a multiple of 16M not quite right.  for the
> 24M config i was playing with it manifests itself as a tlb miss/kernel
> stack overflow.

David,

I've implemented a me general solution for this page pinning which you
may/may not prefer. A snippet and patch are included below.

        off_t offset;
        ssize_t pagesz, memsz;
        int slots, bits;
        bd_t *bip = (bd_t *)__res;

	[ ... ]

        slots = 0;
        offset = 0;
        memsz = bip->bi_memsize;
        while (memsz > 0 && slots <= (PPC4XX_TLB_SIZE / 2)) {
                if ((memsz - (1 << (10 + (2 * PAGESZ_16M)))) >= 0) {
                        bits = PAGESZ_16M;

                } else if ((memsz - (1 << (10 + (2 * PAGESZ_4M)))) >= 0) {
                        bits = PAGESZ_4M;

                } else if ((memsz - (1 << (10 + (2 * PAGESZ_1M)))) >= 0) {
                        bits = PAGESZ_1M;

                } else if ((memsz - (1 << (10 + (2 * PAGESZ_256K)))) >= 0) {
                        bits = PAGESZ_256K;

                } else if ((memsz - (1 << (10 + (2 * PAGESZ_64K)))) >= 0) {
                        bits = PAGESZ_64K;

                } else if ((memsz - (1 << (10 + (2 * PAGESZ_16K)))) >= 0) {
                        bits = PAGESZ_16K;

                } else if ((memsz - (1 << (10 + (2 * PAGESZ_4K)))) >= 0) {
                        bits = PAGESZ_4K;

                } else {
                        bits = PAGESZ_1K;
                }

                pagesz = 1 << (10 + (2 * bits));
                memsz -= pagesz;
                slots++;

                PPC4xx_tlb_pin(KERNELBASE + offset, offset,
                               TLB_PAGESZ(bits), 1);

                offset += pagesz;
        }

The patch against 2.4.0-mvista_010216:

--- init.c-2.4.0-mvista_010216	Sun Mar 11 13:53:01 2001
+++ init.c			Fri Feb 16 11:38:12 2001
 void __init
 MMU_init(void)
 {
-
-/*
-** The maximum tlbs we allow to use is PPC4xx_MAX_PINNED_TLB (32)
-** entries which pins up to half gigabyte of memory.
-*/
-#define PPC4xx_MAX_PINNED_TLB   32
-#define PPC4xx_MAX_MEM  (PPC4xx_MAX_PINNED_TLB * SIZE_16MB)
-#define SIZE_4MB        0x0400000
-#define SIZE_16MB       0x1000000
-
-        extern unsigned char __res[];
-
+        off_t offset;
+        ssize_t pagesz, memsz;
+        int slots, bits;
         bd_t            *bip = (bd_t *)__res;
-        int             i;
-        unsigned int    pinned_tlbs;
-        unsigned int    size_pinned;
-        unsigned int    size_DRAM;
-        unsigned long   start_vaddr;
-        unsigned long   start_paddr;
-        void            *vaddr;

         /*
          * The Zone Protection Register (ZPR) defines how protection will
@@ -948,115 +974,108 @@
          * without regard to the EX and WR bits. In user-mode, access is
          * allowed based on the EX and WR bits.
          */
+        /* ftr revisit: set zone 2..15 to zero?  (are 2..15 used ?) */
         mtspr(SPRN_ZPR, 0x2aaaaaaa);

         flush_instruction_cache();

+        /* ftr revisit
+        ** - reconsider the pin
+        ** - look at MMU_init() for other processors
+        ** - consider setting 0x0000'0000 - 0x07ff'ffff to _not_ be guarded
+        **   in real mode (see SPRN_SGR).  This could improve performance
+        **   of fault handlers.  Have to fix rfi, etc to avoid speculative
+        **   prefetches if turn off guarded protection.
+        */
+
+        slots = 0;
+        offset = 0;
+        memsz = bip->bi_memsize;
+        while (memsz > 0 && slots <= (PPC4XX_TLB_SIZE / 2)) {
+                if ((memsz - (1 << (10 + (2 * PAGESZ_16M)))) >= 0) {
+                        bits = PAGESZ_16M;
+
+                } else if ((memsz - (1 << (10 + (2 * PAGESZ_4M)))) >= 0) {

+                        bits = PAGESZ_4M;
+
+                } else if ((memsz - (1 << (10 + (2 * PAGESZ_1M)))) >= 0) {
+                        bits = PAGESZ_1M;
+
+                } else if ((memsz - (1 << (10 + (2 * PAGESZ_256K)))) >= 0) {
+                        bits = PAGESZ_256K;

-        /* -----  pin 16MB chunks of memory  ----- */
-
-        size_DRAM = bip->bi_memsize;
+                } else if ((memsz - (1 << (10 + (2 * PAGESZ_64K)))) >= 0) {
+                        bits = PAGESZ_64K;

-        if (size_DRAM < SIZE_16MB)
-                printk(KERN_EMERG "MMU_init(): current memory 0x%x is too small."
-                        "  Minimum memory requirement is 16MB\n", size_DRAM);
+                } else if ((memsz - (1 << (10 + (2 * PAGESZ_16K)))) >= 0) {
+                        bits = PAGESZ_16K;

-        if ((size_DRAM % SIZE_4MB) != 0)
-                printk(KERN_EMERG "MMU_init(): current memory 0x%x is not a multiple of 4 MB."
-                        "  This configuration is not supported\n", size_DRAM);
+                } else if ((memsz - (1 << (10 + (2 * PAGESZ_4K)))) >= 0) {
+                        bits = PAGESZ_4K;

-        if (size_DRAM > PPC4xx_MAX_MEM) {
-                printk(KERN_ERR "MMU_init(): current memory 0x%x is too large."
-                        "  Memory above 0x%x will not be used.\n", size_DRAM,
-                        PPC4xx_MAX_MEM);
-                bip->bi_memsize = PPC4xx_MAX_MEM;
-                size_DRAM       = bip->bi_memsize;
+                } else {
+                        bits = PAGESZ_1K;
         }

-        pinned_tlbs = (size_DRAM / SIZE_16MB);
-        size_pinned = 0;
-        start_vaddr = KERNELBASE;
-        start_paddr = 0x0;
-        for (i = 0; i < pinned_tlbs; i++)  {
-                PPC4xx_tlb_pin(start_vaddr, start_paddr, TLB_PAGESZ(PAGESZ_16M), 1);
-                size_pinned += SIZE_16MB;
-                start_vaddr += SIZE_16MB;
-                start_paddr += SIZE_16MB;
+                pagesz = 1 << (10 + (2 * bits));
+                memsz -= pagesz;
+                slots++;
+
+                PPC4xx_tlb_pin(KERNELBASE + offset, offset,
+                               TLB_PAGESZ(bits), 1);
+
+                offset += pagesz;
         }

--
 Grant Erickson                       University of Minnesota Alumni
  o mail:erick205@umn.edu                                 1996 BSEE
  o http://www.umn.edu/~erick205                          1998 MSEE


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
