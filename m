Return-Path: <darren@stevens-zone.net>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sPRwl41smzDrfP
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Sep 2016 00:05:10 +1000 (AEST)
From: Darren Stevens <darren@stevens-zone.net>
To: linuxppc-dev@lists.ozlabs.org
CC: olof@lixom.net,
	Christian Zigotzky <chzigotzky@xenosoft.de>
Date: Wed, 31 Aug 2016 13:24:34 +0100 (BST)
Message-ID: <48ba9b706b8.834928d@auth.smtp.1and1.co.uk>
Subject: [ RFC PATCH 1/3] powerpc/pasemi: Add Nemo motherboard config option.
MIME-Version: 1.0
Content-type: multipart/mixed; boundary="--=_BOUNDARY.6dab4a80700c8394.89"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Warning: This is a message in MIME format. Your mail reader does
not support MIME. Some parts of this message will be readable as
plain text. To see the rest, you will need to upgrade your mail
reader. Following are some URLs where you can find MIME-capable
mail programs for common platforms:

  AmigaOS...........: http://yam.ch/
  Unix/MacOS/Windows: http://www.mozilla.com/thunderbird/

General information about MIME can be found at:
http://en.wikipedia.org/wiki/MIME

----=_BOUNDARY.6dab4a80700c8394.89
Content-Type: text/plain

    Add config option for the Nemo motherboard used in the Amigaone X1000.
    This is a custom PASemi board with an AMD SB600 southbridge, and needs
    some patches to it device tree. This option will be used to build these
    into the kernel

    Signed-off-by: Darren Stevens <darren@stevens-zone.net>

---

----=_BOUNDARY.6dab4a80700c8394.89
Content-Type: text/plain;
	name="nemo_0.patch"
Content-Disposition: attachment;
	filename="nemo_0.patch";
	size=716

diff --git a/arch/powerpc/platforms/pasemi/Kconfig b/arch/powerpc/platforms/pasemi/Kconfig
index 00d4b28..c7f1dbe 100644
--- a/arch/powerpc/platforms/pasemi/Kconfig
+++ b/arch/powerpc/platforms/pasemi/Kconfig
@@ -14,6 +14,16 @@ config PPC_PASEMI
 menu "PA Semi PWRficient options"
 	depends on PPC_PASEMI
 
+config PPC_PASEMI_NEMO
+	bool "Nemo motherboard Support"
+	depends on PPC_PASEMI
+	select PPC_I8259
+	help
+	  This option enables support for the 'Nemo' motherboard
+	  used in A-Eons's Amigaone X1000. This consists of some
+	  device tree patches and workarounds for the SB600 South
+	  Bridge that provides SATA/USB/Audio.
+
 config PPC_PASEMI_IOMMU
 	bool "PA Semi IOMMU support"
 	depends on PPC_PASEMI

----=_BOUNDARY.6dab4a80700c8394.89--
