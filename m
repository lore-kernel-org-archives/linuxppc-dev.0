Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f228.google.com (mail-gx0-f228.google.com
	[209.85.217.228]) by ozlabs.org (Postfix) with ESMTP id 60C74B7D60
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Feb 2010 06:41:49 +1100 (EST)
Received: by gxk28 with SMTP id 28so25809gxk.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 16 Feb 2010 11:41:48 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <200912161429.14968.roman.fietze@telemotive.de>
References: <200912161429.14968.roman.fietze@telemotive.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 16 Feb 2010 12:41:27 -0700
Message-ID: <fa686aa41002161141v20a06768nbdcdb094293bb5b2@mail.gmail.com>
Subject: Re: [PATCH] pata_mpc52xx: optimizing code size by change of ATA
	timing data types
To: Roman Fietze <roman.fietze@telemotive.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-ide@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Jeff Garzik <jgarzik@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[cc'd linux-kernel, linux-ide and Jeff Garzik]

Hi Roman.

you should use ./scripts/get_maintainer.pl to make sure you're cc'ing
the right people when posting patches.  You should repost so that Jeff
has a copy of the patch to pick up (and add my acked-by when you do).

On Wed, Dec 16, 2009 at 6:29 AM, Roman Fietze
<roman.fietze@telemotive.de> wrote:
> Hello Everybody,
>
> A totally simple patch that reduces the text size as of the
> ppc_6xx-size command of pata_mpc52xx by more than 10%, by reducing the
> rodata size from 0x4a4 to 0x17e bytes. This is simply done by changing
> the data types of the ATA timing constants.

Acked-by: Grant Likely <grant.likely@secretlab>

>
> If you are interested at all, and it's worth the trouble, here the
> details:
>
> ppc_6xx-size:
> =A0 =A0 text data bss =A0dec =A0hex filename
> old: 6532 1068 =A0 0 7600 1db0 pata_mpc52xx.o
> new: 5718 1068 =A0 0 6786 1a82 pata_mpc52xx.o
>
> The (assembler) code itself doesn't really change very much. I double
> checked the final results inside mpc52xx_ata_apply_timings() and they
> match.
>
> BTW: Should I break lines at col 72 or 80?
>
>
> From: Roman Fietze <roman.fietze@telemotive.de>
> Date: Wed, 16 Dec 2009 13:10:31 +0100
> Subject: [PATCH] pata_mpc52xx: reduce code size by simple change of const=
ant data types
>
> Signed-off-by: Roman Fietze <roman.fietze@telemotive.de>
> ---
> =A0drivers/ata/pata_mpc52xx.c | =A0 78 ++++++++++++++++++++++------------=
----------
> =A01 files changed, 39 insertions(+), 39 deletions(-)
>
> diff --git a/drivers/ata/pata_mpc52xx.c b/drivers/ata/pata_mpc52xx.c
> index 2bc2dbe..e4e5e82 100644
> --- a/drivers/ata/pata_mpc52xx.c
> +++ b/drivers/ata/pata_mpc52xx.c
> @@ -64,13 +64,13 @@ struct mpc52xx_ata_priv {
>
>
> =A0/* ATAPI-4 PIO specs (in ns) */
> -static const int ataspec_t0[5] =A0 =A0=3D {600, 383, 240, 180, 120};
> -static const int ataspec_t1[5] =A0 =A0=3D { 70, =A050, =A030, =A030, =A0=
25};
> -static const int ataspec_t2_8[5] =A0=3D {290, 290, 290, =A080, =A070};
> -static const int ataspec_t2_16[5] =3D {165, 125, 100, =A080, =A070};
> -static const int ataspec_t2i[5] =A0 =3D { =A00, =A0 0, =A0 0, =A070, =A0=
25};
> -static const int ataspec_t4[5] =A0 =A0=3D { 30, =A020, =A015, =A010, =A0=
10};
> -static const int ataspec_ta[5] =A0 =A0=3D { 35, =A035, =A035, =A035, =A0=
35};
> +static const u16 ataspec_t0[5] =A0 =A0 =A0 =A0 =3D {600, 383, 240, 180, =
120};
> +static const u16 ataspec_t1[5] =A0 =A0 =A0 =A0 =3D { 70, =A050, =A030, =
=A030, =A025};
> +static const u16 ataspec_t2_8[5] =A0 =A0 =A0 =3D {290, 290, 290, =A080, =
=A070};
> +static const u16 ataspec_t2_16[5] =A0 =A0 =A0=3D {165, 125, 100, =A080, =
=A070};
> +static const u16 ataspec_t2i[5] =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D { =A0=
0, =A0 0, =A0 0, =A070, =A025};
> +static const u16 ataspec_t4[5] =A0 =A0 =A0 =A0 =3D { 30, =A020, =A015, =
=A010, =A010};
> +static const u16 ataspec_ta[5] =A0 =A0 =A0 =A0 =3D { 35, =A035, =A035, =
=A035, =A035};
>
> =A0#define CALC_CLKCYC(c,v) ((((v)+(c)-1)/(c)))
>
> @@ -78,13 +78,13 @@ static const int ataspec_ta[5] =A0 =A0=3D { 35, =A035=
, =A035, =A035, =A035};
>
> =A0/* ATAPI-4 MDMA specs (in clocks) */
> =A0struct mdmaspec {
> - =A0 =A0 =A0 u32 t0M;
> - =A0 =A0 =A0 u32 td;
> - =A0 =A0 =A0 u32 th;
> - =A0 =A0 =A0 u32 tj;
> - =A0 =A0 =A0 u32 tkw;
> - =A0 =A0 =A0 u32 tm;
> - =A0 =A0 =A0 u32 tn;
> + =A0 =A0 =A0 u8 t0M;
> + =A0 =A0 =A0 u8 td;
> + =A0 =A0 =A0 u8 th;
> + =A0 =A0 =A0 u8 tj;
> + =A0 =A0 =A0 u8 tkw;
> + =A0 =A0 =A0 u8 tm;
> + =A0 =A0 =A0 u8 tn;
> =A0};
>
> =A0static const struct mdmaspec mdmaspec66[3] =3D {
> @@ -101,23 +101,23 @@ static const struct mdmaspec mdmaspec132[3] =3D {
>
> =A0/* ATAPI-4 UDMA specs (in clocks) */
> =A0struct udmaspec {
> - =A0 =A0 =A0 u32 tcyc;
> - =A0 =A0 =A0 u32 t2cyc;
> - =A0 =A0 =A0 u32 tds;
> - =A0 =A0 =A0 u32 tdh;
> - =A0 =A0 =A0 u32 tdvs;
> - =A0 =A0 =A0 u32 tdvh;
> - =A0 =A0 =A0 u32 tfs;
> - =A0 =A0 =A0 u32 tli;
> - =A0 =A0 =A0 u32 tmli;
> - =A0 =A0 =A0 u32 taz;
> - =A0 =A0 =A0 u32 tzah;
> - =A0 =A0 =A0 u32 tenv;
> - =A0 =A0 =A0 u32 tsr;
> - =A0 =A0 =A0 u32 trfs;
> - =A0 =A0 =A0 u32 trp;
> - =A0 =A0 =A0 u32 tack;
> - =A0 =A0 =A0 u32 tss;
> + =A0 =A0 =A0 u8 tcyc;
> + =A0 =A0 =A0 u8 t2cyc;
> + =A0 =A0 =A0 u8 tds;
> + =A0 =A0 =A0 u8 tdh;
> + =A0 =A0 =A0 u8 tdvs;
> + =A0 =A0 =A0 u8 tdvh;
> + =A0 =A0 =A0 u8 tfs;
> + =A0 =A0 =A0 u8 tli;
> + =A0 =A0 =A0 u8 tmli;
> + =A0 =A0 =A0 u8 taz;
> + =A0 =A0 =A0 u8 tzah;
> + =A0 =A0 =A0 u8 tenv;
> + =A0 =A0 =A0 u8 tsr;
> + =A0 =A0 =A0 u8 trfs;
> + =A0 =A0 =A0 u8 trp;
> + =A0 =A0 =A0 u8 tack;
> + =A0 =A0 =A0 u8 tss;
> =A0};
>
> =A0static const struct udmaspec udmaspec66[6] =3D {
> @@ -270,7 +270,7 @@ mpc52xx_ata_compute_pio_timings(struct mpc52xx_ata_pr=
iv *priv, int dev, int pio)
> =A0{
> =A0 =A0 =A0 =A0struct mpc52xx_ata_timings *timing =3D &priv->timings[dev]=
;
> =A0 =A0 =A0 =A0unsigned int ipb_period =3D priv->ipb_period;
> - =A0 =A0 =A0 unsigned int t0, t1, t2_8, t2_16, t2i, t4, ta;
> + =A0 =A0 =A0 u32 t0, t1, t2_8, t2_16, t2i, t4, ta;
>
> =A0 =A0 =A0 =A0if ((pio < 0) || (pio > 4))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
> @@ -299,8 +299,8 @@ mpc52xx_ata_compute_mdma_timings(struct mpc52xx_ata_p=
riv *priv, int dev,
> =A0 =A0 =A0 =A0if (speed < 0 || speed > 2)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
>
> - =A0 =A0 =A0 t->mdma1 =3D (s->t0M << 24) | (s->td << 16) | (s->tkw << 8)=
 | (s->tm);
> - =A0 =A0 =A0 t->mdma2 =3D (s->th << 24) | (s->tj << 16) | (s->tn << 8);
> + =A0 =A0 =A0 t->mdma1 =3D ((u32)s->t0M << 24) | ((u32)s->td << 16) | ((u=
32)s->tkw << 8) | s->tm;
> + =A0 =A0 =A0 t->mdma2 =3D ((u32)s->th << 24) | ((u32)s->tj << 16) | ((u3=
2)s->tn << 8);
> =A0 =A0 =A0 =A0t->using_udma =3D 0;
>
> =A0 =A0 =A0 =A0return 0;
> @@ -316,11 +316,11 @@ mpc52xx_ata_compute_udma_timings(struct mpc52xx_ata=
_priv *priv, int dev,
> =A0 =A0 =A0 =A0if (speed < 0 || speed > 2)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
>
> - =A0 =A0 =A0 t->udma1 =3D (s->t2cyc << 24) | (s->tcyc << 16) | (s->tds <=
< 8) | s->tdh;
> - =A0 =A0 =A0 t->udma2 =3D (s->tdvs << 24) | (s->tdvh << 16) | (s->tfs <<=
 8) | s->tli;
> - =A0 =A0 =A0 t->udma3 =3D (s->tmli << 24) | (s->taz << 16) | (s->tenv <<=
 8) | s->tsr;
> - =A0 =A0 =A0 t->udma4 =3D (s->tss << 24) | (s->trfs << 16) | (s->trp << =
8) | s->tack;
> - =A0 =A0 =A0 t->udma5 =3D (s->tzah << 24);
> + =A0 =A0 =A0 t->udma1 =3D ((u32)s->t2cyc << 24) | ((u32)s->tcyc << 16) |=
 ((u32)s->tds << 8) | s->tdh;
> + =A0 =A0 =A0 t->udma2 =3D ((u32)s->tdvs << 24) | ((u32)s->tdvh << 16) | =
((u32)s->tfs << 8) | s->tli;
> + =A0 =A0 =A0 t->udma3 =3D ((u32)s->tmli << 24) | ((u32)s->taz << 16) | (=
(u32)s->tenv << 8) | s->tsr;
> + =A0 =A0 =A0 t->udma4 =3D ((u32)s->tss << 24) | ((u32)s->trfs << 16) | (=
(u32)s->trp << 8) | s->tack;
> + =A0 =A0 =A0 t->udma5 =3D (u32)s->tzah << 24;
> =A0 =A0 =A0 =A0t->using_udma =3D 1;
>
> =A0 =A0 =A0 =A0return 0;
> --
> 1.6.5.3
>
>
> Roman
>
> --
> Roman Fietze =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Telemotive AG B=FCro M=FChlha=
usen
> Breitwiesen =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A073=
347 M=FChlhausen
> Tel.: +49(0)7335/18493-45 =A0 =A0 =A0 =A0http://www.telemotive.de
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
