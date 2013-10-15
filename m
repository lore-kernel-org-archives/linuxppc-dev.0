Return-Path: <glikely@secretlab.ca>
Received: from mail-wi0-f181.google.com (mail-wi0-f181.google.com
 [209.85.212.181])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8882A2C036C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Oct 2013 09:55:30 +1100 (EST)
Received: by mail-wi0-f181.google.com with SMTP id l12so5833219wiv.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Oct 2013 15:55:26 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@linaro.org>
Subject: Re: [PATCH v2 01/10] of/irq: Rework of_irq_count()
To: Rob Herring <robherring2@gmail.com>,
 Thierry Reding <thierry.reding@gmail.com>
In-Reply-To: <CAL_JsqLE8aj511oF-gK7Gu5QfmHsQO3+oJ0KFkv0wmuo7i6eiw@mail.gmail.com>
References: <1379510692-32435-1-git-send-email-treding@nvidia.com>
 <1379510692-32435-2-git-send-email-treding@nvidia.com>
 <CAL_JsqLE8aj511oF-gK7Gu5QfmHsQO3+oJ0KFkv0wmuo7i6eiw@mail.gmail.com>
Date: Tue, 15 Oct 2013 23:55:23 +0100
Message-Id: <20131015225523.2A9C1C40099@trevor.secretlab.ca>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Russell King <linux@arm.linux.org.uk>, linux-mips@linux-mips.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Rob Herring <rob.herring@calxeda.com>, Ralf Baechle <ralf@linux-mips.org>,
 sparclinux@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 22 Sep 2013 16:19:27 -0500, Rob Herring <robherring2@gmail.com> wrote:
> On Wed, Sep 18, 2013 at 8:24 AM, Thierry Reding
> <thierry.reding@gmail.com> wrote:
> > The of_irq_to_resource() helper that is used to implement of_irq_count()
> > tries to resolve interrupts and in fact creates a mapping for resolved
> > interrupts. That's pretty heavy lifting for something that claims to
> > just return the number of interrupts requested by a given device node.
> >
> > Instead, use the more lightweight of_irq_map_one(), which, despite the
> > name, doesn't create an actual mapping. Perhaps a better name would be
> > of_irq_translate_one().
> >
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> 
> Acked-by: Rob Herring <rob.herring@calxeda.com>

Applied, thanks.

g.

> 
> > ---
> >  drivers/of/irq.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/of/irq.c b/drivers/of/irq.c
> > index 1752988..5f44388 100644
> > --- a/drivers/of/irq.c
> > +++ b/drivers/of/irq.c
> > @@ -368,9 +368,10 @@ EXPORT_SYMBOL_GPL(of_irq_to_resource);
> >   */
> >  int of_irq_count(struct device_node *dev)
> >  {
> > +       struct of_irq irq;
> >         int nr = 0;
> >
> > -       while (of_irq_to_resource(dev, nr, NULL))
> > +       while (of_irq_map_one(dev, nr, &irq) == 0)
> >                 nr++;
> >
> >         return nr;
> > --
> > 1.8.4
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
