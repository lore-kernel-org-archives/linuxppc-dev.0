Return-Path: <glikely@secretlab.ca>
Received: from mail-we0-x234.google.com (mail-we0-x234.google.com
 [IPv6:2a00:1450:400c:c03::234])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 74B912C0085
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jan 2013 12:40:15 +1100 (EST)
Received: by mail-we0-f180.google.com with SMTP id t57so571645wey.39
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jan 2013 17:40:09 -0800 (PST)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
To: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] powerpc/5200: Fix size to request_mem_region() call
Date: Fri, 18 Jan 2013 01:39:59 +0000
Message-Id: <1358473200-17886-1-git-send-email-grant.likely@secretlab.ca>
Cc: Anatolij Gustschin <agust@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The Bestcomm driver requests a memory region larger than the one
described in the device tree. This is due to an extra undocumented field
in the bestcomm register structure. This hasn't been a problem up to
now, but there is a patch pending to make the DT platform_bus support
code use platform_device_add() which tightens the rules and provides
extra checks for drivers to stay within the specified register regions.

Alternately, I could have removed the extra field from the structure,
but I'm not sure if it is still needed for resume to work. Better be
safe and leave it in.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Anatolij Gustschin <agust@denx.de>
---
 arch/powerpc/sysdev/bestcomm/bestcomm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/sysdev/bestcomm/bestcomm.c b/arch/powerpc/sysdev/bestcomm/bestcomm.c
index d913063..81c3314 100644
--- a/arch/powerpc/sysdev/bestcomm/bestcomm.c
+++ b/arch/powerpc/sysdev/bestcomm/bestcomm.c
@@ -414,7 +414,7 @@ static int mpc52xx_bcom_probe(struct platform_device *op)
 		goto error_sramclean;
 	}
 
-	if (!request_mem_region(res_bcom.start, sizeof(struct mpc52xx_sdma),
+	if (!request_mem_region(res_bcom.start, resource_size(&res_bcom),
 				DRIVER_NAME)) {
 		printk(KERN_ERR DRIVER_NAME ": "
 			"Can't request registers region\n");
-- 
1.7.10.4
