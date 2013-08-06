Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH 56/63] [SCSI] lpfc: Don't force CONFIG_GENERIC_CSUM on
Date: Wed,  7 Aug 2013 02:02:13 +1000
Message-Id: <1375804940-22050-57-git-send-email-anton@samba.org>
In-Reply-To: <1375804940-22050-1-git-send-email-anton@samba.org>
References: <1375804940-22050-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We want ppc64 to be able to select between optimised assembly
checksum routines in big endian, and the generic lib/checksum.c
routines in little endian.

The lpfc driver is forcing CONFIG_GENERIC_CSUM on which means
we are unable to make the choice of when to enable and disable
it in the arch Kconfig. If the option exists it is always
forced on.

Other users of the checksum routines (eg networking code) do
not have a select CONFIG_GENERIC_CSUM, so I don't see why
the lpfc driver should.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 drivers/scsi/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
index 48b2918..92ff027 100644
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -1353,7 +1353,6 @@ config SCSI_LPFC
 	tristate "Emulex LightPulse Fibre Channel Support"
 	depends on PCI && SCSI
 	select SCSI_FC_ATTRS
-	select GENERIC_CSUM
 	select CRC_T10DIF
 	help
           This lpfc driver supports the Emulex LightPulse
-- 
1.8.1.2
