Return-Path: <gkurz@linux.vnet.ibm.com>
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id ECBAB1A17D2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Nov 2014 04:42:32 +1100 (AEDT)
Received: from /spool/local
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gkurz@linux.vnet.ibm.com>;
 Mon, 17 Nov 2014 17:42:29 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 613231B08061
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Nov 2014 17:42:37 +0000 (GMT)
Received: from d06av05.portsmouth.uk.ibm.com (d06av05.portsmouth.uk.ibm.com
 [9.149.37.229])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAHHgPUi3211750
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Nov 2014 17:42:26 GMT
Received: from d06av05.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av05.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAHHgPaL006157
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Nov 2014 10:42:25 -0700
Subject: [PATCH REPOST 1/3] powerpc/vphn: clarify the
 H_HOME_NODE_ASSOCIATIVITY API
From: Greg Kurz <gkurz@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Date: Mon, 17 Nov 2014 18:42:23 +0100
Message-ID: <20141117174223.7717.70152.stgit@bahia.local>
In-Reply-To: <20141117174216.7717.10926.stgit@bahia.local>
References: <20141117174216.7717.10926.stgit@bahia.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Paul Mackerras <paulus@samba.org>
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
 arch/powerpc/mm/numa.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index b9d1dfd..1425517 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -1401,11 +1401,15 @@ static int update_cpu_associativity_changes_mask(void)
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
@@ -1463,7 +1467,7 @@ static long hcall_vphn(unsigned long cpu, __be32 *associativity)
 	int i;
 
 	rc = plpar_hcall9(H_HOME_NODE_ASSOCIATIVITY, retbuf, flags, hwcpu);
-	for (i = 0; i < 6; i++)
+	for (i = 0; i < VPHN_REGISTER_COUNT; i++)
 		retbuf[i] = cpu_to_be64(retbuf[i]);
 	vphn_unpack_associativity(retbuf, associativity);
 
