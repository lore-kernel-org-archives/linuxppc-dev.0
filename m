Return-Path: <david-b@pacbell.net>
Received: from smtp109.sbc.mail.mud.yahoo.com (smtp109.sbc.mail.mud.yahoo.com
	[68.142.198.208]) by ozlabs.org (Postfix) with SMTP id 5D456DDF08
	for <linuxppc-dev@ozlabs.org>; Wed, 16 May 2007 02:05:25 +1000 (EST)
From: David Brownell <david-b@pacbell.net>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [i2c] [PATCH] Make i2c-mpc driver use i2c_add_numbered_adapter
Date: Tue, 15 May 2007 09:05:20 -0700
References: <20070514190545.32739.72083.stgit@trillian.secretlab.ca>
	<200705150828.37529.david-b@pacbell.net>
	<528646bc0705150851pa578a56nc0dc171677748e5a@mail.gmail.com>
In-Reply-To: <528646bc0705150851pa578a56nc0dc171677748e5a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200705150905.21559.david-b@pacbell.net>
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

On Tuesday 15 May 2007, Grant Likely wrote:
> 
> Take another look; this is a funny quirk of the driver.  The
> assignment is 'i2c->adap = mpc_ops'; not 'i2c->adap = &mpc_ops'.  And
> in struct mpc_i2c, the field is declared as 'struct i2c_adapter adap',
> not 'struct i2c_adapter *adap'.  The driver instance gets a copy of
> the mpc_ops structure to initialize it, not a pointer to the staticly
> defined structure.  I got bitten by the same thing when I was looking
> at the code.

I see -- you're right.  That "template" idiom is a good one to get
rid of, FWIW ... not only is it confusing, but it also wastes space.

- Dave
