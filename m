Return-Path: <srs0=trvj=hp=linux.vnet.ibm.com=mahesh@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40WwCL6ZWBzF24d
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Apr 2018 21:42:06 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 40WwCL5n5sz8tF7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Apr 2018 21:42:06 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 40WwCL0Z4sz9rxs
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Apr 2018 21:42:05 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w3QBfNvI145201
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Apr 2018 07:42:03 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2hkdvkrk4u-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Apr 2018 07:42:02 -0400
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Thu, 26 Apr 2018 12:42:01 +0100
Subject: [PATCH v5 0/4] powerpc/fadump: Improvements and fixes for
 firmware-assisted dump.
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>, kernelfans@gmail.com,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Hari Bathini <hbathini@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Ananth Narayan <ananth@in.ibm.com>
Date: Thu, 26 Apr 2018 17:11:56 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <152474278043.5697.2553982145593952228.stgit@jupiter.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

One of the primary issues with Firmware Assisted Dump (fadump) on Power
is that it needs a large amount of memory to be reserved. This reserved
memory is used for saving the contents of old crashed kernel's memory before
fadump capture kernel uses old kernel's memory area to boot. However, This
reserved memory area stays unused until system crash and isn't available
for production kernel to use.

Instead of setting aside a significant chunk of memory that nobody can use,
take advantage Linux kernel's Contiguous Memory Allocator (CMA) feature,
to reserve a significant chunk of memory that the kernel is prevented from
using , but applications are free to use it.

Patch 2 implements the usage of CMA region to allow production kernel to
use that memory for applications usage, making fadump reservationless.
We now initialize siginificant chunk of faump reserved memory for CMA.
Patch 1, 3 and 4 fixes various fadump issues and bugs.

Changes in V5:
- Drop the patch that does metadata movement.
- Move the kexec fix patch to top (patch 1)
- Fold CMA documenation patch into patch 2
- Fix the compilation issues when CONFIG_CMA is not set. Reported by Hari.
- Use the approach of using boot memory size for CMA as suggested by Hari
  except the movement of sections. Thanks to Hari.

Changes in V4:
- patch 1: Make fadump compatible irrespective of kernel versions.
- patch 4: moved out of the series and been posted seperatly at
  http://patchwork.ozlabs.org/patch/896716/
- Documentation update about CMA reservation.

Changes in V3:
- patch 1 & 2: move metadata region and documentation update.
- patch 7: Un-register the faudmp on kexec path


---

Mahesh Salgaonkar (4):
      powerpc/fadump: un-register fadump on kexec path.
      powerpc/fadump: Reservationless firmware assisted dump
      powerpc/fadump: throw proper error message on fadump registration failure.
      powerpc/fadump: Do not allow hot-remove memory from fadump reserved area.


 Documentation/powerpc/firmware-assisted-dump.txt |   10 ++
 arch/powerpc/include/asm/fadump.h                |    6 +
 arch/powerpc/kernel/fadump.c                     |  130 ++++++++++++++++++++--
 arch/powerpc/platforms/pseries/hotplug-memory.c  |    7 +
 4 files changed, 137 insertions(+), 16 deletions(-)

--
Signature
