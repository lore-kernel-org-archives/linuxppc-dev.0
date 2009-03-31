Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
In-Reply-To: <20090331135629.GC3044@pengutronix.de>
References: <20090331125028.066613801@denx.de>
	<20090331125451.600446749@denx.de>
	<20090331133953.GB3044@pengutronix.de>
	<49D21EF1.9050200@grandegger.com>
	<20090331135629.GC3044@pengutronix.de>
Date: Tue, 31 Mar 2009 09:44:55 -0600
Message-ID: <fa686aa40903310844j11a85fb6w3558923e12670ba9@mail.gmail.com>
Subject: Re: [PATCH 1/2] powerpc: i2c-mpc: preserve I2C clocking
From: Grant Likely <grant.likely@secretlab.ca>
To: Wolfram Sang <w.sang@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org,
	linux-i2c@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

2009/3/31 Wolfram Sang <w.sang@pengutronix.de>:
>
>> >> -
>> >> - =A0mpc_i2c_setclock(i2c);
>> >> +
>> >> + =A0if (set_clock)
>> >> + =A0 =A0 =A0 =A0 =A0mpc_i2c_setclock(i2c);
>> >
>> > Can't we drop 'set_clock' with something like this here?
>> >
>> > + =A0 if (!of_get_property(op->node, "fsl,preserve-clocking", NULL)) {
>> > +
>> > + =A0 =A0 =A0 =A0 =A0 if (of_get_property(op->node, "dfsrr", NULL))
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 i2c->flags |=3D FSL_I2C_DEV_SEPA=
RATE_DFSRR;
>> > +
>> > + =A0 =A0 =A0 =A0 =A0 if (of_device_is_compatible(op->node, "fsl,mpc52=
00-i2c") ||
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_device_is_compatible(op->node, "mpc52=
00-i2c"))
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 i2c->flags |=3D FSL_I2C_DEV_CLOC=
K_5200;
>> > +
>> > + =A0 =A0 =A0 =A0 =A0 mpc_i2c_setclock(i2c);
>> > + =A0 }
>>
>> No, because the I2C registers are not yet mapped.
>
> Sorry, I used misleading words :) With 'here' I meant 'at this
> position', i.e. insert my above block where mpc_i2c_setclock was used
> anyway.

I agree.  The extra flag makes the flow more complex.  The code block
should be moved down.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
