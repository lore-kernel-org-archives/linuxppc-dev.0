Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A554C2C00B1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Dec 2013 12:24:54 +1100 (EST)
From: Alexander Graf <agraf@suse.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 4/4] powerpc: Don't return to BE mode when we are already there
Date: Mon, 23 Dec 2013 02:24:45 +0100
Message-Id: <1387761885-39599-5-git-send-email-agraf@suse.de>
In-Reply-To: <1387761885-39599-1-git-send-email-agraf@suse.de>
References: <1387761885-39599-1-git-send-email-agraf@suse.de>
Cc: Dinar Valeev <dvaleev@suse.com>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Our Little Endian kernels can now live in a world where they are
running with Big Endian interrupts enabled. That is great for kexec,
because now we don't have to switch back to Big Endian mode.

Indicate this in the code. Only try to go into Big Endian mode when
we're not already there yet.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/platforms/pseries/setup.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index fb5d98c..7db1cf1 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -446,10 +446,15 @@ static void pSeries_machine_kexec(struct kimage *image)
 #endif
 
 #ifdef __LITTLE_ENDIAN__
+static bool ile_enabled;
+
 long pseries_big_endian_exceptions(void)
 {
 	long rc;
 
+	if (!ile_enabled)
+		return H_SUCCESS;
+
 	while (1) {
 		rc = enable_big_endian_exceptions();
 		if (!H_IS_LONG_BUSY(rc))
@@ -498,8 +503,12 @@ static long pseries_little_endian_exceptions(void)
 
 	while (1) {
 		rc = enable_little_endian_exceptions();
-		if (!H_IS_LONG_BUSY(rc))
+
+		if (!H_IS_LONG_BUSY(rc)) {
+			ile_enabled = true;
 			return rc;
+		}
+
 		mdelay(get_longbusy_msecs(rc));
 	}
 }
-- 
1.8.1.4
