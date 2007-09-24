Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 389A6DDE0D
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Sep 2007 05:01:28 +1000 (EST)
Date: Mon, 24 Sep 2007 14:01:00 -0500
From: Scott Wood <scottwood@freescale.com>
To: paulus@samba.org
Subject: [PATCH] Make instruction dumping work in real mode.
Message-ID: <20070924190100.GB4761@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On non-book-E, if a faulting PC is in the first few pages, and it's not an
ITLB miss, it's likely executing in real mode, probably at an exception vector.

Rather than print a useless XXXXXXXX, it is assumed that this is the case, and
the address is treated as physical.  This helps when debugging corruption at
the beginning of memory.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/kernel/process.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 57c589c..7cb94d7 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -354,6 +354,14 @@ static void show_instructions(struct pt_regs *regs)
 		if (!(i % 8))
 			printk("\n");
 
+#ifndef CONFIG_BOOKE
+		/* If the address is in the first couple pages, it's
+		 * likely executing in real mode.
+		 */
+		if (regs->nip < 0x4000)
+			pc += (unsigned long)phys_to_virt(KERNELBASE);
+#endif
+
 		/* We use __get_user here *only* to avoid an OOPS on a
 		 * bad address because the pc *should* only be a
 		 * kernel address.
-- 
1.5.3.1
