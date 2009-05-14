Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id ACBB5DE05A
	for <linuxppc-dev@ozlabs.org>; Fri, 15 May 2009 02:52:28 +1000 (EST)
In-Reply-To: <d2b9ea600905140317u7a4b9a70s574568d79a1ce7cc@mail.gmail.com>
References: <4A0BD1DB.4090305@doredevelopment.dk>	
	<20090514083453.GB3043@pengutronix.de>
	<4A0BDAD6.5020005@doredevelopment.dk>	
	<OF9EE5E055.DDB954D2-ONC12575B6.003636EC-C12575B6.0036CB06@transmode.se>
	<d2b9ea600905140317u7a4b9a70s574568d79a1ce7cc@mail.gmail.com>
Subject: Re: [PATCH] i2c-mpc: generate START condition after STOP caused by
	read i2c_msg
To: Esben Haabendal <esbenhaabendal@gmail.com>
Message-ID: <OF3CD158BA.04CCFBB5-ONC12575B6.005911D5-C12575B6.005CAFC2@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Thu, 14 May 2009 18:52:23 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Esben Haabendal <esbenhaabendal@gmail.com> wrote on 14/05/2009 12:17:48=
:
> On Thu, May 14, 2009 at 11:58 AM, Joakim Tjernlund
> <joakim.tjernlund@transmode.se> wrote:
> >>
> >> The problem is that after the STOP condition, the following i2c_ms=
g will be
> >> attempted with a repeated START, which according to specification =
will
> >> cause a MAL, which also happens. =A0My MPC8360ERM reads:
> >>
> >> "Attempting a repeated START at the wrong time (or if the bus is o=
wned
> >> by another master), results in loss of arbitration."
> >>
> >> Which I know read as it that we must own the I2C bus when using RS=
TA.
> >
> > I agree with the theory, but isn't the problem here that STOP is pe=
rformed in
> > the middle of this transaction?
> > Remove the STOP and RSTA will work I think.
>
> That was also my first idea.
>
> But at least for my CS4265, reads does not work without a STOP follow=
ing the
> last byte. I guess I am not the first to experience this, as indicate=
d
> by the current
> i2c-mpc.c implementation.
> As far as I can understand the I2C specification, a STOP should not b=
e required
> after reads, but I am not sure.
>
> The cost of the additional STOP is really small.  The only issue I ca=
n see,
> is that with the STOP in the midle of an i2c_transfer, the I2C bus is=
 released.
> This naturally also happens with the current implementation, so I bel=
ieve
> that this patch is a clean improvement.
>
> Anyways, if someone can figure out how to achive this without STOP,
> I will be happy (re)test with my hardware setup here.

>From just playing a little, I think the below patch will get you far.
However, I had to change this too to make it stable:
static void mpc_i2c_start(struct mpc_i2c *i2c)
{
	/* Clear arbitration */
	writeb(0, i2c->base + MPC_I2C_SR);
#if 1 // fix, not sure why
	writeccr(i2c, 0);
	udelay(5);
#endif
	/* Start with MEN */
	writeccr(i2c, CCR_MEN);
}

PS.
   I added back the linuxppc list, let it stay.


diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.=
c
index 6c1cddd..d7edcd2 100644
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -189,9 +189,6 @@ static int mpc_write(struct mpc_i2c *i2c, int targe=
t,
 	unsigned timeout =3D i2c->adap.timeout;
 	u32 flags =3D restart ? CCR_RSTA : 0;

-	/* Start with MEN */
-	if (!restart)
-		writeccr(i2c, CCR_MEN);
 	/* Start as master */
 	writeccr(i2c, CCR_MIEN | CCR_MEN | CCR_MSTA | CCR_MTX | flags);
 	/* Write target byte */
@@ -220,9 +217,6 @@ static int mpc_read(struct mpc_i2c *i2c, int target=
,
 	int i, result;
 	u32 flags =3D restart ? CCR_RSTA : 0;

-	/* Start with MEN */
-	if (!restart)
-		writeccr(i2c, CCR_MEN);
 	/* Switch to read - restart */
 	writeccr(i2c, CCR_MIEN | CCR_MEN | CCR_MSTA | CCR_MTX | flags);
 	/* Write target address byte - this time with the read flag set */
@@ -241,18 +235,15 @@ static int mpc_read(struct mpc_i2c *i2c, int targ=
et,
 		readb(i2c->base + MPC_I2C_DR);
 	}

-	for (i =3D 0; i < length; i++) {
+	for (i =3D length; i ; --i) {
 		result =3D i2c_wait(i2c, timeout, 0);
 		if (result < 0)
 			return result;

-		/* Generate txack on next to last byte */
-		if (i =3D=3D length - 2)
+		/* Generate txack on next to last byte(s) */
+		if (i <=3D 2)
 			writeccr(i2c, CCR_MIEN | CCR_MEN | CCR_MSTA | CCR_TXAK);
-		/* Generate stop on last byte */
-		if (i =3D=3D length - 1)
-			writeccr(i2c, CCR_MIEN | CCR_MEN | CCR_TXAK);
-		data[i] =3D readb(i2c->base + MPC_I2C_DR);
+		data[length-i] =3D readb(i2c->base + MPC_I2C_DR);
 	}

 	return length;

=
