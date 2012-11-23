Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e5.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C388F2C008C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Nov 2012 18:58:46 +1100 (EST)
Received: from /spool/local
 by e5.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Fri, 23 Nov 2012 02:58:43 -0500
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 31161C9003E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Nov 2012 02:58:40 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 qAN7wd4b288262
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Nov 2012 02:58:40 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 qAN7wdOv001420
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Nov 2012 02:58:39 -0500
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/eeh: Do not invalidate PE properly
Date: Fri, 23 Nov 2012 18:58:26 +1100
Message-Id: <1353657506-26306-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

While the EEH does recovery on the specific PE that has PCI errors,
the PCI devices belonging to the PE will be removed and the PE will
be marked as invalid since we still need the information stored in
the PE. We only invalidate the PE when it doesn't have associated
EEH devices and valid child PEs. However, the code used to check
that is wrong. The patch fixes that.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/eeh_pe.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/eeh_pe.c b/arch/powerpc/platforms/pseries/eeh_pe.c
index 44da51a..0ebbb8f 100644
--- a/arch/powerpc/platforms/pseries/eeh_pe.c
+++ b/arch/powerpc/platforms/pseries/eeh_pe.c
@@ -464,7 +464,7 @@ int eeh_rmv_from_parent_pe(struct eeh_dev *edev, int purge_pe)
 			if (list_empty(&pe->edevs)) {
 				cnt = 0;
 				list_for_each_entry(child, &pe->child_list, child) {
-					if (!(pe->type & EEH_PE_INVALID)) {
+					if (!(child->type & EEH_PE_INVALID)) {
 						cnt++;
 						break;
 					}
-- 
1.7.5.4
