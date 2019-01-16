Return-Path: <SRS0=yyDT=PY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B42DAC43387
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 13:50:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35A21206C2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 13:50:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35A21206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43fpVr1wC3zDqf3
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 00:50:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=rppt@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43fpNZ53hkzDqL8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jan 2019 00:44:46 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 x0GDfPwI113167
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jan 2019 08:44:43 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2q23br752e-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jan 2019 08:44:43 -0500
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <rppt@linux.ibm.com>;
 Wed, 16 Jan 2019 13:44:40 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 16 Jan 2019 13:44:28 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x0GDiR5o8782174
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 16 Jan 2019 13:44:27 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 97C1452054;
 Wed, 16 Jan 2019 13:44:27 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.226])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 784FD52050;
 Wed, 16 Jan 2019 13:44:23 +0000 (GMT)
Received: by rapoport-lnx (sSMTP sendmail emulation);
 Wed, 16 Jan 2019 15:44:22 +0200
From: Mike Rapoport <rppt@linux.ibm.com>
To: linux-mm@kvack.org
Subject: [PATCH 00/21] Refine memblock API
Date: Wed, 16 Jan 2019 15:44:00 +0200
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 19011613-4275-0000-0000-000002FFFEDF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011613-4276-0000-0000-0000380E2031
Message-Id: <1547646261-32535-1-git-send-email-rppt@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-16_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=813 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901160114
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
Cc: Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org,
 devicetree@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org,
 linux-mips@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>,
 Guo Ren <guoren@kernel.org>, sparclinux@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, linux-s390@vger.kernel.org,
 linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Weinberger <richard@nod.at>, linux-sh@vger.kernel.org,
 Russell King <linux@armlinux.org.uk>, kasan-dev@googlegroups.com,
 Mike Rapoport <rppt@linux.ibm.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Mark Salter <msalter@redhat.com>, Dennis Zhou <dennis@kernel.org>,
 Matt Turner <mattst88@gmail.com>, linux-snps-arc@lists.infradead.org,
 uclinux-h8-devel@lists.sourceforge.jp, Petr Mladek <pmladek@suse.com>,
 linux-xtensa@linux-xtensa.org, linux-alpha@vger.kernel.org,
 linux-um@lists.infradead.org, linux-m68k@lists.linux-m68k.org,
 Rob Herring <robh+dt@kernel.org>, Greentime Hu <green.hu@gmail.com>,
 xen-devel@lists.xenproject.org, Stafford Horne <shorne@gmail.com>,
 Guan Xuetao <gxt@pku.edu.cn>, linux-arm-kernel@lists.infradead.org,
 Michal Simek <monstr@monstr.eu>, Tony Luck <tony.luck@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, Paul Burton <paul.burton@mips.com>,
 Vineet Gupta <vgupta@synopsys.com>, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>,
 openrisc@lists.librecores.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi,

Current memblock API is quite extensive and, which is more annoying,
duplicated. Except the low-level functions that allow searching for a free
memory region and marking it as reserved, memblock provides three (well,
two and a half) sets of functions to allocate memory. There are several
overlapping functions that return a physical address and there are
functions that return virtual address. Those that return the virtual
address may also clear the allocated memory. And, on top of all that, some
allocators panic and some return NULL in case of error.

This set tries to reduce the mess, and trim down the amount of memblock
allocation methods.

Patches 1-10 consolidate the functions that return physical address of
the allocated memory

Patches 11-13 are some trivial cleanups

Patches 14-19 add checks for the return value of memblock_alloc*() and
panics in case of errors. The patches 14-18 include some minor refactoring
to have better readability of the resulting code and patch 19 is a
mechanical addition of

	if (!ptr)
		panic();

after memblock_alloc*() calls.

And, finally, patches 20 and 21 remove panic() calls memblock and _nopanic
variants from memblock.

Christophe Leroy (1):
  powerpc: use memblock functions returning virtual address

Mike Rapoport (20):
  openrisc: prefer memblock APIs returning virtual address
  memblock: replace memblock_alloc_base(ANYWHERE) with memblock_phys_alloc
  memblock: drop memblock_alloc_base_nid()
  memblock: emphasize that memblock_alloc_range() returns a physical address
  memblock: memblock_phys_alloc_try_nid(): don't panic
  memblock: memblock_phys_alloc(): don't panic
  memblock: drop __memblock_alloc_base()
  memblock: drop memblock_alloc_base()
  memblock: refactor internal allocation functions
  memblock: make memblock_find_in_range_node() and choose_memblock_flags() static
  arch: use memblock_alloc() instead of memblock_alloc_from(size, align, 0)
  arch: don't memset(0) memory returned by memblock_alloc()
  ia64: add checks for the return value of memblock_alloc*()
  sparc: add checks for the return value of memblock_alloc*()
  mm/percpu: add checks for the return value of memblock_alloc*()
  init/main: add checks for the return value of memblock_alloc*()
  swiotlb: add checks for the return value of memblock_alloc*()
  treewide: add checks for the return value of memblock_alloc*()
  memblock: memblock_alloc_try_nid: don't panic
  memblock: drop memblock_alloc_*_nopanic() variants

 arch/alpha/kernel/core_cia.c              |   5 +-
 arch/alpha/kernel/core_marvel.c           |   6 +
 arch/alpha/kernel/pci-noop.c              |  11 +-
 arch/alpha/kernel/pci.c                   |  11 +-
 arch/alpha/kernel/pci_iommu.c             |  16 +-
 arch/alpha/kernel/setup.c                 |   2 +-
 arch/arc/kernel/unwind.c                  |   3 +-
 arch/arc/mm/highmem.c                     |   4 +
 arch/arm/kernel/setup.c                   |   6 +
 arch/arm/mm/init.c                        |   6 +-
 arch/arm/mm/mmu.c                         |  14 +-
 arch/arm64/kernel/setup.c                 |   9 +-
 arch/arm64/mm/kasan_init.c                |  10 ++
 arch/arm64/mm/mmu.c                       |   2 +
 arch/arm64/mm/numa.c                      |   4 +
 arch/c6x/mm/dma-coherent.c                |   4 +
 arch/c6x/mm/init.c                        |   4 +-
 arch/csky/mm/highmem.c                    |   5 +
 arch/h8300/mm/init.c                      |   4 +-
 arch/ia64/kernel/mca.c                    |  25 +--
 arch/ia64/mm/contig.c                     |   8 +-
 arch/ia64/mm/discontig.c                  |   4 +
 arch/ia64/mm/init.c                       |  38 ++++-
 arch/ia64/mm/tlb.c                        |   6 +
 arch/ia64/sn/kernel/io_common.c           |   3 +
 arch/ia64/sn/kernel/setup.c               |  12 +-
 arch/m68k/atari/stram.c                   |   4 +
 arch/m68k/mm/init.c                       |   3 +
 arch/m68k/mm/mcfmmu.c                     |   7 +-
 arch/m68k/mm/motorola.c                   |   9 ++
 arch/m68k/mm/sun3mmu.c                    |   6 +
 arch/m68k/sun3/sun3dvma.c                 |   3 +
 arch/microblaze/mm/init.c                 |  10 +-
 arch/mips/cavium-octeon/dma-octeon.c      |   3 +
 arch/mips/kernel/setup.c                  |   3 +
 arch/mips/kernel/traps.c                  |   5 +-
 arch/mips/mm/init.c                       |   5 +
 arch/nds32/mm/init.c                      |  12 ++
 arch/openrisc/mm/init.c                   |   5 +-
 arch/openrisc/mm/ioremap.c                |   8 +-
 arch/powerpc/kernel/dt_cpu_ftrs.c         |   8 +-
 arch/powerpc/kernel/irq.c                 |   5 -
 arch/powerpc/kernel/paca.c                |   6 +-
 arch/powerpc/kernel/pci_32.c              |   3 +
 arch/powerpc/kernel/prom.c                |   5 +-
 arch/powerpc/kernel/rtas.c                |   6 +-
 arch/powerpc/kernel/setup-common.c        |   3 +
 arch/powerpc/kernel/setup_32.c            |  26 ++--
 arch/powerpc/kernel/setup_64.c            |   4 +
 arch/powerpc/lib/alloc.c                  |   3 +
 arch/powerpc/mm/hash_utils_64.c           |  11 +-
 arch/powerpc/mm/mmu_context_nohash.c      |   9 ++
 arch/powerpc/mm/numa.c                    |   4 +
 arch/powerpc/mm/pgtable-book3e.c          |  12 +-
 arch/powerpc/mm/pgtable-book3s64.c        |   3 +
 arch/powerpc/mm/pgtable-radix.c           |   9 +-
 arch/powerpc/mm/ppc_mmu_32.c              |   3 +
 arch/powerpc/platforms/pasemi/iommu.c     |   3 +
 arch/powerpc/platforms/powermac/nvram.c   |   3 +
 arch/powerpc/platforms/powernv/opal.c     |   3 +
 arch/powerpc/platforms/powernv/pci-ioda.c |   8 +
 arch/powerpc/platforms/ps3/setup.c        |   3 +
 arch/powerpc/sysdev/dart_iommu.c          |   3 +
 arch/powerpc/sysdev/msi_bitmap.c          |   3 +
 arch/s390/kernel/crash_dump.c             |   3 +
 arch/s390/kernel/setup.c                  |  16 ++
 arch/s390/kernel/smp.c                    |   9 +-
 arch/s390/kernel/topology.c               |   6 +
 arch/s390/numa/mode_emu.c                 |   3 +
 arch/s390/numa/numa.c                     |   6 +-
 arch/s390/numa/toptree.c                  |   8 +-
 arch/sh/boards/mach-ap325rxa/setup.c      |   5 +-
 arch/sh/boards/mach-ecovec24/setup.c      |  10 +-
 arch/sh/boards/mach-kfr2r09/setup.c       |   5 +-
 arch/sh/boards/mach-migor/setup.c         |   5 +-
 arch/sh/boards/mach-se/7724/setup.c       |  10 +-
 arch/sh/kernel/machine_kexec.c            |   3 +-
 arch/sh/mm/init.c                         |   8 +-
 arch/sh/mm/numa.c                         |   4 +
 arch/sparc/kernel/prom_32.c               |   6 +-
 arch/sparc/kernel/setup_64.c              |   6 +
 arch/sparc/kernel/smp_64.c                |  12 ++
 arch/sparc/mm/init_32.c                   |   2 +-
 arch/sparc/mm/init_64.c                   |  11 ++
 arch/sparc/mm/srmmu.c                     |  18 ++-
 arch/um/drivers/net_kern.c                |   3 +
 arch/um/drivers/vector_kern.c             |   3 +
 arch/um/kernel/initrd.c                   |   2 +
 arch/um/kernel/mem.c                      |  16 ++
 arch/unicore32/kernel/setup.c             |   4 +
 arch/unicore32/mm/mmu.c                   |  15 +-
 arch/x86/kernel/acpi/boot.c               |   3 +
 arch/x86/kernel/apic/io_apic.c            |   5 +
 arch/x86/kernel/e820.c                    |   5 +-
 arch/x86/kernel/setup_percpu.c            |  10 +-
 arch/x86/mm/kasan_init_64.c               |  14 +-
 arch/x86/mm/numa.c                        |  12 +-
 arch/x86/platform/olpc/olpc_dt.c          |   3 +
 arch/x86/xen/p2m.c                        |  11 +-
 arch/xtensa/mm/kasan_init.c               |  10 +-
 arch/xtensa/mm/mmu.c                      |   3 +
 drivers/clk/ti/clk.c                      |   3 +
 drivers/firmware/memmap.c                 |   2 +-
 drivers/macintosh/smu.c                   |   5 +-
 drivers/of/fdt.c                          |   8 +-
 drivers/of/of_reserved_mem.c              |   7 +-
 drivers/of/unittest.c                     |   8 +-
 drivers/usb/early/xhci-dbc.c              |   2 +-
 drivers/xen/swiotlb-xen.c                 |   7 +-
 include/linux/memblock.h                  |  59 +------
 init/main.c                               |  26 +++-
 kernel/dma/swiotlb.c                      |  21 ++-
 kernel/power/snapshot.c                   |   3 +
 kernel/printk/printk.c                    |  17 +-
 lib/cpumask.c                             |   3 +
 mm/cma.c                                  |  10 +-
 mm/kasan/init.c                           |  10 +-
 mm/memblock.c                             | 249 ++++++++++--------------------
 mm/page_alloc.c                           |  10 +-
 mm/page_ext.c                             |   2 +-
 mm/percpu.c                               |  84 +++++++---
 mm/sparse.c                               |  25 ++-
 122 files changed, 872 insertions(+), 415 deletions(-)

-- 
2.7.4

