Return-Path: <linuxppc-dev+bounces-20584-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B115CD3436
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 May 2026 04:35:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gBbsS5H9Hz2xfR;
	Fri, 08 May 2026 14:35:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778214956;
	cv=none; b=P+hMn9goHfSbOUdSPf+VwV0jQOm/waRSne76Q2pyXrf8iM7l3n6Z0k42HiQA7wetl+tfR31zc1CeS4msj/vYS/lM2Bu7b1niDDhszdoUEYsqvkeoE/lgXPC+JBQQDu/5Y/aQpcBzhypc/YxzO1dFlFzPxpjwcXXr3zh5dN7f4SjES/M9rkCqfbXXIcWHuGnmPxLWn2YUQSbQfu1+ZhDK3oKYyj2Z2pbvItsteT9QP4UoHra9Vq5btubUABKHBkxtrBqgJcXcBLEFGvCJQbfm0haWqnC6uGznkf1xIW0C6KRVWPy/30fbGAk5ND3CFaT4tnp242oMOTc7cHPWRWGqzA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778214956; c=relaxed/relaxed;
	bh=o81ANJPDRQQHE46EmXcEzhNnFbkEoKkXGa+TopafS2o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SFxGLBh8NHuzo74R4bXSdXcKNN6ynC6iANk6gPTvHrwLDarTUDOcg7o1WF7jtWVkOOhz8GRfplqaPTfxnHaBQquu2n7PiWGbxjAlspJHgr1ZqSah2Bmk4NoGCLEYr/LNevWuHTyK0ABTro+82ZCEkAwnZz0CQOGOp08DqBl7JdBdfVH2gcPd0a635uBjvI6VSSQfGpPOKGthzf2aX9jXZ1LtE+iKDoVr/BmDCRDKBZlPhGTcwjwAfirCUfKxCfC5d9wLIm8zAtid1JUvVOjtHpQwIANOUV2zlW257Da7MaIBn2MDNVu1RDJNOkLGlOYvOE8kw2EnoBOKs1H1duqLaQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=hCAM4YSw; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=hCAM4YSw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gBbsN0WLQz2xPb
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 08 May 2026 14:35:51 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 10B7B600AE;
	Fri,  8 May 2026 04:35:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E429C2BCB0;
	Fri,  8 May 2026 04:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778214948;
	bh=L5IVCLmebtoVabNgoZlJQXA8WZVntrHmMT+E5piotwM=;
	h=From:To:Cc:Subject:Date:From;
	b=hCAM4YSwxWA5jRhKmnStsbk/bzQwycwL66hoqKd7rRNgJELMTvfXZUFg1lpN4gg+r
	 ggi7cbiey1a32Ncz2LqGNmerwJDd7vzh0Vjz+CTz88f1tnsgmvOZ2roB4X2wfu5kCm
	 efEWlEhAP6Y4ezAIQVdxcMvsc7Pk/dC5hQo+9BdF0Yqp/6SQXlwu4NEjMd9j/AodN1
	 VPHYhv8GgoR5YyBDBt9ydFecrov6U+kq+yRQ/e+e4ONeXS7G0uVi/sRBWY+crn9Ydm
	 au1rTxseNpppj946g5oxlqSC0XuNQ7PggZs+jWrLoOAL6GLGGvSYWI9Frac7USiFi3
	 9sLRLVCRdTC3A==
From: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Alex Williamson <alex@shazbot.org>,
	Magnus Lindholm <linmag7@gmail.com>,
	Matt Turner <mattst88@gmail.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Christophe Leroy <chleroy@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Dexuan Cui <decui@microsoft.com>,
	=?UTF-8?q?Krzysztof=20Ha=C5=82asa?= <khalasa@piap.pl>,
	Lukas Wunner <lukas@wunner.de>,
	"Oliver O'Halloran" <oohall@gmail.com>,
	Saurabh Singh Sengar <ssengar@microsoft.com>,
	Shuan He <heshuan@bytedance.com>,
	Srivatsa Bhat <srivatsabhat@microsoft.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-pci@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v7 00/24] PCI: Convert all dynamic sysfs attributes to static
Date: Fri,  8 May 2026 04:35:19 +0000
Message-ID: <20260508043543.217179-1-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.54.0
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

This series converts every dynamically allocated PCI sysfs attribute to
a static const definition.  After the full series, pci_sysfs_init() and
sysfs_initialized are gone, and every sysfs file is created by the
driver model at device_add() time.

Currently, the PCI resource files (resourceN, resourceN_wc) and the
legacy bus files (legacy_io, legacy_mem) are created dynamically
from two unsynchronised paths:

Path A: late_initcall

  pci_sysfs_init()                        (late_initcall)
    sysfs_initialized = 1
    for_each_pci_dev()
      pci_create_sysfs_dev_files()
        sysfs_create_bin_file()           (resourceN, resourceN_wc)
    pci_find_next_bus()
      pci_create_legacy_files()
        sysfs_create_bin_file()           (legacy_io, legacy_mem)

Path B: device registration / hotplug

  pci_bus_add_devices()
    pci_bus_add_device()
      pci_create_sysfs_dev_files()
        if (!sysfs_initialized)           <- only guard
          return
        sysfs_create_bin_file()           (resourceN, resourceN_wc)

On most ACPI systems this does not race because PCI enumeration
completes at subsys_initcall time, before pci_sysfs_init() runs:

  subsys_initcall (level 4):
    acpi_pci_root_add()
      pci_bus_add_device()
        pci_create_sysfs_dev_files()
          if (!sysfs_initialized)         <- variable not yet set
            return -EACCES

  late_initcall (level 7):
    pci_sysfs_init()
      sysfs_initialized = 1
      for_each_pci_dev()
        pci_create_sysfs_dev_files()      <- creates the files, no race

On Devicetree platforms the host controller is a platform driver that
probes via the driver model, often on a workqueue, and overlaps with the
late_initcall:

  CPU 0 (late_initcall)                CPU 1 (driver probe)
  ---------------------------          ----------------------------
  pci_sysfs_init()
    sysfs_initialized = 1
    for_each_pci_dev()                 pci_bus_add_device()
      pci_create_sysfs_dev_files()       pci_create_sysfs_dev_files()
        sysfs_create_bin_file()            sysfs_create_bin_file()
                                             -> "duplicate filename"

The same happens on ACPI when probing is asynchronous (hv_pci on
Azure, RISC-V with ACPI).

The duplicate causes sysfs_create_bin_file() to fail with -EEXIST.
pci_create_resource_files() then calls pci_remove_resource_files() in
its error unwind, tearing down files the other thread created and
still references through pdev->res_attr[].  This has caused kernel
panics on i.MX6 and boot failures on other platforms.

Several different fixes have been proposed over the years: reordering
the sysfs_initialized assignment, adding locks, checking
pci_dev_is_added(), setting pdev->res_attr[] to NULL after kfree
(which only prevents a double-free on the teardown path, not the
error unwind removing the other thread's files).  None would address the
root cause.

This has been reported a few times:

  - https://lore.kernel.org/linux-pci/20250702155112.40124-1-heshuan@bytedance.com/
  - https://lore.kernel.org/linux-pci/b51519d6-ce45-4b6d-8135-c70169bd110e@h-partners.com/
  - https://lore.kernel.org/linux-pci/1702093576-30405-1-git-send-email-ssengar@linux.microsoft.com/
  - https://lore.kernel.org/linux-pci/SY0P300MB04687548090B73E40AF97D8897B82@SY0P300MB0468.AUSP300.PROD.OUTLOOK.COM/
  - https://lore.kernel.org/linux-pci/20230105174736.GA1154719@bhelgaas/
  - https://lore.kernel.org/linux-pci/m3eebg9puj.fsf@t19.piap.pl/
  - https://lore.kernel.org/linux-pci/20200716110423.xtfyb3n6tn5ixedh@pali/
  - https://lore.kernel.org/linux-pci/1366196798-15929-1-git-send-email-artem.savkov@gmail.com/
  - https://bugzilla.kernel.org/show_bug.cgi?id=215515
  - https://bugzilla.kernel.org/show_bug.cgi?id=216888

With static attributes the driver model creates sysfs entries once per
device at device_add() time, under the device lock, eliminating the
late_initcall iteration and the race along with it.

	Krzysztof

---
Changes in v7:
  https://lore.kernel.org/linux-pci/20260422161407.118748-1-kwilczynski@kernel.org/

  - Addded Alex Williamson (author of the resource resize sysfs
    attributes) to the list of recipients for visibility.
  - Split pci_llseek_resource() into pci_llseek_resource() and
    pci_llseek_resource_legacy() since legacy attributes operate
    on a struct pci_bus where to_pci_dev() would be invalid,
    as per Bjorn Helgaas' feedback.
  - Moved each llseek variant inside its respective #ifdef guard
    during the corresponding dynamic-to-static conversion commit,
    dropping the __maybe_unused annotations.
  - Extended the WARN macro removal to also cover __legacy_mmap_fits().
  - Updated commit message of patch 18, so that it correctly mentions
    pci_stop_dev() rather than pci_stop_bus_device().
  - Updated commit message of patch 24 to clarify the indirect
    relationship between ReBAR and the HAVE_PCI_MMAP and/or
    ARCH_GENERIC_PCI_MMAP_RESOURCE guards.

Changes in v6:
  https://lore.kernel.org/linux-pci/20260416180107.777065-1-kwilczynski@kernel.org/

   - Fixed commit message for patch 13, removing reference to
     pci_resource_flags() which was no longer changed there.
   - Added a new patch (24) to move the BAR resource resize
     (ReBAR) support behind existing PCI mmap #ifdef guard,
     so that the code is not included on architectures that
     do not support resource resizing (i.e., Alpha, etc.).

Changes in v5:
  https://lore.kernel.org/linux-pci/20260411080148.471335-1-kwilczynski@kernel.org/
  
   - Added new Tested-by, Reviewed-by, and Acked-by tags.
   - Used the existing _io function names in the static macro
     definitions, deferring the rename to the conversion commit
     where it belongs, to avoid a forward reference across
     commits. This was reported by Sashiko, see:
     https://sashiko.dev/#/patchset/20260411080148.471335-1-kwilczynski%40kernel.org?part=6
   - Folded the __resource_resize_store() conversion into the
     main static attributes commit so the resize path is never
     broken between commits. This was reported by Sashiko, see:
     https://sashiko.dev/#/patchset/20260410055040.39233-1-kwilczynski%40kernel.org?part=6
     https://sashiko.dev/#/patchset/20260411080148.471335-1-kwilczynski%40kernel.org?part=7
   - Dropped the unnecessary parentheses cleanup from the Alpha
     BAR index commit, as the line is replaced two commits later
     anyway, as per Ilpo Järvinen's feedback.
   - Squashed the Alpha accessor macro and cleanup commits into
     one, using pci_resource_is_mem() directly instead of the
     intermediate pci_resource_flags() step, as per Ilpo
     Järvinen's feedback.
   - Moved the raw literal conversion in pci_create_legacy_files()
     into the macro definition commit, so the macros and their
     usage are introduced together, as per Ilpo Järvinen's
     feedback.
   - Removed unnecessary backslash line continuation from the
     ternary in pci_mmap_legacy_page_range().
   - Kept pci_resource_len() for visibility checks instead of
     resource_assigned().  The static is_visible() callback
     runs at device_add() time during the PCI enumeration,
     before the pci_assign_unassigned_bus_resources() populates
     res->parent, as such, resource_assigned() returned false
     for every BAR, hiding all resource files.  This is related
     to review feedback from Ilpo Järvinen.

Changes in v4:
  https://lore.kernel.org/linux-pci/20260410055040.39233-1-kwilczynski@kernel.org/

   - Added new Reviewed-by tags.
   - Added pci_resource_is_io() and pci_resource_is_mem() helpers
     for resource type checks, replacing the open-coded bitwise
     flag tests in pci_mmap_resource(), pci_resource_io(), and
     Alpha's pci_mmap_resource(), as per Ilpo Järvinen's
     suggestion.
   - Split the __pci_mmap_fits() cleanup into two patches.  An
     overflow fix for zero-length BARs, which now includes a
     Fixes: tag referencing the original Alpha PCI sysfs commit,
     and the WARN macro removal is a separate cleanup as per Ilpo
     Järvinen's suggestion.
   - Added a missing Fixes: tag to the Alpha lockdown check,
     referencing the commit that added the check to the generic
     path but missed Alpha's implementation.
   - Added PCI_LEGACY_IO_SIZE and PCI_LEGACY_MEM_SIZE macros to
     replace the raw literals used for legacy address space sizes.
     These are used in both Alpha's pci_mmap_legacy_page_range()
     and the static legacy attribute definitions, as per Ilpo
     Järvinen's suggestion.
   - Replaced sysfs_update_groups() in the BAR resize path with
     sysfs_remove_groups() before the resize and sysfs_create_groups()
     after, restoring the original teardown before BAR resize
     ordering.  This was reported by Sashiko, see:
     https://sashiko.dev/#/patchset/20260410055040.39233-1-kwilczynski%40kernel.org?part=7
   - Defined pci_dev_resource_attr_groups as a NULL macro when
     HAVE_PCI_MMAP and ARCH_GENERIC_PCI_MMAP_RESOURCE are both
     absent, so the resize path compiles unconditionally without
     #ifdef guards in the function body.  This was reported by
     Sashiko, see:
     https://sashiko.dev/#/patchset/20260410055040.39233-1-kwilczynski%40kernel.org?part=7
   - Moved the pci_legacy_has_sparse() prototype into the patch
     that introduces the function, alongside the existing
     pci_adjust_legacy_attr() declaration, to fix a bisection
     issue where Alpha would warn on -Wmissing-prototypes.
     This was reported by Sashiko, see:
     https://sashiko.dev/#/patchset/20260410055040.39233-1-kwilczynski%40kernel.org?part=18

Changes in v3:
  https://lore.kernel.org/linux-pci/20210910202623.2293708-1-kw@linux.com/

  - Updated for modern kernel releases and expanded scope.  The
    v2 only covered the generic resource files.  This version
    also converts Alpha's sparse/dense resource files and the
    legacy bus attributes, removing pci_sysfs_init() entirely.
  - Split the single macro definition into three distinct ones
    (per I/O, UC, and WC), to make sure that each carries only
    the callbacks its resource type needs.
  - Updated to use the new .bin_size callback, as the attributes
    are const, to replace using a->size directly, which was not
    ideal.  This required changes to pci_llseek_resource(), to
    ensure that it would work for device and bus-level attributes.
  - Updated the __resource_resize_store() to include CAP_SYS_ADMIN
    capabilities check.
  - Added the security_locked_down() check to Alpha's
    pci_mmap_resource(), to align with other architectures.

Changes in v2:
  https://lore.kernel.org/linux-pci/20210825212255.878043-1-kw@linux.com/

  - Refactored code so that the macros, helpers and internal
    functions can be used to correctly leverage the read(),
    write() and mmap() callbacks rather than to use the
    .is_bin_visible() callback to set up sysfs objects
    internals as this is not supported.
  - Refactored some if-statements to check for a resource
    flag first, and then call either arch_can_pci_mmap_io()
    or arch_can_pci_mmap_wc(), plus store result of testing
    for IORESOURCE_MEM and IORESOURCE_PREFETCH flags into
    a boolean variable, as per Bjorn Helgaas' suggestion.
  - Renamed pci_read_resource_io() and pci_write_resource_io()
    callbacks so that these are not specifically tied to I/O
    BARs read() and write() operations also as per Bjorn
    Helgaas' suggestion.
  - Updated style for code handling bitwise operations to
    match the style that is preferred as per Bjorn Helgaas'
    suggestion.
  - Updated commit messages adding more details about the
    implementation as requested by Bjorn Helgaas.

Krzysztof Wilczyński (24):
  PCI/sysfs: Use PCI resource accessor macros
  PCI: Add pci_resource_is_io() and pci_resource_is_mem() helpers
  PCI/sysfs: Only allow supported resource types in I/O and MMIO helpers
  PCI/sysfs: Split pci_llseek_resource() for device and legacy
    attributes
  PCI/sysfs: Add CAP_SYS_ADMIN check to __resource_resize_store()
  PCI/sysfs: Add static PCI resource attribute macros
  PCI/sysfs: Convert PCI resource files to static attributes
  PCI/sysfs: Warn about BAR resize failure in __resource_resize_store()
  PCI/sysfs: Add stubs for pci_{create,remove}_sysfs_dev_files()
  PCI/sysfs: Limit pci_sysfs_init() late_initcall compile scope
  alpha/PCI: Add security_locked_down() check to pci_mmap_resource()
  alpha/PCI: Use BAR index in sysfs attr->private instead of resource
    pointer
  alpha/PCI: Use PCI resource accessor macros
  alpha/PCI: Fix __pci_mmap_fits() overflow for zero-length BARs
  alpha/PCI: Remove WARN from __pci_mmap_fits() and __legacy_mmap_fits()
  alpha/PCI: Add static PCI resource attribute macros
  alpha/PCI: Convert resource files to static attributes
  PCI/sysfs: Remove pci_{create,remove}_sysfs_dev_files()
  PCI: Add macros for legacy I/O and memory address space sizes
  alpha/PCI: Compute legacy size in pci_mmap_legacy_page_range()
  PCI/sysfs: Add __weak pci_legacy_has_sparse() helper
  PCI/sysfs: Convert legacy I/O and memory attributes to static
    definitions
  PCI/sysfs: Remove pci_create_legacy_files() and pci_sysfs_init()
  PCI/sysfs: Limit BAR resize attribute scope to platforms with PCI mmap

 arch/alpha/include/asm/pci.h   |  13 +-
 arch/alpha/kernel/pci-sysfs.c  | 385 +++++++++++----------
 arch/powerpc/include/asm/pci.h |   2 -
 drivers/pci/bus.c              |   1 -
 drivers/pci/pci-sysfs.c        | 592 +++++++++++++++++++--------------
 drivers/pci/pci.h              |  16 +-
 drivers/pci/probe.c            |   6 -
 drivers/pci/remove.c           |   3 -
 include/linux/pci.h            |  39 ++-
 9 files changed, 589 insertions(+), 468 deletions(-)

-- 
2.54.0


