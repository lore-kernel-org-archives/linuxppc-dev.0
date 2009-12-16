Return-Path: <roman.fietze@telemotive.de>
Received: from coyote.quickmin.net (coyote.quickmin.net [217.14.112.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.quickmin.de", Issuer "smtp.quickmin.de" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id ECA2BB6F0A
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 17 Dec 2009 00:29:20 +1100 (EST)
Received: from rfietze.mit.telemotive.de (rfietze.mit.telemotive.de
	[192.168.5.33])
	by alderan.mit.telemotive.de (Postfix) with ESMTP id 50CC4B7AA0
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 16 Dec 2009 14:29:15 +0100 (CET)
From: Roman Fietze <roman.fietze@telemotive.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] pata_mpc52xx: optimizing code size by change of ATA timing
	data types
MIME-Version: 1.0
Message-ID: <200912161429.14968.roman.fietze@telemotive.de>
Date: Wed, 16 Dec 2009 14:29:14 +0100
Content-Type: text/plain;
  charset="iso-8859-1"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Everybody,

A totally simple patch that reduces the text size as of the
ppc_6xx-size command of pata_mpc52xx by more than 10%, by reducing the
rodata size from 0x4a4 to 0x17e bytes. This is simply done by changing
the data types of the ATA timing constants.

If you are interested at all, and it's worth the trouble, here the
details:

ppc_6xx-size:
     text data bss  dec  hex filename
old: 6532 1068   0 7600 1db0 pata_mpc52xx.o
new: 5718 1068   0 6786 1a82 pata_mpc52xx.o

The (assembler) code itself doesn't really change very much. I double
checked the final results inside mpc52xx_ata_apply_timings() and they
match.

BTW: Should I break lines at col 72 or 80?


=46rom: Roman Fietze <roman.fietze@telemotive.de>
Date: Wed, 16 Dec 2009 13:10:31 +0100
Subject: [PATCH] pata_mpc52xx: reduce code size by simple change of constan=
t data types

Signed-off-by: Roman Fietze <roman.fietze@telemotive.de>
=2D--
 drivers/ata/pata_mpc52xx.c |   78 ++++++++++++++++++++++------------------=
=2D---
 1 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/drivers/ata/pata_mpc52xx.c b/drivers/ata/pata_mpc52xx.c
index 2bc2dbe..e4e5e82 100644
=2D-- a/drivers/ata/pata_mpc52xx.c
+++ b/drivers/ata/pata_mpc52xx.c
@@ -64,13 +64,13 @@ struct mpc52xx_ata_priv {
=20
=20
 /* ATAPI-4 PIO specs (in ns) */
=2Dstatic const int ataspec_t0[5]    =3D {600, 383, 240, 180, 120};
=2Dstatic const int ataspec_t1[5]    =3D { 70,  50,  30,  30,  25};
=2Dstatic const int ataspec_t2_8[5]  =3D {290, 290, 290,  80,  70};
=2Dstatic const int ataspec_t2_16[5] =3D {165, 125, 100,  80,  70};
=2Dstatic const int ataspec_t2i[5]   =3D {  0,   0,   0,  70,  25};
=2Dstatic const int ataspec_t4[5]    =3D { 30,  20,  15,  10,  10};
=2Dstatic const int ataspec_ta[5]    =3D { 35,  35,  35,  35,  35};
+static const u16 ataspec_t0[5]		=3D {600, 383, 240, 180, 120};
+static const u16 ataspec_t1[5]		=3D { 70,  50,  30,  30,  25};
+static const u16 ataspec_t2_8[5]	=3D {290, 290, 290,  80,  70};
+static const u16 ataspec_t2_16[5]	=3D {165, 125, 100,  80,  70};
+static const u16 ataspec_t2i[5]		=3D {  0,   0,   0,  70,  25};
+static const u16 ataspec_t4[5]		=3D { 30,  20,  15,  10,  10};
+static const u16 ataspec_ta[5]		=3D { 35,  35,  35,  35,  35};
=20
 #define CALC_CLKCYC(c,v) ((((v)+(c)-1)/(c)))
=20
@@ -78,13 +78,13 @@ static const int ataspec_ta[5]    =3D { 35,  35,  35,  =
35,  35};
=20
 /* ATAPI-4 MDMA specs (in clocks) */
 struct mdmaspec {
=2D	u32 t0M;
=2D	u32 td;
=2D	u32 th;
=2D	u32 tj;
=2D	u32 tkw;
=2D	u32 tm;
=2D	u32 tn;
+	u8 t0M;
+	u8 td;
+	u8 th;
+	u8 tj;
+	u8 tkw;
+	u8 tm;
+	u8 tn;
 };
=20
 static const struct mdmaspec mdmaspec66[3] =3D {
@@ -101,23 +101,23 @@ static const struct mdmaspec mdmaspec132[3] =3D {
=20
 /* ATAPI-4 UDMA specs (in clocks) */
 struct udmaspec {
=2D	u32 tcyc;
=2D	u32 t2cyc;
=2D	u32 tds;
=2D	u32 tdh;
=2D	u32 tdvs;
=2D	u32 tdvh;
=2D	u32 tfs;
=2D	u32 tli;
=2D	u32 tmli;
=2D	u32 taz;
=2D	u32 tzah;
=2D	u32 tenv;
=2D	u32 tsr;
=2D	u32 trfs;
=2D	u32 trp;
=2D	u32 tack;
=2D	u32 tss;
+	u8 tcyc;
+	u8 t2cyc;
+	u8 tds;
+	u8 tdh;
+	u8 tdvs;
+	u8 tdvh;
+	u8 tfs;
+	u8 tli;
+	u8 tmli;
+	u8 taz;
+	u8 tzah;
+	u8 tenv;
+	u8 tsr;
+	u8 trfs;
+	u8 trp;
+	u8 tack;
+	u8 tss;
 };
=20
 static const struct udmaspec udmaspec66[6] =3D {
@@ -270,7 +270,7 @@ mpc52xx_ata_compute_pio_timings(struct mpc52xx_ata_priv=
 *priv, int dev, int pio)
 {
 	struct mpc52xx_ata_timings *timing =3D &priv->timings[dev];
 	unsigned int ipb_period =3D priv->ipb_period;
=2D	unsigned int t0, t1, t2_8, t2_16, t2i, t4, ta;
+	u32 t0, t1, t2_8, t2_16, t2i, t4, ta;
=20
 	if ((pio < 0) || (pio > 4))
 		return -EINVAL;
@@ -299,8 +299,8 @@ mpc52xx_ata_compute_mdma_timings(struct mpc52xx_ata_pri=
v *priv, int dev,
 	if (speed < 0 || speed > 2)
 		return -EINVAL;
=20
=2D	t->mdma1 =3D (s->t0M << 24) | (s->td << 16) | (s->tkw << 8) | (s->tm);
=2D	t->mdma2 =3D (s->th << 24) | (s->tj << 16) | (s->tn << 8);
+	t->mdma1 =3D ((u32)s->t0M << 24) | ((u32)s->td << 16) | ((u32)s->tkw << 8=
) | s->tm;
+	t->mdma2 =3D ((u32)s->th << 24) | ((u32)s->tj << 16) | ((u32)s->tn << 8);
 	t->using_udma =3D 0;
=20
 	return 0;
@@ -316,11 +316,11 @@ mpc52xx_ata_compute_udma_timings(struct mpc52xx_ata_p=
riv *priv, int dev,
 	if (speed < 0 || speed > 2)
 		return -EINVAL;
=20
=2D	t->udma1 =3D (s->t2cyc << 24) | (s->tcyc << 16) | (s->tds << 8) | s->td=
h;
=2D	t->udma2 =3D (s->tdvs << 24) | (s->tdvh << 16) | (s->tfs << 8) | s->tli;
=2D	t->udma3 =3D (s->tmli << 24) | (s->taz << 16) | (s->tenv << 8) | s->tsr;
=2D	t->udma4 =3D (s->tss << 24) | (s->trfs << 16) | (s->trp << 8) | s->tack;
=2D	t->udma5 =3D (s->tzah << 24);
+	t->udma1 =3D ((u32)s->t2cyc << 24) | ((u32)s->tcyc << 16) | ((u32)s->tds =
<< 8) | s->tdh;
+	t->udma2 =3D ((u32)s->tdvs << 24) | ((u32)s->tdvh << 16) | ((u32)s->tfs <=
< 8) | s->tli;
+	t->udma3 =3D ((u32)s->tmli << 24) | ((u32)s->taz << 16) | ((u32)s->tenv <=
< 8) | s->tsr;
+	t->udma4 =3D ((u32)s->tss << 24) | ((u32)s->trfs << 16) | ((u32)s->trp <<=
 8) | s->tack;
+	t->udma5 =3D (u32)s->tzah << 24;
 	t->using_udma =3D 1;
=20
 	return 0;
=2D-=20
1.6.5.3


Roman

=2D-=20
Roman Fietze                Telemotive AG B=FCro M=FChlhausen
Breitwiesen                              73347 M=FChlhausen
Tel.: +49(0)7335/18493-45        http://www.telemotive.de
