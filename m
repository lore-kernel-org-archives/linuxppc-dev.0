Return-Path: <SRS0=bLNb=WQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 364D0C3A589
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Aug 2019 15:19:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B548F216F4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Aug 2019 15:19:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B548F216F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46CZFq68s0zDqHF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Aug 2019 01:19:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=suse.de
 (client-ip=195.135.220.15; helo=mx1.suse.de; envelope-from=msuchanek@suse.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=suse.de
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46CYz64ZSFzDr1C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Aug 2019 01:06:26 +1000 (AEST)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 52E5BAE42;
 Tue, 20 Aug 2019 15:06:23 +0000 (UTC)
From: Michal Suchanek <msuchanek@suse.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/fadump: when fadump is supported register the fadump
 sysfs files.
Date: Tue, 20 Aug 2019 17:06:16 +0200
Message-Id: <20190820150616.4333-1-msuchanek@suse.de>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: Yangtao Li <tiny.windzz@gmail.com>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Hari Bathini <hbathini@linux.vnet.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Michal Suchanek <msuchanek@suse.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Currently it is not possible to distinguish the case when fadump is
supported by firmware and disabled in kernel and completely unsupported
using the kernel sysfs interface. User can investigate the devicetree
but it is more reasonable to provide sysfs files in case we get some
fadumpv2 in the future.

With this patch sysfs files are available whenever fadump is supported
by firmware.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 arch/powerpc/kernel/fadump.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 4eab97292cc2..f35ab2433a9b 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -1671,13 +1671,9 @@ static void fadump_init_files(void)
  */
 int __init setup_fadump(void)
 {
-	if (!fw_dump.fadump_enabled)
-		return 0;
-
-	if (!fw_dump.fadump_supported) {
+	if (!fw_dump.fadump_supported && fw_dump.fadump_enabled) {
 		printk(KERN_ERR "Firmware-assisted dump is not supported on"
 			" this hardware\n");
-		return 0;
 	}
 
 	fadump_show_config();
@@ -1685,18 +1681,26 @@ int __init setup_fadump(void)
 	 * If dump data is available then see if it is valid and prepare for
 	 * saving it to the disk.
 	 */
-	if (fw_dump.dump_active) {
+	if (fw_dump.fadump_enabled) {
+		if (fw_dump.dump_active) {
+			/*
+			 * if dump process fails then invalidate the
+			 * registration and release memory before proceeding
+			 * for re-registration.
+			 */
+			if (process_fadump(fdm_active) < 0)
+				fadump_invalidate_release_mem();
+		}
 		/*
-		 * if dump process fails then invalidate the registration
-		 * and release memory before proceeding for re-registration.
+		 * Initialize the kernel dump memory structure for FAD
+		 * registration.
 		 */
-		if (process_fadump(fdm_active) < 0)
-			fadump_invalidate_release_mem();
+		else if (fw_dump.reserve_dump_area_size)
+			init_fadump_mem_struct(&fdm,
+					fw_dump.reserve_dump_area_start);
 	}
-	/* Initialize the kernel dump memory structure for FAD registration. */
-	else if (fw_dump.reserve_dump_area_size)
-		init_fadump_mem_struct(&fdm, fw_dump.reserve_dump_area_start);
-	fadump_init_files();
+	if (fw_dump.fadump_supported)
+		fadump_init_files();
 
 	return 1;
 }
-- 
2.22.0

