Return-Path: <gkurz@linux.vnet.ibm.com>
Received: from e06smtp16.uk.ibm.com (e06smtp16.uk.ibm.com [195.75.94.112])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 815E41A02E3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Dec 2014 03:43:28 +1100 (AEDT)
Received: from /spool/local
 by e06smtp16.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gkurz@linux.vnet.ibm.com>;
 Wed, 17 Dec 2014 16:43:24 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id B0FED21A14A0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Dec 2014 15:30:24 +0000 (GMT)
Received: from d06av10.portsmouth.uk.ibm.com (d06av10.portsmouth.uk.ibm.com
 [9.149.37.251])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sBHFUsgw47317236
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Dec 2014 15:30:54 GMT
Received: from d06av10.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av10.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sBHFUrhj011571
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Dec 2014 08:30:53 -0700
Subject: [PATCH v2 1/4] powerpc/vphn: clarify the H_HOME_NODE_ASSOCIATIVITY API
From: Greg Kurz <gkurz@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Date: Wed, 17 Dec 2014 10:41:20 +0100
Message-ID: <20141217094052.16957.58194.stgit@bahia.local>
In-Reply-To: <20141217094007.16957.70423.stgit@bahia.local>
References: <20141217094007.16957.70423.stgit@bahia.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The number of values returned by the H_HOME_NODE_ASSOCIATIVITY h_call deserves
to be explicitly defined, for a better understanding of the code.

Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
---

 No changes in v2.

 arch/powerpc/mm/numa.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 417b0a5..2a83e48 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -1247,11 +1247,15 @@ static int update_cpu_associativity_changes_mask(void)
 	return cpumask_weight(changes);
 }
 
+/* The H_HOME_NODE_ASSOCIATIVITY h_call returns 6 64-bit registers.
+ */
+#define VPHN_REGISTER_COUNT 6
+
 /*
  * 6 64-bit registers unpacked into 12 32-bit associativity values. To form
  * the complete property we have to add the length in the first cell.
  */
-#define VPHN_ASSOC_BUFSIZE (6*sizeof(u64)/sizeof(u32) + 1)
+#define VPHN_ASSOC_BUFSIZE (VPHN_REGISTER_COUNT*sizeof(u64)/sizeof(u32) + 1)
 
 /*
  * Convert the associativity domain numbers returned from the hypervisor
@@ -1309,7 +1313,7 @@ static long hcall_vphn(unsigned long cpu, __be32 *associativity)
 	int i;
 
 	rc = plpar_hcall9(H_HOME_NODE_ASSOCIATIVITY, retbuf, flags, hwcpu);
-	for (i = 0; i < 6; i++)
+	for (i = 0; i < VPHN_REGISTER_COUNT; i++)
 		retbuf[i] = cpu_to_be64(retbuf[i]);
 	vphn_unpack_associativity(retbuf, associativity);
 
