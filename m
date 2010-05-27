Return-Path: <dkirjanov@hera.kernel.org>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E5708B7D1F
	for <linuxppc-dev@ozlabs.org>; Fri, 28 May 2010 00:20:01 +1000 (EST)
Date: Thu, 27 May 2010 14:19:52 +0000
From: Denis Kirjanov <dkirjanov@hera.kernel.org>
To: arnd@arndb.de
Subject: [PATCH] powerpc/cell: Fix integer constant warning
Message-ID: <20100527141952.GA15760@hera.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: paulus@samba.org, adobriyan@gmail.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fix smatch warning:  warning: constant 0x800000000 is so big it is long

Signed-off-by: Denis Kirjanov <dkirjanov@kernel.org>
---
arch/powerpc/platforms/cell/iommu.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/cell/iommu.c b/arch/powerpc/platforms/cell/iommu.c
index e3ec497..0a33aed 100644
--- a/arch/powerpc/platforms/cell/iommu.c
+++ b/arch/powerpc/platforms/cell/iommu.c
@@ -1067,7 +1067,7 @@ static int __init cell_iommu_fixed_mapping_init(void)
 	fbase = _ALIGN_UP(fbase, 1 << IO_SEGMENT_SHIFT);
 	fsize = lmb_phys_mem_size();
 
-	if ((fbase + fsize) <= 0x800000000)
+	if ((fbase + fsize) <= 0x800000000ul)
 		hbase = 0; /* use the device tree window */
 	else {
 		/* If we're over 32 GB we need to cheat. We can't map all of
