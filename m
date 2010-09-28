Return-Path: <glikely@secretlab.ca>
Received: from mail-gw0-f51.google.com (mail-gw0-f51.google.com [74.125.83.51])
	by ozlabs.org (Postfix) with ESMTP id 10CE3B710A
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 29 Sep 2010 09:26:28 +1000 (EST)
Received: by gwb10 with SMTP id 10so96872gwb.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 28 Sep 2010 16:26:26 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20100928232147.GR21564@trinity.fluff.org>
References: <20100924221313.28357.61419.stgit@angua>
	<20100928232147.GR21564@trinity.fluff.org>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 29 Sep 2010 08:26:03 +0900
Message-ID: <AANLkTimB1dACK0QdnJk-Ry0hPpUO7eKv3n_GSBJTttCx@mail.gmail.com>
Subject: Re: [PATCH (Option 1)] of/i2c: fix module load order issue caused by
	of_i2c.c
To: Ben Dooks <ben-i2c@fluff.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: mikpe@it.uu.se, linux-kernel@vger.kernel.org, rdunlap@xenotime.net,
	linux-i2c@vger.kernel.org, khali@linux-fr.org,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 29, 2010 at 8:21 AM, Ben Dooks <ben-i2c@fluff.org> wrote:
> On Fri, Sep 24, 2010 at 04:14:53PM -0600, Grant Likely wrote:
>> Commit 959e85f7, "i2c: add OF-style registration and binding" caused a
>> module dependency loop where of_i2c.c calls functions in i2c-core, and
>> i2c-core calls of_i2c_register_devices() in of_i2c. =A0This means that
>> when i2c support is built as a module when CONFIG_OF is set, then
>> neither i2c_core nor of_i2c are able to be loaded.
>>
>> This patch fixes the problem by moving the of_i2c_register_devices()
>> function into the body of i2c_core and renaming it to
>> i2c_scan_of_devices (of_i2c_register_devices is analogous to the
>> existing i2c_scan_static_board_info function and so should be named
>> similarly). =A0This function isn't called by any code outside of
>> i2c_core, and it must always be present when CONFIG_OF is selected, so
>> it makes sense to locate it there. =A0When CONFIG_OF is not selected,
>> of_i2c_register_devices() becomes a no-op.
>>
>> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
>> ---
>> =A0drivers/i2c/i2c-core.c | =A0 61 +++++++++++++++++++++++++++++++++++++=
+++++++++--
>> =A0drivers/of/of_i2c.c =A0 =A0| =A0 57 ---------------------------------=
------------
>> =A0include/linux/of_i2c.h | =A0 =A07 ------
>> =A03 files changed, 59 insertions(+), 66 deletions(-)
>>
>> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
>> index 6649176..64a261b 100644
>> --- a/drivers/i2c/i2c-core.c
>> +++ b/drivers/i2c/i2c-core.c
>> @@ -32,8 +32,8 @@
>> =A0#include <linux/init.h>
>> =A0#include <linux/idr.h>
>> =A0#include <linux/mutex.h>
>> -#include <linux/of_i2c.h>
>> =A0#include <linux/of_device.h>
>> +#include <linux/of_irq.h>
>> =A0#include <linux/completion.h>
>> =A0#include <linux/hardirq.h>
>> =A0#include <linux/irqflags.h>
>> @@ -818,6 +818,63 @@ static void i2c_scan_static_board_info(struct i2c_a=
dapter *adapter)
>> =A0 =A0 =A0 up_read(&__i2c_board_lock);
>> =A0}
>>
>> +#ifdef CONFIG_OF
>> +void i2c_scan_of_devices(struct i2c_adapter *adap)
>> +{
>> + =A0 =A0 void *result;
>> + =A0 =A0 struct device_node *node;
>> +
>> + =A0 =A0 /* Only register child devices if the adapter has a node point=
er set */
>> + =A0 =A0 if (!adap->dev.of_node)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> +
>> + =A0 =A0 for_each_child_of_node(adap->dev.of_node, node) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct i2c_board_info info =3D {};
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct dev_archdata dev_ad =3D {};
>> + =A0 =A0 =A0 =A0 =A0 =A0 const __be32 *addr;
>> + =A0 =A0 =A0 =A0 =A0 =A0 int len;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&adap->dev, "of_i2c: register %s\n", n=
ode->full_name);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (of_modalias_node(node, info.type, sizeof(i=
nfo.type)) < 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&adap->dev, "of_i2c: m=
odalias failure on %s\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 node->full_nam=
e);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 addr =3D of_get_property(node, "reg", &len);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!addr || (len < sizeof(int))) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&adap->dev, "of_i2c: i=
nvalid reg on %s\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 node->full_nam=
e);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 info.addr =3D be32_to_cpup(addr);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (info.addr > (1 << 10) - 1) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&adap->dev, "of_i2c: i=
nvalid addr=3D%x on %s\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 info.addr, nod=
e->full_name);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 info.irq =3D irq_of_parse_and_map(node, 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 info.of_node =3D of_node_get(node);
>> + =A0 =A0 =A0 =A0 =A0 =A0 info.archdata =3D &dev_ad;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 request_module("%s", info.type);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 result =3D i2c_new_device(adap, &info);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (result =3D=3D NULL) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&adap->dev, "of_i2c: F=
ailure registering %s\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 node->full_nam=
e);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_node_put(node);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq_dispose_mapping(info.irq);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 }
>> +}
>> +#else
>> +static inline void i2c_scan_of_devices(struct i2c_adapter *adap) { }
>> +#endif
>
> Is there any advantage to just making the definition in the header
> file a static inline and removing the #else part of this?

I'm not sure what you mean.  This particular patch makes
i2c_scan_of_devices() completely internal to i2c-core.c so that there
is no need to expose it in the header file at all.

g.

>
> --
> Ben
>
> Q: =A0 =A0 =A0What's a light-year?
> A: =A0 =A0 =A0One-third less calories than a regular year.
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
