Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7746606A319
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Oct 2026 20:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=relay header.b=c++a3WoG
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j91KD0JTsz30FB;
	Thu, 22 Oct 2026 07:36:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=130.117.225.111
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792614991;
	cv=none; b=g1y9pNmavoOUcz9tgfcYV6YyCi2YpLGliOh3KyUzFwPYJIX7NutMwrCizCxcfI2KPTzFiHxSHkPRer50rWhWZvDyIiVVcNWl6NXQDeOyDTy4WFeWZJajjFpxttRjYYG8Niuouvt7IW1nUa6IJrU/91CF01Sj5dDdGBjiqAl7NvQ4F/0Yo+w3NHPnx7FMZGa9LbvfvzrTkv/RBvy6Vzh/TIdt71Ln4d+zVue9tQIe+WbrCBhJvsRAfNRwMZY/iZhKgzcca4b6Ii+JFAR3x8XaDaXjUZyBExB1IGj+fDIiA1pftc9B/2DZ8cBpZCc2M0cRENqkopQ9QjfyC0xfV3t7LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792614991; c=relaxed/relaxed;
	bh=SkBadjVnsGm/Cfkqv5O4o3qsifVGUnFLyHutFvjWljA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mwyJ3VnqJIBZMSlMgIvVWpfsx2IpjABImKtguIaFgzQptaUbGWOFQadhYNzZBd21hfeKRK5KOazT0tsew6MomsDJ9ZMzxDV1HZ0WQL/+MiT80F5PPhsuBSb9d9NNvGe604ISjPIodHRZC017wHEFVrTTE/EYViJnGpkTFxFVhC/0/aCZQQ+NVpiNWc48mY9wpmY1rFFPqf9BMrtY4dhzxlGAhGD62d95eaGwGgGpUDjdTOu+PKNN0JxbTrpTZUHDtdDJrp/Xdf100S9Wk7Ov90MdFnpAvt5b81uOiGZ5ZG2QtmyoHM8grolEnLmJfucfvFv/5LUn15+VSY2O8JX+yg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; dkim=pass (2048-bit key; secure) header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=relay header.b=c++a3WoG; dkim-atps=neutral; spf=pass (client-ip=130.117.225.111; helo=relay.virtuozzo.com; envelope-from=khorenko@virtuozzo.com; receiver=lists.ozlabs.org) smtp.mailfrom=virtuozzo.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=relay header.b=c++a3WoG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=virtuozzo.com (client-ip=130.117.225.111; helo=relay.virtuozzo.com; envelope-from=khorenko@virtuozzo.com; receiver=lists.ozlabs.org)
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j91K64bPNz2xS5
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Oct 2026 07:36:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Message-Id:Date:Subject
	:From; bh=SkBadjVnsGm/Cfkqv5O4o3qsifVGUnFLyHutFvjWljA=; b=c++a3WoGLnnxuoiilN5
	/sjDXakMgea2pz/KZ1Q1A+gCeSKQYXfA5yE0yRraI+yEDkkJ5mfqYlNKg/rVEDbaIRwqXh6Mxgkz4
	DBIxQ5u0GbNFgHGMOAJQCzw6hlWxoKZqYFyOyqVpVix00u+mLrsUDZZ+azDjoBUsAlLYP6qa51pRU
	eLaNEmm/CILy72hm7gSVbKvgSgytmK2yvLMLsCGeoQWhbjjW0Avh7bPSQh0sawkppdr27Xo06bOng
	fe2nfZJBt3dJrOOnn4PYwDFMXcC2C2lLvnuZZGj4w+HHN87ZprkP0MrbUCr/j2UE1bWiW+EAMrnER
	ZWrcmR15NykVg5w==;
Received: from ch-demo-asa.virtuozzo.com ([130.117.225.8] helo=f0.sw.ru)
	by relay.virtuozzo.com with esmtp (Exim 4.96)
	(envelope-from <khorenko@virtuozzo.com>)
	id 1xJcz4-00D9zC-0I;
	Wed, 21 Oct 2026 22:36:08 +0200
From: Konstantin Khorenko <khorenko@virtuozzo.com>
Subject: [PATCH v4 0/4] mm/huge_memory: copy PMDs at fork like the PTE path
 does
Date: Wed, 21 Oct 2026 22:35:59 +0200
Message-Id: <20261021-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v4-0-66f00b7a564c@virtuozzo.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC8i2WoC/62PQU7DMBBFr1J5zaCM4ziGFfdAqIon48ZAa8tOL
 NoqdycuS9jR5Rt9/ffnKjInz1k8764icfHZh9MG6mEnaBpOBwY/bixkIzU2qMAqiIkjlDyHBKi
 ejOqBQjzvp+XA+3gcITFNTB+QI5MfPqHe7Oh6dlajJCm28q3D+a+b+PXth/Ni35nmaquJyVfD+
 basYM39e0RBQBil7Eg3llrUL8WneQmXS3ikcBR1SJH3UUlogLFTRhnjBm3+UrX3UbWbynQ8MBm
 Fvfv11bqu36n68PXoAQAA
X-Change-ID: 20261014-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-bdf7efb612c2
To: Andrew Morton <akpm@linux-foundation.org>, 
 "David Hildenbrand (Arm)" <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Peter Xu <peterx@redhat.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org, 
 =?utf-8?q?Lo=C3=AFc_Molinari?= <loic.molinari@collabora.com>, 
 Lorenzo Stoakes <ljs@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 linux-kselftest@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, Konstantin Khorenko <khorenko@virtuozzo.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=14422;
 i=khorenko@virtuozzo.com; h=from:subject:message-id;
 bh=oxm4DZDC7OL+XA002Vn3zOZkBTsPZLRHcINBFLYg7eI=;
 b=owEBbQKS/ZANAwAKAVGWCkf5YVwqAcsmYgBq2SI3epu9ry1vn3PeuyAI1HwHYQq4AVNqlPnKx
 FGZNxhlxCOJAjMEAAEKAB0WIQRWD23IPcXT0GO9CCxRlgpH+WFcKgUCatkiNwAKCRBRlgpH+WFc
 Kng0EACX2BERX8JeB8VBgcSLAA/ydig13pYo/mu9e+tFpjGUIYeNhnGq53vzeLOSdihIbaI6rrz
 ALSmrjCltvWijaN+TxzUNFXKrCvcfpk/2NdT0woHht7Bkaua6RN3XjKKVvi19xqWPDvTn6axL8i
 fdL1ebvoh0Muu44uoL6W2uKH666RjqiLYnvtx4CNNiqc//9jZNI+gmK+9a1olxyIyx42chF1dFf
 RAVJvDSXawmsYBwtOgjH8BE9LfvZHh0x0H0TjhTo+h/6l5DS7P0QVHTcuZzW+LBdPGupZ7vq5+7
 o/wC3jXq8temnCq7/BTH8QrVH2aitN7p27xGuq80/QW/SGeiqK4Gj0JdJwEr5QqqoiHiitaMJqC
 WucybDbMNfaa6yW/3vejCswRrvindUaUdTL2/U6aYsORmYbLES++oq17vj0db/qzOsZc5mjhytK
 wdNr7AqlYNkT9eb7fGptRMKm4FaUnGY4XAzJVz4AvAWDNlS5AzJcBof5qvzRbI+x3xOdjfaYFeS
 GXj2otHX8yI+drXFKixAldFEQC4FKAFPOCEmcSgyZSvK4eRDxQ0Na/9Ix/40C11Q9E0o3dYZ2my
 ggvJltf0hWaQnRxHOI7W5X85/pfT4a6whraPs26r8Ukg0s7yTCC2QCnjcYUOnsQX0fLjrjvsAUC
 TuUBCWuHZdycYrg==
X-Developer-Key: i=khorenko@virtuozzo.com; a=openpgp;
 fpr=560F6DC83DC5D3D063BD082C51960A47F9615C2A
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

copy_huge_pmd() decides what to copy at fork by its own rules, apart
from copy_present_ptes(): a lockless check for special PMDs, and a skip
of every file THP. Following David's review of v3, this series makes it
decide the way the PTE path does, under the page table lock, with
vm_normal_page_pmd(). That fixes the two bugs v1-v3 were about. The
patches:

1. folio_dup_file_rmap_pmd() duplicated a PMD mapping as HPAGE_PMD_NR
   PTE mappings. It had no caller until patch 2.
2. File THPs are copied at fork instead of being refaulted by the
   child, as their PTEs would be.
3. The special-PMD read moves under the lock. That closes the race with
   a driver zap (vfio-pci, panthor) and the missing page table deposit
   on ppc64 hash that Sashiko found in v1.
4. A selftest for 1 and 2.

Stable
======

The race (since v6.12) and the ppc64 hash NULL deref (since v7.1) are
fixed in patch 3, which only works on top of the copy rework in patch
2. If you want them in stable on their own, I can put a minimal fix in
front instead: take the locks before the special-PMD check, keep the
early return for VMAs without VM_PFNMAP or VM_MIXEDMAP, and deposit a
table where the architecture needs one, with the rework on top. Is
that worth it?

A related refcount bug in copy_huge_pud() for device DAX is fixed in
a separate series, as it does not depend on this one:
https://patch.msgid.link/20261021-vstor-150143-copy_huge_pud-folio-refcount-v1-0-8bd88551f9be@virtuozzo.com

Testing
=======

All on v7.3-rc7 in a KVM guest with 4 vCPUs, x86_64.

Race with a driver zap. The guest's QXL device is bound to vfio-pci in
no-IOMMU mode, BAR0 of 64 MB mapped with PMDs. The reproducer below
forks while a second thread clears PCI_COMMAND_MEMORY through the vfio
config region after a random delay of up to 1 ms; the child waits for
the write to finish and reads one byte of each 2 MB of the BAR. A child
that reads anything without SIGBUS kept a stale mapping. I have not hit
it without help, so a test-only debugfs knob adds an mdelay(2) between
copy_pmd_range()'s lockless pmd_is_huge() and the PMD locks:

  kernel                  delay   forks   stale children
  7.3-rc7                 none    20900   0
  7.3-rc7                 2 ms    150     128
  7.3-rc7 + this series   none    3000    0
  7.3-rc7 + this series   2 ms    400     0

ppc64 hash is not tested on hardware. On x86 a test-only hack makes
arch_needs_pgtable_deposit() true and mremap move the table, as on
ppc64 hash. Without the series the first child of the reproducer oopses
at exit in pgtable_trans_huge_withdraw(); with it the reproducer and
the selftests below pass.

Selftests, with CONFIG_DEBUG_VM:

- fork_file_thp (patch 4) skips on 7.3-rc7, where fork leaves file
  THPs to a refault, and fails on patches 2-3 without patch 1, where
  ShmemPmdMapped drops when the child exits and the kernel reports
  "Bad page cache";
- cow, guard-regions, uffd-unit-tests, uffd-wp-mremap,
  split_huge_page_test, mremap_test, soft-dirty, pagemap_ioctl,
  migration, madv_populate, transhuge-stress and khugepaged pass as on
  7.3-rc7.

Cost
====

fork() now copies file THPs instead of leaving them to a refault, which
costs fork() a reference, an rmap update and a counter per huge PMD and
saves the child a fault per huge PMD it touches. fork() of a process
with 4 GB of shmem THPs mapped MAP_PRIVATE and an anon_vma on the VMA,
medians of 2000 forks:

  kernel                  fork()        fork(), child reads all
  7.3-rc7                 86-129 us     2380-2620 us
  7.3-rc7 + this series   230-355 us    820-930 us

Notes
=====

- drm_gem_shmem and mshv_vtl map special PMDs with
  vmf_insert_pfn_pmd() as well.
- copy_huge_pud() still differs from the PMD tail in that it does not
  mark a shared PUD clean in the child or handle uffd bits.

Reproducer. It writes the BAR as a control and reads it with the
memory disabled, which is harmless for QXL VRAM in a guest; do not
point it at a BAR that holds device registers. Build with
  gcc -O2 -pthread -o fork_revoke fork_revoke.c

run as root with the device bound to vfio-pci; arguments: BDF,
iterations, BAR index, max revoke delay in microseconds, e.g.
  ./fork_revoke 0000:00:02.0 100 0 3000

    // SPDX-License-Identifier: GPL-2.0
    /*
     * Fork while vfio-pci revokes a BAR mapped with huge PMDs.
     *
     * The parent maps a BAR of a vfio-pci device and faults it in. A second
     * thread disables the device memory through the command register, which
     * makes vfio-pci zap all BAR mappings, while the main thread forks. Once
     * the memory is disabled, every access to the BAR must raise SIGBUS. A
     * child that can still read a BAR chunk kept a mapping the zap removed.
     *
     * usage: fork_revoke <domain:bus:dev.fn> [iterations [bar [max_delay_us]]]
     *
     * The revoke starts after a random delay of up to max_delay_us, so that it
     * lands at different points of fork.
     */
    #define _GNU_SOURCE
    #include <errno.h>
    #include <fcntl.h>
    #include <limits.h>
    #include <pthread.h>
    #include <sched.h>
    #include <setjmp.h>
    #include <signal.h>
    #include <stdint.h>
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include <unistd.h>
    #include <sys/ioctl.h>
    #include <sys/mman.h>
    #include <sys/wait.h>
    #include <linux/pci_regs.h>
    #include <linux/vfio.h>

    #define SZ_2M	(2UL << 20)

    static int dev;
    static off_t cfg_off;
    static int go_pipe[2], done_pipe[2];
    static volatile uint32_t *shared;	/* [0]: iteration whose revoke finished */
    static unsigned long iter;
    static unsigned int max_delay_us;
    static sigjmp_buf jb;

    static void die(const char *what)
    {
    	fprintf(stderr, "%s: %s\n", what, strerror(errno));
    	exit(2);
    }

    static int device_fd(const char *bdf)
    {
    	char path[PATH_MAX], link[PATH_MAX], *group_id;
    	int container, group, noiommu;
    	ssize_t len;

    	snprintf(path, sizeof(path), "/sys/bus/pci/devices/%s/iommu_group", bdf);
    	len = readlink(path, link, sizeof(link) - 1);
    	if (len < 0)
    		die("iommu_group");
    	link[len] = 0;
    	group_id = strrchr(link, '/') + 1;
    	snprintf(path, sizeof(path), "/dev/vfio/%s", group_id);
    	noiommu = access(path, F_OK);
    	if (noiommu)
    		snprintf(path, sizeof(path), "/dev/vfio/noiommu-%s", group_id);
    	container = open("/dev/vfio/vfio", O_RDWR);
    	group = open(path, O_RDWR);
    	if (container < 0 || group < 0)
    		die(path);
    	if (ioctl(group, VFIO_GROUP_SET_CONTAINER, &container) ||
    	    ioctl(container, VFIO_SET_IOMMU,
    		  noiommu ? VFIO_NOIOMMU_IOMMU : VFIO_TYPE1v2_IOMMU))
    		die("vfio container");
    	return ioctl(group, VFIO_GROUP_GET_DEVICE_FD, bdf);
    }

    static void set_memory(int on)
    {
    	uint16_t cmd;

    	if (pread(dev, &cmd, 2, cfg_off + PCI_COMMAND) != 2)
    		die("read PCI_COMMAND");
    	cmd = on ? cmd | PCI_COMMAND_MEMORY : cmd & ~PCI_COMMAND_MEMORY;
    	if (pwrite(dev, &cmd, 2, cfg_off + PCI_COMMAND) != 2)
    		die("write PCI_COMMAND");
    }

    static void *revoker(void *arg)
    {
    	unsigned long i;

    	while (read(go_pipe[0], &i, sizeof(i)) == sizeof(i)) {
    		if (max_delay_us)
    			usleep(random() % max_delay_us);
    		set_memory(0);
    		shared[0] = i;
    		if (write(done_pipe[1], &i, sizeof(i)) != sizeof(i))
    			die("done pipe");
    	}
    	return NULL;
    }

    static void sigbus(int sig)
    {
    	siglongjmp(jb, 1);
    }

    /* Number of 2MB chunks of the BAR that can be read without SIGBUS. */
    static unsigned long readable(volatile uint8_t *bar, size_t size)
    {
    	volatile unsigned long n = 0;
    	volatile size_t off;

    	for (off = 0; off < size; off += SZ_2M) {
    		if (sigsetjmp(jb, 1))
    			continue;
    		(void)bar[off];
    		n++;
    	}
    	return n;
    }

    int main(int argc, char **argv)
    {
    	unsigned long iterations = argc > 2 ? strtoul(argv[2], NULL, 0) : 1000;
    	unsigned int index = argc > 3 ? atoi(argv[3]) : 0;
    	struct vfio_region_info cfg = { .argsz = sizeof(cfg),
    					.index = VFIO_PCI_CONFIG_REGION_INDEX };
    	struct vfio_region_info bar = { .argsz = sizeof(bar), .index = index };
    	unsigned long stale_children = 0, stale_chunks = 0, n;
    	volatile uint8_t *map;
    	pthread_t thread;
    	size_t size, off;
    	uint8_t *resv;
    	int status;
    	pid_t pid;

    	if (argc < 2) {
    		fprintf(stderr, "usage: %s <bdf> [iterations [bar [max_delay_us]]]\n",
    			argv[0]);
    		return 2;
    	}
    	max_delay_us = argc > 4 ? atoi(argv[4]) : 0;
    	signal(SIGBUS, sigbus);
    	dev = device_fd(argv[1]);
    	if (dev < 0)
    		die("device fd");
    	if (ioctl(dev, VFIO_DEVICE_GET_REGION_INFO, &cfg) ||
    	    ioctl(dev, VFIO_DEVICE_GET_REGION_INFO, &bar))
    		die("region info");
    	if (!(bar.flags & VFIO_REGION_INFO_FLAG_MMAP) || bar.size < SZ_2M) {
    		fprintf(stderr, "BAR %u: no mmap or smaller than 2MB\n", index);
    		return 2;
    	}
    	cfg_off = cfg.offset;
    	size = bar.size & ~(SZ_2M - 1);

    	/* A 2MB aligned address lets vfio-pci map the BAR with huge PMDs. */
    	resv = mmap(NULL, size + SZ_2M, PROT_NONE,
    		    MAP_PRIVATE | MAP_ANONYMOUS | MAP_NORESERVE, -1, 0);
    	if (resv == MAP_FAILED)
    		die("reserve");
    	resv = (uint8_t *)(((uintptr_t)resv + SZ_2M - 1) & ~(SZ_2M - 1));
    	map = mmap(resv, size, PROT_READ | PROT_WRITE, MAP_SHARED | MAP_FIXED,
    		   dev, bar.offset);
    	if (map == MAP_FAILED)
    		die("mmap BAR");
    	shared = mmap(NULL, 4096, PROT_READ | PROT_WRITE,
    		      MAP_SHARED | MAP_ANONYMOUS, -1, 0);
    	if (shared == MAP_FAILED)
    		die("shared page");

    	/* Control: without a revoke the child reads what the parent wrote. */
    	set_memory(1);
    	for (off = 0; off < size; off += SZ_2M)
    		map[off] = (uint8_t)(off / SZ_2M) ^ 0x5a;
    	pid = fork();
    	if (!pid) {
    		for (off = 0; off < size; off += SZ_2M)
    			if (map[off] != ((uint8_t)(off / SZ_2M) ^ 0x5a))
    				_exit(1);
    		_exit(0);
    	}
    	if (pid < 0 || waitpid(pid, &status, 0) != pid ||
    	    !WIFEXITED(status) || WEXITSTATUS(status)) {
    		fprintf(stderr, "control: child does not see the parent's BAR\n");
    		return 2;
    	}
    	printf("BAR %u: %zu MB, %lu iterations, revoke delay < %u us\n",
    	       index, size >> 20, iterations, max_delay_us);

    	/* Premise: with the memory disabled the BAR cannot be read. */
    	set_memory(0);
    	n = readable(map, size);
    	set_memory(1);
    	if (n) {
    		fprintf(stderr, "memory disabled, parent still reads %lu chunks\n", n);
    		return 2;
    	}

    	if (pipe(go_pipe) || pipe(done_pipe))
    		die("pipe");
    	if (pthread_create(&thread, NULL, revoker, NULL))
    		die("thread");

    	for (iter = 1; iter <= iterations; iter++) {
    		set_memory(1);
    		for (off = 0; off < size; off += SZ_2M)
    			(void)map[off];
    		if (write(go_pipe[1], &iter, sizeof(iter)) != sizeof(iter))
    			die("go pipe");
    		pid = fork();
    		if (pid < 0)
    			die("fork");
    		if (!pid) {
    			while (shared[0] != iter)
    				sched_yield();
    			n = readable(map, size);
    			_exit(n > 255 ? 255 : n);
    		}
    		if (read(done_pipe[0], &n, sizeof(n)) != sizeof(n))
    			die("done pipe");
    		if (waitpid(pid, &status, 0) != pid || !WIFEXITED(status))
    			die("child");
    		if (WEXITSTATUS(status)) {
    			stale_children++;
    			stale_chunks += WEXITSTATUS(status);
    		}
    	}
    	set_memory(1);
    	printf("children with a stale BAR mapping: %lu of %lu (%lu 2MB chunks)\n",
    	       stale_children, iterations, stale_chunks);
    	return stale_children ? 1 : 0;
    }

Assisted-by: LLM
Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
---
Changes in v4:
- Rework after David's review: copy_huge_pmd() decides under the PTL
  with vm_normal_page_pmd(), like copy_present_ptes(), and copies file
  THPs (patches 2, 3). The pmd_none() recheck and the separate deposit
  patch are gone.
- New patch 1: fix folio_dup_file_rmap_pmd(), whose first caller is
  patch 2.
- New selftest, patch 4.
- Move Assisted-by from the patches to the cover letter, after commit
  1e035297ffdad ("docs: remove Assisted-by references").
- Link to v3: https://patch.msgid.link/20261014-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v3-0-85eaec8417f6@virtuozzo.com

Changes in v3:
- Patch 1: recheck the PMD with pmd_none(), as only a zap can change
  it and a zap leaves it none (Lance Yang).
- Link to v2: https://patch.msgid.link/20261014-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v2-0-e1548488fa68@virtuozzo.com

Changes in v2:
- Add patch 2, the page table deposit for ppc64 hash, reported by
  Sashiko.
- Patch 1: name panthor instead of drm_gem_shmem as the driver whose
  stale child mapping reaches freed pages: drm_gem_shmem keeps the
  pages of a purged object until the last mapping goes away.
- Link to v1: https://patch.msgid.link/20261014-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v1-1-d225c60bc316@virtuozzo.com

---
Konstantin Khorenko (4):
      mm/rmap: duplicate a PMD mapping as one in folio_dup_file_rmap_pmd()
      mm/huge_memory: copy file THPs at fork like copy_present_ptes() does
      mm/huge_memory: read a special PMD under the lock in copy_huge_pmd()
      selftests/mm: test fork of PMD-mapped shmem THPs

 MAINTAINERS                                |   1 +
 include/linux/rmap.h                       |   2 +-
 mm/huge_memory.c                           |  82 +++++------
 tools/testing/selftests/mm/Makefile        |   1 +
 tools/testing/selftests/mm/fork_file_thp.c | 227 +++++++++++++++++++++++++++++
 tools/testing/selftests/mm/run_vmtests.sh  |   1 +
 6 files changed, 270 insertions(+), 44 deletions(-)
---
base-commit: a804c5742bff224d4cb4d25dd383554d598be32b
change-id: 20261014-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-bdf7efb612c2

Best regards,
--  
Konstantin Khorenko,
Virtuozzo Linux Kernel Team


