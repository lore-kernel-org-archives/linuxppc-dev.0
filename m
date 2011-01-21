Return-Path: <jlarrew@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CF300B7139
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 21 Jan 2011 16:01:20 +1100 (EST)
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e32.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p0L4pDMa015844
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jan 2011 21:51:13 -0700
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p0L51Fqh111924
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jan 2011 22:01:15 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p0L51E5I017884
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jan 2011 22:01:15 -0700
Date: Thu, 20 Jan 2011 22:01:13 -0700
From: Jesse Larrew <jlarrew@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Message-Id: <20110121050112.5062.23977.sendpatchset@oc7304238415.ibm.com>
In-Reply-To: <20110121050010.5062.3390.sendpatchset@oc7304238415.ibm.com>
References: <20110121050010.5062.3390.sendpatchset@oc7304238415.ibm.com>
Subject: [PATCH 2/4] powerpc/pseries: Fix brace placement in numa.c
Cc: markn@au1.ibm.com, tbreeds@au1.ibm.com, lkessler@us.ibm.com,
	Jesse Larrew <jlarrew@linux.vnet.ibm.com>, mjwolf@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Jesse Larrew <jlarrew@linux.vnet.ibm.com>

Fix brace placement in VPHN code.

Signed-off-by: Jesse Larrew <jlarrew@linux.vnet.ibm.com>
---
 arch/powerpc/mm/numa.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 5259dde..db36a2c 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -1285,9 +1285,8 @@ static void setup_cpu_associativity_change_counters(void)
 		u8 *counts = vphn_cpu_change_counts[cpu];
 		volatile u8 *hypervisor_counts = lppaca[cpu].vphn_assoc_counts;
 
-		for (i = 0; i < VPHN_NR_CHANGE_CTRS; i++) {
+		for (i = 0; i < VPHN_NR_CHANGE_CTRS; i++)
 			counts[i] = hypervisor_counts[i];
-		}
 	}
 }
 
@@ -1354,14 +1353,12 @@ static int vphn_unpack_associativity(const long *packed, unsigned int *unpacked)
 			 */
 			unpacked[i] = *((u32*)field);
 			field += 2;
-		}
-		else if (*field & VPHN_FIELD_MSB) {
+		} else if (*field & VPHN_FIELD_MSB) {
 			/* Data is in the lower 15 bits of this field */
 			unpacked[i] = *field & VPHN_FIELD_MASK;
 			field++;
 			nr_assoc_doms++;
-		}
-		else {
+		} else {
 			/* Data is in the lower 15 bits of this field
 			 * concatenated with the next 16 bit field
 			 */
-- 
1.7.3.4
