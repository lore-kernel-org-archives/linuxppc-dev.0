Return-Path: <glikely@secretlab.ca>
Received: from mail-gy0-f170.google.com (mail-gy0-f170.google.com
	[209.85.160.170]) by ozlabs.org (Postfix) with ESMTP id 6071B1007D1
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Jul 2010 02:58:54 +1000 (EST)
Received: by gyh4 with SMTP id 4so2133332gyh.15
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Jul 2010 09:58:53 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20100727123647.0a3b8832@wker>
References: <1272882222-12253-1-git-send-email-agust@denx.de>
	<1279892973-24110-1-git-send-email-agust@denx.de>
	<AANLkTi=Ee6HR+Ux0g4V1+81DXUmsO=UDhi6jWsDgGchv@mail.gmail.com>
	<20100727123647.0a3b8832@wker>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 27 Jul 2010 10:58:33 -0600
Message-ID: <AANLkTika=KeKcaY_FF8tN5Fy-H+cozjZsGObXoQhKiVh@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] powerpc/mpc5121: add initial support for PDM360NG
	board
To: Anatolij Gustschin <agust@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Detlev Zundel <dzu@denx.de>, Markus Fischer <markus.fischer.ec@ifm.com>,
	devicetree-discuss@lists.ozlabs.org,
	Michael Weiss <michael.weiss@ifm.com>, linuxppc-dev@ozlabs.org,
	Wolfgang Grandegger <wg@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 27, 2010 at 4:36 AM, Anatolij Gustschin <agust@denx.de> wrote:
> Hi Grant,
>
> On Sun, 25 Jul 2010 01:42:23 -0600
> Grant Likely <grant.likely@secretlab.ca> wrote:
> ...
>> Hi Anatolij,
>>
>> Finally got some time tonight to properly dig into this patch. =A0Commen=
ts below.
>
> Thanks for review and comments! My reply below.

Thanks Anatolij, replies below.

>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi@11900 {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc5=
121-psc-spi", "fsl,mpc5121-psc";
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cell-index =3D <9>;
>>
>> Try to drop the cell-index properties. =A0They are almost always misused=
.
>
> Removing cell-index would require changing the spi driver's probe.
> Currently cell-index is used to set spi bus number. What could be used
> for bus enumeration instead? Is it okay to use part of the spi node
> address? e.g. obtaining the offset 0x11900, masking out the unrelated
> bits and shifting by 8 would deliver unique index 9 for PSC9 in SPI
> mode. This would work for all 12 PSC SPI controllers of mpc5121.

Does the spi bus number really matter?  The device tree context gives
you a firm association between spi masters and devices which doesn't
require assigning a specific bus number.  The core spi code can
dynamically assign a bus number for the bus by setting bus_num to -1.

>> > +
>> > + =A0 =A0 =A0 if (bus_num < 0 || bus_num > 11)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
>> > +
>> > + =A0 =A0 =A0 info.bus_num =3D bus_num;
>> > +
>> > + =A0 =A0 =A0 of_dev =3D of_find_device_by_node(np);
>> > + =A0 =A0 =A0 of_node_put(np);
>> > + =A0 =A0 =A0 if (of_dev) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct fsl_spi_platform_data *pdata;
>> > +
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata =3D kzalloc(sizeof(*pdata), GFP_KE=
RNEL);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pdata) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->bus_num =3D bus_n=
um;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->max_chipselect =
=3D 1;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_dev->dev.platform_dat=
a =3D pdata;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> > + =A0 =A0 =A0 }
>> > +
>> > + =A0 =A0 =A0 if (pdm360ng_penirq_init())
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
>> > +
>> > + =A0 =A0 =A0 return spi_register_board_info(&info, 1);
>>
>> This ends up being a lot of code simply to attach a pdata structure to
>> an spi device. =A0I've been thinking about this problem, and I think
>> there is a better way. =A0Instead, use a bus notifier attached to the
>> SPI bus to wait for the spi_device to get registered, but before it
>> gets bound to a driver. =A0Then you can attach the pdata structure very
>> simply. =A0Something like this I think (completely untested, or even
>> compiled. =A0Details are left as an exercise to the developer):
>>
>> static int pdm360ng_touchscreen_notifier_call(struct notifier_block *nb,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 unsigned long event, void *__dev)
>> {
>> =A0 =A0 =A0 struct device *dev =3D __dev;
>>
>> =A0 =A0 =A0 if ((event =3D=3D BUS_NOTIFIY_ADD_DEVICE) && (dev->of_node =
=3D=3D [FOO]))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->platform_data =3D [BAR];
>> }
>>
>> static struct notifier_block pdm360ng_touchscreen_nb =3D {
>> =A0 =A0 =A0 notifier_call =3D pdm360ng_touchscreen_notifier_call;
>> };
>>
>> static int __init pdm360ng_touchscreen_init(void)
>> {
>> =A0 =A0 =A0 bus_register_notifier(&spi_bus_type, pdm360ng_touchscreen_nb=
);
>> }
>
> Thanks! Bus notifier is now used for setting platform data in v4.

Cool!

> This requires fixing the mpc5121 psc spi driver to create spi child
> nodes of the spi master node. I have already send the appropriate
> patch to spi-devel list, but it is not the right approach to call
> of_register_spi_devices() in each driver.

It's not wrong; but it isn't ideal either.

> Do you plan to fix it in
> core spi code in v2.6.36?

Apparently I no longer have to because you've gone ahead and done it
for me anyway.  :-)  I'll take a look at that patch and send you my
comments.

Cheers,
g.
