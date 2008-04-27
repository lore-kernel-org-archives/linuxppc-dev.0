Return-Path: <khali@linux-fr.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8C8FFDDDEA
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Apr 2008 02:56:21 +1000 (EST)
Date: Sun, 27 Apr 2008 18:56:06 +0200
From: Jean Delvare <khali@linux-fr.org>
To: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/3] i2c: Convert all new-style drivers to use module
	aliasing
Message-ID: <20080427185606.6d694218@hyperion.delvare>
In-Reply-To: <200801271040.20248.david-b@pacbell.net>
References: <20080121112517.6fe35a89@hyperion.delvare>
	<20080121114139.3aaa111a@hyperion.delvare>
	<200801271040.20248.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Linux I2C <i2c@lm-sensors.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 27 Jan 2008 10:40:19 -0800, David Brownell wrote:
> General comment:  if you're going to index arrays by enum
> values, it's best to initialize them that way too.  Else
> you're expecting a particular optional policy for how the
> enums get grown...
> 
> - Dave
> 
> 
> On Monday 21 January 2008, Jean Delvare wrote:
> > --- linux-2.6.24-rc8.orig/drivers/rtc/rtc-ds1307.c	2008-01-20 17:26:58.000000000 +0100
> > +++ linux-2.6.24-rc8/drivers/rtc/rtc-ds1307.c	2008-01-20 19:03:48.000000000 +0100
> > @@ -102,42 +102,36 @@ struct chip_desc {
> >  	char			name[9];
> >  	unsigned		nvram56:1;
> >  	unsigned		alarm:1;
> > -	enum ds_type		type;
> >  };
> >  
> >  static const struct chip_desc chips[] = { {
> >  	.name		= "ds1307",
> > -	.type		= ds_1307,
> >  	.nvram56	= 1,
> >  }, {
> 
> So tables like this would become
> 
> 	[ds1307] = { ... },
> 	[ds1337] = { ... },
> 
> >  	.name		= "ds1337",
> > -	.type		= ds_1337,
> >  	.alarm		= 1,
> >  }, {
> >  	.name		= "ds1338",
> > -	.type		= ds_1338,
> >  	.nvram56	= 1,
> >  }, {
> >  	.name		= "ds1339",
> > -	.type		= ds_1339,
> >  	.alarm		= 1,
> >  }, {
> >  	.name		= "ds1340",
> > -	.type		= ds_1340,
> >  }, {
> >  	.name		= "m41t00",
> > -	.type		= m41t00,
> >  }, };
> >  
> > -static inline const struct chip_desc *find_chip(const char *s)
> > -{
> > -	unsigned i;
> > -
> > -	for (i = 0; i < ARRAY_SIZE(chips); i++)
> > -		if (strnicmp(s, chips[i].name, sizeof chips[i].name) == 0)
> > -			return &chips[i];
> > -	return NULL;
> > -}
> > +static const struct i2c_device_id ds1307_id[] = {
> > +	{ "ds1307", ds_1307 },
> > +	{ "ds1337", ds_1337 },
> > +	{ "ds1338", ds_1338 },
> > +	{ "ds1339", ds_1339 },
> > +	{ "ds1340", ds_1340 },
> > +	{ "m41t00", m41t00 },
> > +	{},
> > +};
> > +MODULE_DEVICE_TABLE(i2c, ds1307_id);
> >  
> >  static int ds1307_get_time(struct device *dev, struct rtc_time *t)
> >  {
> > @@ -335,12 +329,7 @@ static int __devinit ds1307_probe(struct
> >  	const struct chip_desc	*chip;
> >  	struct i2c_adapter	*adapter = to_i2c_adapter(client->dev.parent);
> >  
> > -	chip = find_chip(client->name);
> > -	if (!chip) {
> > -		dev_err(&client->dev, "unknown chip type '%s'\n",
> > -				client->name);
> > -		return -ENODEV;
> > -	}
> > +	chip = &chips[id->driver_data];
> 
> ... and that would *ensure* such lines always work right,
> no matter how the enum values grow.
> 
> >  
> >  	if (!i2c_check_functionality(adapter,
> >  			I2C_FUNC_I2C | I2C_FUNC_SMBUS_WRITE_BYTE_DATA))

Done, thanks for the suggestion and sorry for the delay.

-- 
Jean Delvare
