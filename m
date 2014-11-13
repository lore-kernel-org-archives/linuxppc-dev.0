Return-Path: <wsa@the-dreams.de>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8FB471A194C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Nov 2014 18:57:06 +1100 (AEDT)
Received: from pokefinder.org (sauhun.de [89.238.76.85])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D01BD140082
 for <linuxppc-dev@ozlabs.org>; Thu, 13 Nov 2014 18:57:05 +1100 (AEDT)
Date: Thu, 13 Nov 2014 08:58:17 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Neelesh Gupta <neelegup@linux.vnet.ibm.com>
Subject: Re: [PATCH] i2c: Driver to expose PowerNV platform i2c busses
Message-ID: <20141113075817.GA1288@katana>
References: <20141110060424.9407.2498.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
In-Reply-To: <20141110060424.9407.2498.stgit@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, linux-i2c@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I am basically fine if this goes via the powerpc-tree and I was hoping
that I could ack it right now. However, the driver looks a bit rushed
and definately needs updates before it is ready to go.

On Mon, Nov 10, 2014 at 11:35:39AM +0530, Neelesh Gupta wrote:
> The patch exposes the available i2c busses on the PowerNV platform
> to the kernel and implements the bus driver to support i2c and
> smbus commands.
> The driver uses the platform device infrastructure to probe the busses
> on the platform and registers them with the i2c driver framework.
>=20
> Signed-off-by: Neelesh Gupta <neelegup@linux.vnet.ibm.com>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Review for the I2C parts:

> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
> index 78d56c5..350aa86 100644
> --- a/drivers/i2c/busses/Makefile
> +++ b/drivers/i2c/busses/Makefile
> @@ -102,5 +102,6 @@ obj-$(CONFIG_I2C_ELEKTOR)	+=3D i2c-elektor.o
>  obj-$(CONFIG_I2C_PCA_ISA)	+=3D i2c-pca-isa.o
>  obj-$(CONFIG_I2C_SIBYTE)	+=3D i2c-sibyte.o
>  obj-$(CONFIG_SCx200_ACB)	+=3D scx200_acb.o
> +obj-$(CONFIG_I2C_OPAL)		+=3D i2c-opal.o

Please sort it properly, not simply at the end.

> =20
>  ccflags-$(CONFIG_I2C_DEBUG_BUS) :=3D -DDEBUG
> diff --git a/drivers/i2c/busses/i2c-opal.c b/drivers/i2c/busses/i2c-opal.c
> new file mode 100644
> index 0000000..3261716
> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-opal.c
> @@ -0,0 +1,276 @@
> +/*
> + * IBM OPAL I2C driver
> + * Copyright (C) 2014 IBM
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +#include <linux/i2c.h>
> +#include <linux/device.h>
> +#include <linux/platform_device.h>
> +#include <linux/of.h>
> +#include <linux/mm.h>
> +#include <asm/opal.h>
> +#include <asm/firmware.h>

Please sort the includes.

> +
> +static int i2c_opal_send_request(u32 bus_id, struct opal_i2c_request *re=
q)
> +{
> +	struct opal_msg msg;
> +	int token, rc;
> +
> +	token =3D opal_async_get_token_interruptible();
> +	if (token < 0) {
> +		if (token !=3D -ERESTARTSYS)
> +			pr_err("Failed to get the async token\n");
> +
> +		return token;
> +	}
> +
> +	rc =3D opal_i2c_request(token, bus_id, req);
> +	if (rc !=3D OPAL_ASYNC_COMPLETION) {
> +		rc =3D -EIO;
> +		goto exit;
> +	}
> +
> +	rc =3D opal_async_wait_response(token, &msg);
> +	if (rc) {
> +		rc =3D -EIO;
> +		goto exit;

Is it really -EIO? Maybe -ETIMEDOUT?

> +	}
> +
> +	rc =3D be64_to_cpu(msg.params[1]);
> +	if (rc !=3D OPAL_SUCCESS) {
> +		rc =3D -EIO;
> +		goto exit;
> +	}
> +
> +exit:
> +	opal_async_release_token(token);
> +	return rc;
> +}
> +
> +static int i2c_opal_master_xfer(struct i2c_adapter *adap, struct i2c_msg=
 *msgs,
> +				int num)
> +{
> +	unsigned long opal_id =3D (unsigned long)adap->algo_data;
> +	struct opal_i2c_request req;
> +	int rc, i;
> +
> +	/* We only support fairly simple combinations here of one
> +	 * or two messages
> +	 */

I don't think you should offer I2C_FUNC_I2C with those limitations. Is
there a case you really needs this?

> +	memset(&req, 0, sizeof(req));
> +	switch (num) {
> +	case 0:
> +		return 0;
> +	case 1:
> +		req.type =3D (msgs[0].flags & I2C_M_RD) ?
> +			OPAL_I2C_RAW_READ : OPAL_I2C_RAW_WRITE;
> +		req.addr =3D cpu_to_be16(msgs[0].addr);
> +		req.size =3D cpu_to_be32(msgs[0].len);
> +		req.buffer_ra =3D cpu_to_be64(__pa(msgs[0].buf));
> +		break;
> +	case 2:
> +		/* For two messages, we basically support only simple
> +		 * smbus transactions of a write plus a read. We might
> +		 * want to allow also two writes but we'd have to bounce
> +		 * the data into a single buffer.
> +		 */
> +		if ((msgs[0].flags & I2C_M_RD) || !(msgs[1].flags & I2C_M_RD))
> +			return -EIO;
> +		if (msgs[0].len > 4)
> +			return -EIO;
> +		if (msgs[0].addr !=3D msgs[1].addr)
> +			return -EIO;

-EOPNOTSUPP? Please check Documentation/i2c/fault-codes for the error
codes we use.

> +		req.type =3D OPAL_I2C_SM_READ;
> +		req.addr =3D cpu_to_be16(msgs[0].addr);
> +		req.subaddr_sz =3D msgs[0].len;
> +		for (i =3D 0; i < msgs[0].len; i++)
> +			req.subaddr =3D (req.subaddr << 8) | msgs[0].buf[i];
> +		req.subaddr =3D cpu_to_be32(req.subaddr);
> +		req.size =3D cpu_to_be32(msgs[1].len);
> +		req.buffer_ra =3D cpu_to_be64(__pa(msgs[1].buf));
> +		break;
> +	default:
> +		return -EIO;
> +	}
> +
> +	rc =3D i2c_opal_send_request(opal_id, &req);
> +	if (rc)
> +		return rc;
> +
> +	return num;
> +}
> +
> +static int i2c_opal_smbus_xfer(struct i2c_adapter *adap, u16 addr,
> +			       unsigned short flags, char read_write,
> +			       u8 command, int size, union i2c_smbus_data *data)
> +{
> +	unsigned long opal_id =3D (unsigned long)adap->algo_data;
> +	struct opal_i2c_request req;
> +	u8 local[2];
> +	int rc;
> +
> +	memset(&req, 0, sizeof(req));
> +
> +	req.addr =3D cpu_to_be16(addr);
> +	switch (size) {
> +	case I2C_SMBUS_BYTE:
> +		req.buffer_ra =3D cpu_to_be64(__pa(&data->byte));
> +		req.size =3D cpu_to_be32(1);
> +		/* Fall through */
> +	case I2C_SMBUS_QUICK:
> +		req.type =3D (read_write =3D=3D I2C_SMBUS_READ) ?
> +			OPAL_I2C_RAW_READ : OPAL_I2C_RAW_WRITE;
> +		break;
> +	case I2C_SMBUS_BYTE_DATA:
> +		req.buffer_ra =3D cpu_to_be64(__pa(&data->byte));
> +		req.size =3D cpu_to_be32(1);
> +		req.subaddr =3D cpu_to_be32(command);
> +		req.subaddr_sz =3D 1;
> +		req.type =3D (read_write =3D=3D I2C_SMBUS_READ) ?
> +			OPAL_I2C_SM_READ : OPAL_I2C_SM_WRITE;
> +		break;
> +	case I2C_SMBUS_WORD_DATA:
> +		if (!read_write) {
> +			local[0] =3D data->word & 0xff;
> +			local[1] =3D (data->word >> 8) & 0xff;
> +		}
> +		req.buffer_ra =3D cpu_to_be64(__pa(local));
> +		req.size =3D cpu_to_be32(2);
> +		req.subaddr =3D cpu_to_be32(command);
> +		req.subaddr_sz =3D 1;
> +		req.type =3D (read_write =3D=3D I2C_SMBUS_READ) ?
> +			OPAL_I2C_SM_READ : OPAL_I2C_SM_WRITE;
> +		break;
> +	case I2C_SMBUS_I2C_BLOCK_DATA:
> +		req.buffer_ra =3D cpu_to_be64(__pa(&data->block[1]));
> +		req.size =3D cpu_to_be32(data->block[0]);
> +		req.subaddr =3D cpu_to_be32(command);
> +		req.subaddr_sz =3D 1;
> +		req.type =3D (read_write =3D=3D I2C_SMBUS_READ) ?
> +			OPAL_I2C_SM_READ : OPAL_I2C_SM_WRITE;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	rc =3D i2c_opal_send_request(opal_id, &req);
> +	if (!rc && read_write && size =3D=3D I2C_SMBUS_WORD_DATA) {
> +		data->word =3D ((u16)local[1]) << 8;
> +		data->word |=3D local[0];
> +	}
> +
> +	return rc;
> +}
> +
> +static u32 i2c_opal_func(struct i2c_adapter *adapter)
> +{
> +	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
> +	       I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA |
> +	       I2C_FUNC_SMBUS_I2C_BLOCK;
> +}

See comment above about I2C_FUNC_I2C?

> +
> +static const struct i2c_algorithm i2c_opal_algo =3D {
> +	.master_xfer	=3D i2c_opal_master_xfer,
> +	.smbus_xfer	=3D i2c_opal_smbus_xfer,
> +	.functionality	=3D i2c_opal_func,
> +};
> +
> +static int i2c_opal_probe(struct platform_device *pdev)
> +{
> +	struct i2c_adapter	*adapter;
> +	const char		*pname;
> +	u32			opal_id;
> +	int			rc;
> +
> +	if (!pdev->dev.of_node)
> +		return -ENODEV;

Can this happen? How would the match happen otherwise?

> +	rc =3D of_property_read_u32(pdev->dev.of_node, "ibm,opal-id", &opal_id);
> +	if (rc) {
> +		dev_err(&pdev->dev, "Missing ibm,opal-id property !\n");
> +		return -EIO;
> +	}
> +	adapter =3D kzalloc(sizeof(struct i2c_adapter), GFP_KERNEL);

devm_kzalloc?

> +	if (!adapter)
> +		return -ENOMEM;
> +	adapter->algo =3D &i2c_opal_algo;
> +	adapter->algo_data =3D (void *)(unsigned long)opal_id;

double cast?

> +	adapter->dev.parent =3D &pdev->dev;
> +	adapter->dev.of_node =3D of_node_get(pdev->dev.of_node);
> +	pname =3D of_get_property(pdev->dev.of_node, "port-name", NULL);

I have never seen this binding before, it looks fishy. Where is it document=
ed?

> +	if (pname)
> +		strlcpy(adapter->name, pname, sizeof(adapter->name));
> +	else
> +		strlcpy(adapter->name, "opal", sizeof(adapter->name));
> +
> +	platform_set_drvdata(pdev, adapter);
> +	rc =3D i2c_add_adapter(adapter);
> +	if (rc)
> +		dev_err(&pdev->dev, "Failed to register the i2c adapter\n");

Leaking 'adapter' here.

> +
> +	return rc;
> +}
> +
> +static int i2c_opal_remove(struct platform_device *pdev)
> +{
> +	struct i2c_adapter *adapter =3D platform_get_drvdata(pdev);
> +
> +	i2c_del_adapter(adapter);
> +
> +	kfree(adapter);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id i2c_opal_of_match[] =3D {
> +	{
> +		.compatible =3D "ibm,power8-i2c-port",
> +	},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, i2c_opal_of_match);
> +
> +static struct platform_driver i2c_opal_driver =3D {
> +	.probe	=3D i2c_opal_probe,
> +	.remove	=3D i2c_opal_remove,
> +	.driver	=3D {
> +		.name		=3D "i2c-opal",
> +		.owner		=3D THIS_MODULE,

Not needed.

> +		.of_match_table	=3D i2c_opal_of_match,
> +	},
> +};
> +
> +static int __init i2c_opal_init(void)
> +{
> +	if (!firmware_has_feature(FW_FEATURE_OPAL))
> +		return -ENODEV;
> +
> +	return platform_driver_register(&i2c_opal_driver);
> +}
> +
> +static void __exit i2c_opal_exit(void)
> +{
> +	return platform_driver_unregister(&i2c_opal_driver);
> +}
> +
> +MODULE_AUTHOR("Neelesh Gupta <neelegup@linux.vnet.ibm.com>");
> +MODULE_DESCRIPTION("IBM OPAL I2C driver");
> +MODULE_LICENSE("GPL");
> +
> +module_init(i2c_opal_init);
> +module_exit(i2c_opal_exit);

Please put thos right below the functions it references.

>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUZGSYAAoJEBQN5MwUoCm2dM0P/jr6d1Qrw5siJm1c5xlTOIOb
4i7GKNE/FgcjkRPfu3CXc3f4Mi9P8NN4s1vulqeC1Rcec4b7e2qOYkNz8bhg1J1s
DSD2J+PR6d6hd2FTET1KQMS47CAMipl57BN+V4fWeH5kCME7jZR+oXcHaTlTzZi9
fWseerleeIvySLEOgQhG8SI0pp6a2AOFoFpZW4XV/8lf0OO7QZmUvHkJMpYFSX+u
aRqk8/NQW6NJ8vnH2ox7tO9tA+bz7zvDnDj5/Sv9MbEXl1WRSsvxtNPYGEeHaev2
SVbkAOOsYkgLZnvWOQ994WMB6DF1S9mAavsmdHziXQwUh/b+GuBJny2Vo/labYht
SfeK2zkxqfbMYsT4Qpuu9U8F1hpGPCuCUTWy6XlClFIL43Rimik++USAaEJ0M7yr
m5bs0qBksjH78vMLuJdzOYXgpMpmAsFYYqVIBZW9adUlXgXkTD6pfrHE4UU6jWMP
XeAmR8JQzn9Vz5Hn2MNABpBC1VVffs6hjeCbGJgMqR/+frgdNFwVuc9GmhcZCPpu
j0Mb5PgQJtQOvvEJdQtx1EReoVR0DiStFsib1gkM1/374SxSRwBAQWC+k/hPS0Wx
aAxZLtsKYxWA03i6gfWhqlu3Bb+FapaAErBYcO0jL+UxxDzHOO/wwYwXPOHV0hZz
h/0VOKdHjnivnohugHWb
=FG3T
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
