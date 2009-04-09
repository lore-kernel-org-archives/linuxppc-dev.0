Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (xc.sipsolutions.net [83.246.72.84])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 89F5CDE120
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Apr 2009 22:34:55 +1000 (EST)
Subject: Re: [PATCH] AOA: Convert onyx and tas codecs to new-style i2c  
	drivers
From: Johannes Berg <johannes@sipsolutions.net>
To: Jean Delvare <khali@linux-fr.org>
In-Reply-To: <20090409141945.116772e3@hyperion.delvare>
References: <20090408150249.5a62a56c@hyperion.delvare>
	<1239205899.16477.32.camel@johannes.local>
	<20090408224858.04cb6dc4@hyperion.delvare>
	<1239263089.24548.30.camel@johannes.local>
	<20090409141945.116772e3@hyperion.delvare>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-sIWA1p4O9S9PaoFGgLgx"
Date: Thu, 09 Apr 2009 14:34:44 +0200
Message-Id: <1239280485.4953.6.camel@johannes.local>
Mime-Version: 1.0
Cc: Takashi Iwai <tiwai@suse.de>, linuxppc-dev@ozlabs.org,
	alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-sIWA1p4O9S9PaoFGgLgx
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi Jean,

> OK, I understand how it works now, thanks for pointing me to the
> relevant piece of code. It's easier to modify the code when you
> understand the current logic ;)

:)

> The idea is to assign fixed i2c bus numbers to the relevant i2c buses,
> and declare the i2c devices connected to each bus by bus number and
> device address. The i2c-powermac buses are created in
> arch/powerpc/platforms/powermac/low_i2c.c, so you would have to
> instantiate the i2c devices there too. That would basically mean
> merging part of snd-aoa-fabric-layout into
> arch/powerpc/platforms/powermac/low_i2c.c as I understand it, I don't
> know if this sounds reasonable to you.

That doesn't sound too hot -- the fabric module is quite a lot of code
and data.

> So I think we have two options: switch the powermac systems to fixed
> i2c bus numbers and instantiate the i2c sound devices from
> arch/powerpc/platforms/powermac/*, or find a way to obtain a reference
> to the relevant i2c_adapter.
>=20
> I think I have found a way to achieve the latter. This isn't exactly
> how the new model was supposed to work, but it has the advantage to be
> way less intrusive than my original proposal. It may require larger
> changes in the future as the i2c-core cleanups go on, but this should
> do for now.

Heh :)

> My new approach doesn't auto-load anything. Here we go, what you think?
> This time there is no logic change, I'm really only turning legacy code
> into new-style i2c code (basically calling i2c_new_device() instead of
> i2c_attach_client()) and that's about it.
>=20
> (Once again this is only build-tested and I would like people with the
> hardware to give it a try.)

Looks reasonable.

>  static int onyx_create(struct i2c_adapter *adapter,
>  		       struct device_node *node,
>  		       int addr)
>  {
> +	struct i2c_board_info info;
> +	struct i2c_client *client;
> +
> +	memset(&info, 0, sizeof(struct i2c_board_info));
> +	strlcpy(info.type, "aoa_codec_onyx", I2C_NAME_SIZE);
> +	if (node) {
> +		info.addr =3D addr;
> +		info.platform_data =3D node;
> +		client =3D i2c_new_device(adapter, &info);
> +	} else {
> +		/* probe both possible addresses for the onyx chip */
> +		unsigned short probe_onyx[] =3D {
> +			0x46, 0x47, I2C_CLIENT_END
> +		};
> +
> +		client =3D i2c_new_probed_device(adapter, &info, probe_onyx);
> +	}
> +	if (!client)
> +		return -ENODEV;
> +
> +	list_add_tail(&client->detected, &client->driver->clients);

That list_add looks a little hackish, and wouldn't it be racy?

> +static const struct i2c_device_id onyx_i2c_id[] =3D {
> +	{ "aoa_codec_onyx", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, onyx_i2c_id);

Should it really export the device table?

(same comments for tas)

It'll be until mid next week that I can test anything.

johannes

--=-sIWA1p4O9S9PaoFGgLgx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIcBAABAgAGBQJJ3etiAAoJEKVg1VMiehFY+mMP/0lhXlCmlkHdHK4e7dqOojA8
ssZS/7SLl0jpnKWd68BrOg+Pcq7sww+cM6W/wxDQNoJx6A9E3y/ZCv9D+JZE+LTp
A3lPA2DS4SCcL4z6EErUOiH58US3/j2LCup9pWJ02+Te5fdzchwGhr+FGkREAe40
4L3CK028Lw/GRNQXev4kkq8tAFkDMEOPiLzsgkseA/KcKfVAZ84Rw0T/hdWY6NR0
b//+i5MiGKy9Q9eW4dO85xBLHBWSnMjNdCcwlRpnaeAnm1/a4VpU9bdMjtcNLJ+m
bhygGfUfD3PgHrkB0uzdpNcdGl4FtlsChGBLz77b4w85vAXwfvCJFfpTi/wWuJfh
emsKpqej5ia0K0WAinx3UcBxNUkOfI32q8ZiQnVu8yjp8hctXCkaASR7AmmpRZms
4b9MNjHmgllzyTGn3BCMnj4Yc6JMSPeu2OedSE0Ka6LGyKedRpVo2OcGpEb/d4yr
dIRjKPAS72CooT37f5eoOP+hqbJTk6XsglOwTIQl/AX3lNmFfe103IG1RQM8GGVN
ucTB18uVlsev/OboLk5nmvGHSBLHLZ8emnl5dMSsj1HqWu8zhHz5sDhzaPj0jwKg
lAgpr6+eztkuLOkjczDrdBVrn354WIXk3YBweODVTwRDBZZFQIb/r/GrRXwf7KBb
9ba0G6Yu8Ay5LkpgztLU
=NSTg
-----END PGP SIGNATURE-----

--=-sIWA1p4O9S9PaoFGgLgx--
