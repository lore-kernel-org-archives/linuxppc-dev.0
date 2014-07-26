Return-Path: <rickard_strandqvist@spectrumdigital.se>
Received: from mail-wg0-f48.google.com (mail-wg0-f48.google.com [74.125.82.48])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 17EEF1A073A
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Jul 2014 07:25:30 +1000 (EST)
Received: by mail-wg0-f48.google.com with SMTP id x13so5614140wgg.7
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Jul 2014 14:25:26 -0700 (PDT)
From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH] arch: powerpc: sysdev: qe_lib: qe.c: Cleaning up in
 conjunction with strncpy and strcpy
Date: Sat, 26 Jul 2014 23:26:51 +0200
Message-Id: <1406410011-6522-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Cc: devicetree@vger.kernel.org,
 Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Grant Likely <grant.likely@linaro.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Replacing strcpy and strncpy with strlcpy to avoid strings that ar to big,
or lacks null terminate.

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 arch/powerpc/sysdev/qe_lib/qe.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/sysdev/qe_lib/qe.c b/arch/powerpc/sysdev/qe_lib/qe.c
index 238a07b..9f19e6c 100644
--- a/arch/powerpc/sysdev/qe_lib/qe.c
+++ b/arch/powerpc/sysdev/qe_lib/qe.c
@@ -498,7 +498,7 @@ int qe_upload_firmware(const struct qe_firmware *firmware)
 	 * saved microcode information and put in the new.
 	 */
 	memset(&qe_firmware_info, 0, sizeof(qe_firmware_info));
-	strcpy(qe_firmware_info.id, firmware->id);
+	strlcpy(qe_firmware_info.id, firmware->id, sizeof(qe_firmware_info.id));
 	qe_firmware_info.extended_modes = firmware->extended_modes;
 	memcpy(qe_firmware_info.vtraps, firmware->vtraps,
 		sizeof(firmware->vtraps));
@@ -584,8 +584,8 @@ struct qe_firmware_info *qe_get_firmware_info(void)
 	/* Copy the data into qe_firmware_info*/
 	sprop = of_get_property(fw, "id", NULL);
 	if (sprop)
-		strncpy(qe_firmware_info.id, sprop,
-			sizeof(qe_firmware_info.id) - 1);
+		strlcpy(qe_firmware_info.id, sprop,
+			sizeof(qe_firmware_info.id));
 
 	prop = of_find_property(fw, "extended-modes", NULL);
 	if (prop && (prop->length == sizeof(u64))) {
-- 
1.7.10.4
