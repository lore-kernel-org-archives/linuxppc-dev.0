Return-Path: <tnt@246tNt.com>
Received: from outmx019.isp.belgacom.be (outmx019.isp.belgacom.be
	[195.238.2.200])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1893568944
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 Dec 2005 07:42:05 +1100 (EST)
Received: from outmx019.isp.belgacom.be (localhost [127.0.0.1])
	by outmx019.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id jBKKfxKt031780
	for <linuxppc-embedded@ozlabs.org>; Tue, 20 Dec 2005 21:42:00 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <4.20051220_213752_1ebc_tnt@patchsend.246tNt.com>
From: Sylvain Munaut <tnt@246tNt.com>
To: Andrew Morton <akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1
In-Reply-To: <0.20051220_213752_1ebc_tnt@patchsend.246tNt.com>
References: <0.20051220_213752_1ebc_tnt@patchsend.246tNt.com>
Date: Tue, 20 Dec 2005 21:42:02 +0100 (CET)
Cc: Tom Rini <trini@kernel.crashing.org>, Sylvain Munaut <tnt@246tNt.com>,
	Linux PPC Embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH 4/9] ppc32: Fix static IO mapping for Freescale MPC52xx
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

ppc32: Fix static IO mapping for Freescale MPC52xx

The current iomapping used MBAR_SIZE for the size argument
of io_block_mapping, resulting in a call to setbat with a
size argument of 64k which is invalid.

This patch correct this and maps the whole 0xf0000000->0xffffffff
range so that devices on the local bus are also included in
the BAT mapping.

Thanks to Bernhard Kuhn from Metrowerks for pointing this out.

Signed-off-by: Sylvain Munaut <tnt@246tNt.com>

---
commit ae62fed2708efa333d41f7b36893e5fdbd0f6730
tree a1a4da53edb2f235be6658558eeb606a0b2580e9
parent 1661f915e8bd58e52fe3326e038efe74068702e0
author Sylvain Munaut <tnt@246tNt.com> Sun, 18 Dec 2005 11:13:15 +0100
committer Sylvain Munaut <tnt@246tNt.com> Sun, 18 Dec 2005 11:13:15 +0100

 arch/ppc/syslib/mpc52xx_setup.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/ppc/syslib/mpc52xx_setup.c b/arch/ppc/syslib/mpc52xx_setup.c
index bb23745..a4a4b02 100644
--- a/arch/ppc/syslib/mpc52xx_setup.c
+++ b/arch/ppc/syslib/mpc52xx_setup.c
@@ -84,9 +84,11 @@ mpc52xx_set_bat(void)
 void __init
 mpc52xx_map_io(void)
 {
-	/* Here we only map the MBAR */
+	/* Here we map the MBAR and the whole upper zone. MBAR is only
+	   64k but we can't map only 64k with BATs. Map the whole
+	   0xf0000000 range is ok and helps eventual lpb devices placed there */
 	io_block_mapping(
-		MPC52xx_MBAR_VIRT, MPC52xx_MBAR, MPC52xx_MBAR_SIZE, _PAGE_IO);
+		MPC52xx_MBAR_VIRT, MPC52xx_MBAR, 0x10000000, _PAGE_IO);
 }
 
 
