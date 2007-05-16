Return-Path: <khali@linux-fr.org>
Received: from mallaury.nerim.net (smtp-103-wednesday.noc.nerim.net
	[62.4.17.103]) by ozlabs.org (Postfix) with ESMTP id A36CCDDF05
	for <linuxppc-dev@ozlabs.org>; Thu, 17 May 2007 04:25:17 +1000 (EST)
Date: Wed, 16 May 2007 20:25:20 +0200
From: Jean Delvare <khali@linux-fr.org>
To: David Brownell <david-b@pacbell.net>
Subject: Re: [i2c] [PATCH] Make i2c-mpc driver use i2c_add_numbered_adapter
Message-ID: <20070516202520.3c6c5280@hyperion.delvare>
In-Reply-To: <200705150905.21559.david-b@pacbell.net>
References: <20070514190545.32739.72083.stgit@trillian.secretlab.ca>
	<200705150828.37529.david-b@pacbell.net>
	<528646bc0705150851pa578a56nc0dc171677748e5a@mail.gmail.com>
	<200705150905.21559.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: rtc-linux@googlegroups.com, James Chapman <jchapman@katalix.com>,
	linuxppc-dev@ozlabs.org, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 15 May 2007 09:05:20 -0700, David Brownell wrote:
> On Tuesday 15 May 2007, Grant Likely wrote:
> > 
> > Take another look; this is a funny quirk of the driver.  The
> > assignment is 'i2c->adap = mpc_ops'; not 'i2c->adap = &mpc_ops'.  And
> > in struct mpc_i2c, the field is declared as 'struct i2c_adapter adap',
> > not 'struct i2c_adapter *adap'.  The driver instance gets a copy of
> > the mpc_ops structure to initialize it, not a pointer to the staticly
> > defined structure.  I got bitten by the same thing when I was looking
> > at the code.
> 
> I see -- you're right.  That "template" idiom is a good one to get
> rid of, FWIW ... not only is it confusing, but it also wastes space.

Well, maybe you can submit a patch fixing this one?

-- 
Jean Delvare
