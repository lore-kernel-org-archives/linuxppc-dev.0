Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zgtlN1KVfzDqJw
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Feb 2018 07:03:40 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1DK3R9W049553
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Feb 2018 15:03:38 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2g40uy7ek4-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Feb 2018 15:03:38 -0500
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Tue, 13 Feb 2018 13:03:37 -0700
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Michael Ellerman <mwb@linux.vnet.ibm.com>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [PATCH] powerpc: Revert support for ibm,drc-info devtree property
Date: Tue, 13 Feb 2018 14:02:53 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <f5baf8d9-ece2-d3b8-2793-7701a1184c2a@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This reverts commit 02ef6dd8109b581343ebeb1c4c973513682535d6.

The earlier patch tried to enable support for a new property
"ibm,drc-info" on powerpc systems.

Unfortunately, some errors in the associated patch set break things
in some of the DLPAR operations.  In particular when attempting to
hot-add a new CPU or set of CPUs, the original patch failed to
properly calculate the available resources, and aborted the operation.
In addition, the original set missed several opportunities to compress
and reuse common code.

As the associated patch set was meant to provide an optimization of
storage and performance of a set of device-tree properties for future
systems with large amounts of resources, reverting just restores
the previous behavior for existing systems.  It seems unnecessary
to enable this feature and introduce the consequent problems in the
field that it will cause at this time, so please revert it for now
until testing of the corrections are finished properly.

Signed-off-by: Michael W. Bringmann <mwb@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/prom_init.c     | 1 +
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index adf044d..d22c41c 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -874,7 +874,7 @@ struct ibm_arch_vec __cacheline_aligned ibm_architecture_vec = {
 		.mmu = 0,
 		.hash_ext = 0,
 		.radix_ext = 0,
-		.byte22 = OV5_FEAT(OV5_DRC_INFO),
+		.byte22 = 0,
 	},
 
 	/* option vector 6: IBM PAPR hints */
