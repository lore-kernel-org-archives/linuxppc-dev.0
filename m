Return-Path: <SRS0=ZqAX=PD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 486A2C43387
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Dec 2018 04:06:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B941821720
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Dec 2018 04:05:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B941821720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43PfXP55WwzDqHZ
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Dec 2018 15:05:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=telegraphics.com.au
 (client-ip=98.124.60.144; helo=kvm5.telegraphics.com.au;
 envelope-from=fthain@telegraphics.com.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=telegraphics.com.au
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 43PfDF5BSHzDqJh
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Dec 2018 14:51:57 +1100 (AEDT)
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
 id 9772829510; Tue, 25 Dec 2018 19:43:55 -0500 (EST)
To: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Michael Schmitz <schmitzmic@gmail.com>
Message-Id: <e68fcc3ec0a6cd4e14f763366d4d9445890b9b82.1545784679.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1545784679.git.fthain@telegraphics.com.au>
References: <cover.1545784679.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v8 01/25] scsi/atari_scsi: Don't select CONFIG_NVRAM
Date: Wed, 26 Dec 2018 11:37:59 +1100
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On powerpc, setting CONFIG_NVRAM=n builds a kernel with no NVRAM support.
Setting CONFIG_NVRAM=m enables the /dev/nvram misc device module without
enabling NVRAM support in drivers. Setting CONFIG_NVRAM=y enables the
misc device (built-in) and also enables NVRAM support in drivers.

m68k shares the valkyriefb driver with powerpc, and since that driver uses
NVRAM, it is affected by CONFIG_ATARI_SCSI, because of the use of
"select NVRAM".

Adopt the powerpc convention on m68k to avoid surprises.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Tested-by: Christian T. Steigies <cts@debian.org>
---
This patch temporarily disables CONFIG_NVRAM on Atari, to prevent build
failures when bisecting the rest of this patch series. It gets enabled
again with the introduction of CONFIG_HAVE_ARCH_NVRAM_OPS, once the
nvram_* global functions have been moved to an ops struct.
---
 drivers/char/Kconfig      | 5 +----
 drivers/scsi/Kconfig      | 6 +++---
 drivers/scsi/atari_scsi.c | 7 ++++---
 3 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index 9d03b2ff5df6..5b54595dfe30 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -236,7 +236,7 @@ source "drivers/char/hw_random/Kconfig"
 
 config NVRAM
 	tristate "/dev/nvram support"
-	depends on ATARI || X86 || GENERIC_NVRAM
+	depends on X86 || GENERIC_NVRAM
 	---help---
 	  If you say Y here and create a character special file /dev/nvram
 	  with major number 10 and minor number 144 using mknod ("man mknod"),
@@ -254,9 +254,6 @@ config NVRAM
 	  should NEVER idly tamper with it. See Ralf Brown's interrupt list
 	  for a guide to the use of CMOS bytes by your BIOS.
 
-	  On Atari machines, /dev/nvram is always configured and does not need
-	  to be selected.
-
 	  To compile this driver as a module, choose M here: the
 	  module will be called nvram.
 
diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
index 640cd1b31a18..924eb69e7fc4 100644
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -1381,14 +1381,14 @@ config ATARI_SCSI
 	tristate "Atari native SCSI support"
 	depends on ATARI && SCSI
 	select SCSI_SPI_ATTRS
-	select NVRAM
 	---help---
 	  If you have an Atari with built-in NCR5380 SCSI controller (TT,
 	  Falcon, ...) say Y to get it supported. Of course also, if you have
 	  a compatible SCSI controller (e.g. for Medusa).
 
-	  To compile this driver as a module, choose M here: the
-	  module will be called atari_scsi.
+	  To compile this driver as a module, choose M here: the module will
+	  be called atari_scsi. If you also enable NVRAM support, the SCSI
+	  host's ID is taken from the setting in TT RTC NVRAM.
 
 	  This driver supports both styles of NCR integration into the
 	  system: the TT style (separate DMA), and the Falcon style (via
diff --git a/drivers/scsi/atari_scsi.c b/drivers/scsi/atari_scsi.c
index 89f5154c40b6..99e5729d910d 100644
--- a/drivers/scsi/atari_scsi.c
+++ b/drivers/scsi/atari_scsi.c
@@ -755,9 +755,10 @@ static int __init atari_scsi_probe(struct platform_device *pdev)
 	if (ATARIHW_PRESENT(TT_SCSI) && setup_sg_tablesize >= 0)
 		atari_scsi_template.sg_tablesize = setup_sg_tablesize;
 
-	if (setup_hostid >= 0) {
+	if (setup_hostid >= 0)
 		atari_scsi_template.this_id = setup_hostid & 7;
-	} else {
+#ifdef CONFIG_NVRAM
+	else
 		/* Test if a host id is set in the NVRam */
 		if (ATARIHW_PRESENT(TT_CLK) && nvram_check_checksum()) {
 			unsigned char b = nvram_read_byte(16);
@@ -768,7 +769,7 @@ static int __init atari_scsi_probe(struct platform_device *pdev)
 			if (b & 0x80)
 				atari_scsi_template.this_id = b & 7;
 		}
-	}
+#endif
 
 	/* If running on a Falcon and if there's TT-Ram (i.e., more than one
 	 * memory block, since there's always ST-Ram in a Falcon), then
-- 
2.19.2

