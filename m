Return-Path: <alastair@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Q7ym3qwNzF1S9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Apr 2018 12:11:12 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w3H2AnD6077610
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Apr 2018 22:11:10 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2hd1wnnbsj-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Apr 2018 22:11:09 -0400
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <alastair@au1.ibm.com>;
 Tue, 17 Apr 2018 03:11:07 +0100
From: "Alastair D'Silva" <alastair@au1.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, mikey@neuling.org,
 vaibhav@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 malat@debian.org, felix@linux.vnet.ibm.com, pombredanne@nexb.com,
 sukadev@linux.vnet.ibm.com, npiggin@gmail.com,
 gregkh@linuxfoundation.org, arnd@arndb.de,
 andrew.donnellan@au1.ibm.com, fbarrat@linux.vnet.ibm.com,
 corbet@lwn.net, "Alastair D'Silva" <alastair@d-silva.org>
Subject: [PATCH 0/7] ocxl: Implement Power9 as_notify/wait for OpenCAPI
Date: Tue, 17 Apr 2018 12:09:43 +1000
Message-Id: <20180417020950.21446-1-alastair@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Alastair D'Silva <alastair@d-silva.org>

The Power 9 as_notify/wait feature provides a lower latency way to
signal a thread that work is complete. This series enables the use of
this feature from OpenCAPI adapters, as well as addressing a potential
starvation issue when allocating thread IDs.

Alastair D'Silva (7):
  powerpc: Add TIDR CPU feature for Power9
  powerpc: Use TIDR CPU feature to control TIDR allocation
  powerpc: use task_pid_nr() for TID allocation
  ocxl: Rename pnv_ocxl_spa_remove_pe to clarify it's action
  ocxl: Expose the thread_id needed for wait on p9
  ocxl: Add an IOCTL so userspace knows which platform the kernel
    requires
  ocxl: Document new OCXL IOCTLs

 Documentation/accelerators/ocxl.rst   | 10 ++++
 arch/powerpc/include/asm/cputable.h   |  3 +-
 arch/powerpc/include/asm/pnv-ocxl.h   |  2 +-
 arch/powerpc/include/asm/switch_to.h  |  1 -
 arch/powerpc/kernel/dt_cpu_ftrs.c     |  1 +
 arch/powerpc/kernel/process.c         | 99 +----------------------------------
 arch/powerpc/platforms/powernv/ocxl.c |  4 +-
 drivers/misc/ocxl/context.c           |  5 +-
 drivers/misc/ocxl/file.c              | 78 +++++++++++++++++++++++++++
 drivers/misc/ocxl/link.c              | 38 +++++++++++++-
 drivers/misc/ocxl/ocxl_internal.h     |  1 +
 include/misc/ocxl.h                   |  9 ++++
 include/uapi/misc/ocxl.h              | 14 +++++
 13 files changed, 161 insertions(+), 104 deletions(-)

-- 
2.14.3
