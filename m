Return-Path: <ionut.nicu@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 59BCCDE031
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Mar 2008 04:28:19 +1100 (EST)
From: Ionut Nicu <ionut.nicu@freescale.com>
To: linuxppc-dev@ozlabs.org, galak@kernel.crashing.org
Subject: [PATCH] Make qe_get_firmware_info reentrant
Date: Fri,  7 Mar 2008 19:27:59 +0200
Message-Id: <1204910879-18584-1-git-send-email-ionut.nicu@freescale.com>
Cc: Ionut Nicu <ionut.nicu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The function was returning NULL the second time it was
called if the firmware was uploaded from the boot loader
or the first time it was called if the firmware was
uploaded from the kernel.

Signed-off-by: Ionut Nicu <ionut.nicu@freescale.com>
Acked-By: Timur Tabi <timur@freescale.com>
---
 arch/powerpc/sysdev/qe_lib/qe.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/sysdev/qe_lib/qe.c b/arch/powerpc/sysdev/qe_lib/qe.c
index 6efbd5e..53d61a0 100644
--- a/arch/powerpc/sysdev/qe_lib/qe.c
+++ b/arch/powerpc/sysdev/qe_lib/qe.c
@@ -609,7 +609,10 @@ struct qe_firmware_info *qe_get_firmware_info(void)
 	 * If we haven't checked yet, and a driver hasn't uploaded a firmware
 	 * yet, then check the device tree for information.
 	 */
-	if (initialized || qe_firmware_uploaded)
+	if (qe_firmware_uploaded)
+		return &qe_firmware_info;
+
+	if (initialized)
 		return NULL;
 
 	initialized = 1;
-- 
1.5.4.2
