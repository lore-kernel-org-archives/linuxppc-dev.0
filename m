Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.179])
	by ozlabs.org (Postfix) with ESMTP id 0D310DDE1D
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 10 Jul 2007 16:22:06 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so1634573wag
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 09 Jul 2007 23:22:05 -0700 (PDT)
Message-ID: <fa686aa40707092322v58bbdad0veb0ee2ec00f125b0@mail.gmail.com>
Date: Tue, 10 Jul 2007 00:22:05 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Domen Puncer" <domen.puncer@telargo.com>
Subject: Re: [PATCH] i2c-mpc: work around missing-9th-clock-pulse bug
In-Reply-To: <20070710061736.GG4186@moe.telargo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <20070709071955.GD4186@moe.telargo.com>
	<fa686aa40707090853j6079b0c7rbcff7c449baa15e0@mail.gmail.com>
	<20070710061736.GG4186@moe.telargo.com>
Cc: khali@linux-fr.org, i2c@lm-sensors.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 7/10/07, Domen Puncer <domen.puncer@telargo.com> wrote:
> On 09/07/07 09:53 -0600, Grant Likely wrote:
> > On 7/9/07, Domen Puncer <domen.puncer@telargo.com> wrote:
> > >Work around a problem reported on:
> > >http://ozlabs.org/pipermail/linuxppc-embedded/2005-July/019038.html
> > >Without this patch I2C on mpc5200 becomes unusable after a while.
> > >Tested on mpc5200 based boards by Matthias and me.
> > >
> > >Index: work-powerpc.git/drivers/i2c/busses/i2c-mpc.c
> > >===================================================================
> > >--- work-powerpc.git.orig/drivers/i2c/busses/i2c-mpc.c
> > >+++ work-powerpc.git/drivers/i2c/busses/i2c-mpc.c
> > >@@ -153,6 +167,9 @@ static void mpc_i2c_start(struct mpc_i2c
> > > static void mpc_i2c_stop(struct mpc_i2c *i2c)
> > > {
> > >        writeccr(i2c, CCR_MEN);
> > >+       mb();
> > >+       writeccr(i2c, 0);
> > >+       mb();
> > > }
> >
> > Are the mb() calls necessary?  The writeccr path includes eieio; is
> > that not sufficient?
>
> Right, v2:
>
>
> Work around a problem reported on:
> http://ozlabs.org/pipermail/linuxppc-embedded/2005-July/019038.html
> Without this patch I2C on mpc5200 becomes unusable after a while.
> Tested on mpc5200 boards by Matthias and me.
>
>
> Signed-off-by: Domen Puncer <domen.puncer@telargo.com>

Looks good to me,

Acked-by: Grant Likely <grant.likely@secretlab.ca>

>
> ---
>  drivers/i2c/busses/i2c-mpc.c |   17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> Index: work-powerpc.git/drivers/i2c/busses/i2c-mpc.c
> ===================================================================
> --- work-powerpc.git.orig/drivers/i2c/busses/i2c-mpc.c
> +++ work-powerpc.git/drivers/i2c/busses/i2c-mpc.c
> @@ -74,6 +74,20 @@ static irqreturn_t mpc_i2c_isr(int irq,
>         return IRQ_HANDLED;
>  }
>
> +static void mpc_i2c_fixup(struct mpc_i2c *i2c)
> +{
> +       writeccr(i2c, 0);
> +       udelay(30);
> +       writeccr(i2c, CCR_MEN);
> +       udelay(30);
> +       writeccr(i2c, CCR_MSTA | CCR_MTX);
> +       udelay(30);
> +       writeccr(i2c, CCR_MSTA | CCR_MTX | CCR_MEN);
> +       udelay(30);
> +       writeccr(i2c, CCR_MEN);
> +       udelay(30);
> +}
> +
>  static int i2c_wait(struct mpc_i2c *i2c, unsigned timeout, int writing)
>  {
>         unsigned long orig_jiffies = jiffies;
> @@ -153,6 +167,7 @@ static void mpc_i2c_start(struct mpc_i2c
>  static void mpc_i2c_stop(struct mpc_i2c *i2c)
>  {
>         writeccr(i2c, CCR_MEN);
> +       writeccr(i2c, 0);
>  }
>
>  static int mpc_write(struct mpc_i2c *i2c, int target,
> @@ -245,6 +260,8 @@ static int mpc_xfer(struct i2c_adapter *
>                 }
>                 if (time_after(jiffies, orig_jiffies + HZ)) {
>                         pr_debug("I2C: timeout\n");
> +                       if (readb(i2c->base + MPC_I2C_SR) == (CSR_MCF | CSR_MBB | CSR_RXAK))
> +                               mpc_i2c_fixup(i2c);
>                         return -EIO;
>                 }
>                 schedule();
>


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
