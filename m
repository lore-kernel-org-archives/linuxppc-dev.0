Return-Path: <hbathini@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rZZLG0C8HzDqlD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jun 2016 05:25:10 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rZZLF3wDXz9t0N
 for <linuxppc-dev@ozlabs.org>; Thu, 23 Jun 2016 05:25:09 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5MJObiB090352
 for <linuxppc-dev@ozlabs.org>; Wed, 22 Jun 2016 15:25:08 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23qq3k6hsp-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 22 Jun 2016 15:25:07 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Thu, 23 Jun 2016 05:25:05 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 267263578053
 for <linuxppc-dev@ozlabs.org>; Thu, 23 Jun 2016 05:25:02 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5MJP1Lg7274842
 for <linuxppc-dev@ozlabs.org>; Thu, 23 Jun 2016 05:25:01 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5MJP1sN028565
 for <linuxppc-dev@ozlabs.org>; Thu, 23 Jun 2016 05:25:01 +1000
Subject: [PATCH v2 0/2] powerpc/fadump: support memory range syntax for
 fadump memory reservation
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, lkml <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
Date: Thu, 23 Jun 2016 00:54:59 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20160622192213.11192.93613.stgit@hbathini.in.ibm.com>
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
      refactor code parsing size based on memory range
      powerpc/fadump: parse fadump reserve memory size based on memory range


 arch/powerpc/kernel/fadump.c |   64 ++++++++++++++++++++++++----
 include/linux/kernel.h       |    5 ++
 kernel/kexec_core.c          |   63 ++--------------------------
 kernel/params.c              |   96 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 161 insertions(+), 67 deletions(-)

--
Hari Bathini
