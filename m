Return-Path: <cody@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1031D14008F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Apr 2014 03:11:17 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cody@linux.vnet.ibm.com>;
 Tue, 15 Apr 2014 11:11:14 -0600
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 907DC6E8021
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Apr 2014 13:11:05 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp22035.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3FHBBO049021146
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Apr 2014 17:11:12 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3FHBBqh022558
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Apr 2014 13:11:11 -0400
From: Cody P Schafer <cody@linux.vnet.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH v2 0/6] powerpc/perf/hv_{gpci,24x7}: fixes
Date: Tue, 15 Apr 2014 10:10:49 -0700
Message-Id: <1397581855-4585-1-git-send-email-cody@linux.vnet.ibm.com>
Cc: Linux PPC <linuxppc-dev@lists.ozlabs.org>,
 LKML <linux-kernel@vger.kernel.org>, David.Laight@aculab.com,
 Anton Blanchard <anton@samba.org>, Cody P Schafer <cody@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

 - 24x7 and gpci probing now uses pr_debug() and doesn't pad to 80 characters
 - Catalog access is fixed for LE kernels
 - remove c99 feature sparse doesn't like
 - 1 device attr made static


Cody P Schafer (6):
  powerpc/perf/hv_24x7: probe errors changed to pr_debug(), padding
    fixed
  powerpc/perf/hv_gpci: probe failures use pr_debug(), and padding
    reduced
  powerpc/perf/hv-gpci: make device attr static
  powerpc/perf/hv-24x7: use (unsigned long) not (u32) values when
    calling plpar_hcall_norets()
  powerpc/perf/hv-24x7: remove [static 4096], sparse chokes on it
  powerpc/perf/hv-24x7: catalog version number is be64, not be32

 arch/powerpc/perf/hv-24x7.c | 30 +++++++++++++++++++++---------
 arch/powerpc/perf/hv-gpci.c |  6 +++---
 2 files changed, 24 insertions(+), 12 deletions(-)

-- 
1.9.2
