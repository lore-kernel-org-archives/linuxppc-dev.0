Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 57A5A1A0024
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2015 20:35:27 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: hch@lst.de, JBottomley@Odin.com, snitzer@redhat.com, hare@suse.de,
 martin.petersen@oracle.com
Subject: [PATCH] powerpc/configs: Re-enable CONFIG_SCSI_DH
Date: Tue, 29 Sep 2015 20:35:08 +1000
Message-Id: <1443522908-25523-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 086b91d052eb ("scsi_dh: integrate into the core SCSI code")
changed CONFIG_SCSI_DH from tristate to bool.

Our defconfigs have CONFIG_SCSI_DH=m, which the kconfig machinery warns
us is invalid, but instead of converting it to =y it leaves it unset.
This means we loose the CONFIG_SCSI_DH code and everything that depends
on it.

So convert the values in the defconfigs to =y.

Fixes: 086b91d052eb ("scsi_dh: integrate into the core SCSI code")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/configs/ppc64_defconfig   | 2 +-
 arch/powerpc/configs/pseries_defconfig | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/configs/ppc64_defconfig b/arch/powerpc/configs/ppc64_defconfig
index 6bc0ee4b1070..2c041b535a64 100644
--- a/arch/powerpc/configs/ppc64_defconfig
+++ b/arch/powerpc/configs/ppc64_defconfig
@@ -111,7 +111,7 @@ CONFIG_SCSI_QLA_FC=m
 CONFIG_SCSI_QLA_ISCSI=m
 CONFIG_SCSI_LPFC=m
 CONFIG_SCSI_VIRTIO=m
-CONFIG_SCSI_DH=m
+CONFIG_SCSI_DH=y
 CONFIG_SCSI_DH_RDAC=m
 CONFIG_SCSI_DH_ALUA=m
 CONFIG_ATA=y
diff --git a/arch/powerpc/configs/pseries_defconfig b/arch/powerpc/configs/pseries_defconfig
index 7991f37e5fe2..36871a4bfa54 100644
--- a/arch/powerpc/configs/pseries_defconfig
+++ b/arch/powerpc/configs/pseries_defconfig
@@ -114,7 +114,7 @@ CONFIG_SCSI_QLA_FC=m
 CONFIG_SCSI_QLA_ISCSI=m
 CONFIG_SCSI_LPFC=m
 CONFIG_SCSI_VIRTIO=m
-CONFIG_SCSI_DH=m
+CONFIG_SCSI_DH=y
 CONFIG_SCSI_DH_RDAC=m
 CONFIG_SCSI_DH_ALUA=m
 CONFIG_ATA=y
-- 
2.1.4
