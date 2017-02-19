Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vR2RQ5pcyzDqBV
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Feb 2017 21:04:18 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1JA3iZH063324
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Feb 2017 05:04:15 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28pkb2v5bk-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Feb 2017 05:04:14 -0500
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sun, 19 Feb 2017 03:04:13 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: akpm@linux-foundation.org, Rik van Riel <riel@surriel.com>,
 Mel Gorman <mgorman@techsingularity.net>, paulus@ozlabs.org,
 benh@kernel.crashing.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V3 0/3] Numabalancing preserve write fix
Date: Sun, 19 Feb 2017 15:33:42 +0530
Message-Id: <1487498625-10891-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

Changes form V2:
* Fix kvm crashes due to ksm not clearing savedwrite bit.

Changes from V1:
* Update the patch so that it apply cleanly to upstream.
* Add acked-by from Michael Neuling

Aneesh Kumar K.V (3):
  mm/autonuma: Let architecture override how the write bit should be
    stashed in a protnone pte.
  mm/ksm: Handle protnone saved writes when making page write protect
  powerpc/mm/autonuma: Switch ppc64 to its own implementeation of saved
    write

 arch/powerpc/include/asm/book3s/64/pgtable.h | 52 ++++++++++++++++++++++++----
 include/asm-generic/pgtable.h                | 24 +++++++++++++
 mm/huge_memory.c                             |  6 ++--
 mm/ksm.c                                     |  9 +++--
 mm/memory.c                                  |  2 +-
 mm/mprotect.c                                |  4 +--
 6 files changed, 82 insertions(+), 15 deletions(-)

-- 
2.7.4
