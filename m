Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp03.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2CC01B6FA1
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Nov 2011 02:13:47 +1100 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Tue, 15 Nov 2011 15:08:42 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 pAFFANxW2912280
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Nov 2011 02:10:28 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pAFFDT75010212
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Nov 2011 02:13:29 +1100
Subject: [RFC PATCH v5 0/9] fadump: Firmware-assisted dump support for Powerpc.
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Linux Kernel <linux-kernel@vger.kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Tue, 15 Nov 2011 20:43:24 +0530
Message-ID: <20111115151145.16533.16384.stgit@mars.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Anton Blanchard <anton@samba.org>, Amerigo Wang <amwang@redhat.com>,
 Kexec-ml <kexec@lists.infradead.org>, Milton Miller <miltonm@bga.com>,
 Randy Dunlap <rdunlap@xenotime.net>,
 "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi All,

Please find the version 5 of the patchset that implements firmware-assisted
dump mechanism to capture kernel crash dump for Powerpc architecture. The
firmware-assisted dump is a robust mechanism to get reliable kernel crash
dump with assistance from firmware. This approach does not use kexec, instead
firmware assists in booting the kdump kernel while preserving memory contents.

Change in v5:
-------------
- Added 'fadump_' prefix to all static functions defined.

patch 02/10:
- Merged patch 10/10 which introduces a config option CONFIG_FA_DUMP
  for firmware assisted dump feature on Powerpc (ppc64) architecture.
- Increased MIN_BOOT_MEM by 64M to avoid OOM issue during network
  dump capture. When kdump infrastructure is configured to save vmcore
  over network, we run into OOM issue while loading modules related to
  network setup.

Changes in v4:
--------------
patch 04/10:
- Move the init_elfcore_header() function and 'memblock_num_regions' macro
 from generic code to power specific code as these are used only by
 firmware assisted dump implementation which is power specific feature.

patch 05/10:
- Fixes a issue where memblock_free() is invoked from build_cpu_notes()
  function during error_out path. Invoke cpu_notes_buf_free() in error_out
  path instead of memblock_free().

Changes in v3:
-------------
- Re-factored the implementation to work with kdump service start/stop.
  Introduce fadump_registered sysfs control file which will be used by
  kdump init scripts to start/stop firmware assisted dump. echo 1 to
  /sys/kernel/fadump_registered file for fadump registration and
  echo 0 to /sys/kernel/fadump_registered file for fadump un-registration.
- Introduced the locking mechanism to handle simultaneous writes to
  sysfs control files fadump_registered and fadump_release_mem

  Affected patches are: 01/10, 03/10, 08/10.

Changes in v2:
-------------
patch 01/10:
- Modified the documentation to reflect the change of fadump_region
  file under debugfs filesystem.

patch 02/10:
- Modified to use standard pr_debug() macro.
- Modified early_init_dt_scan_fw_dump() to get the size of
  "ibm,configure-kernel-dump-sizes" property and use it to iterate through
  an array of dump sections.
- Introduced boot option 'fadump_reserve_mem=' to let user specify the
  fadump boot memory to be reserved.

patch 03/10:
- Removed few debug print statements.
- Moved the setup_fadump() call from setup_system() and now calling it
  subsys_initcall.
- Moved fadump_region attribute under debugfs.
- Clear the TCE entries if firmware assisted dump is active.

patch 05/10:
- Moved the crash_fadump() invocation from generic code to panic notifier.
- Introduced cpu_notes_buf_alloc() function to allocate cpu notes buffer
  using get_free_pages().

patch 08/10:
- Introduced cpu_notes_buf_free() function to free memory allocated for
  cpu notes buffer.

The most of the code implementation has been adapted from phyp assisted dump
implementation written by Linas Vepstas and Manish Ahuja.

The first patch is a documentation that talks about firmware-assisted dump
mechanism, implementation details and TODO list.

I have tested the patches on following system configuration:
1. LPAR on Power6 with 4GB RAM and 8 CPUs
2. LPAR on Power7 with 2GB RAM and 20 CPUs
3. LPAR on Power7 with 1TB RAM and 896 CPUs

These patches cleanly apply on commit c3b92c878 in linux-2.6 git tree.

Please review the patchset and let me know your comments.

Thanks,
-Mahesh.
---

Mahesh Salgaonkar (9):
      fadump: Add documentation for firmware-assisted dump.
      fadump: Reserve the memory for firmware assisted dump.
      fadump: Register for firmware assisted dump.
      fadump: Initialize elfcore header and add PT_LOAD program headers.
      fadump: Convert firmware-assisted cpu state dump data into elf notes.
      fadump: Add PT_NOTE program header for vmcoreinfo
      fadump: Introduce cleanup routine to invalidate /proc/vmcore.
      fadump: Invalidate registration and release reserved memory for general use.
      fadump: Invalidate the fadump registration during machine shutdown.


 Documentation/powerpc/firmware-assisted-dump.txt |  243 ++++
 arch/powerpc/Kconfig                             |   13 
 arch/powerpc/include/asm/fadump.h                |  216 ++++
 arch/powerpc/kernel/Makefile                     |    1 
 arch/powerpc/kernel/fadump.c                     | 1316 ++++++++++++++++++++++
 arch/powerpc/kernel/iommu.c                      |    8 
 arch/powerpc/kernel/prom.c                       |   15 
 arch/powerpc/kernel/setup-common.c               |   14 
 arch/powerpc/kernel/traps.c                      |    3 
 arch/powerpc/mm/hash_utils_64.c                  |   11 
 fs/proc/vmcore.c                                 |   23 
 11 files changed, 1861 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/powerpc/firmware-assisted-dump.txt
 create mode 100644 arch/powerpc/include/asm/fadump.h
 create mode 100644 arch/powerpc/kernel/fadump.c

-- 
Signature
