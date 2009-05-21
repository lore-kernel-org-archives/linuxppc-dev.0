Return-Path: <glikely@secretlab.ca>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.30])
	by ozlabs.org (Postfix) with ESMTP id 33ECCDE18D
	for <linuxppc-dev@ozlabs.org>; Thu, 21 May 2009 14:21:26 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 2so455079ywt.39
	for <linuxppc-dev@ozlabs.org>; Wed, 20 May 2009 21:21:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090521004626.GA1635@pengutronix.de>
References: <1232559685-2268-1-git-send-email-w.sang@pengutronix.de>
	<1232559685-2268-3-git-send-email-w.sang@pengutronix.de>
	<fa686aa40905190757w68b35333j6f0fa84ea253a486@mail.gmail.com>
	<20090521004626.GA1635@pengutronix.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 20 May 2009 22:21:05 -0600
Message-ID: <fa686aa40905202121m60ead59dm6a12821085b17d8f@mail.gmail.com>
Subject: Re: [PATCH 2/2] maps/mtd-ram: add an of-platform driver
To: Wolfram Sang <w.sang@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org, ben-linux@fluff.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 20, 2009 at 6:46 PM, Wolfram Sang <w.sang@pengutronix.de> wrote=
:
>> > + =A0 =A0 =A0 name =3D of_get_property(op->node, "name", NULL);
>> > + =A0 =A0 =A0 if (!name) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOENT;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&op->dev, "could not get node na=
me\n");
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto bad1;
>> > + =A0 =A0 =A0 }
>
> Can I just use
>
> =A0 =A0 =A0 =A0name =3D op->node->name
>
> here? I wonder because of_device in asm/of_device.h states 'node' as "to =
be
> obsoleted"
It may be labeled as such, but it's been so for over 2 years now, and
op->node is used all over the place.  I think Ben would like to
eventually move to using the node pointer in archdata, but that will
require a fair bit of refactoring.

Ben will kick me if I'm wrong, but I'll go out on a limb and say that
I think you're okay to use it.

>. And could I safely assume that all architectures will have the node
> entry?

All three current users do.

>> > +static struct of_device_id of_ram_match[] =3D {
>> > + =A0 =A0 =A0 { .compatible =3D "mtd-ram", },
>> > + =A0 =A0 =A0 {},
>> > +};
>> > +MODULE_DEVICE_TABLE(of, of_ram_match);
>> > +
>> > +static struct of_platform_driver of_ram_driver =3D {
>>
>> __devinitdata
>
> I assume you mean the match_table and not the of_platform_driver. Shouldn=
't it
> even better be const and using __devinitconst?

correct on both counts.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
