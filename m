Return-Path: <pbathija@amcc.com>
Received: from sdcmail01.amcc.com (sdcmail01.amcc.com [198.137.200.72])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "Messaging Gateway Appliance Demo Cert",
	Issuer "Messaging Gateway Appliance Demo Cert" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 5DCFBB7BEF
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Dec 2009 12:51:49 +1100 (EST)
From: Pravin Bathija <pbathija@amcc.com>
To: linux-scsi@vger.kernel.org
Subject: [PATCH] [SCSI] mpt fusion: Fix 32 bit platforms with 64 bit resources.
Date: Wed,  2 Dec 2009 17:51:46 -0800
Message-Id: <1259805106-23636-1-git-send-email-pbathija@amcc.com>
Cc: linuxppc-dev@ozlabs.org, Eric.Moore@lsi.com,
	Pravin Bathija <pbathija@amcc.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

    Powerpc 44x uses 36 bit real address while the real address defined
    in MPT Fusion driver is of type 32 bit. This causes ioremap to fail and driver
    fails to initialize. This fix changes the data types representing the real
    address from unsigned long 32-bit types to resource_size_t which is 64-bit. The
    driver has been tested, the disks get discovered correctly and can do IO.

Signed-off-by: Pravin Bathija <pbathija@amcc.com>
Acked-by: Feng Kan <fkan@amcc.com>
Acked-by: Fushen Chen <fchen@amcc.com>
Acked-by: Loc Ho <lho@amcc.com>
Acked-by: Tirumala Reddy Marri <tmarri@amcc.com>
Acked-by: Victor Gallardo <vgallardo@amcc.com>
---
 drivers/message/fusion/mptbase.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/message/fusion/mptbase.c b/drivers/message/fusion/mptbase.c
index 5d496a9..9f14a60 100644
--- a/drivers/message/fusion/mptbase.c
+++ b/drivers/message/fusion/mptbase.c
@@ -1511,7 +1511,7 @@ mpt_mapresources(MPT_ADAPTER *ioc)
 {
 	u8		__iomem *mem;
 	int		 ii;
-	unsigned long	 mem_phys;
+	resource_size_t	 mem_phys;
 	unsigned long	 port;
 	u32		 msize;
 	u32		 psize;
-- 
1.5.5
