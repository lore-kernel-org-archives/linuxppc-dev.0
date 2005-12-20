Return-Path: <tnt@246tNt.com>
Received: from outmx016.isp.belgacom.be (outmx016.isp.belgacom.be
	[195.238.2.115])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D34BF689D1
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 Dec 2005 07:43:06 +1100 (EST)
Received: from outmx016.isp.belgacom.be (localhost [127.0.0.1])
	by outmx016.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id jBKKgxDo022760
	for <linuxppc-embedded@ozlabs.org>; Tue, 20 Dec 2005 21:43:00 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <6.20051220_213752_1ebc_tnt@patchsend.246tNt.com>
From: Sylvain Munaut <tnt@246tNt.com>
To: Andrew Morton <akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1
In-Reply-To: <0.20051220_213752_1ebc_tnt@patchsend.246tNt.com>
References: <0.20051220_213752_1ebc_tnt@patchsend.246tNt.com>
Date: Tue, 20 Dec 2005 21:43:03 +0100 (CET)
Cc: Tom Rini <trini@kernel.crashing.org>, Sylvain Munaut <tnt@246tNt.com>,
	Linux PPC Embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH 6/9] ppc32: Remove __init qualifier from mpc52xx pci
	resources fixups
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

ppc32: Remove __init qualifier from mpc52xx pci resources fixups

The mpc52xx_pci_fixup_resources is not only called at init but also
when there is a pci hotplug like when a cardbus card is plugged in.
So that function is needed after init too.

Thanks to Asier Llano Palacios for reporting this.

Signed-off-by: Sylvain Munaut <tnt@246tNt.com>

---
commit 7834134483a1ae663b805714fcd741c1caf41171
tree 56da4218fa2a0bd1541b7743e79415fc48715ba1
parent 0311bddd40fe347ea69a5659f02e1beb8fe96ea8
author Sylvain Munaut <tnt@246tNt.com> Sun, 18 Dec 2005 11:48:56 +0100
committer Sylvain Munaut <tnt@246tNt.com> Sun, 18 Dec 2005 11:48:56 +0100

 arch/ppc/syslib/mpc52xx_pci.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/ppc/syslib/mpc52xx_pci.c b/arch/ppc/syslib/mpc52xx_pci.c
index 4ac1908..e6cb3e2 100644
--- a/arch/ppc/syslib/mpc52xx_pci.c
+++ b/arch/ppc/syslib/mpc52xx_pci.c
@@ -151,7 +151,7 @@ mpc52xx_pci_setup(struct mpc52xx_pci __i
 #endif
 }
 
-static void __init
+static void
 mpc52xx_pci_fixup_resources(struct pci_dev *dev)
 {
 	int i;
