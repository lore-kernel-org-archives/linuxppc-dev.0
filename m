Return-Path: <oohall@gmail.com>
Received: from mail-pl0-x244.google.com (mail-pl0-x244.google.com
 [IPv6:2607:f8b0:400e:c01::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 404PQL6hqtzF1dZ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Mar 2018 16:15:06 +1100 (AEDT)
Received: by mail-pl0-x244.google.com with SMTP id u11-v6so5927481plq.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Mar 2018 22:15:06 -0700 (PDT)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Oliver O'Halloran <oohall@gmail.com>
Subject: [PATCH 5/5] powerpc/zImage: Also check for stdout-path
Date: Mon, 19 Mar 2018 16:14:03 +1100
Message-Id: <20180319051403.23275-5-oohall@gmail.com>
In-Reply-To: <20180319051403.23275-1-oohall@gmail.com>
References: <20180319051403.23275-1-oohall@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The /chosen/linux,stdout-path is "deprecated" in favour of
/chosen/stdout-path so we should be checking for both.

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
 arch/powerpc/boot/serial.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/serial.c b/arch/powerpc/boot/serial.c
index a7f9ac9a27b5..9ef1ed35ae62 100644
--- a/arch/powerpc/boot/serial.c
+++ b/arch/powerpc/boot/serial.c
@@ -92,7 +92,8 @@ static void *serial_get_stdout_devp(void)
 	if (devp == NULL)
 		goto err_out;
 
-	if (getprop(devp, "linux,stdout-path", path, MAX_PATH_LEN) > 0) {
+	if (getprop(devp, "linux,stdout-path", path, MAX_PATH_LEN) > 0 ||
+		getprop(devp, "stdout-path", path, MAX_PATH_LEN) > 0) {
 		devp = finddevice(path);
 		if (devp == NULL)
 			goto err_out;
-- 
2.9.5
