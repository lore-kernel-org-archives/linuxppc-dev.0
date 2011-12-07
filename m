Return-Path: <fthain@telegraphics.com.au>
Received: from vps4.telegraphics.com.au (vm4.telegraphics.com.au
 [98.124.60.149]) by ozlabs.org (Postfix) with ESMTP id 689C31007D5
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Dec 2011 12:26:25 +1100 (EST)
Date: Wed, 7 Dec 2011 12:26:19 +1100 (EST)
From: Finn Thain <fthain@telegraphics.com.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 01/16 v2] pmac_zilog: fix unexpected irq
In-Reply-To: <CAMuHMdUB-jQQB=ieumYTehdZz1EnoSazEAhsnEunHSnK2o=k8Q@mail.gmail.com>
Message-ID: <alpine.LNX.2.00.1112070959380.2418@nippy.intranet>
References: <20111023141108.856998818@telegraphics.com.au>
 <20111023141115.208699274@telegraphics.com.au>
 <alpine.LNX.2.00.1112070203310.14968@nippy.intranet>
 <CAMuHMdUB-jQQB=ieumYTehdZz1EnoSazEAhsnEunHSnK2o=k8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
 BOUNDARY="-1463806400-1463890039-1323221179=:2418"
Cc: linux-m68k@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-serial@vger.kernel.org
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

---1463806400-1463890039-1323221179=:2418
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE


On Tue, 6 Dec 2011, Geert Uytterhoeven wrote:

> Hi Finn,
>=20
> On Tue, Dec 6, 2011 at 16:13, Finn Thain <fthain@telegraphics.com.au> wro=
te:
> > +static void pmz_interrupt_control(struct uart_pmac_port *uap, int enab=
le)
> > +{
> > + =C2=A0 =C2=A0 =C2=A0 if (enable) {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uap->curregs[1] |=3D=
 INT_ALL_Rx | TxINT_ENAB;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!ZS_IS_EXTCLK(ua=
p))
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 uap->curregs[1] |=3D EXT_INT_ENAB;
> > + =C2=A0 =C2=A0 =C2=A0 } else {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uap->curregs[1] &=3D=
 ~(EXT_INT_ENAB | TxINT_ENAB | RxINT_MASK);
>=20
> Should there be a call to zssync() here?

I don't think so. Though I should have mentioned the change in the patch=20
header.

> The old code always did that after disabling interrupts.

pmz_load_zsregs(), pmz_set_termios() and pmz_suspend() don't do it.

sunzilog only does it on sparc64 and only when writing to the data=20
register or writing command modifiers to the control register ("On 64-bit=
=20
sparc we only need to flush single writes to ensure completion.")

I can't find any purpose for control register reads in the chip manual.

The zssync() calls following some WR1 writes originate here:=20
http://git.kernel.org/?p=3Dlinux/kernel/git/tglx/history.git;a=3Dcommitdiff=
;h=3D9e9d9f693c7def3900725c04c6b64311655eea51

So I don't see any need for control register reads but hopefully Ben can=20
say for sure.

Reading the patch now I notice that I dropped a pmz_maybe_update_regs() or=
=20
pmz_load_zsregs() in the suspend path. I will send a new patch.

Finn

>=20
> > + =C2=A0 =C2=A0 =C2=A0 }
> > + =C2=A0 =C2=A0 =C2=A0 write_zsreg(uap, R1, uap->curregs[1]);
> > +}
> > +
> > =C2=A0static struct tty_struct *pmz_receive_chars(struct uart_pmac_port=
 *uap)
> > =C2=A0{
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0struct tty_struct *tty =3D NULL;
> > @@ -339,9 +351,7 @@ static struct tty_struct *pmz_receive_ch
> >
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0return tty;
> > =C2=A0flood:
> > - =C2=A0 =C2=A0 =C2=A0 uap->curregs[R1] &=3D ~(EXT_INT_ENAB | TxINT_ENA=
B | RxINT_MASK);
> > - =C2=A0 =C2=A0 =C2=A0 write_zsreg(uap, R1, uap->curregs[R1]);
> > - =C2=A0 =C2=A0 =C2=A0 zssync(uap);
>=20
> Cfr. e.g. here.
>=20
> > + =C2=A0 =C2=A0 =C2=A0 pmz_interrupt_control(uap, 0);
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0pmz_error("pmz: rx irq flood !\n");
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0return tty;
> > =C2=A0}
>=20
> Gr{oetje,eeting}s,
>=20
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 Geert
>=20
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>=20
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0=C2=A0 -- Linus Torvalds
>=20
---1463806400-1463890039-1323221179=:2418--
