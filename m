Return-Path: <srs0=gorp=ka=linux.vnet.ibm.com=mahesh@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41TXrt0HMdzF36c
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jul 2018 16:03:10 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 41TXrs5G8Yz8tFw
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jul 2018 16:03:09 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 41TXrs1bmTz9s29
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Jul 2018 16:03:08 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6G5wcaw094915
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Jul 2018 02:03:07 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2k8hcgqwh3-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Jul 2018 02:03:06 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Mon, 16 Jul 2018 07:03:04 +0100
Subject: [RFC PATCH v6 0/4] powerpc/fadump: Improvements and fixes for
 firmware-assisted dump.
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Hari Bathini <hbathini@linux.vnet.ibm.com>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, Michal Hocko <mhocko@suse.com>,
 Hari Bathini <hbathini@linux.vnet.ibm.com>,
 Ananth Narayan <ananth@in.ibm.com>, kernelfans@gmail.com
Date: Mon, 16 Jul 2018 11:32:56 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <153172096333.29252.4376707071382727345.stgit@jupiter.in.ibm.com>
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
take advantage ZONE_MOVABLE to mark a significant chunk of reserved memory
as ZONE_MOVABLE, so that the kernel is prevented from using, but
applications are free to use it.

Patch 1 introduces an interface to mark reserved memory as ZONE_MOVABLE.
Patch 2 uses the above interface to mark reserved memory movable so that
it can be used for applications usage, making fadump reservationless.
Patch 3 and 4 fixes minor issues.

Changes in V6:
- Introduce an interface to mark reserved memory as ZONE_MOVABLE. Hence
  sending this series as RFC again.
- Mark reserved area as ZONE_MOVABLE instead of CMA.
- Add fadump=nonmovable parameter for user who don't want to use ZONE_MOVABLE.

Changes in V5:
- Drop the patch that does metadata movement.
- Move the kexec fix patch to top (patch 1)
- Fold CMA documenation patch into patch 2
- Fix the compilation issues when CONFIG_CMA is not set reported by Hari.
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
      mm/page_alloc: Introduce an interface to mark reserved memory as ZONE_MOVABLE
      powerpc/fadump: Reservationless firmware assisted dump
      powerpc/fadump: throw proper error message on fadump registration failure.
      powerpc/fadump: Do not allow hot-remove memory from fadump reserved area.


 Documentation/powerpc/firmware-assisted-dump.txt |   18 +++
 arch/powerpc/include/asm/fadump.h                |    7 +
 arch/powerpc/kernel/fadump.c                     |  123 +++++++++++++++++--
 arch/powerpc/platforms/pseries/hotplug-memory.c  |    7 +
 include/linux/mmzone.h                           |    2 
 mm/page_alloc.c                                  |  146 ++++++++++++++++++++++
 6 files changed, 290 insertions(+), 13 deletions(-)

--
Signature
