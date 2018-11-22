Return-Path: <SRS0=R24o=OB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23047C43441
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Nov 2018 20:11:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 822C02087E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Nov 2018 20:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kKJa9TbM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 822C02087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4319Zb43YPzDqGn
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Nov 2018 07:11:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kKJa9TbM";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=sashal@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="kKJa9TbM"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4319CW5jCqzDqG0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Nov 2018 06:55:19 +1100 (AEDT)
Received: from sasha-vm.mshome.net (unknown [37.142.5.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 73B1620864;
 Thu, 22 Nov 2018 19:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1542916518;
 bh=c2QQR32nZWUIl+gdGy33pEeHH9Se4uLFOnNuj2IdsQA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=kKJa9TbMblr0ZAx06yJWT9kr+YQQw3fAzHFO9ILfYjLOgeDQHpdAQJOqLC12+0btJ
 np5iJjty0c90VzLXMh2jo/dtr7ypzWDebM/4lXBFZxSpJp9tWXEyseqOUgVOLocGZD
 nTyUBH3tCSTvoFjmB/K7jXZ2mjLpF8+OPrwKDFUQ=
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 08/21] powerpc/io: Fix the IO workarounds code to
 work with Radix
Date: Thu, 22 Nov 2018 14:54:39 -0500
Message-Id: <20181122195452.13520-8-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181122195452.13520-1-sashal@kernel.org>
References: <20181122195452.13520-1-sashal@kernel.org>
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Michael Ellerman <mpe@ellerman.id.au>

[ Upstream commit 43c6494fa1499912c8177e71450c0279041152a6 ]

Back in 2006 Ben added some workarounds for a misbehaviour in the
Spider IO bridge used on early Cell machines, see commit
014da7ff47b5 ("[POWERPC] Cell "Spider" MMIO workarounds"). Later these
were made to be generic, ie. not tied specifically to Spider.

The code stashes a token in the high bits (59-48) of virtual addresses
used for IO (eg. returned from ioremap()). This works fine when using
the Hash MMU, but when we're using the Radix MMU the bits used for the
token overlap with some of the bits of the virtual address.

This is because the maximum virtual address is larger with Radix, up
to c00fffffffffffff, and in fact we use that high part of the address
range for ioremap(), see RADIX_KERN_IO_START.

As it happens the bits that are used overlap with the bits that
differentiate an IO address vs a linear map address. If the resulting
address lies outside the linear mapping we will crash (see below), if
not we just corrupt memory.

  virtio-pci 0000:00:00.0: Using 64-bit direct DMA at offset 800000000000000
  Unable to handle kernel paging request for data at address 0xc000000080000014
  ...
  CFAR: c000000000626b98 DAR: c000000080000014 DSISR: 42000000 IRQMASK: 0
  GPR00: c0000000006c54fc c00000003e523378 c0000000016de600 0000000000000000
  GPR04: c00c000080000014 0000000000000007 0fffffff000affff 0000000000000030
         ^^^^
  ...
  NIP [c000000000626c5c] .iowrite8+0xec/0x100
  LR [c0000000006c992c] .vp_reset+0x2c/0x90
  Call Trace:
    .pci_bus_read_config_dword+0xc4/0x120 (unreliable)
    .register_virtio_device+0x13c/0x1c0
    .virtio_pci_probe+0x148/0x1f0
    .local_pci_probe+0x68/0x140
    .pci_device_probe+0x164/0x220
    .really_probe+0x274/0x3b0
    .driver_probe_device+0x80/0x170
    .__driver_attach+0x14c/0x150
    .bus_for_each_dev+0xb8/0x130
    .driver_attach+0x34/0x50
    .bus_add_driver+0x178/0x2f0
    .driver_register+0x90/0x1a0
    .__pci_register_driver+0x6c/0x90
    .virtio_pci_driver_init+0x2c/0x40
    .do_one_initcall+0x64/0x280
    .kernel_init_freeable+0x36c/0x474
    .kernel_init+0x24/0x160
    .ret_from_kernel_thread+0x58/0x7c

This hasn't been a problem because CONFIG_PPC_IO_WORKAROUNDS which
enables this code is usually not enabled. It is only enabled when it's
selected by PPC_CELL_NATIVE which is only selected by
PPC_IBM_CELL_BLADE and that in turn depends on BIG_ENDIAN. So in order
to hit the bug you need to build a big endian kernel, with IBM Cell
Blade support enabled, as well as Radix MMU support, and then boot
that on Power9 using Radix MMU.

Still we can fix the bug, so let's do that. We simply use fewer bits
for the token, taking the union of the restrictions on the address
from both Hash and Radix, we end up with 8 bits we can use for the
token. The only user of the token is iowa_mem_find_bus() which only
supports 8 token values, so 8 bits is plenty for that.

Fixes: 566ca99af026 ("powerpc/mm/radix: Add dummy radix_enabled()")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/include/asm/io.h | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
index 422f99cf9924..e6d33eed8202 100644
--- a/arch/powerpc/include/asm/io.h
+++ b/arch/powerpc/include/asm/io.h
@@ -287,19 +287,13 @@ extern void _memcpy_toio(volatile void __iomem *dest, const void *src,
  * their hooks, a bitfield is reserved for use by the platform near the
  * top of MMIO addresses (not PIO, those have to cope the hard way).
  *
- * This bit field is 12 bits and is at the top of the IO virtual
- * addresses PCI_IO_INDIRECT_TOKEN_MASK.
+ * The highest address in the kernel virtual space are:
  *
- * The kernel virtual space is thus:
+ *  d0003fffffffffff	# with Hash MMU
+ *  c00fffffffffffff	# with Radix MMU
  *
- *  0xD000000000000000		: vmalloc
- *  0xD000080000000000		: PCI PHB IO space
- *  0xD000080080000000		: ioremap
- *  0xD0000fffffffffff		: end of ioremap region
- *
- * Since the top 4 bits are reserved as the region ID, we use thus
- * the next 12 bits and keep 4 bits available for the future if the
- * virtual address space is ever to be extended.
+ * The top 4 bits are reserved as the region ID on hash, leaving us 8 bits
+ * that can be used for the field.
  *
  * The direct IO mapping operations will then mask off those bits
  * before doing the actual access, though that only happen when
@@ -311,8 +305,8 @@ extern void _memcpy_toio(volatile void __iomem *dest, const void *src,
  */
 
 #ifdef CONFIG_PPC_INDIRECT_MMIO
-#define PCI_IO_IND_TOKEN_MASK	0x0fff000000000000ul
-#define PCI_IO_IND_TOKEN_SHIFT	48
+#define PCI_IO_IND_TOKEN_SHIFT	52
+#define PCI_IO_IND_TOKEN_MASK	(0xfful << PCI_IO_IND_TOKEN_SHIFT)
 #define PCI_FIX_ADDR(addr)						\
 	((PCI_IO_ADDR)(((unsigned long)(addr)) & ~PCI_IO_IND_TOKEN_MASK))
 #define PCI_GET_ADDR_TOKEN(addr)					\
-- 
2.17.1

