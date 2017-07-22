Return-Path: <haren@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xDwLY3K2fzDqxb
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Jul 2017 14:55:32 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6M4sY1E133864
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Jul 2017 00:55:30 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2buyhs8vxk-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Jul 2017 00:55:30 -0400
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <haren@linux.vnet.ibm.com>;
 Fri, 21 Jul 2017 22:55:29 -0600
Subject: [PATCH V3 0/6] Enable NX 842 compression engine on Power9
From: Haren Myneni <haren@linux.vnet.ibm.com>
To: mpe@ellerman.id.au, herbert@gondor.apana.org.au
Cc: linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 mikey@neuling.org, benh@kernel.crashing.org, suka@us.ibm.com,
 ddstreet@ieee.org, linuxram@us.ibm.com, npiggin@gmail.com
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 21 Jul 2017 21:55:22 -0700
Mime-Version: 1.0
Message-Id: <1500699322.23205.1.camel@hbabu-laptop>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


P9 introduces Virtual Accelerator Switchboard (VAS) to communicate
with NX 842 engine. icswx function is used to access NX before.
On powerNV systems, NX-842 driver invokes VAS functions for
configuring RxFIFO (receive window) per each NX engine. VAS uses
this FIFO to communicate the request to NX. The kernel opens send
window which is used to transfer compression/decompression requests
to VAS. It maps the send window to the corresponding RxFIFO.
copy/paste instructions are used to pass the CRB to VAS.

This patch series adds P9 NX support for 842 compression engine.
First 4 patches reorganize the current code so that VAS function
can be added.
- nx842_powernv_function points to VAS function if VAS feature is
  available. Otherwise icswx function is used.
- Move configure CRB code nx842_cfg_crb() 
- In addition to freeing co-processor structs for initialization 
  failures and exit, both send and receive windows have to closed
  for VAS.
- Move updating coprocessor info list to nx842_add_coprocs_list().

The last 2 patches adds configuring and invoking VAS, and also
checking P9 NX specific errors that are provided in co-processor
status block (CSB) for failures.

Patches have been tested on P9 DD1 system using VAS changes and
on P8 HW to make sure no regression.

This patchset depends on VAS kernel changes:
https://lists.ozlabs.org/pipermail/linuxppc-dev/2017-May/158178.html

Thanks to Sukadev Bhattiprolu for his review, input and testing with
VAS changes. Also thanks to Michael Ellerman and Benjamin Herrenschmidt
for their valuable guidance and comments.

Changelog[V3]
	- preemption disable for copy/paste as Nichalos Piggin suggested.
	- PTR_ALIGN for workmem buffer based on Ram Pai's comemnt.
 
Changelog[v2]
	- Open/close send windows in nx842_poernv_crypto_init/exit_vas().
	- Changes for the new device-tree NX properties such as priority
	  and compatible properties.
	- Incorporated review comments from Michael Ellerman.
	- Other minor issues found during HW testing.

Haren Myneni (6):
  crypto/nx842: Rename nx842_powernv_function as icswx function
  crypto/nx: Create nx842_configure_crb function
  crypto/nx: Create nx842_delete_coprocs function
  crypto/nx: Add nx842_add_coprocs_list function
  crypto/nx: Add P9 NX specific error codes for 842 engine
  crypto/nx: Add P9 NX support for 842 compression engine.

 arch/powerpc/include/asm/icswx.h   |   3 +
 drivers/crypto/nx/Kconfig          |   1 +
 drivers/crypto/nx/nx-842-powernv.c | 499 +++++++++++++++++++++++++++++++++----
 drivers/crypto/nx/nx-842.c         |   2 +-
 drivers/crypto/nx/nx-842.h         |   8 +
 5 files changed, 465 insertions(+), 48 deletions(-)

-- 
2.11.0
