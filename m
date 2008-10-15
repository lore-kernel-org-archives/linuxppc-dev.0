Return-Path: <benh@ozlabs.org>
To: <dougthompson@xmission.com>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 15 Oct 2008 15:40:19 +1100
Subject: [PATCH] edac/cell: Fix incorrect edac_mode in csrow causing oops
Message-Id: <20081015044057.584D6DDDFB@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, mniyer@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The cell_edac driver is setting the edac_mode field of the
csrow's to an incorrect value, causing the sysfs show routine
for that field to go out of an array bound and Oopsing the kernel
when used.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 drivers/edac/cell_edac.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-work.orig/drivers/edac/cell_edac.c	2008-10-15 15:35:21.000000000 +1100
+++ linux-work/drivers/edac/cell_edac.c	2008-10-15 15:35:29.000000000 +1100
@@ -142,7 +142,7 @@ static void __devinit cell_edac_init_csr
 		csrow->nr_pages = (r.end - r.start + 1) >> PAGE_SHIFT;
 		csrow->last_page = csrow->first_page + csrow->nr_pages - 1;
 		csrow->mtype = MEM_XDR;
-		csrow->edac_mode = EDAC_FLAG_EC | EDAC_FLAG_SECDED;
+		csrow->edac_mode = EDAC_SECDED;
 		dev_dbg(mci->dev,
 			"Initialized on node %d, chanmask=0x%x,"
 			" first_page=0x%lx, nr_pages=0x%x\n",
