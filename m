Return-Path: <jonsmirl@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.183])
	by ozlabs.org (Postfix) with ESMTP id 76337DDDE9
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jan 2008 02:19:01 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so3154343wag.13
	for <linuxppc-dev@ozlabs.org>; Sun, 20 Jan 2008 07:19:00 -0800 (PST)
Message-ID: <9e4733910801200718q7304bc29q38e67580613189e4@mail.gmail.com>
Date: Sun, 20 Jan 2008 10:18:59 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Jean Delvare" <khali@linux-fr.org>,
	"Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Subject: Re: [i2c] [PATCH 19 3/5] Clean up error returns
In-Reply-To: <20080120120730.06dd8a7f@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080112024737.7023.61680.stgit@terra.home>
	<20080112024743.7023.23630.stgit@terra.home>
	<20080120120730.06dd8a7f@hyperion.delvare>
Cc: linuxppc-dev@ozlabs.org, i2c@lm-sensors.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/20/08, Jean Delvare <khali@linux-fr.org> wrote:
> > @@ -381,7 +385,7 @@ static int fsl_i2c_remove(struct platform_device *pdev)
> >       i2c_del_adapter(&i2c->adap);
> >       platform_set_drvdata(pdev, NULL);
> >
> > -     if (i2c->irq != 0)
> > +     if (i2c->irq != NO_IRQ)
> >               free_irq(i2c->irq, i2c);
> >
> >       iounmap(i2c->base);
> >
> >
>
> Is this last chunk a cleanup or a bugfix? It seems that NO_IRQ can have
> value 0 or -1 depending on the architecture, so your change is real on
> some architectures.

I was confused by this too. Search the ppc list archives and there is
a thread about it where BenH tries to explain the correct way of
fixing it to me.

This is part of the ppc to powerpc conversion that has not been
completely cleaned up in this driver. NO_IRQ = -1 is ppc and NO_IRQ =
0 is powerpc. Since this driver didn't originally use the NO_IRQ
define it didn't get automatically converted. We need to identify the
right places where NO_IRQ should have been used.

>
> I have to admit that I'm a bit confused by the way IRQs are handled by
> this driver. On the one hand, there is code to handle polled-mode:
>
> static int i2c_wait(struct mpc_i2c *i2c, unsigned timeout, int writing)
> {
>         (...)
>         if (i2c->irq == 0)

I missed this one, it should have been NO_IRQ.

>         {
>                 (...)
>         } else {
>                 /* Interrupt mode */
>
> But on the other hand the initialization code bails out if the platform
> device doesn't provide an IRQ:

>
> static int fsl_i2c_probe(struct platform_device *pdev)
> {
>         (...)
>         i2c->irq = platform_get_irq(pdev, 0);
>         if (i2c->irq < 0) {
>                 result = -ENXIO;
>                 goto fail_get_irq;

It is only bailing out on an error, not the NO_IRQ case. But maybe the
comparison needs to be with NO_IRQ instead of zero.



>         }
>
> So it seems to me like the polling mode code is never actually used?
> Unless some platforms include an "empty" IRQ in their device
> definition. Which indeed seems to be the case... but then they set the
> IRQ to 0, NOT to NO_IRQ, so I'm wondering if the change you propose is
> really correct.

All of this is very confusing to me, There are physical IRQs and
virtual IRQs. Apparently zero is a legal physical IRQ but it is not a
legal virtual IRQ. We only get virtual IRQs in this code. We need to
get BenH to give us the right answer on these two cases.


>
> Either way, there are more places in the driver where the IRQ is
> compared to 0, so if your change is correct, it should be applied
> consistently. Thus I will revert this part for the time being, if any
> change is really needed with regards to interrupts in this driver,
> please send a separate patch. But please double-check first, as I said
> above it's trickier than it looks.
>
> --
> Jean Delvare
>


-- 
Jon Smirl
jonsmirl@gmail.com
