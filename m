Return-Path: <elfring@users.sourceforge.net>
Received: from mout.web.de (mout.web.de [212.227.17.12])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5A4111A0026
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Dec 2015 09:16:22 +1100 (AEDT)
Subject: [POWERPC] bootwrapper: One check less in fsl_get_immr() after error
 detection
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
References: <566ABCD9.1060404@users.sourceforge.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Julia Lawall <julia.lawall@lip6.fr>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <566F3E49.2010506@users.sourceforge.net>
Date: Mon, 14 Dec 2015 23:10:17 +0100
MIME-Version: 1.0
In-Reply-To: <566ABCD9.1060404@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 14 Dec 2015 23:01:32 +0100

A status check was performed by the fsl_get_immr() function even if it
was known already that a system setting did not fit to the expectations.

This implementation detail could be improved by an adjustment for
a jump label according to the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/powerpc/boot/fsl-soc.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/boot/fsl-soc.c b/arch/powerpc/boot/fsl-soc.c
index b835ed6..ff1dae3 100644
--- a/arch/powerpc/boot/fsl-soc.c
+++ b/arch/powerpc/boot/fsl-soc.c
@@ -34,24 +34,24 @@ u32 *fsl_get_immr(void)
 			naddr = 2;
 
 		if (naddr != 1 && naddr != 2)
-			goto err;
+			goto report_failure;
 
 		size = getprop(soc, "ranges", prop_buf, MAX_PROP_LEN);
 
 		if (size < 12)
-			goto err;
+			goto report_failure;
 		if (prop_buf[0] != 0)
-			goto err;
+			goto report_failure;
 		if (naddr == 2 && prop_buf[1] != 0)
-			goto err;
+			goto report_failure;
 
 		if (!dt_xlate_addr(soc, prop_buf + naddr, 8, &ret))
 			ret = 0;
 	}
 
-err:
-	if (!ret)
+	if (!ret) {
+report_failure:
 		printf("fsl_get_immr: Failed to find immr base\r\n");
-
+	}
 	return (u32 *)ret;
 }
-- 
2.6.3
