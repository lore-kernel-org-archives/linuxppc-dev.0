Return-Path: <hbathini@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s4NWl736RzDqRt
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Aug 2016 05:32:51 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3s4NWl2pnKz9sxR
 for <linuxppc-dev@ozlabs.org>; Thu,  4 Aug 2016 05:32:51 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u73JNeWU145880
 for <linuxppc-dev@ozlabs.org>; Wed, 3 Aug 2016 15:32:49 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24kkajh07b-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 03 Aug 2016 15:32:49 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Thu, 4 Aug 2016 05:32:45 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 5F3083578052
 for <linuxppc-dev@ozlabs.org>; Thu,  4 Aug 2016 05:32:43 +1000 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u73JWhkY27984054
 for <linuxppc-dev@ozlabs.org>; Thu, 4 Aug 2016 05:32:43 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u73JWggP006400
 for <linuxppc-dev@ozlabs.org>; Thu, 4 Aug 2016 05:32:43 +1000
Subject: [RESEND][PATCH v2 0/2] powerpc/fadump: support memory range syntax
 for fadump memory reservation
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, rusty@rustcorp.com.au,
 ebiederm@xmission.com, vgoyal@redhat.com,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
Cc: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>, kexec@lists.infradead.org,
 lkml <linux-kernel@vger.kernel.org>,
 Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Date: Thu, 04 Aug 2016 01:02:37 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <147025270324.29229.8322429758761407397.stgit@hbathini.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patchset adds support to input system memory range based memory size
for fadump reservation. The crashkernel parameter already supports such
syntax. The first patch refactors the parsing code of crashkernel parameter
for reuse. The second patch uses the newly refactored parsing code to reserve
memory for fadump based on system memory size.

---

Hari Bathini (2):
      kexec: refactor code parsing size based on memory range
      powerpc/fadump: parse fadump reserve memory size based on memory range


 arch/powerpc/kernel/fadump.c |   64 ++++++++++++++++++++++++----
 include/linux/kernel.h       |    5 ++
 kernel/kexec_core.c          |   63 ++--------------------------
 kernel/params.c              |   96 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 161 insertions(+), 67 deletions(-)
