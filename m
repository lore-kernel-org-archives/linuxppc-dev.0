Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp07.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 054912C00E1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Sep 2012 19:30:09 +1000 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 21 Sep 2012 15:00:00 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q8L9TuBJ48168992
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Sep 2012 14:59:56 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q8LExWDK008009
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Sep 2012 20:29:32 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, shangw@linux.vnet.ibm.com
Subject: [PATCH] arch/powerpc: Don't release eeh_mutex in eeh_phb_pe_get
Date: Fri, 21 Sep 2012 14:59:46 +0530
Message-Id: <1348219786-31221-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

=====================================
[ BUG: bad unlock balance detected! ]
3.6.0-rc5-00338-gcaa1d63-dirty #6 Not tainted
-------------------------------------
swapper/0/1 is trying to release lock (eeh_mutex) at:
[<c000000000058218>] .eeh_add_to_parent_pe+0x318/0x410
but there are no more locks to release!

other info that might help us debug this:
no locks held by swapper/0/1.

stack backtrace:
Call Trace:
[c00000003e483870] [c000000000013310] .show_stack+0x70/0x1c0 (unreliable)
[c00000003e483920] [c0000000000d8310] .print_unlock_inbalance_bug+0x110/0x120
[c00000003e4839b0] [c0000000000d9a50] .lock_release+0x1d0/0x240
[c00000003e483a60] [c000000000778064] .__mutex_unlock_slowpath+0xb4/0x250
[c00000003e483b10] [c000000000058218] .eeh_add_to_parent_pe+0x318/0x410
[c00000003e483bc0] [c00000000005a118] .pseries_eeh_of_probe+0x258/0x2f0
[c00000003e483cc0] [c000000000032528] .traverse_pci_devices+0xa8/0x150
[c00000003e483d70] [c000000000aa7288] .eeh_init+0xd4/0x140
[c00000003e483e00] [c00000000000abc4] .do_one_initcall+0x64/0x1e0
[c00000003e483ec0] [c000000000a90418] .kernel_init+0x1e8/0x2bc
[c00000003e483f90] [c00000000002048c] .kernel_thread+0x54/0x70
EEH: PCI Enhanced I/O Error Handling Enabled

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/eeh_pe.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/eeh_pe.c b/arch/powerpc/platforms/pseries/eeh_pe.c
index 9d35543..797cd18 100644
--- a/arch/powerpc/platforms/pseries/eeh_pe.c
+++ b/arch/powerpc/platforms/pseries/eeh_pe.c
@@ -105,11 +105,8 @@ static struct eeh_pe *eeh_phb_pe_get(struct pci_controller *phb)
 		 * the PE for PHB has been determined when that
 		 * was created.
 		 */
-		if ((pe->type & EEH_PE_PHB) &&
-		    pe->phb == phb) {
-			eeh_unlock();
+		if ((pe->type & EEH_PE_PHB) && pe->phb == phb)
 			return pe;
-		}
 	}
 
 	return NULL;
-- 
1.7.10
