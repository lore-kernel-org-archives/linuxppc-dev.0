Return-Path: <avorontsov@ru.mvista.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id D1B20B7C42
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 28 Aug 2009 03:30:21 +1000 (EST)
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 52235DDD01
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Aug 2009 03:30:21 +1000 (EST)
Date: Thu, 27 Aug 2009 21:30:19 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 3/5] powerpc/qe: Add qe_upload_firmware() stub for non-QE
	builds
Message-ID: <20090827173019.GC739@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is needed to avoid #ifdefs in MPC85xx suspend/resume code.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/include/asm/qe.h |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/qe.h b/arch/powerpc/include/asm/qe.h
index 791c67a..e8232bb 100644
--- a/arch/powerpc/include/asm/qe.h
+++ b/arch/powerpc/include/asm/qe.h
@@ -218,8 +218,15 @@ struct qe_firmware_info {
 	u64 extended_modes;	/* Extended modes */
 };
 
+#ifdef CONFIG_QUICC_ENGINE
 /* Upload a firmware to the QE */
 int qe_upload_firmware(const struct qe_firmware *firmware);
+#else
+static inline int qe_upload_firmware(const struct qe_firmware *firmware)
+{
+	return -ENOSYS;
+}
+#endif /* CONFIG_QUICC_ENGINE */
 
 /* Obtain information on the uploaded firmware */
 struct qe_firmware_info *qe_get_firmware_info(void);
-- 
1.6.3.3
