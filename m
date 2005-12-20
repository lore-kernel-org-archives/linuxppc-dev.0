Return-Path: <tnt@246tNt.com>
Received: from outmx021.isp.belgacom.be (outmx021.isp.belgacom.be
	[195.238.2.202])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3FA9B68944
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 Dec 2005 07:42:40 +1100 (EST)
Received: from outmx021.isp.belgacom.be (localhost [127.0.0.1])
	by outmx021.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id jBKKgWT8011985
	for <linuxppc-embedded@ozlabs.org>; Tue, 20 Dec 2005 21:42:33 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <5.20051220_213752_1ebc_tnt@patchsend.246tNt.com>
From: Sylvain Munaut <tnt@246tNt.com>
To: Andrew Morton <akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1
In-Reply-To: <0.20051220_213752_1ebc_tnt@patchsend.246tNt.com>
References: <0.20051220_213752_1ebc_tnt@patchsend.246tNt.com>
Date: Tue, 20 Dec 2005 21:42:33 +0100 (CET)
Cc: Tom Rini <trini@kernel.crashing.org>, Sylvain Munaut <tnt@246tNt.com>,
	Linux PPC Embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH 5/9] ppc32: Modify Freescale MPC52xx IRQ mapping to _not_
	use irq 0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

ppc32: Modify Freescale MPC52xx IRQ mapping to _not_ use irq 0

AFAIK IRQ number 0 is a perfectly valid IRQ number. But it seems there
are numerous places where it's considered to be invalid or "no irq" value.
Since that value is problematic, the IRQ mapping is changed to not
use it.

Signed-off-by: Sylvain Munaut <tnt@246tNt.com>

---
commit 0311bddd40fe347ea69a5659f02e1beb8fe96ea8
tree 16003ab98c67face9c25bdb247e241d88dd596f5
parent ae62fed2708efa333d41f7b36893e5fdbd0f6730
author Sylvain Munaut <tnt@246tNt.com> Sun, 18 Dec 2005 11:20:17 +0100
committer Sylvain Munaut <tnt@246tNt.com> Sun, 18 Dec 2005 11:20:17 +0100

 include/asm-ppc/mpc52xx.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/asm-ppc/mpc52xx.h b/include/asm-ppc/mpc52xx.h
index e5f80c2..04d5630 100644
--- a/include/asm-ppc/mpc52xx.h
+++ b/include/asm-ppc/mpc52xx.h
@@ -107,7 +107,7 @@ enum ppc_sys_devices {
 #define MPC52xx_SDMA_IRQ_NUM	17
 #define MPC52xx_PERP_IRQ_NUM	23
 
-#define MPC52xx_CRIT_IRQ_BASE	0
+#define MPC52xx_CRIT_IRQ_BASE	1
 #define MPC52xx_MAIN_IRQ_BASE	(MPC52xx_CRIT_IRQ_BASE + MPC52xx_CRIT_IRQ_NUM)
 #define MPC52xx_SDMA_IRQ_BASE	(MPC52xx_MAIN_IRQ_BASE + MPC52xx_MAIN_IRQ_NUM)
 #define MPC52xx_PERP_IRQ_BASE	(MPC52xx_SDMA_IRQ_BASE + MPC52xx_SDMA_IRQ_NUM)
