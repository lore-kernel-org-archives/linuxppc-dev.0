Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-gw0-f42.google.com (mail-gw0-f42.google.com [74.125.83.42])
	by ozlabs.org (Postfix) with ESMTP id 52E84B70A9
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Sep 2010 21:06:07 +1000 (EST)
Received: by gwb19 with SMTP id 19so724870gwb.15
	for <linuxppc-dev@ozlabs.org>; Thu, 09 Sep 2010 04:06:05 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1284027632-32573-3-git-send-email-tie-fei.zang@freescale.com>
References: <1284027632-32573-1-git-send-email-tie-fei.zang@freescale.com>
	<1284027632-32573-2-git-send-email-tie-fei.zang@freescale.com>
	<1284027632-32573-3-git-send-email-tie-fei.zang@freescale.com>
Date: Thu, 9 Sep 2010 13:06:00 +0200
Message-ID: <AANLkTik3ViwjmOFfm6GUwmuzMkO75+2pCUdnC0z8A7Jb@mail.gmail.com>
Subject: Re: [PATCH v2 3/3][MTD] P4080/mtd: Fix the freescale lbc issue with
	36bit mode
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Roy Zang <tie-fei.zang@freescale.com>
Content-Type: text/plain; charset=UTF-8
Cc: B07421@freescale.com, dedekind1@gmail.com, B25806@freescale.com,
	linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	akpm@linux-foundation.org, dwmw2@infradead.org, B11780@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 9, 2010 at 12:20, Roy Zang <tie-fei.zang@freescale.com> wrote:
> From: Lan Chunhe-B25806 <b25806@freescale.com>
>
> When system uses 36bit physical address, res.start is 36bit
> physical address. But the function of in_be32 returns 32bit
> physical address. Then both of them compared each other is
> wrong. So by converting the address of res.start into
> the right format fixes this issue.

> =C2=A0/**
> + * fsl_lbc_addr - convert the base address
> + * @addr_base: base address of the memory bank
> + *
> + * This function converts a base address of lbc into the right format fo=
r the BR
> + * registers. If the SOC has eLBC then it returns 32bit physical address=
 else
> + * it returns 34bit physical address for local bus(Example: MPC8641).
> + */
> +unsigned int fsl_lbc_addr(phys_addr_t addr_base)
    ^^^^^^^^^^^^
Shouldn't this be u32 or __be32, for consistency with the actual
comparisons below?

> @@ -52,7 +76,7 @@ int fsl_lbc_find(phys_addr_t addr_base)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__be32 br =3D in_b=
e32(&lbc->bank[i].br);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__be32 or =3D in_b=
e32(&lbc->bank[i].or);
>
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (br & BR_V && (br &=
 or & BR_BA) =3D=3D addr_base)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (br & BR_V && (br &=
 or & BR_BA) =3D=3D fsl_lbc_addr(addr_base))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return i;

> @@ -851,7 +851,7 @@ static int __devinit fsl_elbc_nand_probe(struct platf=
orm_device *dev,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(in_=
be32(&lbc->bank[bank].br) & BR_MSEL) =3D=3D BR_MS_FCM &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(in_=
be32(&lbc->bank[bank].br) &
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 in_=
be32(&lbc->bank[bank].or) & BR_BA)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
=3D=3D res.start)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
=3D=3D fsl_lbc_addr(res.start))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0break;

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
