Return-Path: <gkurz@linux.vnet.ibm.com>
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5BE371A01EF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Oct 2014 21:43:13 +1100 (EST)
Received: from /spool/local
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gkurz@linux.vnet.ibm.com>;
 Wed, 15 Oct 2014 11:43:08 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id CF7932190061
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Oct 2014 11:42:43 +0100 (BST)
Received: from d06av08.portsmouth.uk.ibm.com (d06av08.portsmouth.uk.ibm.com
 [9.149.37.249])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s9FAh6A316974188
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Oct 2014 10:43:06 GMT
Received: from d06av08.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s9FAh6Qt012109
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Oct 2014 04:43:06 -0600
Subject: [PATCH v3] powerpc/vphn: NUMA node code expects big-endian
From: Greg Kurz <gkurz@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Date: Wed, 15 Oct 2014 12:42:58 +0200
Message-ID: <20141015103804.20932.99794.stgit@bahia.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The associativity domain numbers are obtained from the hypervisor through
registers and written into memory by the guest: the packed array passed to
vphn_unpack_associativity() is then native-endian, unlike what was assumed
in the following commit:

commit b08a2a12e44eaec5024b2b969f4fcb98169d1ca3
Author: Alistair Popple <alistair@popple.id.au>
Date:   Wed Aug 7 02:01:44 2013 +1000

    powerpc: Make NUMA device node code endian safe

This issue fills the topology with bogus data and makes it unusable. It may
lead to severe performance breakdowns.

We should ideally patch the vphn_unpack_associativity() function to do the
64-bit loads, but this requires some more brain storming.

In the meantime, let's go for a suboptimal and temporary bug fix: this patch
converts each 64-bit value of the packed array to big endian, as expected by
the current parsing code in vphn_unpack_associativity().

Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
---

Changes in v3:
- dropped the complicated bit-shift based solution as requested by Michael
  Ellerman

 arch/powerpc/mm/numa.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 649666d..b81bfe3 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -1442,8 +1442,11 @@ static long hcall_vphn(unsigned long cpu, __be32 *associativity)
 	long retbuf[PLPAR_HCALL9_BUFSIZE] = {0};
 	u64 flags = 1;
 	int hwcpu = get_hard_smp_processor_id(cpu);
+	int i;
 
 	rc = plpar_hcall9(H_HOME_NODE_ASSOCIATIVITY, retbuf, flags, hwcpu);
+	for (i = 0; i < 6; i++)
+		retbuf[i] = cpu_to_be64(retbuf[i]);
 	vphn_unpack_associativity(retbuf, associativity);
 
 	return rc;
