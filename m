Return-Path: <gsi@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:28:0:1:25:1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 1234F2C01F6
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Aug 2013 06:46:03 +1000 (EST)
From: Gerhard Sittig <gsi@denx.de>
To: linuxppc-dev@lists.ozlabs.org, Anatolij Gustschin <agust@denx.de>,
 Mike Turquette <mturquette@linaro.org>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v4 12/31] powerpc: mpc512x: array decl for MCLK registers in
 CCM
Date: Tue,  6 Aug 2013 22:43:52 +0200
Message-Id: <1375821851-31609-13-git-send-email-gsi@denx.de>
In-Reply-To: <1375821851-31609-1-git-send-email-gsi@denx.de>
References: <1374495298-22019-1-git-send-email-gsi@denx.de>
 <1375821851-31609-1-git-send-email-gsi@denx.de>
Cc: Detlev Zundel <dzu@denx.de>, Wolfram Sang <wsa@the-dreams.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Gerhard Sittig <gsi@denx.de>,
 Rob Herring <rob.herring@calxeda.com>, Mark Brown <broonie@kernel.org>,
 Marc Kleine-Budde <mkl@pengutronix.de>, David Woodhouse <dwmw2@infradead.org>,
 Wolfgang Grandegger <wg@grandegger.com>,
 Mauro Carvalho Chehab <m.chehab@samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

reword the clock control module's registers declaration such that the
MCLK related registers form an array and get indexed by PSC controller
or CAN controller component number

this change is in preparation to COMMON_CLK support for the MPC512x
platform, the changed declaration remains neutral to existing code since
the PSC and MSCAN CCR fields declared here aren't referenced anywhere

Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
 arch/powerpc/include/asm/mpc5121.h |   18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/include/asm/mpc5121.h b/arch/powerpc/include/asm/mpc5121.h
index 8ae133e..887d3d6 100644
--- a/arch/powerpc/include/asm/mpc5121.h
+++ b/arch/powerpc/include/asm/mpc5121.h
@@ -32,25 +32,11 @@ struct mpc512x_ccm {
 	u32	scfr2;	/* System Clock Frequency Register 2 */
 	u32	scfr2s;	/* System Clock Frequency Shadow Register 2 */
 	u32	bcr;	/* Bread Crumb Register */
-	u32	p0ccr;	/* PSC0 Clock Control Register */
-	u32	p1ccr;	/* PSC1 CCR */
-	u32	p2ccr;	/* PSC2 CCR */
-	u32	p3ccr;	/* PSC3 CCR */
-	u32	p4ccr;	/* PSC4 CCR */
-	u32	p5ccr;	/* PSC5 CCR */
-	u32	p6ccr;	/* PSC6 CCR */
-	u32	p7ccr;	/* PSC7 CCR */
-	u32	p8ccr;	/* PSC8 CCR */
-	u32	p9ccr;	/* PSC9 CCR */
-	u32	p10ccr;	/* PSC10 CCR */
-	u32	p11ccr;	/* PSC11 CCR */
+	u32	psc_ccr[12];	/* PSC Clock Control Registers */
 	u32	spccr;	/* SPDIF Clock Control Register */
 	u32	cccr;	/* CFM Clock Control Register */
 	u32	dccr;	/* DIU Clock Control Register */
-	u32	m1ccr;	/* MSCAN1 CCR */
-	u32	m2ccr;	/* MSCAN2 CCR */
-	u32	m3ccr;	/* MSCAN3 CCR */
-	u32	m4ccr;	/* MSCAN4 CCR */
+	u32	mscan_ccr[4];	/* MSCAN Clock Control Registers */
 	u8	res[0x98]; /* Reserved */
 };
 
-- 
1.7.10.4
