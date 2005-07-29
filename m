Return-Path: <roger.larsson@norran.net>
Received: from ns.skekraft.net (ns.skekraft.net [213.199.96.131])
	by ozlabs.org (Postfix) with ESMTP id EBBF667DF7
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 30 Jul 2005 08:19:56 +1000 (EST)
From: Roger Larsson <roger.larsson@norran.net>
To: Matt Porter <mporter@kernel.crashing.org>
Date: Fri, 29 Jul 2005 23:47:33 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200507292347.34021.roger.larsson@norran.net>
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: PPC440EP (405GPr) (2.4, 2.6) scatter/gather DMA - now works
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

We are actually still using the 2.4 tree with our own patches
to make SGDMA work.

Using a different approach...
1. We need more than one page of descriptors, so we allocate one
    at a time. [Doing DMA transfers of hires images directly to user space]
2. Interrupt is handled in a simpler way:
   If interrupts are enabled:
   * always enable error
   * always enable end of transfer interrupts
   * only enable terminal count interrupt on last descriptor

Anyway we have ported our patch from using 405 GPr to 440 EP,
during that we run into one major roadblock, now solved.

[ppc4xx_dma.h]
504 #ifdef PPC4xx_DMA_64BIT
 505 typedef struct {
 506         uint32_t control;
 507         uint32_t control_count;
 508         phys_addr_t src_addr;
 509         phys_addr_t dst_addr;
 510         phys_addr_t next;
 511 } ppc_sgl_t;
 512 #else
 513 typedef struct {
 514         uint32_t control;
 515         phys_addr_t src_addr;
 516         phys_addr_t dst_addr;
 517         uint32_t control_count;
 518         uint32_t next;
 519 } ppc_sgl_t;
 520 #endif

440EP is a strange...
It has 36 bit address, four 64 bit DMA and four 32 bit DMA...
Since we do not, yet, use any 64 bit DMA we turned that off...

[mmu.h]
/*
 * Define physical address type.  Machines using split size
 * virtual/physical addressing like 32-bit virtual / 36-bit
 * physical need a larger than native word size type. -Matt
 */
#ifdef CONFIG_PTE_64BIT
typedef unsigned long long phys_addr_t;
extern phys_addr_t fixup_bigphys_addr(phys_addr_t, phys_addr_t);
#else
typedef unsigned long phys_addr_t;
#endif

Since phys_addr_t is 64 bits... the discriptor layout gets wrong...
In this case I think it is better to use uint32_t for those addresses.

What is worse is how to support BOTH 32 and 64 bits DMA at
the same time. Possibly ppc_sgl_t could be private for ppc4xx_sgdma?

Is there other processors in the ppc family that have both 64
and 32 bits DMA?

I have forgot to send our patch for several days now, but this
is the most important part. This message is also to make me
remember to prepare those patches!!!

/RogerL
