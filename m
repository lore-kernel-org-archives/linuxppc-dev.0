Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
 [209.85.214.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id DA51B1007D5
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Dec 2011 02:27:29 +1100 (EST)
Received: by bkcjk13 with SMTP id jk13so5831038bkc.38
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Dec 2011 07:27:21 -0800 (PST)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <alpine.LNX.2.00.1112070203310.14968@nippy.intranet>
References: <20111023141108.856998818@telegraphics.com.au>
 <20111023141115.208699274@telegraphics.com.au>
 <alpine.LNX.2.00.1112070203310.14968@nippy.intranet>
Date: Tue, 6 Dec 2011 16:27:20 +0100
Message-ID: <CAMuHMdUB-jQQB=ieumYTehdZz1EnoSazEAhsnEunHSnK2o=k8Q@mail.gmail.com>
Subject: Re: [PATCH 01/16 v2] pmac_zilog: fix unexpected irq
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Finn Thain <fthain@telegraphics.com.au>
Content-Type: text/plain; charset=UTF-8
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

Hi Finn,

On Tue, Dec 6, 2011 at 16:13, Finn Thain <fthain@telegraphics.com.au> wrote=
:
> +static void pmz_interrupt_control(struct uart_pmac_port *uap, int enable=
)
> +{
> + =C2=A0 =C2=A0 =C2=A0 if (enable) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uap->curregs[1] |=3D I=
NT_ALL_Rx | TxINT_ENAB;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!ZS_IS_EXTCLK(uap)=
)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 uap->curregs[1] |=3D EXT_INT_ENAB;
> + =C2=A0 =C2=A0 =C2=A0 } else {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uap->curregs[1] &=3D ~=
(EXT_INT_ENAB | TxINT_ENAB | RxINT_MASK);

Should there be a call to zssync() here?
The old code always did that after disabling interrupts.

> + =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 write_zsreg(uap, R1, uap->curregs[1]);
> +}
> +
> =C2=A0static struct tty_struct *pmz_receive_chars(struct uart_pmac_port *=
uap)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct tty_struct *tty =3D NULL;
> @@ -339,9 +351,7 @@ static struct tty_struct *pmz_receive_ch
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return tty;
> =C2=A0flood:
> - =C2=A0 =C2=A0 =C2=A0 uap->curregs[R1] &=3D ~(EXT_INT_ENAB | TxINT_ENAB =
| RxINT_MASK);
> - =C2=A0 =C2=A0 =C2=A0 write_zsreg(uap, R1, uap->curregs[R1]);
> - =C2=A0 =C2=A0 =C2=A0 zssync(uap);

Cfr. e.g. here.

> + =C2=A0 =C2=A0 =C2=A0 pmz_interrupt_control(uap, 0);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0pmz_error("pmz: rx irq flood !\n");
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return tty;
> =C2=A0}

Gr{oetje,eeting}s,

=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0=C2=A0 -- Linus Torvalds
