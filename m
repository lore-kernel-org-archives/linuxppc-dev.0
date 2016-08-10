Return-Path: <hbathini@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s8RbR4X7pzDqPn
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 20:05:07 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3s8RbQ3nZJz9stc
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Aug 2016 20:05:06 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7AA4x1x038147
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Aug 2016 06:05:05 -0400
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [125.16.236.8])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24qm9sx6bj-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Aug 2016 06:05:04 -0400
Received: from localhost
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Wed, 10 Aug 2016 15:35:01 +0530
Received: from d28relay08.in.ibm.com (d28relay08.in.ibm.com [9.184.220.159])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 114AB125804F
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Aug 2016 15:38:08 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay08.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7AA4w6238994092
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Aug 2016 15:34:58 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7AA4sG8025973
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Aug 2016 15:34:57 +0530
Subject: [PATCH v3 0/2] powerpc/fadump: support memory range syntax for
 fadump memory reservation
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, dyoung@redhat.com,
 ebiederm@xmission.com, vgoyal@redhat.com,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
Cc: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>, kexec@lists.infradead.org,
 lkml <linux-kernel@vger.kernel.org>,
 Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Date: Wed, 10 Aug 2016 15:34:51 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <147082324660.4631.6557186560310369015.stgit@hbathini.in.ibm.com>
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


 arch/powerpc/kernel/fadump.c |   63 ++++++++++++++++++++++---
 include/linux/kernel.h       |    5 ++
 kernel/kexec_core.c          |   63 ++-----------------------
 lib/cmdline.c                |  104 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 168 insertions(+), 67 deletions(-)
