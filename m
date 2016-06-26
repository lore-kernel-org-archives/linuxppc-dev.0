Return-Path: <darren@stevens-zone.net>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rd1Fm2zyczDqm9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 04:44:42 +1000 (AEST)
From: Darren Stevens <darren@stevens-zone.net>
To: linuxppc-dev@lists.ozlabs.org
CC: Christian Zigotzky <chzigotzky@xenosoft.de>, matthew@a-eon.com,
 Pat Wall <pjwall@mac.com>, R.T.Dickinson <rtd2@xtra.co.nz>,
 aperez@alexperez.com
Date: Sun, 26 Jun 2016 18:42:11 +0100 (BST)
Message-ID: <4863e2f8235.599ebfcf@auth.smtp.1and1.co.uk>
Subject: Proposed: Patch to fix boot on PA6T
MIME-Version: 1.0
Content-type: multipart/mixed; boundary="--=_BOUNDARY.6d401b301879572c.5f"
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

----=_BOUNDARY.6d401b301879572c.5f
Content-Type: text/plain

Hello All,

    commit d6a9996e84ac4beb7713e9485f4563e100a9b03e
    powerpc/mm: vmalloc abstraction in preparation for radix

    This commit introduced variables for some linux kernel addresses that had
before
    been constants, unfortunately this stopped PaSemi PA6T systems(*) from
booting as
    they call ioremap to map SoC registers before the mmu is initialised. The
attached
    patch adds a hard-coded init of pci_io_base to the pas_init_early()
function which
    which allows the kernel to boot normally.

    The value will be harmlessly set again once pci starts up.

    (*) At the moment this has only been tested on an AmigaOneX1000, but I
expect PaSemi
    reference systems to have been affected in the same way.

Kind regards
Darren

----=_BOUNDARY.6d401b301879572c.5f
Content-Type: text/plain;
	name="pa6t-bootfix.patch"
Content-Disposition: attachment;
	filename="pa6t-bootfix.patch";
	size=643

diff --git a/arch/powerpc/platforms/pasemi/setup.c b/arch/powerpc/platforms/pasemi/setup.c
index d71b2c7..6b8d2ab 100644
--- a/arch/powerpc/platforms/pasemi/setup.c
+++ b/arch/powerpc/platforms/pasemi/setup.c
@@ -61,6 +61,7 @@ static struct mce_regs mce_regs[MAX_MCE_REGS];
 static int num_mce_regs;
 static int nmi_virq = NO_IRQ;
 
+extern unsigned long pci_io_base;
 
 static void pas_restart(char *cmd)
 {
@@ -341,6 +342,10 @@ out:
 
 static void __init pas_init_early(void)
 {
+	/* Initialise the IO pointer so we don't crash on boot */
+
+	pci_io_base = (H_KERN_VIRT_START + (H_KERN_VIRT_SIZE >> 1));
+
 	iommu_init_early_pasemi();
 }
 


----=_BOUNDARY.6d401b301879572c.5f--
