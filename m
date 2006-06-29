Return-Path: <wojtekka@toxygen.net>
Received: from toxygen.net (toxygen.net [213.146.59.4])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "toxygen.net", Issuer "toxygen.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 9F33767BAD
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 30 Jun 2006 09:23:35 +1000 (EST)
Received: from [192.168.0.2] (unknown [82.146.247.25])
	by toxygen.net (Postfix) with ESMTP id 8DD5A11BE
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 30 Jun 2006 01:04:27 +0200 (CEST)
Message-ID: <44A45C23.9000306@toxygen.net>
Date: Fri, 30 Jun 2006 01:02:59 +0200
From: Wojtek Kaniewski <wojtekka@toxygen.net>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: [PATCH] PCI-less kernel for PPC405-based boards
Content-Type: multipart/mixed; boundary="------------090008000209000104030308"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------090008000209000104030308
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit

This patch fixes compilation errors of PCI-less kernel for Bubinga and
EP405 boards. Other PPC405-based boards with bios_fixup() (Walnut and
Sycamore) already contain required #ifdefs.

Signed-Off-By: Wojtek Kaniewski <wojtekka@toxygen.net>

--------------090008000209000104030308
Content-Type: text/x-patch;
 name="linux-2.6.17-ppc4xx-pciless.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6.17-ppc4xx-pciless.patch"

diff -uNr linux-2.6.17.orig/arch/ppc/platforms/4xx/bubinga.c linux-2.6.17/arch/ppc/platforms/4xx/bubinga.c
--- linux-2.6.17.orig/arch/ppc/platforms/4xx/bubinga.c	2006-03-21 13:58:58.000000000 +0100
+++ linux-2.6.17/arch/ppc/platforms/4xx/bubinga.c	2006-06-30 00:53:44.000000000 +0200
@@ -117,7 +117,7 @@
 void __init
 bios_fixup(struct pci_controller *hose, struct pcil0_regs *pcip)
 {
-
+#ifdef CONFIG_PCI
 	unsigned int bar_response, bar;
 	/*
 	 * Expected PCI mapping:
@@ -213,6 +213,7 @@
 	printk(" ptm2la\t0x%x\n", in_le32(&(pcip->ptm2la)));
 
 #endif
+#endif
 }
 
 void __init
diff -uNr linux-2.6.17.orig/arch/ppc/platforms/4xx/ep405.c linux-2.6.17/arch/ppc/platforms/4xx/ep405.c
--- linux-2.6.17.orig/arch/ppc/platforms/4xx/ep405.c	2006-06-18 12:10:45.000000000 +0200
+++ linux-2.6.17/arch/ppc/platforms/4xx/ep405.c	2006-06-30 00:54:01.000000000 +0200
@@ -69,6 +69,7 @@
 void __init
 bios_fixup(struct pci_controller *hose, struct pcil0_regs *pcip)
 {
+#ifdef CONFIG_PCI
 	unsigned int bar_response, bar;
 	/*
 	 * Expected PCI mapping:
@@ -131,6 +132,7 @@
 		    PCI_FUNC(hose->first_busno), bar, bar_response);
 	}
 	/* end work arround */
+#endif
 }
 
 void __init

--------------090008000209000104030308--
