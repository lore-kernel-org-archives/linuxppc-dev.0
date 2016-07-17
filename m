Return-Path: <darren@stevens-zone.net>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rsxfX2TZ5zDqLw
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jul 2016 05:47:32 +1000 (AEST)
From: Darren Stevens <darren@stevens-zone.net>
To: linuxppc-dev@lists.ozlabs.org
CC: Olof Johansson <olof@lixom.net>,
 Christian Zigotzky <chzigotzky@xenosoft.de>
Date: Sun, 17 Jul 2016 19:46:41 +0100 (BST)
Message-ID: <487fa17881e.5524720d@auth.smtp.1and1.co.uk>
Subject: [PATCH 1/1] pasemi: Add fixup_device_tree function to prom_init
MIME-Version: 1.0
Content-type: multipart/mixed; boundary="--=_BOUNDARY.6cfd9cc03cd2f6d6.0b"
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

----=_BOUNDARY.6cfd9cc03cd2f6d6.0b
Content-Type: text/plain


    Add a pasmei platform specific entry in the fixup_device_tree() call
    in prom_init.c.
    
    This call will be used to fix the broken device tree passed by CFE 
    on AmigaOneX1000 machines.
    
    Signed-off-by: Darren Stevens<darren@stevens-zone.net>

---

----=_BOUNDARY.6cfd9cc03cd2f6d6.0b
Content-Type: text/plain;
	name="prom.patch"
Content-Disposition: attachment;
	filename="prom.patch";
	size=720

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 6ee4b72..287ce4b 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -2639,6 +2639,13 @@ static void __init fixup_device_tree_efika(void)
 #else
 #define fixup_device_tree_efika()
 #endif
+#ifdef CONFIG_PPC_PASEMI
+static void __init fixup_device_tree_pasemi(void)
+{
+}
+#else
+#define fixup_device_tree_pasemi()
+#endif
 
 static void __init fixup_device_tree(void)
 {
@@ -2647,6 +2654,7 @@ static void __init fixup_device_tree(void)
 	fixup_device_tree_chrp();
 	fixup_device_tree_pmac();
 	fixup_device_tree_efika();
+	fixup_device_tree_pasemi();
 }
 
 static void __init prom_find_boot_cpu(void)

----=_BOUNDARY.6cfd9cc03cd2f6d6.0b--
