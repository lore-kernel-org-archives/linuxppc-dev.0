Return-Path: <jonsmirl@gmail.com>
Received: from rn-out-0910.google.com (rn-out-0910.google.com [64.233.170.188])
	by ozlabs.org (Postfix) with ESMTP id 99782DDE20
	for <linuxppc-dev@ozlabs.org>; Sat,  3 May 2008 00:23:03 +1000 (EST)
Received: by rn-out-0910.google.com with SMTP id e13so700871rng.16
	for <linuxppc-dev@ozlabs.org>; Fri, 02 May 2008 07:23:02 -0700 (PDT)
Message-ID: <9e4733910805020723p7900c132j872893113f9d739e@mail.gmail.com>
Date: Fri, 2 May 2008 10:23:01 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Jean Delvare" <khali@linux-fr.org>
Subject: Re: [PATCH] mpc i2c driver, compare to NO_IRQ instead of zero
In-Reply-To: <20080219174221.5b18cba8@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080121200740.13800.20524.stgit@terra.home>
	<20080219174221.5b18cba8@hyperion.delvare>
Cc: linuxppc-dev@ozlabs.org, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 2/19/08, Jean Delvare <khali@linux-fr.org> wrote:
>  >       i2c->irq = platform_get_irq(pdev, 0);
>  > -     if (i2c->irq < 0) {
>  > +     if (i2c->irq < NO_IRQ) {
>
>
> I am skeptical about this one. Can platform_get_irq() really return
>  NO_IRQ? I thought that the IRQ resource would be plain missing if the
>  device has no IRQ, so I would expect:
>
>
>         i2c->irq = platform_get_irq(pdev, 0);
>         if (i2c->irq < 0)
>
>                 i2c->irq = NO_IRQ; /* Use polling */
>
>  Testing against NO_IRQ suggests that devices with no IRQ would still
>  have an IRQ resource defined and explicitly set to NO_IRQ. Sounds weird
>  to me. Can you please clarify this point?

Your fix is correct. I'm not sure polling worked in the original driver.

>  For what it's worth, no other kernel driver checks for irq < NO_IRQ.
>  They all check for irq < 0 after calling platform_get_irq().
>
>
>  >               result = -ENXIO;
>  >               goto fail_get_irq;
>  >       }
>  > @@ -344,7 +344,7 @@ static int fsl_i2c_probe(struct platform_device *pdev)
>  >               goto fail_map;
>  >       }
>  >
>  > -     if (i2c->irq != 0)
>  > +     if (i2c->irq != NO_IRQ)
>  >               if ((result = request_irq(i2c->irq, mpc_i2c_isr,
>  >                                         IRQF_SHARED, "i2c-mpc", i2c)) < 0) {
>  >                       printk(KERN_ERR
>  > @@ -367,7 +367,7 @@ static int fsl_i2c_probe(struct platform_device *pdev)
>  >       return result;
>  >
>  >        fail_add:
>  > -     if (i2c->irq != 0)
>  > +     if (i2c->irq != NO_IRQ)
>  >               free_irq(i2c->irq, i2c);
>  >        fail_irq:
>  >       iounmap(i2c->base);
>  > @@ -384,7 +384,7 @@ static int fsl_i2c_remove(struct platform_device *pdev)
>  >       i2c_del_adapter(&i2c->adap);
>  >       platform_set_drvdata(pdev, NULL);
>  >
>  > -     if (i2c->irq != 0)
>  > +     if (i2c->irq != NO_IRQ)
>  >               free_irq(i2c->irq, i2c);
>  >
>  >       iounmap(i2c->base);
>
>
> The rest looks good.
>
>  --
>
> Jean Delvare
>


-- 
Jon Smirl
jonsmirl@gmail.com
