Return-Path: <darren@stevens-zone.net>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z8vnM23CSzDr0N
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Jan 2018 09:16:51 +1100 (AEDT)
From: Darren Stevens <darren@stevens-zone.net>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
CC: Christian Zigotzky <chzigotzky@xenosoft.de>
Date: Sun, 31 Dec 2017 22:16:41 +0000 (GMT)
Message-ID: <4b3d22a081a.208ad70e@auth.smtp.1and1.co.uk>
Subject: [PATCH NEXT 4/4] powerpc/pasemi: Connect Nemo boot code.
MIME-Version: 1.0
Content-type: multipart/mixed; boundary="--=_BOUNDARY.6c368940208d079b.fc"
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

----=_BOUNDARY.6c368940208d079b.fc
Content-Type: text/plain

    The previous 3 commits added support code for the Nemo motherbard
    as used in the Amigaone X1000, now wire them up so the board can
    be detected and initalised at boot time.
    
    Signed-off-by: Darren Stevens <Darren@stevens-zone.net>

---

----=_BOUNDARY.6c368940208d079b.fc
Content-Type: text/plain;
	name="link.patch"
Content-Disposition: attachment;
	filename="link.patch";
	size=1030

diff --git a/arch/powerpc/platforms/pasemi/setup.c b/arch/powerpc/platforms/pasemi/setup.c
index 8d3664f..bb3a4d5 100644
--- a/arch/powerpc/platforms/pasemi/setup.c
+++ b/arch/powerpc/platforms/pasemi/setup.c
@@ -136,7 +136,14 @@ static void __init pas_setup_arch(void)
 	smp_ops = &pas_smp_ops;
 #endif
 	/* Lookup PCI hosts */
+#ifdef CONFIG_PPC_PASEMI_NEMO
+	if (nemo_board)
+		nemo_pci_init();
+	else
+		pas_pci_init();
+#else
 	pas_pci_init();
+#endif
 
 #ifdef CONFIG_DUMMY_CONSOLE
 	conswitchp = &dummy_con;
@@ -548,6 +555,19 @@ static int __init pas_probe(void)
 	    !of_machine_is_compatible("pasemi,pwrficient"))
 		return 0;
 
+#ifdef CONFIG_PPC_PASEMI_NEMO
+	/*
+	 * Check for the Nemo motherboard here, if we are running on one
+	 * change the machine definition to fit
+	 */
+	if (of_machine_is_compatible("pasemi,nemo")) {
+		pm_power_off		= pas_shutdown;
+		ppc_md.name		= "A-EON Amigaone X1000";
+		ppc_md.init_IRQ		= nemo_init_IRQ;
+		nemo_board = true;
+	}
+#endif
+
 	iommu_init_early_pasemi();
 
 	return 1;

----=_BOUNDARY.6c368940208d079b.fc--
