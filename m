Return-Path: <tushar.behera@linaro.org>
Received: from mail-da0-f51.google.com (mail-da0-f51.google.com
 [209.85.210.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A01F22C007E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Nov 2012 15:38:09 +1100 (EST)
Received: by mail-da0-f51.google.com with SMTP id i30so741627dad.38
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Nov 2012 20:38:09 -0800 (PST)
From: Tushar Behera <tushar.behera@linaro.org>
To: linuxppc-dev@lists.ozlabs.org,
	devicetree-discuss@lists.ozlabs.org
Subject: [PATCH 2/2] powerpc/pseries: pci: Use NULL instead of 0 for pointers
Date: Tue, 20 Nov 2012 10:01:52 +0530
Message-Id: <1353385912-25882-2-git-send-email-tushar.behera@linaro.org>
In-Reply-To: <1353385912-25882-1-git-send-email-tushar.behera@linaro.org>
References: <1353385912-25882-1-git-send-email-tushar.behera@linaro.org>
Cc: patches@linaro.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The third argument for of_get_property() is a pointer, hence pass
NULL instead of 0.

Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
---
This code is in a '#if 0' section, but I went ahead with the patch as
this is the only location in kernel where of_get_property is passed 0
as the third argument. If this function is not going to be used again,
then we may consider removing the code altogether.

 arch/powerpc/platforms/pseries/pci.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/pci.c b/arch/powerpc/platforms/pseries/pci.c
index 56b864d..0b580f4 100644
--- a/arch/powerpc/platforms/pseries/pci.c
+++ b/arch/powerpc/platforms/pseries/pci.c
@@ -40,7 +40,8 @@ void pcibios_name_device(struct pci_dev *dev)
 	 */
 	dn = pci_device_to_OF_node(dev);
 	if (dn) {
-		const char *loc_code = of_get_property(dn, "ibm,loc-code", 0);
+		const char *loc_code = of_get_property(dn, "ibm,loc-code",
+				NULL);
 		if (loc_code) {
 			int loc_len = strlen(loc_code);
 			if (loc_len < sizeof(dev->dev.name)) {
-- 
1.7.4.1
