Return-Path: <vaishali.thakkar@oracle.com>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qVTsR3VcDzDq6W
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Mar 2016 23:49:15 +1100 (AEDT)
From: Vaishali Thakkar <vaishali.thakkar@oracle.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 n-horiguchi@ah.jp.nec.com, mike.kravetz@oracle.com,
 hillf.zj@alibaba-inc.com, mhocko@suse.com,
 baiyaowei@cmss.chinamobile.com, dingel@linux.vnet.ibm.com,
 kirill.shutemov@linux.intel.com, dave.hansen@linux.intel.com,
 paul.gortmaker@windriver.com, catalin.marinas@arm.com,
 will.deacon@arm.com, cmetcalf@ezchip.com,
 linux-arm-kernel@lists.infradead.org, james.hogan@imgtec.com,
 linux-metag@vger.kernel.org, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
 Vaishali Thakkar <vaishali.thakkar@oracle.com>
Subject: [PATCH v2 0/6] mm/hugetlb: Fix commandline parsing behavior for
 invalid hugepagesize
Date: Wed, 23 Mar 2016 17:37:18 +0530
Message-Id: <1458734844-14833-1-git-send-email-vaishali.thakkar@oracle.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Current code fails to ignore the 'hugepages=' parameters when unsupported
hugepagesize is specified. With this patchset, introduce new architecture
independent routine hugetlb_bad_size to handle such command line options.
And then call it in architecture specific code.

Changes since v1:
	- Separated different architecture specific changes in different
	  patches
	- CC'ed all arch maintainers

Vaishali Thakkar (6):
  mm/hugetlb: Introduce hugetlb_bad_size
  arm64: mm: Use hugetlb_bad_size
  metag: mm: Use hugetlb_bad_size
  powerpc: mm: Use hugetlb_bad_size
  tile: mm: Use hugetlb_bad_size
  x86: mm: Use hugetlb_bad_size

 arch/arm64/mm/hugetlbpage.c   |  1 +
 arch/metag/mm/hugetlbpage.c   |  1 +
 arch/powerpc/mm/hugetlbpage.c |  6 ++++--
 arch/tile/mm/hugetlbpage.c    |  7 ++++++-
 arch/x86/mm/hugetlbpage.c     |  1 +
 include/linux/hugetlb.h       |  1 +
 mm/hugetlb.c                  | 14 +++++++++++++-
 7 files changed, 27 insertions(+), 4 deletions(-)

-- 
2.1.4
