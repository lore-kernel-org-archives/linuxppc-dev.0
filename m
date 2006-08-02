Return-Path: <kallepokki@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.191])
	by ozlabs.org (Postfix) with ESMTP id B936867B87
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  2 Aug 2006 17:10:48 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id c2so526395nfe
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 02 Aug 2006 00:10:46 -0700 (PDT)
Message-ID: <a425f86c0608020010q5b1c07d3s537a284455801d0b@mail.gmail.com>
Date: Wed, 2 Aug 2006 10:10:46 +0300
From: "Kalle Pokki" <kalle.pokki@iki.fi>
Sender: kallepokki@gmail.com
To: linuxppc-embedded@ozlabs.org
Subject: 82xx PCI setup ioremapping twice
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

In pq2_find_bridges(), there is a call to setup_m8260_indirect_pci(),
which ioremaps the configuration address and data registers. The call
uses the cpm2_immr pointer, which however is already ioremapped by
cpm2_reset(). ioremapping these addresses twice seems to always crash
my board, and I need to e.g.

Index: linux-2.6.15.4/arch/ppc/syslib/m82xx_pci.c
===================================================================
--- linux-2.6.15.4.orig/arch/ppc/syslib/m82xx_pci.c     2006-08-02
09:45:54.000000000 +0300
+++ linux-2.6.15.4/arch/ppc/syslib/m82xx_pci.c  2006-08-02
09:46:32.000000000 +0300
@@ -324,7 +324,7 @@
        hose->set_cfg_type = 1;
 #endif

-       setup_m8260_indirect_pci(hose,
+       setup_indirect_pci_nomap(hose,
                                 (unsigned long)&cpm2_immr->im_pci.pci_cfg_addr,
                                 (unsigned
long)&cpm2_immr->im_pci.pci_cfg_data);

or use the physical addresses in the original function call.

Should ioremap() code check for these double mappings? There seems to
be some attempts to do that. I remember the PCI initialisation wasn't
a problem some time before with an earlier kernel version, a different
8248 board, and internal memory at 0xf0000000.

My internal memory is at physical address 0xff000000.
Linux kernel version is 2.6.15.4.
The board is a custom 8247.
