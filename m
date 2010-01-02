Return-Path: <fthain@telegraphics.com.au>
Received: from mail.telegraphics.com.au (www.telegraphics.com.au
	[204.15.192.19]) by ozlabs.org (Postfix) with ESMTP id C2585B6EEF
	for <linuxppc-dev@ozlabs.org>; Sun,  3 Jan 2010 03:47:13 +1100 (EST)
Date: Sun, 3 Jan 2010 03:39:25 +1100 (EST)
From: Finn Thain <fthain@telegraphics.com.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/2] pmac-zilog: add platform driver
In-Reply-To: <10f740e81001020443h78c615d2l206b99c386600108@mail.gmail.com>
Message-ID: <alpine.OSX.2.00.1001030255060.414@localhost>
References: <alpine.OSX.2.00.0911171657290.371@silk.local>
	<10f740e81001020443h78c615d2l206b99c386600108@mail.gmail.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-961451201-1262450365=:414"
Cc: linux-m68k@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-961451201-1262450365=:414
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE


On Sat, 2 Jan 2010, Geert Uytterhoeven wrote:

> On Tue, Nov 17, 2009 at 10:04, Finn Thain <fthain@telegraphics.com.au>=20
> wrote:
> > Add platform driver to the pmac-zilog driver for mac 68k, putting the=
=20
> > powermac-specific bits inside #ifdef CONFIG_PPC_PMAC.
>=20
> > --- linux-2.6.31.orig/drivers/serial/pmac_zilog.c =C2=A0 =C2=A0 =C2=A0 =
2009-11-17 17:07:28.000000000 +1100
> > +++ linux-2.6.31/drivers/serial/pmac_zilog.c =C2=A0 =C2=A02009-11-17 17=
:07:38.000000000 +1100
>=20
> > @@ -1427,6 +1439,8 @@ static struct uart_ops pmz_pops =3D {
> > =C2=A0#endif
> > =C2=A0};
> >
> > +#ifdef CONFIG_PPC_PMAC
> > +
> > =C2=A0/*
> > =C2=A0* Setup one port structure after probing, HW is down at this poin=
t,
> > =C2=A0* Unlike sunzilog, we don't need to pre-init the spinlock as we d=
on't
> > @@ -1823,6 +1837,88 @@ next:
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> > =C2=A0}
> >
> > +#else
> > +
> > +extern struct platform_device scc_a_pdev, scc_b_pdev;
>=20
> scripts/checkpatch.pl doesn't like this extern, and it's right.
> Can't this be found using standard platform device/driver matching?

The console initcall and arch initcall order didn't permit me to easily=20
gather the bootinfo data and populate the platform device resources early=
=20
enough. (On powermacs there is the open firmware device tree, but of=20
course, we don't have one.)

I would like to further adopt the driver model in order to ditch the=20
macintosh_config global, and I'd also like to have proper nubus device=20
matching. But I think that the serial console device is a bit exceptional=
=20
so I'm not too fussed about these two globals.

Anyway, I don't know of a better way to do the serial console but I'm open=
=20
to suggestions.

> BTW, there are a few other minor checkpatch issues with some of the=20
> other patches in the series, too.

I ran checkpatch on all those patches before I submitted them. I ignored=20
some of the complaints about whitespace where I felt that checkpatch got=20
it wrong (space character following tab character, IIRC).

checkpatch found lots of mistakes that I did fix, but it can't determine=20
the most human readable style in all cases, especially where consistency=20
with the surrounding code is actually more conducive to readability than=20
strict but sporadic conformance to simple rules would be.

Finn

>=20
> Gr{oetje,eeting}s,
>=20
> =09=09=09=09=09=09Geert
>=20
--0-961451201-1262450365=:414--
