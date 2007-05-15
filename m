Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.170])
	by ozlabs.org (Postfix) with ESMTP id 34C3DDDF1B
	for <linuxppc-dev@ozlabs.org>; Wed, 16 May 2007 01:51:44 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so1172693ugf
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 08:51:40 -0700 (PDT)
Message-ID: <528646bc0705150851pa578a56nc0dc171677748e5a@mail.gmail.com>
Date: Tue, 15 May 2007 09:51:40 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "David Brownell" <david-b@pacbell.net>
Subject: Re: [i2c] [PATCH] Make i2c-mpc driver use i2c_add_numbered_adapter
In-Reply-To: <200705150828.37529.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <20070514190545.32739.72083.stgit@trillian.secretlab.ca>
	<20070515152626.199f9d6b@hyperion.delvare>
	<200705150828.37529.david-b@pacbell.net>
Cc: rtc-linux@googlegroups.com, James Chapman <jchapman@katalix.com>,
	linuxppc-dev@ozlabs.org, i2c@lm-sensors.org,
	Jean Delvare <khali@linux-fr.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 5/15/07, David Brownell <david-b@pacbell.net> wrote:
> On Tuesday 15 May 2007, Jean Delvare wrote:
> > On Mon, 14 May 2007 13:11:23 -0600, Grant Likely wrote:
>
> > > --- a/drivers/i2c/busses/i2c-mpc.c
> > > +++ b/drivers/i2c/busses/i2c-mpc.c
> > > @@ -327,9 +327,10 @@ static int fsl_i2c_probe(struct platform_device *pdev)
> > >     platform_set_drvdata(pdev, i2c);
> > >
> > >     i2c->adap = mpc_ops;
> > > +   i2c->adap.nr = pdev->id;
>
> By the way:  mpc_ops is a static i2c_adapter, so given that
> the reason for using pdev->id that way was that there might
> be more than one such platform device ... shouldn't allocation
> of the adapter be moved into allocation of the "i2c->" object?

Take another look; this is a funny quirk of the driver.  The
assignment is 'i2c->adap = mpc_ops'; not 'i2c->adap = &mpc_ops'.  And
in struct mpc_i2c, the field is declared as 'struct i2c_adapter adap',
not 'struct i2c_adapter *adap'.  The driver instance gets a copy of
the mpc_ops structure to initialize it, not a pointer to the staticly
defined structure.  I got bitten by the same thing when I was looking
at the code.

Not to mention that mpc_ops is poorly named.

Cheers,
g.


-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
