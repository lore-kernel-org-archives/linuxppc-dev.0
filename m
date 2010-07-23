Return-Path: <Holger.Brunck@keymile.com>
Received: from mail.de.keymile.com (mail.de.keymile.com [195.8.104.1])
	by ozlabs.org (Postfix) with SMTP id 89B351007D2
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 24 Jul 2010 01:33:47 +1000 (EST)
Message-ID: <4C49B39C.9000301@keymile.com>
Date: Fri, 23 Jul 2010 17:22:04 +0200
From: Holger brunck <holger.brunck@keymile.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] i2c: adapt i2c_ram struct according to MPC8272 manual
Content-Type: text/plain;
	charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Additionaly to the MPC8260, the MPC8272 I2C PRAM memory map
has an additional entry for the SDMATMP (word). This patch
adds this at offset 0x34 to the i2c_ram struct.

Signed-off-by: Holger Brunck <holger.brunck@keymile.com>
---
 drivers/i2c/busses/i2c-cpm.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-cpm.c b/drivers/i2c/busses/i2c-cpm.c
index a6dbfb1..95d204f 100644
--- a/drivers/i2c/busses/i2c-cpm.c
+++ b/drivers/i2c/busses/i2c-cpm.c
@@ -77,7 +77,8 @@ struct i2c_ram {
 	uint    txtmp;		/* Internal */
 	char    res1[4];	/* Reserved */
 	ushort  rpbase;		/* Relocation pointer */
-	char    res2[2];	/* Reserved */
+	char    res2[6];	/* Reserved */
+	uint    sdmatmp;	/* Internal */
 };

 #define I2COM_START	0x80
-- 
1.7.0.5
