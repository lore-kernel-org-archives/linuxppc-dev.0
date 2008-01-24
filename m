Return-Path: <jonsmirl@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.182])
	by ozlabs.org (Postfix) with ESMTP id 7FF5CDDE01
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jan 2008 10:07:40 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so664519wag.13
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jan 2008 15:07:39 -0800 (PST)
Message-ID: <9e4733910801241507t214561a4sb70bbb375b1f60a9@mail.gmail.com>
Date: Thu, 24 Jan 2008 18:07:38 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: benh@kernel.crashing.org
Subject: Re: [i2c] [PATCH] mpc i2c driver, compare to NO_IRQ instead of zero
In-Reply-To: <1201214138.6815.107.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080121200740.13800.20524.stgit@terra.home>
	<9e4733910801241432r4424d41ayd5e41e57bc3e052b@mail.gmail.com>
	<1201214138.6815.107.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/24/08, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
> On Thu, 2008-01-24 at 17:32 -0500, Jon Smirl wrote:
> > Ben, do you approve of this? How should error be checked for, is
> > <NO_IRQ right? The current code in the kernel looks to be broken
> > because of these checks, the ppc build is wrong and powerpc polled
> > mode doesn't work.
>
>  == 0 should work on powerpc since NO_IRQ is defined to be 0 there no ?

The driver being patched is used in both the powerpc and ppc builds.

>
> Anyway, using the symbolic constant is always nicer I suppose.
>
> Ben.
>
> > On 1/21/08, Jon Smirl <jonsmirl@gmail.com> wrote:
> > > Alter the mpc i2c driver to use the NO_IRQ symbol instead of the constant zero when checking for valid interrupts. NO_IRQ=-1 on ppc and NO_IRQ=0 on powerpc so the checks against zero are not correct.
> > >
> > > Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
> > > ---
> > >
> > >  drivers/i2c/busses/i2c-mpc.c |   10 +++++-----
> > >  1 files changed, 5 insertions(+), 5 deletions(-)
> > >
> > >
> > > diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
> > > index bbe787b..d20959d 100644
> > > --- a/drivers/i2c/busses/i2c-mpc.c
> > > +++ b/drivers/i2c/busses/i2c-mpc.c
> > > @@ -99,7 +99,7 @@ static int i2c_wait(struct mpc_i2c *i2c, unsigned timeout, int writing)
> > >         u32 x;
> > >         int result = 0;
> > >
> > > -       if (i2c->irq == 0)
> > > +       if (i2c->irq == NO_IRQ)
> > >         {
> > >                 while (!(readb(i2c->base + MPC_I2C_SR) & CSR_MIF)) {
> > >                         schedule();
> > > @@ -329,7 +329,7 @@ static int fsl_i2c_probe(struct platform_device *pdev)
> > >                 return -ENOMEM;
> > >
> > >         i2c->irq = platform_get_irq(pdev, 0);
> > > -       if (i2c->irq < 0) {
> > > +       if (i2c->irq < NO_IRQ) {
> > >                 result = -ENXIO;
> > >                 goto fail_get_irq;
> > >         }
> > > @@ -344,7 +344,7 @@ static int fsl_i2c_probe(struct platform_device *pdev)
> > >                 goto fail_map;
> > >         }
> > >
> > > -       if (i2c->irq != 0)
> > > +       if (i2c->irq != NO_IRQ)
> > >                 if ((result = request_irq(i2c->irq, mpc_i2c_isr,
> > >                                           IRQF_SHARED, "i2c-mpc", i2c)) < 0) {
> > >                         printk(KERN_ERR
> > > @@ -367,7 +367,7 @@ static int fsl_i2c_probe(struct platform_device *pdev)
> > >         return result;
> > >
> > >        fail_add:
> > > -       if (i2c->irq != 0)
> > > +       if (i2c->irq != NO_IRQ)
> > >                 free_irq(i2c->irq, i2c);
> > >        fail_irq:
> > >         iounmap(i2c->base);
> > > @@ -384,7 +384,7 @@ static int fsl_i2c_remove(struct platform_device *pdev)
> > >         i2c_del_adapter(&i2c->adap);
> > >         platform_set_drvdata(pdev, NULL);
> > >
> > > -       if (i2c->irq != 0)
> > > +       if (i2c->irq != NO_IRQ)
> > >                 free_irq(i2c->irq, i2c);
> > >
> > >         iounmap(i2c->base);
> > >
> > >
> > > _______________________________________________
> > > i2c mailing list
> > > i2c@lm-sensors.org
> > > http://lists.lm-sensors.org/mailman/listinfo/i2c
> > >
> >
> >
>
>


-- 
Jon Smirl
jonsmirl@gmail.com
