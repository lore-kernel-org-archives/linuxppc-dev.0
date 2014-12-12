Return-Path: <Amit.Tomar@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0134.outbound.protection.outlook.com [157.56.111.134])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C6D2D1A04F6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Dec 2014 22:50:47 +1100 (AEDT)
From: Amit Tomar <Amit.Tomar@freescale.com>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [Patch] :Fix ISR return value in i2c-mpc.c 
Date: Fri, 12 Dec 2014 11:17:15 +0000
Message-ID: <BL2PR03MB4496E03E1930685FD2A4FD483600@BL2PR03MB449.namprd03.prod.outlook.com>
References: <BL2PR03MB4495ADAE7D752F82B58B1D783600@BL2PR03MB449.namprd03.prod.outlook.com>
In-Reply-To: <BL2PR03MB4495ADAE7D752F82B58B1D783600@BL2PR03MB449.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "agraf@suse.de" <agraf@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In current scenario, ISR of i2c-mpc.c is returning IRQ_HANDLED for doing no=
thing which is not right .

With below patch ISR now return IRQ_NONE for doing nothing and IRQ_HANDLED =
for doing handler work.


Signed-off-by: Amit Singh Tomar <amit.tomar@freescale.com>
---
drivers/i2c/busses/i2c-mpc.c |=A0=A0=A0 3 ++-
1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
index 0edf630..7a3136f 100644
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
--=20
1.7.9.5
