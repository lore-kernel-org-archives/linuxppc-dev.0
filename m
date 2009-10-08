Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20091008143301.GA6084@oksana.dev.rtsoft.ru>
References: <1255010672-21656-1-git-send-email-w.sang@pengutronix.de>
	<20091008143301.GA6084@oksana.dev.rtsoft.ru>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 8 Oct 2009 08:53:46 -0600
Message-ID: <fa686aa40910080753v6f597b0h4ce835db9f7a653@mail.gmail.com>
Subject: Re: [RFC] misc/at24: add experimental OF support for the generic
	eeprom driver
To: avorontsov@ru.mvista.com
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org,
	linux-i2c@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 8, 2009 at 8:33 AM, Anton Vorontsov
<avorontsov@ru.mvista.com> wrote:
> On Thu, Oct 08, 2009 at 04:04:32PM +0200, Wolfram Sang wrote:
>> As Anton introduced archdata support, I wondered if this is a suitable w=
ay to
>> handle the platform_data/devicetree_property-dualism (at least for some
>> drivers).
>
> Yes, we handle OF in a similar way for mmc_spi driver. Though,
>
> [...]
>> --- a/drivers/misc/eeprom/at24.c
>> +++ b/drivers/misc/eeprom/at24.c
>> @@ -22,6 +22,9 @@
> [...]
>> +#ifdef CONFIG_OF_I2C
>> +#include <linux/of.h>
>> +#endif
> [..]
>> +#ifdef CONFIG_OF_I2C
>> +static void at24_get_ofdata(struct i2c_client *client, struct at24_plat=
form_data *chip)
>> +{
>> + =A0 =A0 const u32 *val;
>> + =A0 =A0 struct device_node *node =3D dev_archdata_get_node(&client->de=
v.archdata);
>> +
>> + =A0 =A0 if (node) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (of_get_property(node, "read-only", NULL))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 chip->flags |=3D AT24_FLAG_REA=
DONLY;
>> + =A0 =A0 =A0 =A0 =A0 =A0 val =3D of_get_property(node, "pagesize", NULL=
);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (val)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 chip->page_size =3D *val;
>> + =A0 =A0 }
>> +}
>> +#else
>> +static void at24_get_ofdata(struct i2c_client *client, struct at24_plat=
form_data *chip)
>> +{ }
>> +#endif
>
> #ifdefs are ugly in .c files. I'd suggest to move the OF code
> into a separate file. As an example, see

Please don't.  It is such a small amount of code, and I far prefer to
see drivers self contained in a single .c file.  #ifdefs are fine IMHO
when it is a top level block, and not inside a function block.  In the
example you give, I do like the move toward focusing on the pdata
structure; but the patch ads a *lot* of code for something very
simple.  And then we'll need to do the same think for every driver
which will ever be described in the device tree.  It's the right
direction, but still not right.  Driver writers shouldn't have to
write anything more than a tiny function to populate pdata from the
device tree.  Managing that pdata instance needs to be done with
common infrastructure (but I don't have a firm idea about how it
should look yet).  In the mean time I think Wolfram's approach has
lower impact.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
