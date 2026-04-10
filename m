Return-Path: <linuxppc-dev+bounces-19533-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94F38E99049
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Apr 2026 07:13:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fsSh60Rxrz2yZ6;
	Fri, 10 Apr 2026 17:13:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775800249;
	cv=none; b=dUJcaNOGBoCbWQkNAUy+D/ecjAHFljy67bLN37gnUIrzSgMru+FNrJHJNJsr/YS+/lONRqapE7BLCewbRyMheAf3E4mLFu+B4HdpuXMhbO7+IsBFRzhDeHwXIDkVWGfWq8f8SSgIoVxEaboktenqF0Jkg8VQvqxr7SdEFxqeniMoUYJ9Ugf8V2JFPk3gsecmq9hdhgUlTB8zIJ7NFsMeL/dB8VFe6MQo3TpzUZU5DtNzpc9T+zLNgmLxYiQwIx2KHGvoAE3t3wSBqFftAfisPrThiPv5Y2IaGvrzOq+nVVYfFEdIHTqVEaAZM9LC9qgFdjUAho7+MWd9w9fuDMCKvg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775800249; c=relaxed/relaxed;
	bh=xli3ItSO7TpWj0s2BkwHIIPqfda3Fz4QEifSA6owFKM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T5IsD+cct6EGPFERDX1AvS2qW1asLwJY/bwvNhpRDmhoYnU/1ENp5b/77i/z/TAQeI4n19aqwKKR3iFfCJd4UwGeBgvQFl1qu4mXrgt5FAhLSwguFBJ00Cht+V+hy1QkV0ngKXphkmFMaVwcpuBo99LrNwGF83I737y/HTpHZdYNJLnSHebeyF1VAjH4O3z7DJpO38KHoYmyeuh31eE+mMo0XiN9Mx3DAyZ0Nul40Gnqui4Vmc3nZxQ8zOxBOU1/gvdSEk9xuKCzW65d41SOV/FzlRYXLEpS2EbIFJx5GLEyuMRz1iKDxjpdN+LBnjmrDr2CN2tOhX78FcOiRo6rYw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=TdZG2f9t; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=TdZG2f9t;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kwilczynski@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fsQrm0PCRz2yRl
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2026 15:50:47 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 3CD3760142;
	Fri, 10 Apr 2026 05:50:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B723BC19421;
	Fri, 10 Apr 2026 05:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775800244;
	bh=heNFs70N3BP1J7/YAXV0i5l1cHEi6uhW1IDN/z9Cms0=;
	h=From:To:Cc:Subject:Date:From;
	b=TdZG2f9txWpdj7lY67wEZFVQXWBe+rLFAMovErKrjBn6+8wWffZgTOjB0EUSFV8bU
	 xvP+MIZPndc6dlAsTGQVncui+vuuY8GzJUI/p7K1ZLLrXIhyObLCt8VjBHYI13lFj8
	 seKMHcHg2hsuKm586Myz1bqU0SjwxlqGO6OXshoYBUa7n04PTJkoKo/BAXAFeVEhyB
	 ojCBMdpG5+V/psVi7tdM+uv2iK8yoXCpoJQi1JkhhH09Z8iQB/HkmkeI7lfEJUau57
	 wjD5UBH1KQgjs526NJql8iCUdJboPZw4qw3Q34UPLMm5sBIAjAGviCn1T4rBiS2rP1
	 s1LT9RZ6z3+DA==
From: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
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
Subject: [PATCH 00/20] PCI: Convert all dynamic sysfs attributes to static
Date: Fri, 10 Apr 2026 05:50:20 +0000
Message-ID: <20260410055040.39233-1-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.53.0
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

  pci_sysfs_init                        (late_initcall)
    sysfs_initialized = 1
    for_each_pci_dev
      pci_create_sysfs_dev_files
        sysfs_create_bin_file           (resourceN, resourceN_wc)
    pci_find_next_bus
      pci_create_legacy_files
        sysfs_create_bin_file           (legacy_io, legacy_mem)

Path B: device registration / hotplug

  pci_bus_add_devices
    pci_bus_add_device
      pci_create_sysfs_dev_files
        if (!sysfs_initialized) return  <- only guard
        sysfs_create_bin_file           (resourceN, resourceN_wc)

On most ACPI systems this does not race because PCI enumeration
completes at subsys_initcall time, before pci_sysfs_init() runs:

  subsys_initcall (level 4):
    acpi_pci_root_add
      pci_bus_add_device
        pci_create_sysfs_dev_files
          if (!sysfs_initialized)          <- not yet set
            return -EACCES

  late_initcall (level 7):
    pci_sysfs_init
      sysfs_initialized = 1
      for_each_pci_dev
        pci_create_sysfs_dev_files         <- creates the files, no race

On Devicetree platforms the host controller is a platform driver that
probes via the driver model, often on a workqueue, and overlaps with the
late_initcall:

  CPU 0 (late_initcall)                CPU 1 (driver probe)
  ---------------------------          ----------------------------
  pci_sysfs_init()
    sysfs_initialized = 1
    for_each_pci_dev(pdev)             pci_bus_add_device(pdev)
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

Krzysztof Wilczyński (20):
  PCI/sysfs: Use PCI resource accessor macros
  PCI/sysfs: Only allow supported resource types in I/O and MMIO helpers
  PCI/sysfs: Use BAR length in pci_llseek_resource() when attr->size is
    zero
  PCI/sysfs: Add CAP_SYS_ADMIN check to __resource_resize_store()
  PCI/sysfs: Add static PCI resource attribute macros
  PCI/sysfs: Convert PCI resource files to static attributes
  PCI/sysfs: Convert __resource_resize_store() to use static attributes
  PCI/sysfs: Add stubs for pci_{create,remove}_sysfs_dev_files()
  PCI/sysfs: Limit pci_sysfs_init() late_initcall compile scope
  alpha/PCI: Add security_locked_down() check to pci_mmap_resource()
  alpha/PCI: Use BAR index in sysfs attr->private instead of resource
    pointer
  alpha/PCI: Use PCI resource accessor macros
  alpha/PCI: Clean up __pci_mmap_fits()
  alpha/PCI: Add static PCI resource attribute macros
  alpha/PCI: Convert resource files to static attributes
  PCI/sysfs: Remove pci_{create,remove}_sysfs_dev_files()
  alpha/PCI: Compute legacy size in pci_mmap_legacy_page_range()
  PCI/sysfs: Add __weak pci_legacy_has_sparse() helper
  PCI/sysfs: Convert legacy I/O and memory attributes to static
    definitions
  PCI/sysfs: Remove pci_create_legacy_files() and pci_sysfs_init()

 arch/alpha/include/asm/pci.h   |  13 +-
 arch/alpha/kernel/pci-sysfs.c  | 369 +++++++++++----------
 arch/powerpc/include/asm/pci.h |   2 -
 drivers/pci/bus.c              |   1 -
 drivers/pci/pci-sysfs.c        | 575 +++++++++++++++++++--------------
 drivers/pci/pci.h              |  16 +-
 drivers/pci/probe.c            |   6 -
 drivers/pci/remove.c           |   3 -
 include/linux/pci.h            |   9 -
 9 files changed, 545 insertions(+), 449 deletions(-)

--
2.53.0

