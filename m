Return-Path: <anton@samba.org>
Date: Sun, 30 Jan 2011 09:26:19 +1100
From: Anton Blanchard <anton@samba.org>
To: Nishanth Aravamudan <nacc@us.ibm.com>, Benjamin Herrenschmidt
	<benh@kernel.crashing.org>, jlarrew@linux.vnet.ibm.com
Subject: [PATCH 2/5] powerpc/numa: Check for all VPHN changes
Message-ID: <20110130092619.7e414259@kryten>
In-Reply-To: <20110130092434.42a887ef@kryten>
References: <20110118123152.50f75a72@kryten>
	<20110118224718.GA19039@us.ibm.com>
	<1295409980.2148.125.camel@pasglop>
	<20110119043757.GA29865@us.ibm.com>
	<20110130092217.70ebb424@kryten> <20110130092434.42a887ef@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


The hypervisor uses unsigned 1 byte counters to signal topology changes to
the OS. Since they can wrap we need to check for any difference, not just if
the hypervisor count is greater than the previous count.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-2.6/arch/powerpc/mm/numa.c
===================================================================
--- linux-2.6.orig/arch/powerpc/mm/numa.c	2011-01-29 11:16:56.741843175 +1100
+++ linux-2.6/arch/powerpc/mm/numa.c	2011-01-29 12:44:42.059356526 +1100
@@ -1342,7 +1342,7 @@ static int update_cpu_associativity_chan
 		volatile u8 *hypervisor_counts = lppaca[cpu].vphn_assoc_counts;
 
 		for (i = 0; i < distance_ref_points_depth; i++) {
-			if (hypervisor_counts[i] > counts[i]) {
+			if (hypervisor_counts[i] != counts[i]) {
 				counts[i] = hypervisor_counts[i];
 				changed = 1;
 			}
