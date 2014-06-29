Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 564D11A005E
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Jun 2014 21:18:02 +1000 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sun, 29 Jun 2014 21:18:00 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 454562BB0040
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Jun 2014 21:17:55 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5TAtW7852363510
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Jun 2014 20:55:32 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5TBHsSD004644
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Jun 2014 21:17:54 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: agraf@suse.de, benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH 0/6] Use virtual page class key protection mechanism for
 speeding up guest page fault
Date: Sun, 29 Jun 2014 16:47:28 +0530
Message-Id: <1404040655-12076-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

With the current code we do an expensive hash page table lookup on every
page fault resulting from a missing hash page table entry. A NO_HPTE
page fault can happen due to the below reasons:

1) Missing hash pte as per guest. This should be forwarded to the guest
2) MMIO hash pte. The address against which the load/store is performed
   should be emulated as a MMIO operation.
3) Missing hash pte because host swapped out the guest page.

We want to differentiate (1) from (2) and (3) so that we can speed up
page fault due to (1). Optimizing (1) will help in improving
the overall performance because that covers a large percentage of
the page faults.

To achieve the above we use virtual page calss protection mechanism for
covering (2) and (3). For both the above case we mark the hpte
valid, but associate the page with virtual page class index 30 and 31.
The authority mask register is configured such that class index 30 and 31
will have read/write denied. The above change results in a key fault
for (2) and (3). This allows us to forward a NO_HPTE fault directly to guest
without doing the expensive hash pagetable lookup.

For the test below:

#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/mman.h>

#define PAGES (40*1024)

int main()
{
	unsigned long size = getpagesize();
	unsigned long length = size * PAGES;
	unsigned long i, j, k = 0;

	for (j = 0; j < 10; j++) {
		char *c = mmap(NULL, length, PROT_READ|PROT_WRITE,
			       MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
		if (c == MAP_FAILED) {
			perror("mmap");
			exit(1);
		}
		for (i = 0; i < length; i += size)
			c[i] = 0;

		/* flush hptes */
		mprotect(c, length, PROT_WRITE);

		for (i = 0; i < length; i += size)
			c[i] = 10;

		mprotect(c, length, PROT_READ);

		for (i = 0; i < length; i += size)
			k += c[i];

		munmap(c, length);
	}
}

Without Fix:
----------
[root@qemu-pr-host ~]# time ./pfault

real    0m8.438s
user    0m0.855s
sys     0m7.540s
[root@qemu-pr-host ~]#


With Fix:
--------
[root@qemu-pr-host ~]# time ./pfault

real    0m7.833s
user    0m0.782s
sys     0m7.038s
[root@qemu-pr-host ~]#



Aneesh Kumar K.V (6):
  KVM: PPC: BOOK3S: HV: Clear hash pte bits from do_h_enter callers
  KVM: PPC: BOOK3S: HV: Deny virtual page class key update via h_protect
  KVM: PPC: BOOK3S: HV: Remove dead code
  KVM: PPC: BOOK3S: HV: Use new functions for mapping/unmapping hpte in
    host
  KVM: PPC: BOOK3S: Use hpte_update_in_progress to track invalid hpte
    during an hpte update
  KVM: PPC: BOOK3S: HV: Use virtual page class protection mechanism for
    host fault and mmio

 arch/powerpc/include/asm/kvm_book3s_64.h |  97 +++++++++++++++++-
 arch/powerpc/include/asm/kvm_host.h      |   1 +
 arch/powerpc/include/asm/reg.h           |   1 +
 arch/powerpc/kernel/asm-offsets.c        |   1 +
 arch/powerpc/kvm/book3s_64_mmu_hv.c      |  99 ++++++++++++------
 arch/powerpc/kvm/book3s_hv.c             |   1 +
 arch/powerpc/kvm/book3s_hv_rm_mmu.c      | 166 +++++++++++++++++++++----------
 arch/powerpc/kvm/book3s_hv_rmhandlers.S  | 100 +++++++++++++++++--
 8 files changed, 371 insertions(+), 95 deletions(-)

-- 
1.9.1
