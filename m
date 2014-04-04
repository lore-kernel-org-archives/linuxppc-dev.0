Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B607D1400C6
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Apr 2014 17:27:28 +1100 (EST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Fri, 4 Apr 2014 11:57:24 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 46139E004B
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Apr 2014 12:01:29 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s346REpm3277144
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Apr 2014 11:57:14 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s346RJFL027403
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Apr 2014 11:57:21 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-mm@kvack.org, linux-arch@vger.kernel.org, x86@kernel.org
Subject: [PATCH V2 0/2] FAULT_AROUND_ORDER patchset performance data for
 powerpc
Date: Fri,  4 Apr 2014 11:57:13 +0530
Message-Id: <1396592835-24767-1-git-send-email-maddy@linux.vnet.ibm.com>
Cc: riel@redhat.com, ak@linux.intel.com, peterz@infradead.org,
 rusty@rustcorp.com.au, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 paulus@samba.org, mgorman@suse.de, akpm@linux-foundation.org, mingo@kernel.org,
 kirill.shutemov@linux.intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Kirill A. Shutemov with faultaround patchset introduced
vm_ops->map_pages() for mapping easy accessible pages around
fault address in hope to reduce number of minor page faults.

This patchset creates infrastructure to move the FAULT_AROUND_ORDER
to arch/ using Kconfig. This will enable architecture maintainers
to decide on suitable FAULT_AROUND_ORDER value based on
performance data for that architecture. First patch also adds
FAULT_AROUND_ORDER Kconfig element for X86. Second patch list
out the performance numbers for powerpc (platform pseries) and
adds FAULT_AROUND_ORDER Kconfig element for powerpc.

V2 Changes:
  Created Kconfig parameter for FAULT_AROUND_ORDER
  Added check in do_read_fault to handle FAULT_AROUND_ORDER value of 0
  Made changes in commit messages.

Madhavan Srinivasan (2):
  mm: move FAULT_AROUND_ORDER to arch/
  mm: add FAULT_AROUND_ORDER Kconfig paramater for powerpc

 arch/powerpc/platforms/pseries/Kconfig |    5 +++++
 arch/x86/Kconfig                       |    4 ++++
 include/linux/mm.h                     |    9 +++++++++
 mm/memory.c                            |   12 +++++-------
 4 files changed, 23 insertions(+), 7 deletions(-)

-- 
1.7.10.4
