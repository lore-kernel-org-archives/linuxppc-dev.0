Return-Path: <oakad@yahoo.com>
Received: from web37605.mail.mud.yahoo.com (web37605.mail.mud.yahoo.com
	[209.191.87.88]) by ozlabs.org (Postfix) with SMTP id E51151007D2
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 27 Jan 2011 19:14:24 +1100 (EST)
Message-ID: <468529.34173.qm@web37605.mail.mud.yahoo.com>
Date: Thu, 27 Jan 2011 00:14:21 -0800 (PST)
From: Alex Dubov <oakad@yahoo.com>
Subject: [PATCH] gianfar: Fall back to software tcp/udp checksum on older
	controllers
To: mlcreech@gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As specified by errata eTSEC49 of MPC8548 and errata eTSEC12 of MPC83xx,=0A=
older revisions of gianfar controllers will be unable to calculate a TCP/UD=
P=0Apacket checksum for some aligments of the appropriate FCB. This patch c=
hecks=0Afor FCB alignment on such controllers and falls back to software ch=
ecksumming=0Aif the aligment is known to be bad.=0A=0ASigned-off-by: Alex D=
ubov <oakad@yahoo.com>=0A---=0AThis is my, somewhat different approach to M=
atthew Creech proposed solution.=0A=0A drivers/net/gianfar.c |   21 +++++++=
++++++++++++--=0A drivers/net/gianfar.h |    1 +=0A 2 files changed, 20 ins=
ertions(+), 2 deletions(-)=0A=0Adiff --git a/drivers/net/gianfar.c b/driver=
s/net/gianfar.c=0Aindex 5ed8f9f..b4f0e99 100644=0A--- a/drivers/net/gianfar=
.c=0A+++ b/drivers/net/gianfar.c=0A@@ -950,6 +950,11 @@ static void gfar_de=
tect_errata(struct gfar_private *priv)=0A =09=09=09(pvr =3D=3D 0x80861010 &=
& (mod & 0xfff9) =3D=3D 0x80c0))=0A =09=09priv->errata |=3D GFAR_ERRATA_A00=
2;=0A =0A+=09/* MPC8313 Rev < 2.0, MPC8548 rev 2.0 */=0A+=09if ((pvr =3D=3D=
 0x80850010 && mod =3D=3D 0x80b0 && rev < 0x0020)=0A+=09    || (pvr =3D=3D =
0x80210020 && mod =3D=3D 0x8030 && rev =3D=3D 0x0020))=0A+=09=09priv->errat=
a |=3D GFAR_ERRATA_12;=0A+=0A =09if (priv->errata)=0A =09=09dev_info(dev, "=
enabled errata workarounds, flags: 0x%x\n",=0A =09=09=09 priv->errata);=0A@=
@ -2156,8 +2161,20 @@ static int gfar_start_xmit(struct sk_buff *skb, struc=
t net_device *dev)=0A =09/* Set up checksumming */=0A =09if (CHECKSUM_PARTI=
AL =3D=3D skb->ip_summed) {=0A =09=09fcb =3D gfar_add_fcb(skb);=0A-=09=09ls=
tatus |=3D BD_LFLAG(TXBD_TOE);=0A-=09=09gfar_tx_checksum(skb, fcb);=0A+=09=
=09switch (unlikely(gfar_has_errata(priv, GFAR_ERRATA_12))=0A+=09=09=09? 1 =
: 0) {=0A+=09=09case 1:=0A+=09=09=09/* as specified by errata */=0A+=09=09=
=09if (((unsigned long)fcb % 0x20) > 0x18) { =0A+=09=09=09=09__skb_pull(skb=
, GMAC_FCB_LEN);=0A+=09=09=09=09skb_checksum_help(skb);=0A+=09=09=09=09brea=
k;=0A+=09=09=09}=0A+=09=09=09/* otherwise, fall through */=0A+=09=09default=
:=0A+=09=09=09lstatus |=3D BD_LFLAG(TXBD_TOE);=0A+=09=09=09gfar_tx_checksum=
(skb, fcb);=0A+=09=09}=0A =09}=0A =0A =09if (vlan_tx_tag_present(skb)) {=0A=
diff --git a/drivers/net/gianfar.h b/drivers/net/gianfar.h=0Aindex 54de413.=
.ec5d595 100644=0A--- a/drivers/net/gianfar.h=0A+++ b/drivers/net/gianfar.h=
=0A@@ -1039,6 +1039,7 @@ enum gfar_errata {=0A =09GFAR_ERRATA_74=09=09=3D 0=
x01,=0A =09GFAR_ERRATA_76=09=09=3D 0x02,=0A =09GFAR_ERRATA_A002=09=3D 0x04,=
=0A+=09GFAR_ERRATA_12=09=09=3D 0x08, /* a.k.a errata eTSEC49 */=0A };=0A =
=0A /* Struct stolen almost completely (and shamelessly) from the FCC enet =
source=0A-- =0A1.7.3.2=0A=0A=0A=0A=0A      
