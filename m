Return-Path: <avolkov@varma-el.com>
Received: from amanaus.varma-el.com (unknown [195.144.244.147])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.varma-el.com",
	Issuer "mail.varma-el.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 9955068A68
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 Jan 2006 19:34:57 +1100 (EST)
Message-ID: <43C614A5.6030703@varma-el.com>
Date: Thu, 12 Jan 2006 11:34:45 +0300
From: Andrey Volkov <avolkov@varma-el.com>
MIME-Version: 1.0
To: Sylvain Munaut <tnt@246tNt.com>
Content-Type: multipart/mixed; boundary="------------010607090800000105020007"
Cc: LKML <linux-kernel@vger.kernel.org>,
	ML linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: [kernel-2.6.15] Fix PCI irq mapping for lite5200
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
--------------010607090800000105020007
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 7bit

Hi Sylvain,

This patch fix problem of PCI boards irq mapping on lite5200
(raised after your changes of MPC52xx_IRQ0 number)

--
Regards
Andrey Volkov

--------------010607090800000105020007
Content-Type: text/plain;
 name="01-lite5200_map_irq-fix.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="01-lite5200_map_irq-fix.diff"

	lite5200_map_irq: Fix irq mapping for external PCI boards

Signed-off-by: Andrey Volkov <avolkov@varma-el.com>
---

 arch/ppc/platforms/lite5200.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/ppc/platforms/lite5200.c b/arch/ppc/platforms/lite5200.c
index 7ed52dc..cd4acb3 100644
--- a/arch/ppc/platforms/lite5200.c
+++ b/arch/ppc/platforms/lite5200.c
@@ -73,7 +73,8 @@ lite5200_show_cpuinfo(struct seq_file *m
 static int
 lite5200_map_irq(struct pci_dev *dev, unsigned char idsel, unsigned char pin)
 {
-	return (pin == 1) && (idsel==24) ? MPC52xx_IRQ0 : -1;
+	/* Only INTA supported */
+	return (pin == 1) ? MPC52xx_IRQ0 : -1;
 }
 #endif
 

--------------010607090800000105020007--
