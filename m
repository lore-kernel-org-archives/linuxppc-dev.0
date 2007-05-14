Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.170])
	by ozlabs.org (Postfix) with ESMTP id 150BCDDECF
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 05:02:29 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so1023463ugf
	for <linuxppc-dev@ozlabs.org>; Mon, 14 May 2007 12:02:27 -0700 (PDT)
Message-ID: <528646bc0705141202h1cf1a309y2e1ed1289974b3c7@mail.gmail.com>
Date: Mon, 14 May 2007 13:02:18 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "David Brownell" <david-b@pacbell.net>
Subject: Re: [patch/rft 4/4] rtc-ds1307 platform update,
	powerpc mpc834x_itx and mpc8313_rdb
In-Reply-To: <200705141149.27858.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <200705140946.41993.david-b@pacbell.net>
	<528646bc0705141044s244ce3ecyad5096c441134203@mail.gmail.com>
	<200705141125.59266.david-b@pacbell.net>
	<200705141149.27858.david-b@pacbell.net>
Cc: linuxppc-dev@ozlabs.org, i2c@lm-sensors.org, rtc-linux@googlegroups.com,
	James Chapman <jchapman@katalix.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 5/14/07, David Brownell <david-b@pacbell.net> wrote:
>
> > > > @@ -329,7 +330,7 @@ static int fsl_i2c_probe(struct platform
> > > >         i2c->adap = mpc_ops;
> > > >         i2c_set_adapdata(&i2c->adap, i2c);
> > > >         i2c->adap.dev.parent = &pdev->dev;
> > > > -       if ((result = i2c_add_adapter(&i2c->adap)) < 0) {
> > > > +       if ((result = i2c_add_numbered_adapter(&i2c->adap)) < 0) {
> > > >                 printk(KERN_ERR "i2c-mpc - failed to add adapter\n");
> > > >                 goto fail_add;
> > > >         }
> > >
> > > ...
> > >
> > > I think you need to add this line before the call to i2c_add_numbered_adapter:
> > >
> > > i2c->adap.nr = pdev->id;
> >
> > If these chips do have multiple instances of that adapter logic,
> > that would be an appropriate change.  The only "gotcha" might be
> > that some platforms use the "pdev->id = -1" trick when there's
> > only a single instance ... that would probably map to zero.
> >
> > I'll hope that whoever makes all this work will resolve those
> > particular questions ...
>
> Oh, and by the way:  patches updating I2C adapter drivers to work
> with new-style drivers look to be OK to get into 2.6.22 with just
> an Ack from Jean, via the MM tree.  (Right, Jean?)
>
> In this case I'll hope someone else does the real submission, after
> testing.  I just wanted to nudge the process along

I'll submit this one (at least the i2c-mpc.c bits).  It's already
working on my mpc5200 board.  I don't have any of the other boards, so
those fixups should come from others.

Cheers,
g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
