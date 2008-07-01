Return-Path: <khali@linux-fr.org>
Date: Tue, 1 Jul 2008 19:12:24 +0200
From: Jean Delvare <khali@linux-fr.org>
To: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [PATCH 2/2] Add the of_find_i2c_device_by_node function, V4
Message-ID: <20080701191224.10ed2437@hyperion.delvare>
In-Reply-To: <9e4733910807011000t67e3abe5kb39302e911558dad@mail.gmail.com>
References: <20080630230126.12482.87927.stgit@terra>
	<20080630230128.12482.79570.stgit@terra>
	<20080701170544.72051418@hyperion.delvare>
	<9e4733910807010812h30e49144v5b3012e6c156ecca@mail.gmail.com>
	<20080701164329.GF6918@secretlab.ca>
	<9e4733910807011000t67e3abe5kb39302e911558dad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 1 Jul 2008 13:00:08 -0400, Jon Smirl wrote:
> On 7/1/08, Grant Likely <grant.likely@secretlab.ca> wrote:
> > My preference is for things like of_spi and of_i2c to go with the
> >  related busses; I think it makes more sense to keep all the I2C stuff
> >  together, but I've already lost that battle once.
> 
> This is a similar problem to adding aliases to the i2c driver drivers
> for the device tree names of the i2c devices. Instead we have code in
> drivers/of/of_i2c.c that tries to guess the translation from device
> tree to linux names. Adding aliases to the drivers would eliminate the
> need for of_find_i2c_driver().
> 
> I've previously posted patches implementing device tree names in the
> drivers that used ifdef to only instantiate on powerpc builds. For
> example....
> 
> diff --git a/drivers/i2c/chips/tps65010.c b/drivers/i2c/chips/tps65010.c
> index e07274d..9cd1770 100644
> --- a/drivers/i2c/chips/tps65010.c
> +++ b/drivers/i2c/chips/tps65010.c
> @@ -571,6 +571,10 @@ static const struct i2c_device_id tps65010_id[] = {
>         { "tps65011", TPS65011 },
>         { "tps65012", TPS65012 },
>         { "tps65013", TPS65013 },
> +       OF_ID("ti,tps65010", TPS65010)
> +       OF_ID("ti,tps65011", TPS65011)
> +       OF_ID("ti,tps65012", TPS65012)
> +       OF_ID("ti,tps65013", TPS65013)
>         { },
>  };
>  MODULE_DEVICE_TABLE(i2c, tps65010_id);

Yeah, yeah, you've been asking for this for months already, but it's
just not going to happen, sorry. You want to abuse the standard Linux
alias mechanism for your personal (i.e. openfirmware) use, but that's
bad. Linux drivers shouldn't have to know whether they are used in
openfirmware trees and what device names are used there. And device
names as seen by user-space shouldn't vary depending on whether the
device comes from an openfirmware tree or not - otherwise all
user-space apps need to learn about both naming conversions.

Unsurprisingly, no other subsystem does what you propose.

-- 
Jean Delvare
