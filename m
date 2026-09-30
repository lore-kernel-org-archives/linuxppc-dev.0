Return-Path: <linuxppc-dev+bounces-28587-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9531CA5FC7
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Sep 2026 15:52:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hw0112mv5z2xqM;
	Thu, 01 Oct 2026 01:52:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790783541;
	cv=none; b=hb84n+IQRA/8+KQIYPx6+esjrJ3CP0BWY7rh6MZ4oQ7VYmklo/61rMZRvqS8ePRMh+E+cqroAsC5FBn9SnkiqvUg82G8wGIbcrN7E0jDMCcayfyJphu4I6nnmVzEaW2cD5A97TVzryrAIkZJYmVvecQz5KQ2S/Py70bexls7H3cfK2yQagjnOySB4WPcGakKUegIU522YA5ymkHNQBMxumayv/GkNpCGU4E7drag8FjUbOfHZlaydeZebiC6I4ZPeG+edj5LMQbsxd14m4Wf1dCSPatMQJudxVObKF08dLHhitS15bCRgu45ggVOl1lOX1fiLbYaSO4kVsJR4C80MA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790783541; c=relaxed/relaxed;
	bh=2pHiO3miX9czvhrv+sqw3PWgll1h4c+VRg5Qpnj7QXI=;
	h=Date:From:To:CC:Subject:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=EMcseMNMjkME2fCynDpBNZfTay0Ot7uJNIzewjeWfTa6sxpESlPi6fjeXlbJ97WMU6cTKJLgCX6AEupx0HsJwyn+0M7REWZ1gude8ZZBCM8YXhgxsf+12WH1JCCfjjGL7FD59tCfwQ1sIQt4wGppiAJrOcRWjUyOqOALooYfIwbSLV2+km/zReia7F8l7OKxsJu5lur0/Wsry4p3t4sMPmFKjop2Vana6+XPG5Wb/autz1Br/Byb7I9VBZECFDB82xWmz0BLA0MxvwF3jtNwkwjtto9wmNhdqgQgwg7/aYrmiRG5QR0nQdqCJ/QJtsn3450SyCxjPkuYdguiMd8DFw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; dkim=pass (2048-bit key; unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=jeMVyqUT; dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=tnXwCEZg; dkim-atps=neutral; spf=pass (client-ip=5.75.144.95; helo=mail.mainlining.org; envelope-from=brads@mainlining.org; receiver=lists.ozlabs.org) smtp.mailfrom=mainlining.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=jeMVyqUT;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=tnXwCEZg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=mainlining.org (client-ip=5.75.144.95; helo=mail.mainlining.org; envelope-from=brads@mainlining.org; receiver=lists.ozlabs.org)
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hw00y2KvQz2xlw
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Oct 2026 01:52:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1790783516; bh=2pHiO3miX9czvhrv+sqw3PW
	gll1h4c+VRg5Qpnj7QXI=; b=jeMVyqUTcqYQ6ZBCZeFn8e9scFo56GtgYKDIr3FRkEytS0bllO
	tjVAnfPSiTfKYiL70I5ntaMdEwIM9hSlkfEcwJPY8uKJ88rW70tn2mqTIW1lXBL+oaHm563Ribs
	oZGB215ljvshnHUKLv0BemTwkf/SNJb8KaGRQqlZkFKr2IPDOZRbTbexN4hQX81lPmkmSVCHC9t
	eGQEuSK+RSg9fAYw0PUPs9/lmCz6T/8r450H1Vw9fv5XWdLC4ozn7N35hjsTIEPODQJImjnT6bd
	EYF1H08tgsDidXi+9d6x26e9Ai1Apfe51o9PzoklgA3qdHAJgBkukA4bQYAFt2QIj1g==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1790783516; bh=2pHiO3miX9czvhrv+sqw3PW
	gll1h4c+VRg5Qpnj7QXI=; b=tnXwCEZgR02WKcInCwcbC9OLYGRztGYl44AUbhoCBc/6092jtg
	2IA1HAdF6FOkaCx/tZEtbGnfwN2ZFCFZapBw==;
Date: Wed, 30 Sep 2026 16:51:58 +0100
From: Bradley Morgan <brads@mainlining.org>
To: hemanth.selam@gmail.com
CC: chleroy@kernel.org, geoff@infradead.org, gregkh@linuxfoundation.org,
 jirislaby@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-serial@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mahesh@linux.ibm.com,
 mpe@ellerman.id.au, npiggin@gmail.com, oohall@gmail.com, shuah@kernel.org
Subject: Re: [PATCH v2 1/2] powerpc: fix typos in comments
In-Reply-To: <20260908055133.16469-2-hemanth.selam@gmail.com>
Message-ID: <2C343B26-B5AB-45E5-919A-976124DC29EC@mainlining.org>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 8 September 2026 06:51:32 BST, Hemanth Selam <hemanth.selam@gmail.com>
wrote:
>Fix typos in comments, reported by scripts/checkpatch.pl using the
>misspelling list in scripts/spelling.txt.  Only touches comments, no code
>changes.
>
>Assisted-by: Cursor:claude-opus-5
>Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
>---
> arch/powerpc/include/asm/book3s/64/mmu-hash.h          |  8 ++++----
> arch/powerpc/include/asm/book3s/64/radix.h             |  2 +-
> arch/powerpc/include/asm/fsl_hcalls.h                  |  2 +-
> arch/powerpc/include/asm/io.h                          |  2 +-
> arch/powerpc/include/asm/machdep.h                     |  2 +-
> arch/powerpc/include/asm/nohash/32/pte-8xx.h           |  2 +-
> arch/powerpc/include/asm/pmac_feature.h                |  2 +-
> arch/powerpc/include/asm/prom.h                        |  2 +-
> arch/powerpc/include/asm/sfp-machine.h                 |  2 +-
> arch/powerpc/include/asm/smu.h                         | 10 +++++-----
> arch/powerpc/include/asm/task_size_64.h                |  2 +-
> arch/powerpc/include/asm/uaccess.h                     |  2 +-
> arch/powerpc/include/uapi/asm/bootx.h                  |  2 +-
> arch/powerpc/kernel/eeh.c                              |  4 ++--
> arch/powerpc/kernel/eeh_event.c                        |  2 +-
> arch/powerpc/kernel/exceptions-64e.S                   |  2 +-
> arch/powerpc/kernel/exceptions-64s.S                   |  4 ++--
> arch/powerpc/kernel/fadump.c                           |  2 +-
> arch/powerpc/kernel/irq_64.c                           |  2 +-
> arch/powerpc/kernel/paca.c                             |  2 +-
> arch/powerpc/kernel/pci_dn.c                           |  2 +-
> arch/powerpc/kernel/prom.c                             |  4 ++--
> arch/powerpc/kernel/setup_64.c                         |  2 +-
> arch/powerpc/kernel/signal_64.c                        |  2 +-
> arch/powerpc/kernel/smp.c                              |  2 +-
> arch/powerpc/kernel/switch.S                           |  2 +-
> arch/powerpc/kexec/core_64.c                           |  2 +-
> arch/powerpc/kvm/book3s_pr.c                           |  2 +-
> arch/powerpc/kvm/book3s_xive.c                         |  8 ++++----
> arch/powerpc/kvm/bookehv_interrupts.S                  |  2 +-
> arch/powerpc/lib/copyuser_power7.S                     |  4 ++--
> arch/powerpc/lib/memcpy_power7.S                       |  4 ++--
> arch/powerpc/lib/rheap.c                               |  2 +-
> arch/powerpc/mm/book3s64/hash_native.c                 |  6 +++---
> arch/powerpc/mm/book3s64/hugetlbpage.c                 |  2 +-
> arch/powerpc/mm/book3s64/radix_tlb.c                   |  4 ++--
> arch/powerpc/mm/book3s64/slb.c                         |  4 ++--
> arch/powerpc/mm/nohash/tlb.c                           |  2 +-
> arch/powerpc/perf/imc-pmu.c                            |  2 +-
> arch/powerpc/platforms/powermac/low_i2c.c              |  2 +-
> arch/powerpc/platforms/powermac/pci.c                  |  2 +-
> arch/powerpc/platforms/powermac/sleep.S                |  2 +-
> arch/powerpc/platforms/powernv/opal-memory-errors.c    |  2 +-
> arch/powerpc/platforms/powernv/opal.c                  |  2 +-
> arch/powerpc/platforms/powernv/pci-ioda.c              |  2 +-
> arch/powerpc/platforms/powernv/vas.h                   |  2 +-
> arch/powerpc/platforms/ps3/platform.h                  |  4 ++--
> arch/powerpc/platforms/pseries/firmware.c              |  4 ++--
> arch/powerpc/platforms/pseries/papr_scm.c              |  4 ++--
> arch/powerpc/xmon/ppc-opc.c                            |  4 ++--
> arch/powerpc/xmon/ppc.h                                |  2 +-
> drivers/tty/hvc/hvc_opal.c                             |  2 +-
> .../testing/selftests/powerpc/tm/tm-signal-msr-resv.c  |  2 +-
> tools/testing/selftests/powerpc/tm/tm-tar.c            |  2 +-
> 54 files changed, 77 insertions(+), 77 deletions(-)
>
>diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
>index af12e2ba8eb8..bfa452337f16 100644
>--- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
>+++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
>@@ -234,7 +234,7 @@ static inline unsigned long get_sllp_encoding(int psize)
> /*
>  * encode page number shift.
>  * in order to fit the 78 bit va in a 64 bit variable we shift the va by
>- * 12 bits. This enable us to address upto 76 bit va.
>+ * 12 bits. This enable us to address up to 76 bit va.
>  * For hpt hash from a va we can ignore the page size bits of va and for
>  * hpte encoding we ignore up to 23 bits of va. So ignoring lower 12 bits ensure
>  * we work in all cases including 4k page size.
>@@ -586,7 +586,7 @@ static inline void slb_set_size(u16 size) { }
>  * Now certain config support MAX_PHYSMEM more than 512TB. Hence we will need
>  * to use more than one context for linear mapping the kernel.
>  * For vmalloc and memmap, we use just one context with 512TB. With 64 byte
>- * struct page size, we need ony 32 TB in memmap for 2PB (51 bits (MAX_PHYSMEM_BITS)).
>+ * struct page size, we need only 32 TB in memmap for 2PB (51 bits (MAX_PHYSMEM_BITS)).
>  */
> #if (H_MAX_PHYSMEM_BITS > MAX_EA_BITS_PER_CONTEXT)
> #define MAX_KERNEL_CTX_CNT	(1UL << (H_MAX_PHYSMEM_BITS - MAX_EA_BITS_PER_CONTEXT))
>@@ -701,7 +701,7 @@ static inline void subpage_prot_free(struct mm_struct *mm) {}
> 
> /*
>  * One bit per slice. We have lower slices which cover 256MB segments
>- * upto 4G range. That gets us 16 low slices. For the rest we track slices
>+ * up to 4G range. That gets us 16 low slices. For the rest we track slices
>  * in 1TB size.
>  */
> struct slice_mask {
>@@ -756,7 +756,7 @@ static inline unsigned long vsid_scramble(unsigned long protovsid,
> 	unsigned long vsid;
> 	unsigned long vsid_modulus = ((1UL << vsid_bits) - 1);
> 	/*
>-	 * We have same multipler for both 256 and 1T segements now
>+	 * We have same multiplier for both 256 and 1T segements now
> 	 */
> 	vsid = protovsid * vsid_multiplier;
> 	vsid = (vsid >> vsid_bits) + (vsid & vsid_modulus);
>diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/include/asm/book3s/64/radix.h
>index da954e779744..c51bfbfeda85 100644
>--- a/arch/powerpc/include/asm/book3s/64/radix.h
>+++ b/arch/powerpc/include/asm/book3s/64/radix.h
>@@ -222,7 +222,7 @@ static inline void radix__set_pte_at(struct mm_struct *mm, unsigned long addr,
> 	 *
> 	 * This is not necessary for correctness, because a spurious fault
> 	 * is tolerated by the page fault handler, and this store will
>-	 * eventually be seen. In testing, there was no noticable increase
>+	 * eventually be seen. In testing, there was no noticeable increase
> 	 * in user faults on POWER9. Avoiding ptesync here is a significant
> 	 * win for things like fork. If a future microarchitecture benefits
> 	 * from ptesync, it should probably go into update_mmu_cache, rather
>diff --git a/arch/powerpc/include/asm/fsl_hcalls.h b/arch/powerpc/include/asm/fsl_hcalls.h
>index b889d13547fd..d89156ca528c 100644
>--- a/arch/powerpc/include/asm/fsl_hcalls.h
>+++ b/arch/powerpc/include/asm/fsl_hcalls.h
>@@ -336,7 +336,7 @@ static inline unsigned int fh_partition_stop(unsigned int partition)
>  * structures.  The array must be guest physically contiguous.
>  *
>  * This structure must be aligned on 32-byte boundary, so that no single
>- * strucuture can span two pages.
>+ * structure can span two pages.
>  */
> struct fh_sg_list {
> 	uint64_t source;   /**< guest physical address to copy from */
>diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
>index 7a89754842d6..df1ae59e1e69 100644
>--- a/arch/powerpc/include/asm/io.h
>+++ b/arch/powerpc/include/asm/io.h
>@@ -56,7 +56,7 @@ extern unsigned long pci_dram_offset;
> 
> extern resource_size_t isa_mem_base;
> 
>-/* Boolean set by platform if PIO accesses are suppored while _IO_BASE
>+/* Boolean set by platform if PIO accesses are supported while _IO_BASE
>  * is not set or addresses cannot be translated to MMIO. This is typically
>  * set when the platform supports "special" PIO accesses via a non memory
>  * mapped mechanism, and allows things like the early udbg UART code to
>diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
>index 256f9309bf4f..48e357cd4390 100644
>--- a/arch/powerpc/include/asm/machdep.h
>+++ b/arch/powerpc/include/asm/machdep.h
>@@ -96,7 +96,7 @@ struct machdep_calls {
> 	int		(*hmi_exception_early)(struct pt_regs *regs);
> 	long		(*machine_check_early)(struct pt_regs *regs);
> 
>-	/* Called during machine check exception to retrive fixup address. */
>+	/* Called during machine check exception to retrieve fixup address. */
> 	bool		(*mce_check_early_recovery)(struct pt_regs *regs);
> 
> 	void            (*machine_check_log_err)(void);
>diff --git a/arch/powerpc/include/asm/nohash/32/pte-8xx.h b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
>index e2ea8ba9f8ca..fc90a3258886 100644
>--- a/arch/powerpc/include/asm/nohash/32/pte-8xx.h
>+++ b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
>@@ -21,7 +21,7 @@
>  * These will get masked from the level 2 descriptor at TLB load time, and
>  * copied to the MD_TWC before it gets loaded.
>  * Large page sizes added.  We currently support two sizes, 4K and 8M.
>- * This also allows a TLB hander optimization because we can directly
>+ * This also allows a TLB handler optimization because we can directly
>  * load the PMD into MD_TWC.  The 8M pages are only used for kernel
>  * mapping of well known areas.  The PMD (PGD) entries contain control
>  * flags in addition to the address, so care must be taken that the
>diff --git a/arch/powerpc/include/asm/pmac_feature.h b/arch/powerpc/include/asm/pmac_feature.h
>index 420e2878ae67..062b46a246ba 100644
>--- a/arch/powerpc/include/asm/pmac_feature.h
>+++ b/arch/powerpc/include/asm/pmac_feature.h
>@@ -61,7 +61,7 @@
> #define PMAC_TYPE_UNKNOWN_OHARE		0x2f	/* Unknown, but OHare based */
> 
> /* Here are the Heathrow based machines
>- * FIXME: Differenciate wallstreet,mainstreet,wallstreetII
>+ * FIXME: Differentiate wallstreet,mainstreet,wallstreetII
>  */
> #define PMAC_TYPE_GOSSAMER		0x30	/* Gossamer motherboard */
> #define PMAC_TYPE_SILK			0x31	/* Desktop PowerMac G3 */
>diff --git a/arch/powerpc/include/asm/prom.h b/arch/powerpc/include/asm/prom.h
>index 2076852e6c2e..eb41b4ecd5cb 100644
>--- a/arch/powerpc/include/asm/prom.h
>+++ b/arch/powerpc/include/asm/prom.h
>@@ -33,7 +33,7 @@ struct property;
> /*
>  * This is what gets passed to the kernel by prom_init or kexec
>  *
>- * The dt struct contains the device tree structure, full pathes and
>+ * The dt struct contains the device tree structure, full paths and
>  * property contents. The dt strings contain a separate block with just
>  * the strings for the property names, and is fully page aligned and
>  * self contained in a page, so that it can be kept around by the kernel,
>diff --git a/arch/powerpc/include/asm/sfp-machine.h b/arch/powerpc/include/asm/sfp-machine.h
>index 8b957aabb826..44c873b88e43 100644
>--- a/arch/powerpc/include/asm/sfp-machine.h
>+++ b/arch/powerpc/include/asm/sfp-machine.h
>@@ -258,7 +258,7 @@
> 
> /* asm fragments for mul and div */
> 
>-/* umul_ppmm(high_prod, low_prod, multipler, multiplicand) multiplies two
>+/* umul_ppmm(high_prod, low_prod, multiplier, multiplicand) multiplies two
>  * UWtype integers MULTIPLER and MULTIPLICAND, and generates a two UWtype
>  * word product in HIGH_PROD and LOW_PROD.
>  */
>diff --git a/arch/powerpc/include/asm/smu.h b/arch/powerpc/include/asm/smu.h
>index 2ac6ab903023..9903c504a8e1 100644
>--- a/arch/powerpc/include/asm/smu.h
>+++ b/arch/powerpc/include/asm/smu.h
>@@ -521,7 +521,7 @@ extern int smu_queue_i2c(struct smu_i2c_cmd *cmd);
> 
> 
> /*
>- * - SMU "sdb" partitions informations -
>+ * - SMU "sdb" partitions information -
>  */
> 
> 
>@@ -569,7 +569,7 @@ struct smu_sdbp_fvt {
> };
> 
> /* This partition contains voltage & current sensor calibration
>- * informations
>+ * information
>  */
> #define SMU_SDB_CPUVCP_ID		0x21
> 
>@@ -610,9 +610,9 @@ struct smu_sdbp_sensortree {
> 	__u8	unknown[3];
> };
> 
>-/* This partition contains CPU thermal control PID informations. So far
>+/* This partition contains CPU thermal control PID information. So far
>  * only single CPU machines have been seen with an SMU, so we assume this
>- * carries only informations for those
>+ * carries only information for those
>  */
> #define SMU_SDB_CPUPIDDATA_ID		0x17
> 
>@@ -688,7 +688,7 @@ struct smu_user_cmd_hdr
> struct smu_user_reply_hdr
> {
> 	__u32		status;			/* Command status */
>-	__u32		reply_len;		/* Length of data follwing */
>+	__u32		reply_len;		/* Length of data following */
> };
> 
> #endif /*  _SMU_H */
>diff --git a/arch/powerpc/include/asm/task_size_64.h b/arch/powerpc/include/asm/task_size_64.h
>index 5a709951c901..e6b74380d249 100644
>--- a/arch/powerpc/include/asm/task_size_64.h
>+++ b/arch/powerpc/include/asm/task_size_64.h
>@@ -58,7 +58,7 @@
> 
> /*
>  * Initial task size value for user applications. For book3s 64 we start
>- * with 128TB and conditionally enable upto 512TB
>+ * with 128TB and conditionally enable up to 512TB
>  */
> #ifdef CONFIG_PPC_BOOK3S_64
> #define DEFAULT_MAP_WINDOW	\
>diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
>index 49039074b33f..8eb3c3c01fe0 100644
>--- a/arch/powerpc/include/asm/uaccess.h
>+++ b/arch/powerpc/include/asm/uaccess.h
>@@ -165,7 +165,7 @@ do {								\
> 
> /*
>  * This does an atomic 128 byte aligned load from userspace.
>- * Upto caller to do enable_kernel_vmx() before calling!
>+ * Up to caller to do enable_kernel_vmx() before calling!
>  */
> #define __get_user_atomic_128_aligned(kaddr, uaddr, err)		\
> 	__asm__ __volatile__(				\
>diff --git a/arch/powerpc/include/uapi/asm/bootx.h b/arch/powerpc/include/uapi/asm/bootx.h
>index 1b8c121071d9..d99f48fa9c6e 100644
>--- a/arch/powerpc/include/uapi/asm/bootx.h
>+++ b/arch/powerpc/include/uapi/asm/bootx.h
>@@ -60,7 +60,7 @@ typedef struct boot_info_map_entry
> } boot_info_map_entry_t;
> 
> 
>-/* Here are the boot informations that are passed to the bootstrap
>+/* Here are the boot information that are passed to the bootstrap
>  * Note that the kernel arguments and the device tree are appended
>  * at the end of this structure. */
> typedef struct boot_infos
>diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
>index bb836f02101c..16ccb92ebc6c 100644
>--- a/arch/powerpc/kernel/eeh.c
>+++ b/arch/powerpc/kernel/eeh.c
>@@ -351,7 +351,7 @@ static inline unsigned long eeh_token_to_phys(unsigned long token)
> 
> /*
>  * On PowerNV platform, we might already have fenced PHB there.
>- * For that case, it's meaningless to recover frozen PE. Intead,
>+ * For that case, it's meaningless to recover frozen PE. Instead,
>  * We have to handle fenced PHB firstly.
>  */
> static int eeh_phb_check_failure(struct eeh_pe *pe)
>@@ -1084,7 +1084,7 @@ void eeh_remove_device(struct pci_dev *dev)
> 	 * During the hotplug for EEH error recovery, we need the EEH
> 	 * device attached to the parent PE in order for BAR restore
> 	 * a bit later. So we keep it for BAR restore and remove it
>-	 * from the parent PE during the BAR resotre.
>+	 * from the parent PE during the BAR restore.
> 	 */
> 	edev->pdev = NULL;
> 
>diff --git a/arch/powerpc/kernel/eeh_event.c b/arch/powerpc/kernel/eeh_event.c
>index 279c1ceccd6d..4012ab408e0e 100644
>--- a/arch/powerpc/kernel/eeh_event.c
>+++ b/arch/powerpc/kernel/eeh_event.c
>@@ -134,7 +134,7 @@ int __eeh_send_failure_event(struct eeh_pe *pe)
> 	list_add(&event->list, &eeh_eventlist);
> 	spin_unlock_irqrestore(&eeh_eventlist_lock, flags);
> 
>-	/* For EEH deamon to knick in */
>+	/* For EEH daemon to knick in */
> 	complete(&eeh_eventlist_event);
> 
> 	return 0;
>diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
>index 63f6b9f513a4..ba06afc6955d 100644
>--- a/arch/powerpc/kernel/exceptions-64e.S
>+++ b/arch/powerpc/kernel/exceptions-64e.S
>@@ -874,7 +874,7 @@ kernel_dbg_exc:
> 	bl	unknown_exception
> 	b	interrupt_return
> 
>-/* Embedded Hypervisor priviledged  */
>+/* Embedded Hypervisor privileged  */
> 	START_EXCEPTION(ehpriv);
> 	NORMAL_EXCEPTION_PROLOG(0x320, BOOKE_INTERRUPT_HV_PRIV,
> 			        PROLOG_ADDITION_NONE)
>diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
>index b7229430ca94..36f611c0d206 100644
>--- a/arch/powerpc/kernel/exceptions-64s.S
>+++ b/arch/powerpc/kernel/exceptions-64s.S
>@@ -1183,7 +1183,7 @@ EXC_COMMON_BEGIN(machine_check_early_common)
> 
> 	/*
> 	 * Switch to mc_emergency stack and handle re-entrancy (we limit
>-	 * the nested MCE upto level 4 to avoid stack overflow).
>+	 * the nested MCE up to level 4 to avoid stack overflow).
> 	 * Save MCE registers srr1, srr0, dar and dsisr and then set ME=1
> 	 *
> 	 * We use paca->in_mce to check whether this is the first entry or
>@@ -2980,7 +2980,7 @@ TRAMP_REAL_BEGIN(rfscv_flush_fallback)
> 	sync
> 
> 	/*
>-	 * The load adresses are at staggered offsets within cachelines,
>+	 * The load addresses are at staggered offsets within cachelines,
> 	 * which suits some pipelines better (on others it should not
> 	 * hurt).
> 	 */
>diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
>index 7f79c9aea4a9..88eb184878c6 100644
>--- a/arch/powerpc/kernel/fadump.c
>+++ b/arch/powerpc/kernel/fadump.c
>@@ -1755,7 +1755,7 @@ void __init fadump_setup_param_area(void)
> 		 * must meet the following conditions:
> 		 * 1. The first memory block size must be higher than the
> 		 *    minimum RMA (MIN_RMA) size. Bootloader can use memory
>-		 *    upto RMA size. So it should be avoided.
>+		 *    up to RMA size. So it should be avoided.
> 		 * 2. The range should be between MIN_RMA and RMA size (ppc64_rma_size)
> 		 * 3. It must not overlap with the fadump reserved area.
> 		 */
>diff --git a/arch/powerpc/kernel/irq_64.c b/arch/powerpc/kernel/irq_64.c
>index d5c48d1b0a31..5600a86f8ddd 100644
>--- a/arch/powerpc/kernel/irq_64.c
>+++ b/arch/powerpc/kernel/irq_64.c
>@@ -417,7 +417,7 @@ bool prep_irq_for_idle_irqsoff(void)
>  * Take the SRR1 wakeup reason, index into this table to find the
>  * appropriate irq_happened bit.
>  *
>- * Sytem reset exceptions taken in idle state also come through here,
>+ * System reset exceptions taken in idle state also come through here,
>  * but they are NMI interrupts so do not need to wait for IRQs to be
>  * restored, and should be taken as early as practical. These are marked
>  * with 0xff in the table. The Power ISA specifies 0100b as the system
>diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
>index 7502066c3c53..0e263b97e016 100644
>--- a/arch/powerpc/kernel/paca.c
>+++ b/arch/powerpc/kernel/paca.c
>@@ -141,7 +141,7 @@ static struct lppaca * __init new_lppaca(int cpu, unsigned long limit)
> #ifdef CONFIG_PPC_64S_HASH_MMU
> /*
>  * 3 persistent SLBs are allocated here.  The buffer will be zero
>- * initially, hence will all be invaild until we actually write them.
>+ * initially, hence will all be invalid until we actually write them.
>  *
>  * If you make the number of persistent SLB entries dynamic, please also
>  * update PR KVM to flush and restore them accordingly.
>diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
>index a7b664befed2..7a6fe1300714 100644
>--- a/arch/powerpc/kernel/pci_dn.c
>+++ b/arch/powerpc/kernel/pci_dn.c
>@@ -406,7 +406,7 @@ void *pci_traverse_device_nodes(struct device_node *start,
> 	struct device_node *dn, *nextdn;
> 	void *ret;
> 
>-	/* We started with a phb, iterate all childs */
>+	/* We started with a phb, iterate all children */
> 	for (dn = start->child; dn; dn = nextdn) {
> 		const __be32 *classp;
> 		u32 class = 0;
>diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
>index 9ed9dde7d231..f80de43bfc58 100644
>--- a/arch/powerpc/kernel/prom.c
>+++ b/arch/powerpc/kernel/prom.c
>@@ -814,7 +814,7 @@ void __init early_init_devtree(void *params)
> 	of_scan_flat_dt(early_init_dt_scan_fw_dump, NULL);
> #endif
> 
>-	/* Retrieve various informations from the /chosen node of the
>+	/* Retrieve various information from the /chosen node of the
> 	 * device-tree, including the platform type, initrd location and
> 	 * size, TCE reserve, and more ...
> 	 */
>@@ -888,7 +888,7 @@ void __init early_init_devtree(void *params)
> 
> 	dt_cpu_ftrs_scan();
> 
>-	/* Retrieve CPU related informations from the flat tree
>+	/* Retrieve CPU related information from the flat tree
> 	 * (altivec support, boot CPU ID, ...)
> 	 */
> 	of_scan_flat_dt(early_init_dt_scan_cpus, NULL);
>diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
>index 8fd7cbf3bd04..3f72afbc8dd9 100644
>--- a/arch/powerpc/kernel/setup_64.c
>+++ b/arch/powerpc/kernel/setup_64.c
>@@ -540,7 +540,7 @@ void smp_release_cpus(void)
>  * Initialize some remaining members of the ppc64_caches and systemcfg
>  * structures
>  * (at least until we get rid of them completely). This is mostly some
>- * cache informations about the CPU that will be used by cache flush
>+ * cache information about the CPU that will be used by cache flush
>  * routines and/or provided to userland
>  */
> 
>diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
>index 86bb5bb4c143..8bba96dce9e3 100644
>--- a/arch/powerpc/kernel/signal_64.c
>+++ b/arch/powerpc/kernel/signal_64.c
>@@ -214,7 +214,7 @@ static long setup_tm_sigcontexts(struct sigcontext __user *sc,
> 	 * the context). This is very important because we must ensure we
> 	 * don't lose the VRSAVE content that may have been set prior to
> 	 * the process doing its first vector operation
>-	 * Userland shall check AT_HWCAP to know wether it can rely on the
>+	 * Userland shall check AT_HWCAP to know whether it can rely on the
> 	 * v_regs pointer or not.
> 	 */
> #ifdef CONFIG_ALTIVEC
>diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
>index 6a5a5469aaae..7f7da0fabb0c 100644
>--- a/arch/powerpc/kernel/smp.c
>+++ b/arch/powerpc/kernel/smp.c
>@@ -1183,7 +1183,7 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
> 	if (smp_ops && smp_ops->probe)
> 		smp_ops->probe();
> 
>-	// Initalise the generic SMT topology support
>+	// Initialise the generic SMT topology support
> 	num_threads = 1;
> 	if (smt_enabled_at_boot)
> 		num_threads = smt_enabled_at_boot;
>diff --git a/arch/powerpc/kernel/switch.S b/arch/powerpc/kernel/switch.S
>index 59e3ee99db0e..0652392c917f 100644
>--- a/arch/powerpc/kernel/switch.S
>+++ b/arch/powerpc/kernel/switch.S
>@@ -11,7 +11,7 @@
> 
> #ifdef CONFIG_PPC_BOOK3S_64
> /*
>- * Cancel all explict user streams as they will have no use after context
>+ * Cancel all explicit user streams as they will have no use after context
>  * switch and will stop the HW from creating streams itself
>  */
> #define STOP_STREAMS		\
>diff --git a/arch/powerpc/kexec/core_64.c b/arch/powerpc/kexec/core_64.c
>index 58c13a59b93b..3ce888b06e34 100644
>--- a/arch/powerpc/kexec/core_64.c
>+++ b/arch/powerpc/kexec/core_64.c
>@@ -347,7 +347,7 @@ void default_machine_kexec(struct kimage *image)
> 
> 	printk("kexec: Starting switchover sequence.\n");
> 
>-	/* switch to a staticly allocated stack.  Based on irq stack code.
>+	/* switch to a statically allocated stack.  Based on irq stack code.
> 	 * We setup preempt_count to avoid using VMX in memcpy.
> 	 * XXX: the task struct will likely be invalid once we do the copy!
> 	 */
>diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
>index ecfb88bf6464..3133ed5aa29a 100644
>--- a/arch/powerpc/kvm/book3s_pr.c
>+++ b/arch/powerpc/kvm/book3s_pr.c
>@@ -633,7 +633,7 @@ static void kvmppc_set_pvr_pr(struct kvm_vcpu *vcpu, u32 pvr)
>  * emulate 32 bytes dcbz length.
>  *
>  * The Book3s_64 inventors also realized this case and implemented a special bit
>- * in the HID5 register, which is a hypervisor ressource. Thus we can't use it.
>+ * in the HID5 register, which is a hypervisor resource. Thus we can't use it.
>  *
>  * My approach here is to patch the dcbz instruction on executing pages.
>  */
>diff --git a/arch/powerpc/kvm/book3s_xive.c b/arch/powerpc/kvm/book3s_xive.c
>index 1d67237783b7..f045633c884c 100644
>--- a/arch/powerpc/kvm/book3s_xive.c
>+++ b/arch/powerpc/kvm/book3s_xive.c
>@@ -1230,7 +1230,7 @@ static int xive_target_interrupt(struct kvm *kvm,
>  * allow queue overflows, we implement the following rules:
>  *
>  *  - Unless it was never enabled (or we run out of capacity)
>- *    an interrupt is always targetted at a valid server/queue
>+ *    an interrupt is always targeted at a valid server/queue
>  *    pair even when "masked" by the guest. This pair tends to
>  *    be the last one used but it can be changed under some
>  *    circumstances. That allows us to separate targetting
>@@ -1309,7 +1309,7 @@ int kvmppc_xive_set_xive(struct kvm *kvm, u32 irq, u32 server,
> 	 * xive_lock_for_unmask will not actually unmask, this will
> 	 * be done later by xive_finish_unmask() once the targetting
> 	 * has been done, so we don't try to unmask an interrupt
>-	 * that hasn't yet been targetted.
>+	 * that hasn't yet been targeted.
> 	 */
> 	if (priority == MASKED)
> 		xive_lock_and_mask(xive, sb, state);
>@@ -1406,7 +1406,7 @@ int kvmppc_xive_int_on(struct kvm *kvm, u32 irq)
> 	pr_devel("int_on(irq=0x%x)\n", irq);
> 
> 	/*
>-	 * Check if interrupt was not targetted
>+	 * Check if interrupt was not targeted
> 	 */
> 	if (state->act_priority == MASKED) {
> 		pr_devel("int_on on untargetted interrupt\n");
>@@ -1615,7 +1615,7 @@ int kvmppc_xive_set_mapped(struct kvm *kvm, unsigned long guest_irq,
> 
> 	/*
> 	 * Configure the IRQ to match the existing configuration of
>-	 * the IPI if it was already targetted. Otherwise this will
>+	 * the IPI if it was already targeted. Otherwise this will
> 	 * mask the interrupt in a lossy way (act_priority is 0xff)
> 	 * which is fine for a never started interrupt.
> 	 */
>diff --git a/arch/powerpc/kvm/bookehv_interrupts.S b/arch/powerpc/kvm/bookehv_interrupts.S
>index 8b4a402217ba..bba92695dab4 100644
>--- a/arch/powerpc/kvm/bookehv_interrupts.S
>+++ b/arch/powerpc/kvm/bookehv_interrupts.S
>@@ -133,7 +133,7 @@ END_BTB_FLUSH_SECTION
> 
> 	/*
> 	 * We don't use external PID support. lwepx faults would need to be
>-	 * handled by KVM and this implies aditional code in DO_KVM (for
>+	 * handled by KVM and this implies additional code in DO_KVM (for
> 	 * DTB_MISS, DSI and LRAT) to check ESR[EPID] and EPLC[EGS] which
> 	 * is too intrusive for the host. Get last instuction in
> 	 * kvmppc_get_last_inst().
>diff --git a/arch/powerpc/lib/copyuser_power7.S b/arch/powerpc/lib/copyuser_power7.S
>index 17dbcfbae25f..d0e0bed379a0 100644
>--- a/arch/powerpc/lib/copyuser_power7.S
>+++ b/arch/powerpc/lib/copyuser_power7.S
>@@ -323,7 +323,7 @@ err3;	std	r0,0(r3)
> 
> 4:	sub	r5,r5,r6
> 
>-	/* Get the desination 128B aligned */
>+	/* Get the destination 128B aligned */
> 	neg	r6,r3
> 	srdi	r7,r6,4
> 	mtocrf	0x01,r7
>@@ -497,7 +497,7 @@ err3;	stw	r7,4(r3)
> 
> 4:	sub	r5,r5,r6
> 
>-	/* Get the desination 128B aligned */
>+	/* Get the destination 128B aligned */
> 	neg	r6,r3
> 	srdi	r7,r6,4
> 	mtocrf	0x01,r7
>diff --git a/arch/powerpc/lib/memcpy_power7.S b/arch/powerpc/lib/memcpy_power7.S
>index b7c5e7fca8b9..a75ce988d11e 100644
>--- a/arch/powerpc/lib/memcpy_power7.S
>+++ b/arch/powerpc/lib/memcpy_power7.S
>@@ -287,7 +287,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
> 
> 4:	sub	r5,r5,r6
> 
>-	/* Get the desination 128B aligned */
>+	/* Get the destination 128B aligned */
> 	neg	r6,r3
> 	srdi	r7,r6,4
> 	mtocrf	0x01,r7
>@@ -461,7 +461,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
> 
> 4:	sub	r5,r5,r6
> 
>-	/* Get the desination 128B aligned */
>+	/* Get the destination 128B aligned */
> 	neg	r6,r3
> 	srdi	r7,r6,4
> 	mtocrf	0x01,r7
>diff --git a/arch/powerpc/lib/rheap.c b/arch/powerpc/lib/rheap.c
>index d6d72719801b..779bd42e402d 100644
>--- a/arch/powerpc/lib/rheap.c
>+++ b/arch/powerpc/lib/rheap.c
>@@ -3,7 +3,7 @@
>  * heap points to. Normal heap implementations use the memory they manage
>  * to place their list. We cannot do that because the memory we manage may
>  * have special properties, for example it is uncachable or of different
>- * endianess.
>+ * endianness.
>  *
>  * Author: Pantelis Antoniou <panto@intracom.gr>
>  *
>diff --git a/arch/powerpc/mm/book3s64/hash_native.c b/arch/powerpc/mm/book3s64/hash_native.c
>index ab2a80e59011..e39382842354 100644
>--- a/arch/powerpc/mm/book3s64/hash_native.c
>+++ b/arch/powerpc/mm/book3s64/hash_native.c
>@@ -75,7 +75,7 @@ static inline unsigned long  ___tlbie(unsigned long vpn, int psize,
> 	 * We need 14 to 65 bits of va for a tlibe of 4K page
> 	 * With vpn we ignore the lower VPN_SHIFT bits already.
> 	 * And top two bits are already ignored because we can
>-	 * only accomodate 76 bits in a 64 bit vpn with a VPN_SHIFT
>+	 * only accommodate 76 bits in a 64 bit vpn with a VPN_SHIFT
> 	 * of 12.
> 	 */
> 	va = vpn << VPN_SHIFT;
>@@ -108,7 +108,7 @@ static inline unsigned long  ___tlbie(unsigned long vpn, int psize,
> 		 * AVAL bits:
> 		 * We don't need all the bits, but rest of the bits
> 		 * must be ignored by the processor.
>-		 * vpn cover upto 65 bits of va. (0...65) and we need
>+		 * vpn cover up to 65 bits of va. (0...65) and we need
> 		 * 58..64 bits of va.
> 		 */
> 		va |= (vpn & 0xfe); /* AVAL */
>@@ -203,7 +203,7 @@ static inline void __tlbiel(unsigned long vpn, int psize, int apsize, int ssize)
> 		 * AVAL bits:
> 		 * We don't need all the bits, but rest of the bits
> 		 * must be ignored by the processor.
>-		 * vpn cover upto 65 bits of va. (0...65) and we need
>+		 * vpn cover up to 65 bits of va. (0...65) and we need
> 		 * 58..64 bits of va.
> 		 */
> 		va |= (vpn & 0xfe);
>diff --git a/arch/powerpc/mm/book3s64/hugetlbpage.c b/arch/powerpc/mm/book3s64/hugetlbpage.c
>index 2bcbbf9d85ac..0092f9863f0c 100644
>--- a/arch/powerpc/mm/book3s64/hugetlbpage.c
>+++ b/arch/powerpc/mm/book3s64/hugetlbpage.c
>@@ -107,7 +107,7 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
> 
> 		pa = pte_pfn(__pte(old_pte)) << PAGE_SHIFT;
> 
>-		/* clear HPTE slot informations in new PTE */
>+		/* clear HPTE slot information in new PTE */
> 		new_pte = (new_pte & ~_PAGE_HPTEFLAGS) | H_PAGE_HASHPTE;
> 
> 		slot = hpte_insert_repeating(hash, vpn, pa, rflags, 0,
>diff --git a/arch/powerpc/mm/book3s64/radix_tlb.c b/arch/powerpc/mm/book3s64/radix_tlb.c
>index 7de5760164a9..3ae1a4cd7b2a 100644
>--- a/arch/powerpc/mm/book3s64/radix_tlb.c
>+++ b/arch/powerpc/mm/book3s64/radix_tlb.c
>@@ -737,7 +737,7 @@ static DEFINE_PER_CPU(unsigned int, mm_cpumask_trim_clock);
>  * Interval between flushes at which we send out IPIs to check whether the
>  * mm_cpumask can be trimmed for the case where it's not a single-threaded
>  * process flushing its own mm. The intent is to reduce the cost of later
>- * flushes. Don't want this to be so low that it adds noticable cost to TLB
>+ * flushes. Don't want this to be so low that it adds noticeable cost to TLB
>  * flushing, or so high that it doesn't help reduce global TLBIEs.
>  */
> static unsigned long tlb_mm_cpumask_trim_timer = 1073;
>@@ -1384,7 +1384,7 @@ void radix__flush_tlb_all(void)
> 	asm volatile(PPC_TLBIE_5(%0, %4, %3, %2, %1)
> 		     : : "r"(rb), "i"(r), "i"(1), "i"(ric), "r"(rs) : "memory");
> 	/*
>-	 * now flush host entires by passing PRS = 0 and LPID == 0
>+	 * now flush host entries by passing PRS = 0 and LPID == 0
> 	 */
> 	asm volatile(PPC_TLBIE_5(%0, %4, %3, %2, %1)
> 		     : : "r"(rb), "i"(r), "i"(prs), "i"(ric), "r"(0) : "memory");
>diff --git a/arch/powerpc/mm/book3s64/slb.c b/arch/powerpc/mm/book3s64/slb.c
>index 15f73abd1506..ad632929768e 100644
>--- a/arch/powerpc/mm/book3s64/slb.c
>+++ b/arch/powerpc/mm/book3s64/slb.c
>@@ -269,7 +269,7 @@ void slb_dump_contents(struct slb_entry *slb_ptr)
> 		/* RR is not so useful as it's often not used for allocation */
> 		pr_err("SLB RR allocator index %d\n", get_paca()->stab_rr);
> 
>-		/* Dump slb cache entires as well. */
>+		/* Dump slb cache entries as well. */
> 		pr_err("SLB cache ptr value = %d\n", get_paca()->slb_save_cache_ptr);
> 		pr_err("Valid SLB cache entries:\n");
> 		n = min_t(int, get_paca()->slb_save_cache_ptr, SLB_CACHE_ENTRIES);
>@@ -667,7 +667,7 @@ static long slb_allocate_kernel(unsigned long ea, unsigned long id)
> 
> 	if (id == LINEAR_MAP_REGION_ID) {
> 
>-		/* We only support upto H_MAX_PHYSMEM_BITS */
>+		/* We only support up to H_MAX_PHYSMEM_BITS */
> 		if ((ea & EA_MASK) > (1UL << H_MAX_PHYSMEM_BITS))
> 			return -EFAULT;
> 
>diff --git a/arch/powerpc/mm/nohash/tlb.c b/arch/powerpc/mm/nohash/tlb.c
>index 0a650742f3a0..a70f02485778 100644
>--- a/arch/powerpc/mm/nohash/tlb.c
>+++ b/arch/powerpc/mm/nohash/tlb.c
>@@ -2,7 +2,7 @@
> /*
>  * This file contains the routines for TLB flushing.
>  * On machines where the MMU does not use a hash table to store virtual to
>- * physical translations (ie, SW loaded TLBs or Book3E compilant processors,
>+ * physical translations (ie, SW loaded TLBs or Book3E compliant processors,
>  * this does -not- include 603 however which shares the implementation with
>  * hash based processors)
>  *
>diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
>index f401181d8669..b7171d2ccb37 100644
>--- a/arch/powerpc/perf/imc-pmu.c
>+++ b/arch/powerpc/perf/imc-pmu.c
>@@ -1546,7 +1546,7 @@ static int init_nest_pmu_ref(void)
> 
> 	/*
> 	 * Loop to init the per_cpu "local_nest_imc_refc" with the proper
>-	 * "nest_imc_refc" index. This makes get_nest_pmu_ref() alot simple.
>+	 * "nest_imc_refc" index. This makes get_nest_pmu_ref() a lot simple.
> 	 */
> 	for_each_possible_cpu(cpu) {
> 		nid = cpu_to_node(cpu);
>diff --git a/arch/powerpc/platforms/powermac/low_i2c.c b/arch/powerpc/platforms/powermac/low_i2c.c
>index a175a32a222b..53636098520c 100644
>--- a/arch/powerpc/platforms/powermac/low_i2c.c
>+++ b/arch/powerpc/platforms/powermac/low_i2c.c
>@@ -912,7 +912,7 @@ static void __init smu_i2c_probe(void)
> 
> 	printk(KERN_INFO "SMU i2c %pOF\n", controller);
> 
>-	/* Look for childs, note that they might not be of the right
>+	/* Look for children, note that they might not be of the right
> 	 * type as older device trees mix i2c busses and other things
> 	 * at the same level
> 	 */
>diff --git a/arch/powerpc/platforms/powermac/pci.c b/arch/powerpc/platforms/powermac/pci.c
>index d71359b5331c..bcdefed2ab84 100644
>--- a/arch/powerpc/platforms/powermac/pci.c
>+++ b/arch/powerpc/platforms/powermac/pci.c
>@@ -628,7 +628,7 @@ static void __init setup_u3_agp(struct pci_controller* hose)
> 	 * to reassign bus numbers for HT. If we ever have P2P bridges
> 	 * on AGP, we'll have to move pci_assign_all_busses to the
> 	 * pci_controller structure so we enable it for AGP and not for
>-	 * HT childs.
>+	 * HT children.
> 	 * We hard code the address because of the different size of
> 	 * the reg address cell, we shall fix that by killing struct
> 	 * reg_property and using some accessor functions instead
>diff --git a/arch/powerpc/platforms/powermac/sleep.S b/arch/powerpc/platforms/powermac/sleep.S
>index 822ed70cdcbf..c78ee0611246 100644
>--- a/arch/powerpc/platforms/powermac/sleep.S
>+++ b/arch/powerpc/platforms/powermac/sleep.S
>@@ -229,7 +229,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_SPEC7450)
> 	mtspr	SPRN_HID0,r2
> 	sync
> 
>-/* This loop puts us back to sleep in case we have a spurrious
>+/* This loop puts us back to sleep in case we have a spurious
>  * wakeup so that the host bridge properly stays asleep. The
>  * CPU will be turned off, either after a known time (about 1
>  * second) on wallstreet & lombard, or as soon as the CPU enters
>diff --git a/arch/powerpc/platforms/powernv/opal-memory-errors.c b/arch/powerpc/platforms/powernv/opal-memory-errors.c
>index 54815882d7c0..51c54911458c 100644
>--- a/arch/powerpc/platforms/powernv/opal-memory-errors.c
>+++ b/arch/powerpc/platforms/powernv/opal-memory-errors.c
>@@ -1,6 +1,6 @@
> // SPDX-License-Identifier: GPL-2.0-or-later
> /*
>- * OPAL asynchronus Memory error handling support in PowerNV.
>+ * OPAL asynchronous Memory error handling support in PowerNV.
>  *
>  * Copyright 2013 IBM Corporation
>  * Author: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
>index 1946dbdc9fa1..93b3eee84501 100644
>--- a/arch/powerpc/platforms/powernv/opal.c
>+++ b/arch/powerpc/platforms/powernv/opal.c
>@@ -1017,7 +1017,7 @@ static int __init opal_init(void)
> 	/* Initialise OPAL sensor interface */
> 	opal_sensor_init();
> 
>-	/* Initialise OPAL hypervisor maintainence interrupt handling */
>+	/* Initialise OPAL hypervisor maintenance interrupt handling */
> 	opal_hmi_handler_init();
> 
> 	/* Create i2c platform devices */
>diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>index 32ecbc46e74b..f0b0827a773c 100644
>--- a/arch/powerpc/platforms/powernv/pci-ioda.c
>+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>@@ -387,7 +387,7 @@ static void __init pnv_ioda_parse_m64_window(struct pnv_phb *phb)
> 		return;
> 	}
> 
>-	/* Configure M64 informations */
>+	/* Configure M64 information */
> 	res = &hose->mem_resources[1];
> 	res->name = dn->full_name;
> 	res->start = of_translate_address(dn, r + 2);
>diff --git a/arch/powerpc/platforms/powernv/vas.h b/arch/powerpc/platforms/powernv/vas.h
>index 08d9d3d5a22b..85294ff6b7e8 100644
>--- a/arch/powerpc/platforms/powernv/vas.h
>+++ b/arch/powerpc/platforms/powernv/vas.h
>@@ -26,7 +26,7 @@
>  * Coprocessor Request Blocks (CRB)s and submit them using the "copy" and
>  * "paste" instructions which were introduced in Power9.
>  *
>- * A Power node can have (upto?) 8 Power chips. There is one instance of
>+ * A Power node can have (up to?) 8 Power chips. There is one instance of
>  * VAS in each Power9 chip. Each instance of VAS has 64K windows or ports,
>  * Senders and receivers must each connect to a separate window before they
>  * can exchange messages through the switchboard.
>diff --git a/arch/powerpc/platforms/ps3/platform.h b/arch/powerpc/platforms/ps3/platform.h
>index 6beecdb0d51f..37cf51b4cb60 100644
>--- a/arch/powerpc/platforms/ps3/platform.h
>+++ b/arch/powerpc/platforms/ps3/platform.h
>@@ -229,8 +229,8 @@ int ps3_repository_read_boot_dat_info(u64 *lpar_addr, unsigned int *size);
> 
> /**
>  * enum spu_resource_type - Type of spu resource.
>- * @spu_resource_type_shared: Logical spu is shared with other partions.
>- * @spu_resource_type_exclusive: Logical spu is not shared with other partions.
>+ * @spu_resource_type_shared: Logical spu is shared with other partitions.
>+ * @spu_resource_type_exclusive: Logical spu is not shared with other partitions.
>  *
>  * Returned by ps3_repository_read_spu_resource_id().
>  */
>diff --git a/arch/powerpc/platforms/pseries/firmware.c b/arch/powerpc/platforms/pseries/firmware.c
>index 18447e5fa17d..ec1c2b2e4cfa 100644
>--- a/arch/powerpc/platforms/pseries/firmware.c
>+++ b/arch/powerpc/platforms/pseries/firmware.c
>@@ -33,7 +33,7 @@ struct hypertas_fw_feature {
> 
> /*
>  * The names in this table match names in rtas/ibm,hypertas-functions.  If the
>- * entry ends in a '*', only upto the '*' is matched.  Otherwise the entire
>+ * entry ends in a '*', only up to the '*' is matched.  Otherwise the entire
>  * string must match.
>  */
> static __initdata struct hypertas_fw_feature
>@@ -90,7 +90,7 @@ static void __init fw_hypertas_feature_init(const char *hypertas,
> 
> 			/*
> 			 * If there is a '*' at the end of name, only check
>-			 * upto there
>+			 * up to there
> 			 */
> 			size = strlen(name);
> 			if (size && name[size - 1] == '*') {
>diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
>index 75da96c08cdd..6778ad0847df 100644
>--- a/arch/powerpc/platforms/pseries/papr_scm.c
>+++ b/arch/powerpc/platforms/pseries/papr_scm.c
>@@ -229,7 +229,7 @@ static int drc_pmem_query_n_bind(struct papr_scm_priv *p)
> 
> /*
>  * Query the Dimm performance stats from PHYP and copy them (if returned) to
>- * provided struct papr_scm_perf_stats instance 'stats' that can hold atleast
>+ * provided struct papr_scm_perf_stats instance 'stats' that can hold at least
>  * (num_stats + header) bytes.
>  * - If buff_stats == NULL the return value is the size in bytes of the buffer
>  * needed to hold all supported performance-statistics.
>@@ -790,7 +790,7 @@ static int papr_pdsm_health(struct papr_scm_priv *p,
> 	if (rc)
> 		goto out;
> 
>-	/* Always fetch upto date dimm health data ignoring cached values */
>+	/* Always fetch up to date dimm health data ignoring cached values */
> 	rc = __drc_pmem_query_health(p);
> 	if (rc) {
> 		mutex_unlock(&p->health_mutex);
>diff --git a/arch/powerpc/xmon/ppc-opc.c b/arch/powerpc/xmon/ppc-opc.c
>index de9b4236728c..bab041fdef98 100644
>--- a/arch/powerpc/xmon/ppc-opc.c
>+++ b/arch/powerpc/xmon/ppc-opc.c
>@@ -697,7 +697,7 @@ const struct powerpc_operand powerpc_operands[] =
> #define TBR SV + 1
>   { 0x3ff, 11, insert_tbr, extract_tbr,
>     PPC_OPERAND_OPTIONAL | PPC_OPERAND_OPTIONAL_VALUE},
>-  /* If the TBR operand is ommitted, use the value 268.  */
>+  /* If the TBR operand is omitted, use the value 268.  */
>   { -1, 268, NULL, NULL, 0},
> 
>   /* The TO field in a D or X form instruction.  */
>@@ -837,7 +837,7 @@ const struct powerpc_operand powerpc_operands[] =
>   /* The S field in a XL form instruction.  */
> #define SXL S + 1
>   { 0x1, 11, NULL, NULL, PPC_OPERAND_OPTIONAL | PPC_OPERAND_OPTIONAL_VALUE},
>-  /* If the SXL operand is ommitted, use the value 1.  */
>+  /* If the SXL operand is omitted, use the value 1.  */
>   { -1, 1, NULL, NULL, 0},
> 
>   /* SH field starting at bit position 16.  */
>diff --git a/arch/powerpc/xmon/ppc.h b/arch/powerpc/xmon/ppc.h
>index 1d98b8dd134e..b107d56df668 100644
>--- a/arch/powerpc/xmon/ppc.h
>+++ b/arch/powerpc/xmon/ppc.h
>@@ -402,7 +402,7 @@ extern const unsigned int num_powerpc_operands;
> 
> /* This flag is only used with PPC_OPERAND_OPTIONAL.  If this operand
>    is omitted, then the value it should use for the operand is stored
>-   in the SHIFT field of the immediatly following operand field.  */
>+   in the SHIFT field of the immediately following operand field.  */
> #define PPC_OPERAND_OPTIONAL_VALUE (0x400000)
> 
> /* This flag is only used with PPC_OPERAND_OPTIONAL.  The operand is
>diff --git a/drivers/tty/hvc/hvc_opal.c b/drivers/tty/hvc/hvc_opal.c
>index 402da9e7c534..422f3a930934 100644
>--- a/drivers/tty/hvc/hvc_opal.c
>+++ b/drivers/tty/hvc/hvc_opal.c
>@@ -196,7 +196,7 @@ static int hvc_opal_probe(struct platform_device *dev)
> 				     termno, 0);
> 		}
> 
>-		/* Instanciate now to establish a mapping index==vtermno */
>+		/* Instantiate now to establish a mapping index==vtermno */
> 		hvc_instantiate(termno, termno, ops);
> 	} else {
> 		pr_err("hvc_opal: Device %pOF has duplicate terminal number #%d\n",
>diff --git a/tools/testing/selftests/powerpc/tm/tm-signal-msr-resv.c b/tools/testing/selftests/powerpc/tm/tm-signal-msr-resv.c
>index 4a61e9bd12b4..8aee18819603 100644
>--- a/tools/testing/selftests/powerpc/tm/tm-signal-msr-resv.c
>+++ b/tools/testing/selftests/powerpc/tm/tm-signal-msr-resv.c
>@@ -42,7 +42,7 @@ void signal_usr1(int signum, siginfo_t *info, void *uc)
> #else
> 	ucp->uc_mcontext.uc_regs->gregs[PT_MSR] |= (7ULL);
> #endif
>-	/* Should segv on return becuase of invalid context */
>+	/* Should segv on return because of invalid context */
> 	segv_expected = 1;
> }
> 
>diff --git a/tools/testing/selftests/powerpc/tm/tm-tar.c b/tools/testing/selftests/powerpc/tm/tm-tar.c
>index f2a9137f3c1e..ea420caa3961 100644
>--- a/tools/testing/selftests/powerpc/tm/tm-tar.c
>+++ b/tools/testing/selftests/powerpc/tm/tm-tar.c
>@@ -50,7 +50,7 @@ int test_tar(void)
> 			"bne	2b;"
> 			"tend.;"
> 
>-			/* Transaction sucess! TAR should be 3 */
>+			/* Transaction success! TAR should be 3 */
> 			"mfspr  7, %[tar];"
> 			"ori	%[res], 7, 4;"  // res = 3|4 = 7
> 			"b	4f;"
>
ugh, why even do this

Oh well, didn't break nothing:


Tested-by: Bradley Morgan <brads@mainlining.org> # Power10

--- Thanks!
"I'm not a very positive person" - Linus torvalds

