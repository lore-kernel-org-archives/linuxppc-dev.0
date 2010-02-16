Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f201.google.com (mail-yw0-f201.google.com
	[209.85.211.201]) by ozlabs.org (Postfix) with ESMTP id B0A9FB7CBD
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Feb 2010 03:00:07 +1100 (EST)
Received: by ywh39 with SMTP id 39so5284584ywh.17
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 16 Feb 2010 08:00:05 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1256245888-25210-2-git-send-email-w.sang@pengutronix.de>
References: <1256245888-25210-1-git-send-email-w.sang@pengutronix.de>
	<1256245888-25210-2-git-send-email-w.sang@pengutronix.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 16 Feb 2010 08:59:38 -0700
Message-ID: <fa686aa41002160759k360e55bdkbb3fd67ba523b027@mail.gmail.com>
Subject: Re: [PATCH 1/3] i2c/mpc: drop NO_IRQ
To: Wolfram Sang <w.sang@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, linux-i2c@vger.kernel.org,
	Ben Dooks <ben-linux@fluff.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 22, 2009 at 2:11 PM, Wolfram Sang <w.sang@pengutronix.de> wrote=
:
> Drop NO_IRQ as 0 is the preferred way to describe 'no irq'
> (http://lkml.org/lkml/2005/11/21/221). This change is safe, as the driver=
 is
> only used on powerpc, where NO_IRQ is 0 anyhow.
>
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Ben Dooks <ben-linux@fluff.org>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
> =A0drivers/i2c/busses/i2c-mpc.c | =A0 =A06 +++---
> =A01 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
> index d325e86..7e58443 100644
> --- a/drivers/i2c/busses/i2c-mpc.c
> +++ b/drivers/i2c/busses/i2c-mpc.c
> @@ -115,7 +115,7 @@ static int i2c_wait(struct mpc_i2c *i2c, unsigned tim=
eout, int writing)
> =A0 =A0 =A0 =A0u32 x;
> =A0 =A0 =A0 =A0int result =3D 0;
>
> - =A0 =A0 =A0 if (i2c->irq =3D=3D NO_IRQ) {
> + =A0 =A0 =A0 if (!i2c->irq) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0while (!(readb(i2c->base + MPC_I2C_SR) & C=
SR_MIF)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0schedule();
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (time_after(jiffies, or=
ig_jiffies + timeout)) {
> @@ -520,7 +520,7 @@ static int __devinit fsl_i2c_probe(struct of_device *=
op,
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0i2c->irq =3D irq_of_parse_and_map(op->node, 0);
> - =A0 =A0 =A0 if (i2c->irq !=3D NO_IRQ) { /* i2c->irq =3D NO_IRQ implies =
polling */
> + =A0 =A0 =A0 if (i2c->irq) { /* no i2c->irq implies polling */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0result =3D request_irq(i2c->irq, mpc_i2c_i=
sr,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 I=
RQF_SHARED, "i2c-mpc", i2c);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (result < 0) {
> @@ -579,7 +579,7 @@ static int __devexit fsl_i2c_remove(struct of_device =
*op)
> =A0 =A0 =A0 =A0i2c_del_adapter(&i2c->adap);
> =A0 =A0 =A0 =A0dev_set_drvdata(&op->dev, NULL);
>
> - =A0 =A0 =A0 if (i2c->irq !=3D NO_IRQ)
> + =A0 =A0 =A0 if (i2c->irq)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0free_irq(i2c->irq, i2c);
>
> =A0 =A0 =A0 =A0irq_dispose_mapping(i2c->irq);
> --
> 1.6.5
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
