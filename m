Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vMrf1702xzDq8M
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 16:32:25 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1E5SmNP139611
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 00:32:23 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28kjhyuvxq-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 00:32:23 -0500
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 13 Feb 2017 22:32:22 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: akpm@linux-foundation.org, Rik van Riel <riel@surriel.com>,
 Mel Gorman <mgorman@techsingularity.net>, paulus@ozlabs.org,
 benh@kernel.crashing.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V2 0/2] Numabalancing preserve write fix
Date: Tue, 14 Feb 2017 11:01:52 +0530
Message-Id: <1487050314-3892-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch series address an issue w.r.t THP migration and autonuma
preserve write feature. migrate_misplaced_transhuge_page() cannot deal with
concurrent modification of the page. It does a page copy without
following the migration pte sequence. IIUC, this was done to keep the
migration simpler and at the time of implemenation we didn't had THP
page cache which would have required a more elaborate migration scheme.
That means thp autonuma migration expect the protnone with saved write
to be done such that both kernel and user cannot update
the page content. This patch series enables archs like ppc64 to do that.
We are good with the hash translation mode with the current code,
because we never create a hardware page table entry for a protnone pte. 

Changes from V1:
* Update the patch so that it apply cleanly to upstream.
* Add acked-by from Michael Neuling

Aneesh Kumar K.V (2):
  mm/autonuma: Let architecture override how the write bit should be
    stashed in a protnone pte.
  powerpc/mm/autonuma: Switch ppc64 to its own implementeation of saved
    write

 arch/powerpc/include/asm/book3s/64/mmu-hash.h |  3 +++
 arch/powerpc/include/asm/book3s/64/pgtable.h  | 32 +++++++++++++++++++++++++--
 include/asm-generic/pgtable.h                 | 16 ++++++++++++++
 mm/huge_memory.c                              |  4 ++--
 mm/memory.c                                   |  2 +-
 mm/mprotect.c                                 |  4 ++--
 6 files changed, 54 insertions(+), 7 deletions(-)

-- 
2.7.4
