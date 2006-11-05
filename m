Return-Path: <hnguyen@de.ibm.com>
Received: from mtagate2.uk.ibm.com (mtagate2.uk.ibm.com [195.212.29.135])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate2.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 831A767C20
	for <linuxppc-dev@ozlabs.org>; Mon,  6 Nov 2006 07:46:02 +1100 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate2.uk.ibm.com (8.13.8/8.13.8) with ESMTP id kA5KjOdK156960
	for <linuxppc-dev@ozlabs.org>; Sun, 5 Nov 2006 20:45:24 GMT
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
	[9.149.37.212])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with
	ESMTP id kA5Km5HV2343108
	for <linuxppc-dev@ozlabs.org>; Sun, 5 Nov 2006 20:48:05 GMT
Received: from d06av01.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av01.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id kA5KjFbV028341
	for <linuxppc-dev@ozlabs.org>; Sun, 5 Nov 2006 20:45:15 GMT
From: Hoang-Nam Nguyen <hnguyen@de.ibm.com>
To: rolandd@cisco.com
Subject: [PATCH 2.6.19 2/4] ehca: hcp_phyp.c: correct page mapping in 64k page
	mode
Date: Sun, 5 Nov 2006 21:41:28 +0100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_5xkTFOip1X5A9Ve"
Message-Id: <200611052141.29030.hnguyen@de.ibm.com>
Cc: linuxppc-dev@ozlabs.org, raisch@de.ibm.com, linux-kernel@vger.kernel.org,
	openib-general@openib.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Boundary-00=_5xkTFOip1X5A9Ve
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello Roland!
This is another patch of ehca for 64k page support. It fixes a bug that maps
4k aligned addresses in 64k page mode in a wrong way.
Thanks!
Nam


Signed-off-by: Hoang-Nam Nguyen <hnguyen@de.ibm.com>
---


 hcp_phyp.c |    5 +++--0018_64kpage_ioremap.patch  
 1 files changed, 3 insertions(+), 2 deletions(-)


diff --git a/drivers/infiniband/hw/ehca/hcp_phyp.c b/drivers/infiniband/hw/ehca/hcp_phyp.c
index 0b1a477..6237252 100644
--- a/drivers/infiniband/hw/ehca/hcp_phyp.c
+++ b/drivers/infiniband/hw/ehca/hcp_phyp.c
@@ -44,13 +44,14 @@ #include "hipz_hw.h"
 
 int hcall_map_page(u64 physaddr, u64 *mapaddr)
 {
- *mapaddr = (u64)(ioremap(physaddr, EHCA_PAGESIZE));
+ *mapaddr = (u64)ioremap((physaddr & PAGE_MASK), PAGE_SIZE) +
+  (physaddr & (~PAGE_MASK));
  return 0;
 }
 
 int hcall_unmap_page(u64 mapaddr)
 {
- iounmap((volatile void __iomem*)mapaddr);
+ iounmap((void __iomem*)(mapaddr & PAGE_MASK));
  return 0;
 }
 

--Boundary-00=_5xkTFOip1X5A9Ve
Content-Type: text/x-diff;
  charset="us-ascii";
  name="roland_svnehca_0018_64kpage_ioremap.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="roland_svnehca_0018_64kpage_ioremap.patch"

diff --git a/drivers/infiniband/hw/ehca/hcp_phyp.c b/drivers/infiniband/hw/ehca/hcp_phyp.c
index 0b1a477..6237252 100644
--- a/drivers/infiniband/hw/ehca/hcp_phyp.c
+++ b/drivers/infiniband/hw/ehca/hcp_phyp.c
@@ -44,13 +44,14 @@ #include "hipz_hw.h"
 
 int hcall_map_page(u64 physaddr, u64 *mapaddr)
 {
-	*mapaddr = (u64)(ioremap(physaddr, EHCA_PAGESIZE));
+	*mapaddr = (u64)ioremap((physaddr & PAGE_MASK), PAGE_SIZE) +
+		(physaddr & (~PAGE_MASK));
 	return 0;
 }
 
 int hcall_unmap_page(u64 mapaddr)
 {
-	iounmap((volatile void __iomem*)mapaddr);
+	iounmap((void __iomem*)(mapaddr & PAGE_MASK));
 	return 0;
 }
 

--Boundary-00=_5xkTFOip1X5A9Ve--
