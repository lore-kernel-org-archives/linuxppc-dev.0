Return-Path: <Amit.Tomar@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0105.outbound.protection.outlook.com [207.46.100.105])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6E2E81A0DD8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jan 2015 21:39:36 +1100 (AEDT)
From: Amit Tomar <Amit.Tomar@freescale.com>
To: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Subject: [PATCH] i2c/mpc: Fix ISR return value
Date: Fri, 30 Jan 2015 10:24:10 +0000
Message-ID: <BL2PR03MB449C87445D2FD1F15E9D33483310@BL2PR03MB449.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

ISR should not return IRQ_HANDLED for not handling anything.=20
This patch fixes the return value of ISR for the same case.


Signed-off-by: Amit Singh Tomar <amit.tomar@freescale.com>
---
drivers/i2c/busses/i2c-mpc.c |=A0=A0=A0 3 ++-
1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c in=
dex 0edf630..7a3136f 100644
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -95,8 +95,9 @@ static irqreturn_t mpc_i2c_isr(int irq, void *dev_id)
=A0=A0=A0=A0=A0=A0=A0 i2c->interrupt =3D readb(i2c->base + MPC_I2C_SR);
=A0=A0=A0=A0=A0=A0=A0 writeb(0, i2c->base + MPC_I2C_SR);
=A0=A0=A0=A0=A0=A0=A0 wake_up(&i2c->queue);
+=A0=A0 =A0=A0  return IRQ_HANDLED;
=A0=A0=A0 }
-=A0 return IRQ_HANDLED;
+ =A0return IRQ_NONE;
}

/* Sometimes 9th clock pulse isn't generated, and slave doesn't release
--
1.7.9.5
=20
