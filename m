Return-Path: <linuxppc-dev+bounces-20629-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04B69CD3445
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 May 2026 23:00:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gC4NJ2CgKz2xnZ;
	Sat, 09 May 2026 09:00:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778281248;
	cv=none; b=GIdra6kWpXpM/Ba6LwDYOhNC0nA8fl38qFcGqTgNT9ffUCamna5hrpIQNJhc26yOMIOmW2CmOnEeY/5CGGbcdMCXQOIA6QW+cBudMPhRriv5tuB+EybkBhOwB+8q5fWI4nxyJC3VoE70o6j9hv/t+GXvLdrsPgk/wIcf275OHEbZ1N6AYSoyG9SYh2StFZGKEoTu8i4bVECqVEqgeD18yS88sDNb00AdIDEfBwP58y6K3RY1JRa64RS+o4xooIY1hkj3g2PRqiaNGguSd/8o+9m3mo9+EUOEXl8/3/aOHkykg5HvyvXZOI1Q7msho+z/07ExsT3B+GKZrnDOcpyADA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778281248; c=relaxed/relaxed;
	bh=O2G/ziMEFdL0pgo+p1zjbUQko3gkhEyDn5d9XvTMn+8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=B4D4u8eeJXI5Nl70Mink6mxb12B6e4e0zkGaojk9AXxixn0Z90bv5YXH8lfgqyFAd3+NFgW9WV35pThIITgnnzFX3XT27rXrcr97aArosCh7t7vm6nzvWMbLZkjndthljYm+LX17J601+D16xeSaNZAP1hEHQO6BPdojZT18w7iMT1uDzM+tZWR3JsT+OyK1uMRpMlx6vHnjLJNHrejne0aiKw5viS2XDxbXD+EJajzqS8yTiJWhPIxe6yma3U4JiGHBIEPzZFn7KEvg2Tkj7K2pDCSEnIcloH3YHql4FhwW1ITX8GXMv33MuLZi9o1hpVchNrz1zHe3fPJSUihgNg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=avPUFc4g; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=avPUFc4g;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gC4NF6CNYz2xnK
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 09 May 2026 09:00:45 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id A17156024D;
	Fri,  8 May 2026 23:00:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BBF4C2BCB0;
	Fri,  8 May 2026 23:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778281242;
	bh=oEngaZAwPI7Pm3q4uwFuvqJJYnhHy4MdMYAlYUFGwjQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=avPUFc4g1/52FD+STEoTVCWmzaJsKjBNzKgnEU+3Hn0UPRk4N7bHeZh7p6f9OpN+8
	 prH9FbfDoR9Vx9PPZJuLGQdmz3X7ulei/I9O0VCFsuNdu/pvKs7Jr8X4qlcAaR5M9k
	 rgmNOz2LRsKerr9tFAR6L9o97i4W21yLJXWx7NyXdvAcaRA5ix92PBhZVblsP7nWrw
	 KxtUhYe5iWj13tQrbCPcjqX2qoLfzupRzg93WEgmUYVsr+3eGsbW+YKg9cuY4ADtFx
	 rWxjxnHO+bJSKbdVCtClaUfBwRiM7LQwET4n3jLBCdi18llx14FFt7aQt3E3IJ7Qjv
	 jgMDmAO7kiSCA==
Date: Fri, 8 May 2026 18:00:40 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
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
	Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>,
	Lukas Wunner <lukas@wunner.de>,
	Oliver O'Halloran <oohall@gmail.com>,
	Saurabh Singh Sengar <ssengar@microsoft.com>,
	Shuan He <heshuan@bytedance.com>,
	Srivatsa Bhat <srivatsabhat@microsoft.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	linux-pci@vger.kernel.org, linux-alpha@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v7 00/24] PCI: Convert all dynamic sysfs attributes to
 static
Message-ID: <20260508230040.GA29318@bhelgaas>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260508043543.217179-1-kwilczynski@kernel.org>

On Fri, May 08, 2026 at 04:35:19AM +0000, Krzysztof Wilczyński wrote:
> Hello,
> 
> This series converts every dynamically allocated PCI sysfs attribute to
> a static const definition.  After the full series, pci_sysfs_init() and
> sysfs_initialized are gone, and every sysfs file is created by the
> driver model at device_add() time.
> 
> Currently, the PCI resource files (resourceN, resourceN_wc) and the
> legacy bus files (legacy_io, legacy_mem) are created dynamically
> from two unsynchronised paths:
> 
> Path A: late_initcall
> 
>   pci_sysfs_init()                        (late_initcall)
>     sysfs_initialized = 1
>     for_each_pci_dev()
>       pci_create_sysfs_dev_files()
>         sysfs_create_bin_file()           (resourceN, resourceN_wc)
>     pci_find_next_bus()
>       pci_create_legacy_files()
>         sysfs_create_bin_file()           (legacy_io, legacy_mem)
> 
> Path B: device registration / hotplug
> 
>   pci_bus_add_devices()
>     pci_bus_add_device()
>       pci_create_sysfs_dev_files()
>         if (!sysfs_initialized)           <- only guard
>           return
>         sysfs_create_bin_file()           (resourceN, resourceN_wc)
> 
> On most ACPI systems this does not race because PCI enumeration
> completes at subsys_initcall time, before pci_sysfs_init() runs:
> 
>   subsys_initcall (level 4):
>     acpi_pci_root_add()
>       pci_bus_add_device()
>         pci_create_sysfs_dev_files()
>           if (!sysfs_initialized)         <- variable not yet set
>             return -EACCES
> 
>   late_initcall (level 7):
>     pci_sysfs_init()
>       sysfs_initialized = 1
>       for_each_pci_dev()
>         pci_create_sysfs_dev_files()      <- creates the files, no race
> 
> On Devicetree platforms the host controller is a platform driver that
> probes via the driver model, often on a workqueue, and overlaps with the
> late_initcall:
> 
>   CPU 0 (late_initcall)                CPU 1 (driver probe)
>   ---------------------------          ----------------------------
>   pci_sysfs_init()
>     sysfs_initialized = 1
>     for_each_pci_dev()                 pci_bus_add_device()
>       pci_create_sysfs_dev_files()       pci_create_sysfs_dev_files()
>         sysfs_create_bin_file()            sysfs_create_bin_file()
>                                              -> "duplicate filename"
> 
> The same happens on ACPI when probing is asynchronous (hv_pci on
> Azure, RISC-V with ACPI).
> 
> The duplicate causes sysfs_create_bin_file() to fail with -EEXIST.
> pci_create_resource_files() then calls pci_remove_resource_files() in
> its error unwind, tearing down files the other thread created and
> still references through pdev->res_attr[].  This has caused kernel
> panics on i.MX6 and boot failures on other platforms.
> 
> Several different fixes have been proposed over the years: reordering
> the sysfs_initialized assignment, adding locks, checking
> pci_dev_is_added(), setting pdev->res_attr[] to NULL after kfree
> (which only prevents a double-free on the teardown path, not the
> error unwind removing the other thread's files).  None would address the
> root cause.
> 
> This has been reported a few times:
> 
>   - https://lore.kernel.org/linux-pci/20250702155112.40124-1-heshuan@bytedance.com/
>   - https://lore.kernel.org/linux-pci/b51519d6-ce45-4b6d-8135-c70169bd110e@h-partners.com/
>   - https://lore.kernel.org/linux-pci/1702093576-30405-1-git-send-email-ssengar@linux.microsoft.com/
>   - https://lore.kernel.org/linux-pci/SY0P300MB04687548090B73E40AF97D8897B82@SY0P300MB0468.AUSP300.PROD.OUTLOOK.COM/
>   - https://lore.kernel.org/linux-pci/20230105174736.GA1154719@bhelgaas/
>   - https://lore.kernel.org/linux-pci/m3eebg9puj.fsf@t19.piap.pl/
>   - https://lore.kernel.org/linux-pci/20200716110423.xtfyb3n6tn5ixedh@pali/
>   - https://lore.kernel.org/linux-pci/1366196798-15929-1-git-send-email-artem.savkov@gmail.com/
>   - https://bugzilla.kernel.org/show_bug.cgi?id=215515
>   - https://bugzilla.kernel.org/show_bug.cgi?id=216888
> 
> With static attributes the driver model creates sysfs entries once per
> device at device_add() time, under the device lock, eliminating the
> late_initcall iteration and the race along with it.
> 
> 	Krzysztof
> 
> ---
> Changes in v7:
>   https://lore.kernel.org/linux-pci/20260422161407.118748-1-kwilczynski@kernel.org/
> 
>   - Addded Alex Williamson (author of the resource resize sysfs
>     attributes) to the list of recipients for visibility.
>   - Split pci_llseek_resource() into pci_llseek_resource() and
>     pci_llseek_resource_legacy() since legacy attributes operate
>     on a struct pci_bus where to_pci_dev() would be invalid,
>     as per Bjorn Helgaas' feedback.
>   - Moved each llseek variant inside its respective #ifdef guard
>     during the corresponding dynamic-to-static conversion commit,
>     dropping the __maybe_unused annotations.
>   - Extended the WARN macro removal to also cover __legacy_mmap_fits().
>   - Updated commit message of patch 18, so that it correctly mentions
>     pci_stop_dev() rather than pci_stop_bus_device().
>   - Updated commit message of patch 24 to clarify the indirect
>     relationship between ReBAR and the HAVE_PCI_MMAP and/or
>     ARCH_GENERIC_PCI_MMAP_RESOURCE guards.
> 
> Changes in v6:
>   https://lore.kernel.org/linux-pci/20260416180107.777065-1-kwilczynski@kernel.org/
> 
>    - Fixed commit message for patch 13, removing reference to
>      pci_resource_flags() which was no longer changed there.
>    - Added a new patch (24) to move the BAR resource resize
>      (ReBAR) support behind existing PCI mmap #ifdef guard,
>      so that the code is not included on architectures that
>      do not support resource resizing (i.e., Alpha, etc.).
> 
> Changes in v5:
>   https://lore.kernel.org/linux-pci/20260411080148.471335-1-kwilczynski@kernel.org/
>   
>    - Added new Tested-by, Reviewed-by, and Acked-by tags.
>    - Used the existing _io function names in the static macro
>      definitions, deferring the rename to the conversion commit
>      where it belongs, to avoid a forward reference across
>      commits. This was reported by Sashiko, see:
>      https://sashiko.dev/#/patchset/20260411080148.471335-1-kwilczynski%40kernel.org?part=6
>    - Folded the __resource_resize_store() conversion into the
>      main static attributes commit so the resize path is never
>      broken between commits. This was reported by Sashiko, see:
>      https://sashiko.dev/#/patchset/20260410055040.39233-1-kwilczynski%40kernel.org?part=6
>      https://sashiko.dev/#/patchset/20260411080148.471335-1-kwilczynski%40kernel.org?part=7
>    - Dropped the unnecessary parentheses cleanup from the Alpha
>      BAR index commit, as the line is replaced two commits later
>      anyway, as per Ilpo Järvinen's feedback.
>    - Squashed the Alpha accessor macro and cleanup commits into
>      one, using pci_resource_is_mem() directly instead of the
>      intermediate pci_resource_flags() step, as per Ilpo
>      Järvinen's feedback.
>    - Moved the raw literal conversion in pci_create_legacy_files()
>      into the macro definition commit, so the macros and their
>      usage are introduced together, as per Ilpo Järvinen's
>      feedback.
>    - Removed unnecessary backslash line continuation from the
>      ternary in pci_mmap_legacy_page_range().
>    - Kept pci_resource_len() for visibility checks instead of
>      resource_assigned().  The static is_visible() callback
>      runs at device_add() time during the PCI enumeration,
>      before the pci_assign_unassigned_bus_resources() populates
>      res->parent, as such, resource_assigned() returned false
>      for every BAR, hiding all resource files.  This is related
>      to review feedback from Ilpo Järvinen.
> 
> Changes in v4:
>   https://lore.kernel.org/linux-pci/20260410055040.39233-1-kwilczynski@kernel.org/
> 
>    - Added new Reviewed-by tags.
>    - Added pci_resource_is_io() and pci_resource_is_mem() helpers
>      for resource type checks, replacing the open-coded bitwise
>      flag tests in pci_mmap_resource(), pci_resource_io(), and
>      Alpha's pci_mmap_resource(), as per Ilpo Järvinen's
>      suggestion.
>    - Split the __pci_mmap_fits() cleanup into two patches.  An
>      overflow fix for zero-length BARs, which now includes a
>      Fixes: tag referencing the original Alpha PCI sysfs commit,
>      and the WARN macro removal is a separate cleanup as per Ilpo
>      Järvinen's suggestion.
>    - Added a missing Fixes: tag to the Alpha lockdown check,
>      referencing the commit that added the check to the generic
>      path but missed Alpha's implementation.
>    - Added PCI_LEGACY_IO_SIZE and PCI_LEGACY_MEM_SIZE macros to
>      replace the raw literals used for legacy address space sizes.
>      These are used in both Alpha's pci_mmap_legacy_page_range()
>      and the static legacy attribute definitions, as per Ilpo
>      Järvinen's suggestion.
>    - Replaced sysfs_update_groups() in the BAR resize path with
>      sysfs_remove_groups() before the resize and sysfs_create_groups()
>      after, restoring the original teardown before BAR resize
>      ordering.  This was reported by Sashiko, see:
>      https://sashiko.dev/#/patchset/20260410055040.39233-1-kwilczynski%40kernel.org?part=7
>    - Defined pci_dev_resource_attr_groups as a NULL macro when
>      HAVE_PCI_MMAP and ARCH_GENERIC_PCI_MMAP_RESOURCE are both
>      absent, so the resize path compiles unconditionally without
>      #ifdef guards in the function body.  This was reported by
>      Sashiko, see:
>      https://sashiko.dev/#/patchset/20260410055040.39233-1-kwilczynski%40kernel.org?part=7
>    - Moved the pci_legacy_has_sparse() prototype into the patch
>      that introduces the function, alongside the existing
>      pci_adjust_legacy_attr() declaration, to fix a bisection
>      issue where Alpha would warn on -Wmissing-prototypes.
>      This was reported by Sashiko, see:
>      https://sashiko.dev/#/patchset/20260410055040.39233-1-kwilczynski%40kernel.org?part=18
> 
> Changes in v3:
>   https://lore.kernel.org/linux-pci/20210910202623.2293708-1-kw@linux.com/
> 
>   - Updated for modern kernel releases and expanded scope.  The
>     v2 only covered the generic resource files.  This version
>     also converts Alpha's sparse/dense resource files and the
>     legacy bus attributes, removing pci_sysfs_init() entirely.
>   - Split the single macro definition into three distinct ones
>     (per I/O, UC, and WC), to make sure that each carries only
>     the callbacks its resource type needs.
>   - Updated to use the new .bin_size callback, as the attributes
>     are const, to replace using a->size directly, which was not
>     ideal.  This required changes to pci_llseek_resource(), to
>     ensure that it would work for device and bus-level attributes.
>   - Updated the __resource_resize_store() to include CAP_SYS_ADMIN
>     capabilities check.
>   - Added the security_locked_down() check to Alpha's
>     pci_mmap_resource(), to align with other architectures.
> 
> Changes in v2:
>   https://lore.kernel.org/linux-pci/20210825212255.878043-1-kw@linux.com/
> 
>   - Refactored code so that the macros, helpers and internal
>     functions can be used to correctly leverage the read(),
>     write() and mmap() callbacks rather than to use the
>     .is_bin_visible() callback to set up sysfs objects
>     internals as this is not supported.
>   - Refactored some if-statements to check for a resource
>     flag first, and then call either arch_can_pci_mmap_io()
>     or arch_can_pci_mmap_wc(), plus store result of testing
>     for IORESOURCE_MEM and IORESOURCE_PREFETCH flags into
>     a boolean variable, as per Bjorn Helgaas' suggestion.
>   - Renamed pci_read_resource_io() and pci_write_resource_io()
>     callbacks so that these are not specifically tied to I/O
>     BARs read() and write() operations also as per Bjorn
>     Helgaas' suggestion.
>   - Updated style for code handling bitwise operations to
>     match the style that is preferred as per Bjorn Helgaas'
>     suggestion.
>   - Updated commit messages adding more details about the
>     implementation as requested by Bjorn Helgaas.
> 
> Krzysztof Wilczyński (24):
>   PCI/sysfs: Use PCI resource accessor macros
>   PCI: Add pci_resource_is_io() and pci_resource_is_mem() helpers
>   PCI/sysfs: Only allow supported resource types in I/O and MMIO helpers
>   PCI/sysfs: Split pci_llseek_resource() for device and legacy
>     attributes
>   PCI/sysfs: Add CAP_SYS_ADMIN check to __resource_resize_store()
>   PCI/sysfs: Add static PCI resource attribute macros
>   PCI/sysfs: Convert PCI resource files to static attributes
>   PCI/sysfs: Warn about BAR resize failure in __resource_resize_store()
>   PCI/sysfs: Add stubs for pci_{create,remove}_sysfs_dev_files()
>   PCI/sysfs: Limit pci_sysfs_init() late_initcall compile scope
>   alpha/PCI: Add security_locked_down() check to pci_mmap_resource()
>   alpha/PCI: Use BAR index in sysfs attr->private instead of resource
>     pointer
>   alpha/PCI: Use PCI resource accessor macros
>   alpha/PCI: Fix __pci_mmap_fits() overflow for zero-length BARs
>   alpha/PCI: Remove WARN from __pci_mmap_fits() and __legacy_mmap_fits()
>   alpha/PCI: Add static PCI resource attribute macros
>   alpha/PCI: Convert resource files to static attributes
>   PCI/sysfs: Remove pci_{create,remove}_sysfs_dev_files()
>   PCI: Add macros for legacy I/O and memory address space sizes
>   alpha/PCI: Compute legacy size in pci_mmap_legacy_page_range()
>   PCI/sysfs: Add __weak pci_legacy_has_sparse() helper
>   PCI/sysfs: Convert legacy I/O and memory attributes to static
>     definitions
>   PCI/sysfs: Remove pci_create_legacy_files() and pci_sysfs_init()
>   PCI/sysfs: Limit BAR resize attribute scope to platforms with PCI mmap
> 
>  arch/alpha/include/asm/pci.h   |  13 +-
>  arch/alpha/kernel/pci-sysfs.c  | 385 +++++++++++----------
>  arch/powerpc/include/asm/pci.h |   2 -
>  drivers/pci/bus.c              |   1 -
>  drivers/pci/pci-sysfs.c        | 592 +++++++++++++++++++--------------
>  drivers/pci/pci.h              |  16 +-
>  drivers/pci/probe.c            |   6 -
>  drivers/pci/remove.c           |   3 -
>  include/linux/pci.h            |  39 ++-
>  9 files changed, 589 insertions(+), 468 deletions(-)

Updated pci/sysfs to this series, thank you very much!  Looks great!

