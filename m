Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 5581A67F34
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Oct 2006 02:37:59 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] Add of_platform_device_scan().
Date: Wed, 4 Oct 2006 18:37:46 +0200
References: <20061003225659.GA11955@ld0162-tx32.am.freescale.net>
	<200610040118.09416.arnd@arndb.de> <4523E214.5060404@freescale.com>
In-Reply-To: <4523E214.5060404@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200610041837.47317.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 04 October 2006 18:32, Scott Wood wrote:
> What I'd really like (long-term, of course) is if platform_device and=20
> of_device were merged, with device tree support (or at least a means of=20
> passing on properties that *could* come from a device tree without=20
> special glue code that knows about each property) in arch-neutral code;=20
> the mechanism for discovering devices ideally shouldn't depend on the=20
> CPU's instruction set.

My guess is that this won't happen, because other architectures
normally don't describe their platform devices in a way that is
anywhere near what we have on powerpc.

Benh suggested moving some of the functionality of of_platform_device
into the common of_device so we don't really have to use an
of_platform_device for stuff that can be automatically probed.

I guess we'll see a patch from him soon.

> > +=A0=A0=A0=A0=A0for (child =3D NULL; (child =3D of_get_next_child(root,=
 child)); ) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (strcmp(child->type, "spider=
") =3D=3D 0) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0ret =3D=
 of_soc_device_create(child, NULL);
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (ret)
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0goto out3;
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0}
> > +=A0=A0=A0=A0=A0}
>=20
> Why only spider?

Mistake on my side. That's what I have in my experimental device tree.
It should be more generic.

	Arnd <><
