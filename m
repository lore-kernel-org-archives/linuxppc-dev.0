Return-Path: <jochen@scram.de>
Received: from mail0.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail0.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 51919DDEC8
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 25 Sep 2007 03:15:08 +1000 (EST)
Message-ID: <46F7F091.7000406@scram.de>
Date: Mon, 24 Sep 2007 19:14:57 +0200
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: [PATCH#2 2/4] [PPC] Fix cpm_dpram_addr returning phys mem instead
	of virt mem
Content-Type: multipart/mixed; boundary="------------080108060506090808090900"
Cc: linux-kernel@vger.kernel.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------080108060506090808090900
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

cpm_dpram_addr returns physical memory of the DP RAM instead of
iomapped virtual memory. As there usually is a 1:1 MMU map of
the IMMR area, this is often not noticed. However, cpm_dpram_phys
assumes this iomapped virtual memory and returns garbage on the
1:1 mapped memory causing CPM1 uart console to fail.

This patch fixes the problem (copied from the powerpc tree).

Signed-off-by: Jochen Friedrich <jochen@scram.de>
---
 arch/ppc/8xx_io/commproc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

--------------080108060506090808090900
Content-Type: text/x-patch;
 name="e99a679ff14fb0073efd9220f5aa933e47516202.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="e99a679ff14fb0073efd9220f5aa933e47516202.diff"

diff --git a/arch/ppc/8xx_io/commproc.c b/arch/ppc/8xx_io/commproc.c
index 7088428..9da880b 100644
--- a/arch/ppc/8xx_io/commproc.c
+++ b/arch/ppc/8xx_io/commproc.c
@@ -459,7 +459,7 @@ EXPORT_SYMBOL(cpm_dpdump);
 
 void *cpm_dpram_addr(unsigned long offset)
 {
-	return ((immap_t *)IMAP_ADDR)->im_cpm.cp_dpmem + offset;
+	return (void *)(dpram_vbase + offset);
 }
 EXPORT_SYMBOL(cpm_dpram_addr);
 


--------------080108060506090808090900--
