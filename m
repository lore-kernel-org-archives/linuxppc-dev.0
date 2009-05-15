Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 23669DE0C3
	for <linuxppc-dev@ozlabs.org>; Fri, 15 May 2009 21:06:02 +1000 (EST)
In-Reply-To: <d2b9ea600905150318s69b86b5ct3816b274bf343a79@mail.gmail.com>
References: <4A0BD1DB.4090305@doredevelopment.dk>	
	<20090514083453.GB3043@pengutronix.de>
	<4A0BDAD6.5020005@doredevelopment.dk>	
	<OF9EE5E055.DDB954D2-ONC12575B6.003636EC-C12575B6.0036CB06@transmode.se>
	<d2b9ea600905140317u7a4b9a70s574568d79a1ce7cc@mail.gmail.com>	
	<OF3CD158BA.04CCFBB5-ONC12575B6.005911D5-C12575B6.005CAFC2@transmode.se>
	<d2b9ea600905150318s69b86b5ct3816b274bf343a79@mail.gmail.com>
Subject: Re: [PATCH] i2c-mpc: generate START condition after STOP caused by
	read i2c_msg
To: Esben Haabendal <esbenhaabendal@gmail.com>
Message-ID: <OFCADC684E.A2599121-ONC12575B7.003B8AB5-C12575B7.003CF795@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Fri, 15 May 2009 13:05:56 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-i2c@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Esben Haabendal <esbenhaabendal@gmail.com> wrote on 15/05/2009 12:18:39:

>
> I have now spent a few hours trying a lot of different paths to fix
> this approach, but I simply cannot find a way to get i2c read to work
> without a trailing STOP condition with this controller.

I found a bug which lets me remove the "fix" and seems related to your
problem. Updated patch last in mail

>
> Is there a problem in applying my patch, as it should be "clean"
> improvement over the current implementation, which uses STOP
> condition, but does not work.
>
> Until Isomeone finds a way to get it to work without STOP, we will
> have a working driver, which I assume is what we want.

Your patch appears OK too. I just wanted to see if a better fix was
possible. Your patch is less risky and it is the safe bet so soon before
release.

 Jocke

diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
index 6c1cddd..04eff40 100644
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -189,9 +189,6 @@ static int mpc_write(struct mpc_i2c *i2c, int target,
 	unsigned timeout = i2c->adap.timeout;
 	u32 flags = restart ? CCR_RSTA : 0;

-	/* Start with MEN */
-	if (!restart)
-		writeccr(i2c, CCR_MEN);
 	/* Start as master */
 	writeccr(i2c, CCR_MIEN | CCR_MEN | CCR_MSTA | CCR_MTX | flags);
 	/* Write target byte */
@@ -214,15 +211,12 @@ static int mpc_write(struct mpc_i2c *i2c, int target,
 }

 static int mpc_read(struct mpc_i2c *i2c, int target,
-		    u8 * data, int length, int restart)
+		    u8 * data, int length, int restart, int last)
 {
 	unsigned timeout = i2c->adap.timeout;
 	int i, result;
 	u32 flags = restart ? CCR_RSTA : 0;

-	/* Start with MEN */
-	if (!restart)
-		writeccr(i2c, CCR_MEN);
 	/* Switch to read - restart */
 	writeccr(i2c, CCR_MIEN | CCR_MEN | CCR_MSTA | CCR_MTX | flags);
 	/* Write target address byte - this time with the read flag set */
@@ -241,18 +235,18 @@ static int mpc_read(struct mpc_i2c *i2c, int target,
 		readb(i2c->base + MPC_I2C_DR);
 	}

-	for (i = 0; i < length; i++) {
+	for (i = length; i ; --i) {
 		result = i2c_wait(i2c, timeout, 0);
 		if (result < 0)
 			return result;

 		/* Generate txack on next to last byte */
-		if (i == length - 2)
+		if (i == 2)
 			writeccr(i2c, CCR_MIEN | CCR_MEN | CCR_MSTA | CCR_TXAK);
-		/* Generate stop on last byte */
-		if (i == length - 1)
-			writeccr(i2c, CCR_MIEN | CCR_MEN | CCR_TXAK);
-		data[i] = readb(i2c->base + MPC_I2C_DR);
+		/* Generate stop on last byte, iff last transaction */
+		if (i == 1 && last)
+			writeccr(i2c, CCR_MIEN | CCR_MEN);
+		data[length-i] = readb(i2c->base + MPC_I2C_DR);
 	}

 	return length;
@@ -294,7 +288,7 @@ static int mpc_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 		tm_i2c_select_mux(pmsg->addr);
 		if (pmsg->flags & I2C_M_RD)
 			ret =
-			    mpc_read(i2c, pmsg->addr, pmsg->buf, pmsg->len, i);
+			    mpc_read(i2c, pmsg->addr, pmsg->buf, pmsg->len, i, i == num-1);
 		else
 			ret =
 			    mpc_write(i2c, pmsg->addr, pmsg->buf, pmsg->len, i);
