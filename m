Return-Path: <matthias.fuchs@esd-electronics.com>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 258EDB7CE7
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Feb 2010 03:12:11 +1100 (EST)
From: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] powerpc/mpc512x: Add gpio driver
Date: Mon, 22 Feb 2010 17:05:30 +0100
References: <201001281448.42965.matthias.fuchs@esd-electronics.com>
	<fa686aa41002161119x6eb41203rb73b888176ce5040@mail.gmail.com>
In-Reply-To: <fa686aa41002161119x6eb41203rb73b888176ce5040@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201002221705.30700.matthias.fuchs@esd-electronics.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Grant,

thanks for comments. I will post an updated version soon.


On Tuesday 16 February 2010 20:19, Grant Likely wrote:
> > + =A0 =A0 =A0 return 0;
> > +}
> > +arch_initcall(mpc512x_add_gpiochips);
>=20
> Don't do this.  Either make this a proper of_platform device driver,
> or call mpc512x_add_gpiochips() explicitly from the arch platform
> setup code.  Otherwise, if the kernel is built for multiplatform, this
> function will get executed regardless of the platform.
In this case I prefer moving the call to the platform code.
I tested the driver on one of our 5123 boards. Shall I add it=20
to mpc5121_ads.c:mpc5121_ads_setup_arch() also? So it's at least called=20
on the reference board? I not sure if there are some LEDs or buttons
that could use it.

Matthias
