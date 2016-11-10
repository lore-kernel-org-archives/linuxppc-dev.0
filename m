Return-Path: <hbathini@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tF1kd5fmczDvgx
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Nov 2016 22:57:29 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAABsqZU115944
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Nov 2016 06:57:27 -0500
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26mptgfwj1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Nov 2016 06:57:26 -0500
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Thu, 10 Nov 2016 21:57:24 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id C6A873578052
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Nov 2016 22:57:21 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uAABvLOk6160704
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Nov 2016 22:57:21 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uAABvLxY003017
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Nov 2016 22:57:21 +1100
Subject: [PATCH 0/3] kexec/fadump: remove dependency with CONFIG_KEXEC and
 reuse crashkernel parameter for fadump
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: fenghua.yu@intel.com, tony.luck@intel.com, linux-ia64@vger.kernel.org,
 dyoung@redhat.com, kexec@lists.infradead.org,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>, ebiederm@xmission.com,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 vgoyal@redhat.com
Date: Thu, 10 Nov 2016 17:27:10 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <147877899077.31483.3740501843050856595.stgit@hbathini.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Traditionally, kdump is used to save vmcore in case of a crash. Some
architectures like powerpc can save vmcore using architecture specific
support instead of kexec/kdump mechanism. Such architecture specific
support also needs to reserve memory, to be used by dump capture kernel.
crashkernel parameter can be a reused, for memory reservation, by such
architecture specific infrastructure.

This patchset removes dependency with CONFIG_KEXEC for crashkernel parameter
and vmcoreinfo related code as it can be reused without kexec support. Also,
crashkernel parameter is reused instead of fadump_reserve_mem to reserve
memory for fadump.

The first patch moves crashkernel parameter parsing and vmcoreinfo related
code under CONFIG_CRASH_CORE instead of CONFIG_KEXEC_CORE to reuse without
depending on it. The second patch reuses crashkernel for reserving memory
for fadump instead of fadump_reserve_mem. This has the advantage of using
all the syntaxes crashkernel supports, for fadump as well. The third patch
updates fadump kernel documentation about use of crashkernel parameter.

---

Hari Bathini (3):
      crash: move crashkernel parsing and vmcore related code under CONFIG_CRASH_CORE
      powerpc/fadump: reuse crashkernel parameter for fadump memory reservation
      powerpc/fadump: update documentation about crashkernel parameter reuse


 Documentation/powerpc/firmware-assisted-dump.txt |   23 +
 arch/Kconfig                                     |    4 
 arch/ia64/kernel/crash.c                         |   22 -
 arch/powerpc/Kconfig                             |   10 
 arch/powerpc/include/asm/fadump.h                |    2 
 arch/powerpc/kernel/crash.c                      |    2 
 arch/powerpc/kernel/fadump.c                     |   57 +--
 arch/powerpc/kernel/setup-common.c               |    5 
 include/linux/crash_core.h                       |   75 ++++
 include/linux/kexec.h                            |   63 ---
 kernel/Makefile                                  |    1 
 kernel/crash_core.c                              |  450 ++++++++++++++++++++++
 kernel/kexec_core.c                              |  435 ---------------------
 13 files changed, 575 insertions(+), 574 deletions(-)
 create mode 100644 include/linux/crash_core.h
 create mode 100644 kernel/crash_core.c
