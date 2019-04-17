Return-Path: <SRS0=iZn8=ST=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53FACC10F12
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 07:43:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C18C20675
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 07:43:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C18C20675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44kZ3q0YtjzDqQJ
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 17:43:35 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44kZ241jFxzDqMK
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Apr 2019 17:42:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 44kZ240yw0z9s3Z; Wed, 17 Apr 2019 17:42:04 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 44kZ240XSSz9s5c; Wed, 17 Apr 2019 17:42:03 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/mm/radix: Make Radix require HUGETLB_PAGE
Date: Wed, 17 Apr 2019 17:41:40 +1000
Message-Id: <20190417074140.25130-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: stewart@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, joel@jms.id.au
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Joel reported weird crashes using skiroot_defconfig, in his case we
jumped into an NX page:

  kernel tried to execute exec-protected page (c000000002bff4f0) - exploit attempt? (uid: 0)
  BUG: Unable to handle kernel instruction fetch
  Faulting instruction address: 0xc000000002bff4f0

Looking at the disassembly, we had simply branched to that address:

  c000000000c001bc  49fff335    bl     c000000002bff4f0

But that didn't match the original kernel image:

  c000000000c001bc  4bfff335    bl     c000000000bff4f0 <kobject_get+0x8>

When STRICT_KERNEL_RWX is enabled, and we're using the radix MMU, we
call radix__change_memory_range() late in boot to change page
protections. We do that both to mark rodata read only and also to mark
init text no-execute. That involves walking the kernel page tables,
and clearing _PAGE_WRITE or _PAGE_EXEC respectively.

With radix we may use hugepages for the linear mapping, so the code in
radix__change_memory_range() uses eg. pmd_huge() to test if it has
found a huge mapping, and if so it stops the page table walk and
changes the PMD permissions.

However if the kernel is built without HUGETLBFS support, pmd_huge()
is just a #define that always returns 0. That causes the code in
radix__change_memory_range() to incorrectly interpret the PMD value as
a pointer to a PTE page rather than as a PTE at the PMD level.

Unfortunately the combination of _PAGE_PTE and _PAGE_PRESENT in the
high bits of the PMD entry give us 0xc in the top nibble which means
the PMD entry happens to look like a valid pointer into the linear
mapping.

We can see this using `dv` in xmon:

  0:mon> dv c000000000000000
  pgd  @ 0xc000000001740000
  pgdp @ 0xc000000001740000 = 0x80000000ffffb009
  pudp @ 0xc0000000ffffb000 = 0x80000000ffffa009
  pmdp @ 0xc0000000ffffa000 = 0xc00000000000018f	<- not a pointer
  ptep @ 0xc000000000000100 = 0xa64bb17da64ab07d	<- kernel text

The end result is we treat the value at 0xc000000000000100 as a PTE
and clear _PAGE_WRITE or _PAGE_EXEC, potentially corrupting the code
at that address.

In Joel's specific case we cleared the sign bit in the offset of the
branch, causing a backward branch to turn into a forward branch which
caused us to branch into a non-executable page. However the exact
nature of the crash depends on kernel version, compiler version, and
other factors.

We need to fix radix__change_memory_range() to not use accessors that
depend on HUGETLBFS, but we also have radix memory hotplug code that
uses pmd_huge() etc that will also need fixing. So for now just
disallow the broken combination of Radix with HUGETLBFS disabled.

The only defconfig we have that is affected is skiroot_defconfig, so
turn on HUGETLBFS there so that it still gets Radix.

Fixes: 566ca99af026 ("powerpc/mm/radix: Add dummy radix_enabled()")
Cc: stable@vger.kernel.org # v4.7+
Reported-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/configs/skiroot_defconfig | 1 +
 arch/powerpc/platforms/Kconfig.cputype | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/configs/skiroot_defconfig b/arch/powerpc/configs/skiroot_defconfig
index 5ba131c30f6b..1bcd468ab422 100644
--- a/arch/powerpc/configs/skiroot_defconfig
+++ b/arch/powerpc/configs/skiroot_defconfig
@@ -266,6 +266,7 @@ CONFIG_UDF_FS=m
 CONFIG_MSDOS_FS=m
 CONFIG_VFAT_FS=m
 CONFIG_PROC_KCORE=y
+CONFIG_HUGETLBFS=y
 # CONFIG_MISC_FILESYSTEMS is not set
 # CONFIG_NETWORK_FILESYSTEMS is not set
 CONFIG_NLS=y
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 842b2c7e156a..50cd09b4e05d 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -324,7 +324,7 @@ config ARCH_ENABLE_SPLIT_PMD_PTLOCK
 
 config PPC_RADIX_MMU
 	bool "Radix MMU Support"
-	depends on PPC_BOOK3S_64
+	depends on PPC_BOOK3S_64 && HUGETLB_PAGE
 	select ARCH_HAS_GIGANTIC_PAGE if (MEMORY_ISOLATION && COMPACTION) || CMA
 	default y
 	help
-- 
2.20.1

