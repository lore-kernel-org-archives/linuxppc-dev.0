Return-Path: <glikely@secretlab.ca>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.30])
	by ozlabs.org (Postfix) with ESMTP id 47AD9DDEF9
	for <linuxppc-dev@ozlabs.org>; Thu, 28 May 2009 15:09:26 +1000 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so2358313yxb.39
	for <linuxppc-dev@ozlabs.org>; Wed, 27 May 2009 22:09:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090528010000.31423083@lappy.seanm.ca>
References: <9481.63517.qm@web28305.mail.ukl.yahoo.com>
	<1243160487.22770.59.camel@pasglop>
	<1243210914.24376.11.camel@pasglop> <200905250243.15436.arnd@arndb.de>
	<1243226023.24376.23.camel@pasglop>
	<20090527233451.2d02343d@lappy.seanm.ca>
	<fa686aa40905272042yd7b4698gbd1133b4c61c9b87@mail.gmail.com>
	<20090528010000.31423083@lappy.seanm.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 27 May 2009 23:09:05 -0600
Message-ID: <fa686aa40905272209p61c4a4b9ofa29c0de15d9efa1@mail.gmail.com>
Subject: Re: powerpc: DMA coherent allocations broken for
	CONFIG_NOT_COHERENT_CACHE
To: Sean MacLennan <smaclennan@pikatech.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 27, 2009 at 11:00 PM, Sean MacLennan
<smaclennan@pikatech.com> wrote:
> On Wed, 27 May 2009 21:42:18 -0600
> Grant Likely <grant.likely@secretlab.ca> wrote:
>
>> Make your driver use a platform device or an of_platform device. =A0It's
>> not at all hard.
>
> Here is my first shot.... any other fields that I need to fill in so I
> don't have any gotchas?
>
> /* This must exist */
> static void warp_device_release(struct device *dev) {}

It will be easier if you do it as an of_device.  Then you just need to
add a node to the device tree and it will get registered correctly
without any platform specific registration code.  That gives your
driver something to bind against.

However, if you do want to do it this way...

> static struct platform_device warp_device =3D {
> =A0 =A0 =A0 =A0.name =3D "warp-device",
> =A0 =A0 =A0 =A0.id =3D 0,
> =A0 =A0 =A0 =A0.num_resources =3D 0,
> =A0 =A0 =A0 =A0.dev =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.coherent_dma_mask =3D ~0ULL,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.release =3D warp_device_release,
> =A0 =A0 =A0 =A0},
> };

No need for all this.  use platform_device_register_simple() instead.
Again, that gives your driver something to bind again, this time on
the platform bus (instead of of_platform bus).

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
