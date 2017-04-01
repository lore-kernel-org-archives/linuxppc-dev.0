Return-Path: <haren@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vwPz54VrMzDqHg
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  2 Apr 2017 03:11:13 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v31H8qpK002325
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 1 Apr 2017 13:11:00 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29j6hckvkr-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 01 Apr 2017 13:11:00 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <haren@linux.vnet.ibm.com>;
 Sat, 1 Apr 2017 11:10:59 -0600
Subject: [RESEND PATCH 0/5] Enable NX 842 compression engine on Power9
From: Haren Myneni <haren@linux.vnet.ibm.com>
To: herbert@gondor.apana.org.au, mpe@ellerman.id.au, ddstreet@ieee.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org,
 benh@kernel.crashing.org, mikey@neuling.org, suka@us.ibm.com,
 hbabu@us.ibm.com
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 01 Apr 2017 10:10:51 -0700
Mime-Version: 1.0
Message-Id: <1491066651.29552.35.camel@hbabu-laptop>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Sorry for reposting. Missed to specify dependency - VAS kernel changes.

[PATCH 0/5] Enable NX 842 compression engine on Power9

P9 introduces Virtual Accelerator Switchboard (VAS) to communicate
with NX 842 engine. icswx function is used to access NX before.
On powerNV systems, NX-842 driver invokes VAS functions for
configuring RxFIFO (receive window) per each NX engine. VAS uses
this FIFO to communicate the request to NX. The kernel opens send 
window which is used to transfer compression/decompression requests 
to VAS. It maps the send window to the corresponding RxFIFO. 
copy/paste instructions are used to pass the CRB to VAS.

This patch series adds P9 NX support for 842 compression engine.
First 3 patches reorganize the current code so that VAS function
can be added.
- nx842_powernv_function points to VAS function if VAS feature is
  available. Otherwise icswx function is used.
- Move configure CRB code nx842_cfg_crb() 
- In addition to freeing co-processor structs for initialization 
  failures and exit, both send and receive windows have to closed
  for VAS.

The last 2 patches adds configuring and invoking VAS, and also 
checking P9 NX specific errors that are provided in co-processor 
status block (CSB) for failures.

Patches have been tested in P9 Simics environment using VAS changes. 
This patchset depends on VAS kernel changes:
https://lists.ozlabs.org/pipermail/linuxppc-dev/2017-March/156078.html

Thanks to Sukadev Bhattiprolu for his review, input and testing with 
VAS changes.

Haren Myneni (5):
  crypto/nx: Rename nx842_powernv_function as icswx function
  crypto/nx: Create nx842_cfg_crb function
  crypto/nx: Create nx842_delete_coproc function
  crypto/nx: Add P9 NX support for 842 compression engine.
  crypto/nx: Add P9 NX specific error codes for 842 engine

 arch/powerpc/include/asm/icswx.h   |   3 +
 arch/powerpc/include/asm/vas.h     |   2 +
 drivers/crypto/nx/Kconfig          |   1 +
 drivers/crypto/nx/nx-842-powernv.c | 435 +++++++++++++++++++++++++++++++++----
 drivers/crypto/nx/nx-842.h         |   8 +
 5 files changed, 407 insertions(+), 42 deletions(-)

-- 
1.8.3.1
