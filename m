Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.173])
	by ozlabs.org (Postfix) with ESMTP id 3FC34DDF09
	for <linuxppc-dev@ozlabs.org>; Thu, 17 May 2007 04:38:12 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so142377ugf
	for <linuxppc-dev@ozlabs.org>; Wed, 16 May 2007 11:38:10 -0700 (PDT)
Message-ID: <528646bc0705161138q3ed921dag81f0f86216d10a20@mail.gmail.com>
Date: Wed, 16 May 2007 12:38:10 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Jean Delvare" <khali@linux-fr.org>
Subject: Re: [i2c] [PATCH] Make i2c-mpc driver use i2c_add_numbered_adapter
In-Reply-To: <20070516202520.3c6c5280@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <20070514190545.32739.72083.stgit@trillian.secretlab.ca>
	<200705150828.37529.david-b@pacbell.net>
	<528646bc0705150851pa578a56nc0dc171677748e5a@mail.gmail.com>
	<200705150905.21559.david-b@pacbell.net>
	<20070516202520.3c6c5280@hyperion.delvare>
Cc: rtc-linux@googlegroups.com, James Chapman <jchapman@katalix.com>,
	David Brownell <david-b@pacbell.net>, linuxppc-dev@ozlabs.org,
	i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 5/16/07, Jean Delvare <khali@linux-fr.org> wrote:
> On Tue, 15 May 2007 09:05:20 -0700, David Brownell wrote:
> > On Tuesday 15 May 2007, Grant Likely wrote:
> > >
> > > Take another look; this is a funny quirk of the driver.  The
> > > assignment is 'i2c->adap = mpc_ops'; not 'i2c->adap = &mpc_ops'.  And
> > > in struct mpc_i2c, the field is declared as 'struct i2c_adapter adap',
> > > not 'struct i2c_adapter *adap'.  The driver instance gets a copy of
> > > the mpc_ops structure to initialize it, not a pointer to the staticly
> > > defined structure.  I got bitten by the same thing when I was looking
> > > at the code.
> >
> > I see -- you're right.  That "template" idiom is a good one to get
> > rid of, FWIW ... not only is it confusing, but it also wastes space.
>
> Well, maybe you can submit a patch fixing this one?

Heh, oops.

I had replied to David saying that I would do this bit; but I forgot
to cc the list.

I'll take care of this.

Cheers,
g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
