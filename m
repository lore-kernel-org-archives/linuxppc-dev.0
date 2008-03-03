Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 04147DDF2F
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Mar 2008 04:50:32 +1100 (EST)
From: Timur Tabi <timur@freescale.com>
To: galak@kernel.crashing.org, linuxppc-dev@ozlabs.org
Subject: [PATCH] fix QE firmware uploading limit
Date: Mon,  3 Mar 2008 11:11:30 -0600
Message-Id: <1204564290-18283-1-git-send-email-timur@freescale.com>
Cc: Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Fix a typo in qe_upload_firmware() that prevented uploading firmware on
systems with more than one RISC core.

Signed-off-by: Timur Tabi <timur@freescale.com>
---

This patch is for 2.6.25.

 arch/powerpc/sysdev/qe_lib/qe.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/sysdev/qe_lib/qe.c b/arch/powerpc/sysdev/qe_lib/qe.c
index 6efbd5e..f963fbf 100644
--- a/arch/powerpc/sysdev/qe_lib/qe.c
+++ b/arch/powerpc/sysdev/qe_lib/qe.c
@@ -509,7 +509,7 @@ int qe_upload_firmware(const struct qe_firmware *firmware)
 	}
 
 	/* Validate some of the fields */
-	if ((firmware->count < 1) || (firmware->count >= MAX_QE_RISC)) {
+	if ((firmware->count < 1) || (firmware->count > MAX_QE_RISC)) {
 		printk(KERN_ERR "qe-firmware: invalid data\n");
 		return -EINVAL;
 	}
-- 
1.5.4
