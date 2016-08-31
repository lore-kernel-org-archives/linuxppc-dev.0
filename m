Return-Path: <darren@stevens-zone.net>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sPS2g6dcQzDrhc
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Sep 2016 00:10:19 +1000 (AEST)
From: Darren Stevens <darren@stevens-zone.net>
To: linuxppc-dev@lists.ozlabs.org
CC: olof@lixom.net,
	Christian Zigotzky <chzigotzky@xenosoft.de>
Date: Wed, 31 Aug 2016 13:24:45 +0100 (BST)
Message-ID: <48ba9b708e2.6395f2f3@auth.smtp.1and1.co.uk>
Subject: [ RFC PATCH 3/3] powerpc:pasemi: Fix device_type of Nemo SB600 node.
MIME-Version: 1.0
Content-type: multipart/mixed; boundary="--=_BOUNDARY.6dab4a807b7bb6b1.a1"
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

----=_BOUNDARY.6dab4a807b7bb6b1.a1
Content-Type: text/plain

    The of_node for the SB600 (io-bridge) has its device_type set to
    'io-bridge' Set it to 'isa' so that it can be found by
    isa_bridge_find_early() instead of using patches in the kernel.

    Signed-off-by: Darren Stevens <darren@stevens-zone.net>

---

----=_BOUNDARY.6dab4a807b7bb6b1.a1
Content-Type: text/plain;
	name="nemo_2.patch"
Content-Disposition: attachment;
	filename="nemo_2.patch";
	size=833

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 8269093..d75937a 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -2697,6 +2697,24 @@ static void __init fixup_device_tree_pasemi(void)
 			}
 		}
 	}
+
+	/*
+	 * The io-bridge has device_type set to 'io-bridge'
+	 * change it to 'isa' so that generic isa-bridge code can add the SB600 and
+	 * its on-board peripherals.
+	 */
+
+	name = "/pxp@0,e0000000/io-bridge@0";
+        iob = call_prom("finddevice", 1, 1, ADDR(name));
+        if (!PHANDLE_VALID(iob))
+                return;
+
+	/* device_type is already set, just change it. */
+
+	prom_printf("Changing device_type of SB600 node...\n");
+
+	prom_setprop(iob, name, "device_type", "isa", sizeof("isa"));
+
 #endif //CONFIG_PPC_PASEMI_NEMO
 }
 #else

----=_BOUNDARY.6dab4a807b7bb6b1.a1--
