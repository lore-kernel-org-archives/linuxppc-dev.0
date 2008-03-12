Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-quonix.sasl.smtp.pobox.com
	[208.72.237.25]) by ozlabs.org (Postfix) with ESMTP id DF6BFDE076
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Mar 2008 10:46:08 +1100 (EST)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 45F1F2B6C
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Mar 2008 19:45:57 -0400 (EDT)
Received: from thinkcentre (24-155-246-53.dyn.grandenetworks.net
	[24.155.246.53]) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
	ESMTP id
	CD3D32B6B for <linuxppc-dev@ozlabs.org>; Wed, 12 Mar 2008 19:45:55 -0400
	(EDT)
From: Nathan Lynch <ntl@pobox.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/3] maple: enable ipr driver in defconfig
Date: Wed, 12 Mar 2008 18:43:05 -0500
Message-Id: <1205365385-28315-4-git-send-email-ntl@pobox.com>
In-Reply-To: <1205365385-28315-1-git-send-email-ntl@pobox.com>
References: <1205365385-28315-1-git-send-email-ntl@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Some machines supported by the maple platform have an Obsidian
controller which can't be used without enabling CONFIG_IPR and the
options on which it depends.

Signed-off-by: Nathan Lynch <ntl@pobox.com>
---
 arch/powerpc/configs/maple_defconfig |  133 ++++++++++++++++++++++++++++++++--
 1 files changed, 128 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/configs/maple_defconfig b/arch/powerpc/configs/maple_defconfig
index 8b810d0..25be62b 100644
--- a/arch/powerpc/configs/maple_defconfig
+++ b/arch/powerpc/configs/maple_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.24-rc4
-# Thu Dec  6 16:48:26 2007
+# Wed Mar 12 16:21:48 2008
 #
 CONFIG_PPC64=y
 
@@ -333,7 +333,7 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
-# CONFIG_FW_LOADER is not set
+CONFIG_FW_LOADER=y
 # CONFIG_DEBUG_DRIVER is not set
 # CONFIG_DEBUG_DEVRES is not set
 # CONFIG_SYS_HYPERVISOR is not set
@@ -374,6 +374,7 @@ CONFIG_BLK_DEV_IDEDISK=y
 CONFIG_BLK_DEV_IDECD=y
 # CONFIG_BLK_DEV_IDETAPE is not set
 # CONFIG_BLK_DEV_IDEFLOPPY is not set
+# CONFIG_BLK_DEV_IDESCSI is not set
 CONFIG_IDE_TASK_IOCTL=y
 CONFIG_IDE_PROC_FS=y
 
@@ -427,10 +428,129 @@ CONFIG_IDE_ARCH_OBSOLETE_INIT=y
 # SCSI device support
 #
 # CONFIG_RAID_ATTRS is not set
-# CONFIG_SCSI is not set
-# CONFIG_SCSI_DMA is not set
+CONFIG_SCSI=y
+CONFIG_SCSI_DMA=y
+# CONFIG_SCSI_TGT is not set
 # CONFIG_SCSI_NETLINK is not set
-# CONFIG_ATA is not set
+# CONFIG_SCSI_PROC_FS is not set
+
+#
+# SCSI support type (disk, tape, CD-ROM)
+#
+CONFIG_BLK_DEV_SD=y
+# CONFIG_CHR_DEV_ST is not set
+# CONFIG_CHR_DEV_OSST is not set
+# CONFIG_BLK_DEV_SR is not set
+CONFIG_CHR_DEV_SG=y
+# CONFIG_CHR_DEV_SCH is not set
+
+#
+# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
+#
+# CONFIG_SCSI_MULTI_LUN is not set
+# CONFIG_SCSI_CONSTANTS is not set
+# CONFIG_SCSI_LOGGING is not set
+# CONFIG_SCSI_SCAN_ASYNC is not set
+CONFIG_SCSI_WAIT_SCAN=m
+
+#
+# SCSI Transports
+#
+# CONFIG_SCSI_SPI_ATTRS is not set
+# CONFIG_SCSI_FC_ATTRS is not set
+# CONFIG_SCSI_ISCSI_ATTRS is not set
+# CONFIG_SCSI_SAS_LIBSAS is not set
+# CONFIG_SCSI_SRP_ATTRS is not set
+CONFIG_SCSI_LOWLEVEL=y
+# CONFIG_ISCSI_TCP is not set
+# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
+# CONFIG_SCSI_3W_9XXX is not set
+# CONFIG_SCSI_ACARD is not set
+# CONFIG_SCSI_AACRAID is not set
+# CONFIG_SCSI_AIC7XXX is not set
+# CONFIG_SCSI_AIC7XXX_OLD is not set
+# CONFIG_SCSI_AIC79XX is not set
+# CONFIG_SCSI_AIC94XX is not set
+# CONFIG_SCSI_ARCMSR is not set
+# CONFIG_MEGARAID_NEWGEN is not set
+# CONFIG_MEGARAID_LEGACY is not set
+# CONFIG_MEGARAID_SAS is not set
+# CONFIG_SCSI_HPTIOP is not set
+# CONFIG_SCSI_DMX3191D is not set
+# CONFIG_SCSI_EATA is not set
+# CONFIG_SCSI_FUTURE_DOMAIN is not set
+# CONFIG_SCSI_GDTH is not set
+# CONFIG_SCSI_IPS is not set
+# CONFIG_SCSI_INITIO is not set
+# CONFIG_SCSI_INIA100 is not set
+# CONFIG_SCSI_STEX is not set
+# CONFIG_SCSI_SYM53C8XX_2 is not set
+CONFIG_SCSI_IPR=y
+CONFIG_SCSI_IPR_TRACE=y
+CONFIG_SCSI_IPR_DUMP=y
+# CONFIG_SCSI_QLOGIC_1280 is not set
+# CONFIG_SCSI_QLA_FC is not set
+# CONFIG_SCSI_QLA_ISCSI is not set
+# CONFIG_SCSI_LPFC is not set
+# CONFIG_SCSI_DC395x is not set
+# CONFIG_SCSI_DC390T is not set
+# CONFIG_SCSI_DEBUG is not set
+# CONFIG_SCSI_SRP is not set
+CONFIG_ATA=y
+CONFIG_ATA_NONSTANDARD=y
+# CONFIG_SATA_AHCI is not set
+# CONFIG_SATA_SVW is not set
+# CONFIG_ATA_PIIX is not set
+# CONFIG_SATA_MV is not set
+# CONFIG_SATA_NV is not set
+# CONFIG_PDC_ADMA is not set
+# CONFIG_SATA_QSTOR is not set
+# CONFIG_SATA_PROMISE is not set
+# CONFIG_SATA_SX4 is not set
+# CONFIG_SATA_SIL is not set
+# CONFIG_SATA_SIL24 is not set
+# CONFIG_SATA_SIS is not set
+# CONFIG_SATA_ULI is not set
+# CONFIG_SATA_VIA is not set
+# CONFIG_SATA_VITESSE is not set
+# CONFIG_SATA_INIC162X is not set
+# CONFIG_PATA_ALI is not set
+# CONFIG_PATA_AMD is not set
+# CONFIG_PATA_ARTOP is not set
+# CONFIG_PATA_ATIIXP is not set
+# CONFIG_PATA_CMD640_PCI is not set
+# CONFIG_PATA_CMD64X is not set
+# CONFIG_PATA_CS5520 is not set
+# CONFIG_PATA_CS5530 is not set
+# CONFIG_PATA_CYPRESS is not set
+# CONFIG_PATA_EFAR is not set
+# CONFIG_ATA_GENERIC is not set
+# CONFIG_PATA_HPT366 is not set
+# CONFIG_PATA_HPT37X is not set
+# CONFIG_PATA_HPT3X2N is not set
+# CONFIG_PATA_HPT3X3 is not set
+# CONFIG_PATA_IT821X is not set
+# CONFIG_PATA_IT8213 is not set
+# CONFIG_PATA_JMICRON is not set
+# CONFIG_PATA_TRIFLEX is not set
+# CONFIG_PATA_MARVELL is not set
+# CONFIG_PATA_MPIIX is not set
+# CONFIG_PATA_OLDPIIX is not set
+# CONFIG_PATA_NETCELL is not set
+# CONFIG_PATA_NS87410 is not set
+# CONFIG_PATA_NS87415 is not set
+# CONFIG_PATA_OPTI is not set
+# CONFIG_PATA_OPTIDMA is not set
+# CONFIG_PATA_PDC_OLD is not set
+# CONFIG_PATA_RADISYS is not set
+# CONFIG_PATA_RZ1000 is not set
+# CONFIG_PATA_SC1200 is not set
+# CONFIG_PATA_SERVERWORKS is not set
+# CONFIG_PATA_PDC2027X is not set
+# CONFIG_PATA_SIL680 is not set
+# CONFIG_PATA_SIS is not set
+# CONFIG_PATA_VIA is not set
+# CONFIG_PATA_WINBOND is not set
 # CONFIG_MD is not set
 # CONFIG_FUSION is not set
 
@@ -536,6 +656,7 @@ CONFIG_USB_PEGASUS=y
 # CONFIG_HIPPI is not set
 # CONFIG_PPP is not set
 # CONFIG_SLIP is not set
+# CONFIG_NET_FC is not set
 # CONFIG_SHAPER is not set
 # CONFIG_NETCONSOLE is not set
 # CONFIG_NETPOLL is not set
@@ -783,12 +904,14 @@ CONFIG_USB_UHCI_HCD=y
 #
 # may also be needed; see USB_STORAGE Help for more information
 #
+# CONFIG_USB_STORAGE is not set
 # CONFIG_USB_LIBUSUAL is not set
 
 #
 # USB Imaging devices
 #
 # CONFIG_USB_MDC800 is not set
+# CONFIG_USB_MICROTEK is not set
 CONFIG_USB_MON=y
 
 #
-- 
1.5.4.4
