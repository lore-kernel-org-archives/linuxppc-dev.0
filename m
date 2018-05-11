Return-Path: <alastair@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40j0F32PnJzF155
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 May 2018 16:15:03 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4B69CvA011435
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 May 2018 02:15:00 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2hw1uggh3a-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 May 2018 02:15:00 -0400
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <alastair@au1.ibm.com>;
 Fri, 11 May 2018 07:14:58 +0100
From: "Alastair D'Silva" <alastair@au1.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, mikey@neuling.org,
 vaibhav@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 malat@debian.org, felix@linux.vnet.ibm.com, pombredanne@nexb.com,
 sukadev@linux.vnet.ibm.com, npiggin@gmail.com,
 gregkh@linuxfoundation.org, arnd@arndb.de,
 andrew.donnellan@au1.ibm.com, fbarrat@linux.vnet.ibm.com,
 corbet@lwn.net, "Alastair D'Silva" <alastair@d-silva.org>
Subject: [PATCH v5 0/7] ocxl: Implement Power9 as_notify/wait for OpenCAPI
Date: Fri, 11 May 2018 16:12:56 +1000
Message-Id: <20180511061303.10728-1-alastair@au1.ibm.com>
Content-Type: text/plain
MIME-Version: 1.0
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

Changelog:
v5:
  Remove stray brace
  Fix bad rename of ocxl_ioctl_platform to ocxl_ioctl_features
v4:
  Remove the "unique" statement from the set_thread_tidr function and
    move the text explaining why it is safe from the commit message
    to the function description
v3:
  Fix references to POWER9
  Remove stray whitespace edit from docs
  Add more details to commit message for "use task_pid_nr()"
  Retitle patch 6 to indicate OCXL rather than CPU features
v2:
  Rename get_platform IOCTL to get_features
  Move stray edit from patch 1 to patch 3

Alastair D'Silva (7):
  powerpc: Add TIDR CPU feature for POWER9
  powerpc: Use TIDR CPU feature to control TIDR allocation
  powerpc: use task_pid_nr() for TID allocation
  ocxl: Rename pnv_ocxl_spa_remove_pe to clarify it's action
  ocxl: Expose the thread_id needed for wait on POWER9
  ocxl: Add an IOCTL so userspace knows what OCXL features are available
  ocxl: Document new OCXL IOCTLs

 Documentation/accelerators/ocxl.rst   |  11 ++++
 arch/powerpc/include/asm/cputable.h   |   3 +-
 arch/powerpc/include/asm/pnv-ocxl.h   |   2 +-
 arch/powerpc/include/asm/switch_to.h  |   1 -
 arch/powerpc/kernel/dt_cpu_ftrs.c     |   1 +
 arch/powerpc/kernel/process.c         | 101 +---------------------------------
 arch/powerpc/platforms/powernv/ocxl.c |   4 +-
 drivers/misc/ocxl/context.c           |   5 +-
 drivers/misc/ocxl/file.c              |  78 ++++++++++++++++++++++++++
 drivers/misc/ocxl/link.c              |  38 ++++++++++++-
 drivers/misc/ocxl/ocxl_internal.h     |   1 +
 include/misc/ocxl.h                   |   9 +++
 include/uapi/misc/ocxl.h              |  14 +++++
 13 files changed, 163 insertions(+), 105 deletions(-)

-- 
2.14.3
