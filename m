Return-Path: <super.firetwister@googlemail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.174])
	by ozlabs.org (Postfix) with ESMTP id 86A22DDE25
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 17:40:38 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so311680ugf.0
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 00:40:36 -0700 (PDT)
To: Uwe =?iso-8859-1?q?Kleine-K=F6nig?= <Uwe.Kleine-Koenig@digi.com>
Subject: Re: UIO not working on ppc405 onchip registers
Date: Tue, 22 Jul 2008 09:47:41 +0200
References: <200807212152.16080.super.firetwister@gmail.com>
	<20080722061730.GB12576@digi.com>
In-Reply-To: <20080722061730.GB12576@digi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200807220947.43074.super.firetwister@gmail.com>
From: super.firetwister@googlemail.com
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	"linux-embedded@vger.kernel.org" <linux-embedded@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello Uwe,

On Tuesday 22 July 2008, Uwe Kleine-K=F6nig wrote:

> I don't know powerpc in general nor ppc405ep in detail but IIRC arm has
> problems if some memory is mapped twice.  Might this be the problem
> here?

Maybee, the emac0 (0xef600800) and emac1 (0xef600900) get mapped as well,=20
because AFAIK I have to map a whole pagesize (0x1000).

> > +       int uiofd =3D open(UIO_DEV,O_RDWR);
>
> For debugging this is OK, in the final application you should add some
> tests.  Check the UIO documentation for the details.

The whole example was meant to be short.


> > +static int uio_gpio_remove(struct device *dev)
> > +{
> > +       uio_unregister_device(&info);
> > +       info.mem[0].addr =3D 0;
> > +       info.mem[0].size =3D 0;
> > +       return 0;
> > +}
>
> Are you sure that overwriting info.mem[0].addr is a good idea?  Then
> unbinding the platform device and rebinding it fails to do the right
> thing for sure.

This was stolen from uio_dummy. So this might become a common error :(


Thanks a lot for your comments, I will try to get an exclusive memory regio=
n=20
mapped.

Markus
