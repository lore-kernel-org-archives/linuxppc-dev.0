Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.229])
	by ozlabs.org (Postfix) with ESMTP id 82CA8DDDE1
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Jun 2009 09:13:13 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id f9so2536751rvb.9
	for <linuxppc-dev@ozlabs.org>; Tue, 02 Jun 2009 16:13:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4A124202.4010201@doredevelopment.dk>
References: <4A124202.4010201@doredevelopment.dk>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 2 Jun 2009 17:12:52 -0600
Message-ID: <fa686aa40906021612q3f40a0docffa9766b53cd90b@mail.gmail.com>
Subject: Re: [PATCH v2] i2c-mpc: generate START condition after STOP caused by
	read i2c_msg
To: Esben Haabendal <eha@doredevelopment.dk>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, linux-i2c@vger.kernel.org,
	Ben Dooks <ben-linux@fluff.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Esben and Ben,

Sorry for the lateness in reviewing this.  FWIW, here are my comments.

g.

On Mon, May 18, 2009 at 11:22 PM, Esben Haabendal
<eha@doredevelopment.dk> wrote:
> This fixes MAL (arbitration lost) bug caused by illegal use of
> RSTA (repeated START) after STOP condition generated after last byte
> of reads. With this patch, it is possible to do an i2c_transfer() with
> additional i2c_msg's following the I2C_M_RD messages.
>
> It still needs to be resolved if it is possible to fix this issue
> by removing the STOP condition after reads in a robust way.
>
> Signed-off-by: Esben Haabendal <eha@doredevelopment.dk>
> ---
> =A0drivers/i2c/busses/i2c-mpc.c | =A0 =A09 +++++++--
> =A01 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
> index 4af5c09..0199f9a 100644
> --- a/drivers/i2c/busses/i2c-mpc.c
> +++ b/drivers/i2c/busses/i2c-mpc.c
> @@ -456,17 +456,22 @@ static int mpc_xfer(struct i2c_adapter *adap, struc=
t
> i2c_msg *msgs, int num)
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0for (i =3D 0; ret >=3D 0 && i < num; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int restart =3D i;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pmsg =3D &msgs[i];
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_dbg(i2c->dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"Doing %s %d bytes to 0x%0=
2x - %d of %d messages\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pmsg->flags & I2C_M_RD ? "=
read" : "write",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pmsg->len, pmsg->addr, i +=
 1, num);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (i > 0 && ((pmsg - 1)->flags & I2C_M_RD)=
)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 restart =3D 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (pmsg->flags & I2C_M_RD)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc_read(i2c, pmsg-=
>addr, pmsg->buf, pmsg->len,
> i);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc_read(i2c, pmsg-=
>addr, pmsg->buf, pmsg->len,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
restart);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc_write(i2c, pmsg=
->addr, pmsg->buf, pmsg->len,
> i);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc_write(i2c, pmsg=
->addr, pmsg->buf, pmsg->len,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 restart);
> =A0 =A0 =A0 =A0}

Hmmm, seems to be a rather convoluted code path.  Surely this could be
handled in a clearer way.  The whole (pmsg - 1) bit raises my eyebrows
(I'd rather see msgs[i-1]).  At the very least this deserves an
comment describing what it is doing.  The following might be better
for the next person who has to read this code:

+      int restart =3D 0;
       for (i =3D 0; ret >=3D 0 && i < num; i++) {
               pmsg =3D &msgs[i];
               dev_dbg(i2c->dev,
                       "Doing %s %d bytes to 0x%02x - %d of %d messages\n",
                       pmsg->flags & I2C_M_RD ? "read" : "write",
                       pmsg->len, pmsg->addr, i + 1, num);
               if (pmsg->flags & I2C_M_RD)
                       ret =3D
-                           mpc_read(i2c, pmsg->addr, pmsg->buf, pmsg->len,
i);
+                           mpc_read(i2c, pmsg->addr, pmsg->buf, pmsg->len,
+                                    restart);
               else
                       ret =3D
-                           mpc_write(i2c, pmsg->addr, pmsg->buf, pmsg->len=
,
i);
+                           mpc_write(i2c, pmsg->addr, pmsg->buf, pmsg->len=
,
+                                     restart);
+               /* Only set the restart flag if this was not an
I2C_M_RD transaction
+                * because it causes an illegal use of
+                * RSTA (repeated START) after STOP condition
generated after last byte
+                * of reads  */
+               restart =3D (pmsg->flags & I2C_M_RD =3D=3D 0);
       }

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
