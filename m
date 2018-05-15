Return-Path: <srs0=h6/a=ic=linux.ibm.com=hbathini@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40lQMV6KPPzF2XK
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 May 2018 14:59:02 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 40lQMV1stsz8sxv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 May 2018 14:59:02 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 40lQMT29fvz9s1w
 for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2018 14:59:01 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4F4s6ZC076426
 for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2018 00:58:58 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2hyreh0xbg-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2018 00:58:58 -0400
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.ibm.com>;
 Tue, 15 May 2018 05:58:56 +0100
Subject: [RFC PATCH 0/5] Add FADump support on PowerNV platform
From: Hari Bathini <hbathini@linux.ibm.com>
To: Ananth N Mavinakayanahalli <ananth@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Vasant Hegde <hegdevasant@linux.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Stewart Smith <stewart@linux.ibm.com>
Date: Tue, 15 May 2018 10:28:50 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <152636029761.17123.10365462779196202939.stgit@hbathini.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Firmware-Assisted Dump (FADump) is currently supported only on pseries
platform. This patch series adds support for powernv platform too. 

The first two patches refactor the FADump code to make use of common
code across multiple platforms. The third patch adds basic FADump support
to powernv platform. The next patch processes state data provided by f/w
and adds core notes to core file. The last patch adds support to export
opalcore. This is to make debugging of failures in opal code easier.

The patch series is tested with a few workarounds in firmware and kernel
as the full and final firmware support is currently being worked on.
The below skiboot patch series adds the relevant OPAL changes:

    http://patchwork.ozlabs.org/project/skiboot/list/?series=42576

---

Hari Bathini (5):
      powerpc/fadump: move internal fadump code to a new file
      pseries/fadump: move out platform specific support from generic code
      powerpc/fadump: enable fadump support on powernv platform
      powerpc/fadump: process architected register state data provided by firmware
      powerpc/powernv: export /proc/opaldump for analysing opal crashes


 arch/powerpc/Kconfig                            |    2 
 arch/powerpc/include/asm/fadump.h               |  185 ----
 arch/powerpc/include/asm/opal-api.h             |    4 
 arch/powerpc/include/asm/opal.h                 |    1 
 arch/powerpc/kernel/Makefile                    |    2 
 arch/powerpc/kernel/fadump.c                    | 1111 +++++++++--------------
 arch/powerpc/kernel/fadump_internal.c           |  194 ++++
 arch/powerpc/kernel/fadump_internal.h           |  197 ++++
 arch/powerpc/platforms/powernv/Makefile         |    1 
 arch/powerpc/platforms/powernv/opal-wrappers.S  |    1 
 arch/powerpc/platforms/powernv/opalcore.c       |  282 ++++++
 arch/powerpc/platforms/powernv/opalcore.h       |   28 +
 arch/powerpc/platforms/powernv/powernv_fadump.c |  503 ++++++++++
 arch/powerpc/platforms/powernv/powernv_fadump.h |   72 +
 arch/powerpc/platforms/pseries/Makefile         |    1 
 arch/powerpc/platforms/pseries/pseries_fadump.c |  532 +++++++++++
 arch/powerpc/platforms/pseries/pseries_fadump.h |   96 ++
 17 files changed, 2335 insertions(+), 877 deletions(-)
 create mode 100644 arch/powerpc/kernel/fadump_internal.c
 create mode 100644 arch/powerpc/kernel/fadump_internal.h
 create mode 100644 arch/powerpc/platforms/powernv/opalcore.c
 create mode 100644 arch/powerpc/platforms/powernv/opalcore.h
 create mode 100644 arch/powerpc/platforms/powernv/powernv_fadump.c
 create mode 100644 arch/powerpc/platforms/powernv/powernv_fadump.h
 create mode 100644 arch/powerpc/platforms/pseries/pseries_fadump.c
 create mode 100644 arch/powerpc/platforms/pseries/pseries_fadump.h

--
Signature
