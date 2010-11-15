Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1289841916-3825-1-git-send-email-w.sang@pengutronix.de>
References: <1289841916-3825-1-git-send-email-w.sang@pengutronix.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 15 Nov 2010 14:41:06 -0700
Message-ID: <AANLkTikLvQip1cp0U_JN+u4GkYqZoXMB2eaON1F2-P0d@mail.gmail.com>
Subject: Re: [PATCH 1/2] misc: at24: parse OF-data, too
To: Wolfram Sang <w.sang@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 15, 2010 at 10:25 AM, Wolfram Sang <w.sang@pengutronix.de> wrot=
e:
> Information about the pagesize and read-only-status may also come from
> the devicetree. Parse this data, too, and act accordingly. While we are
> here, change the initialization printout a bit. write_max is useful to
> know to detect performance bottlenecks, the rest is superfluous.
>
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> ---
>
> Grant: As mentioned at ELCE10, I could pretty much respin this old approa=
ch I
> tried roughly a year ago (just with archdata then). If the approach and d=
ocs
> are good, I am fine with the patches entering via one of your trees.
>
> =A0Documentation/powerpc/dts-bindings/eeprom.txt | =A0 28 +++++++++++++++=
+++++++
> =A0drivers/misc/eeprom/at24.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0 33 ++++++++++++++++++++-----
> =A02 files changed, 53 insertions(+), 6 deletions(-)
> =A0create mode 100644 Documentation/powerpc/dts-bindings/eeprom.txt
>
> diff --git a/Documentation/powerpc/dts-bindings/eeprom.txt b/Documentatio=
n/powerpc/dts-bindings/eeprom.txt
> new file mode 100644
> index 0000000..4342c10
> --- /dev/null
> +++ b/Documentation/powerpc/dts-bindings/eeprom.txt
> @@ -0,0 +1,28 @@
> +EEPROMs (I2C)
> +
> +Required properties:
> +
> + =A0- compatible : should be "<manufacturer>,<type>"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0If there is no specific driver for <manu=
facturer>, a generic
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0driver based on <type> is selected. Poss=
ible types are:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A024c00, 24c01, 24c02, 24c04, 24c08, 24c16=
, 24c32, 24c64,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A024c128, 24c256, 24c512, 24c1024, spd
> +
> + =A0- reg : the I2C address of the EEPROM
> +
> +Optional properties:
> +
> + =A0- pagesize : the length of the pagesize for writing. Please consult =
the
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 manual of your device, that value varies a =
lot. A wrong value
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0may result in data loss! If not specified, a=
 safety value of
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0'1' is used which will be very slow.

As Anton mentions, the compatible value should be specific enough that
a pagesize property isn't needed (assuming there aren't at24 devices
with differing page sizes), but that leaves the question of where to
put the page size data in the driver.  I think the obvious answer is
to put it in the at24_ids table.  This would also be a good thing for
the non-OF use-cases too.  Unfortunately the driver_data field is
already in use and requires refactoring to turn driver_data into a
pointer to a structure, and so requires more work (sorry).

A refactored at24_ids table might look something like (there may be a
cleaner way to go about it though, I used the macro to solve the
problem of constructing an at24_platform_data structure for each entry
and storing a pointer to it in the unsigned long driver_data field):

#define AT24_DEVDATA(_len, _page_size, _flags)   \
	((unsigned long)((struct at24_platform_data[]) \
		{{.byte_len =3D len, .page_size =3D _page_size, .flags =3D
		_flags}}))

static const struct i2c_device_id at24_ids[] =3D {
	/* needs 8 addresses as A0-A2 are ignored */
	{ "24c00", AT24_DEVDATA(128 / 8, 16, AT24_FLAG_TAKE8ADDR) },
	/* old variants can't be handled with this generic entry! */
	{ "24c01", AT24_DEVDATA(1024 / 8, 16, 0) },
	{ "24c02", AT24_DEVDATA(2048 / 8, 16, 0) },
	...
};

This will also make the probe code simpler.

However, if I am wrong and similarly named at24 devices have different
page sizes, then encoding it in a property is the right thing to do.

Also, the read-only property is fine.

g.


> +
> + =A0- read-only: this parameterless property disables writes to the eepr=
om
> +
> +Example:
> +
> +eeprom@52 {
> + =A0 =A0 =A0 compatible =3D "atmel,24c32";
> + =A0 =A0 =A0 reg =3D <0x52>;
> + =A0 =A0 =A0 pagesize =3D <32>;
> +};
> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
> index 559b0b3..aaf16cb 100644
> --- a/drivers/misc/eeprom/at24.c
> +++ b/drivers/misc/eeprom/at24.c
> @@ -20,6 +20,7 @@
> =A0#include <linux/log2.h>
> =A0#include <linux/bitops.h>
> =A0#include <linux/jiffies.h>
> +#include <linux/of.h>
> =A0#include <linux/i2c.h>
> =A0#include <linux/i2c/at24.h>
>
> @@ -457,6 +458,27 @@ static ssize_t at24_macc_write(struct memory_accesso=
r *macc, const char *buf,
>
> =A0/*--------------------------------------------------------------------=
-----*/
>
> +#ifdef CONFIG_OF
> +static void at24_get_ofdata(struct i2c_client *client,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct at24_platform_data *chip)
> +{
> + =A0 =A0 =A0 const u32 *val;
> + =A0 =A0 =A0 struct device_node *node =3D client->dev.of_node;
> +
> + =A0 =A0 =A0 if (node) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (of_get_property(node, "read-only", NULL=
))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 chip->flags |=3D AT24_FLAG_=
READONLY;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 val =3D of_get_property(node, "pagesize", N=
ULL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (val)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 chip->page_size =3D *val;
> + =A0 =A0 =A0 }
> +}
> +#else
> +static void at24_get_ofdata(struct i2c_client *client,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct at24_platform_data *chip)
> +{ }
> +#endif /* CONFIG_OF */
> +
> =A0static int at24_probe(struct i2c_client *client, const struct i2c_devi=
ce_id *id)
> =A0{
> =A0 =A0 =A0 =A0struct at24_platform_data chip;
> @@ -485,6 +507,9 @@ static int at24_probe(struct i2c_client *client, cons=
t struct i2c_device_id *id)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0chip.page_size =3D 1;
>
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* update chipdata if OF is present */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 at24_get_ofdata(client, &chip);
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0chip.setup =3D NULL;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0chip.context =3D NULL;
> =A0 =A0 =A0 =A0}
> @@ -597,19 +622,15 @@ static int at24_probe(struct i2c_client *client, co=
nst struct i2c_device_id *id)
>
> =A0 =A0 =A0 =A0i2c_set_clientdata(client, at24);
>
> - =A0 =A0 =A0 dev_info(&client->dev, "%zu byte %s EEPROM %s\n",
> + =A0 =A0 =A0 dev_info(&client->dev, "%zu byte %s EEPROM, %s, %u bytes/wr=
ite\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0at24->bin.size, client->name,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 writable ? "(writable)" : "(read-only)");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 writable ? "writable" : "read-only", at24->=
write_max);
> =A0 =A0 =A0 =A0if (use_smbus =3D=3D I2C_SMBUS_WORD_DATA ||
> =A0 =A0 =A0 =A0 =A0 =A0use_smbus =3D=3D I2C_SMBUS_BYTE_DATA) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_notice(&client->dev, "Falling back to =
%s reads, "
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "performance will suf=
fer\n", use_smbus =3D=3D
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 I2C_SMBUS_WORD_DATA ?=
 "word" : "byte");
> =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 dev_dbg(&client->dev,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 "page_size %d, num_addresses %d, write_max =
%d, use_smbus %d\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 chip.page_size, num_addresses,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 at24->write_max, use_smbus);
>
> =A0 =A0 =A0 =A0/* export data to kernel code */
> =A0 =A0 =A0 =A0if (chip.setup)
> --
> 1.7.2.3
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
