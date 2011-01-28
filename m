Return-Path: <oakad@yahoo.com>
Received: from web37608.mail.mud.yahoo.com (web37608.mail.mud.yahoo.com
	[209.191.87.91]) by ozlabs.org (Postfix) with SMTP id 86770B70EE
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 28 Jan 2011 15:37:50 +1100 (EST)
Message-ID: <640295.36173.qm@web37608.mail.mud.yahoo.com>
Date: Thu, 27 Jan 2011 20:37:48 -0800 (PST)
From: Alex Dubov <oakad@yahoo.com>
Subject: [PATCH v2] gianfar: Fall back to software tcp/udp checksum on older
	controllers
To: Anton Vorontsov <cbouatmailru@gmail.com>
In-Reply-To: <20110127095100.GA5411@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net,
	mlcreech@gmail.com
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
P=0Apacket checksum for some alignments of the appropriate FCB. This patch =
checks=0Afor FCB alignment on such controllers and falls back to software c=
hecksumming=0Aif the alignment is known to be bad.=0A=0ASigned-off-by: Alex=
 Dubov <oakad@yahoo.com>=0A---=0AChanges for v2:=0A   - Make indentation sl=
ightly more consistent.=0A   - Replace bizarre switch-based condition with =
plain boring one.=0A=0A drivers/net/gianfar.c |   16 ++++++++++++++--=0A dr=
ivers/net/gianfar.h |    1 +=0A 2 files changed, 15 insertions(+), 2 deleti=
ons(-)=0A=0Adiff --git a/drivers/net/gianfar.c b/drivers/net/gianfar.c=0Ain=
dex 5ed8f9f..3da19a5 100644=0A--- a/drivers/net/gianfar.c=0A+++ b/drivers/n=
et/gianfar.c=0A@@ -950,6 +950,11 @@ static void gfar_detect_errata(struct g=
far_private *priv)=0A =09=09=09(pvr =3D=3D 0x80861010 && (mod & 0xfff9) =3D=
=3D 0x80c0))=0A =09=09priv->errata |=3D GFAR_ERRATA_A002;=0A =0A+=09/* MPC8=
313 Rev < 2.0, MPC8548 rev 2.0 */=0A+=09if ((pvr =3D=3D 0x80850010 && mod =
=3D=3D 0x80b0 && rev < 0x0020) ||=0A+=09=09=09(pvr =3D=3D 0x80210020 && mod=
 =3D=3D 0x8030 && rev =3D=3D 0x0020))=0A+=09=09priv->errata |=3D GFAR_ERRAT=
A_12;=0A+=0A =09if (priv->errata)=0A =09=09dev_info(dev, "enabled errata wo=
rkarounds, flags: 0x%x\n",=0A =09=09=09 priv->errata);=0A@@ -2156,8 +2161,1=
5 @@ static int gfar_start_xmit(struct sk_buff *skb, struct net_device *dev=
)=0A =09/* Set up checksumming */=0A =09if (CHECKSUM_PARTIAL =3D=3D skb->ip=
_summed) {=0A =09=09fcb =3D gfar_add_fcb(skb);=0A-=09=09lstatus |=3D BD_LFL=
AG(TXBD_TOE);=0A-=09=09gfar_tx_checksum(skb, fcb);=0A+=09=09/* as specified=
 by errata */=0A+=09=09if (unlikely(gfar_has_errata(priv, GFAR_ERRATA_12)=
=0A+=09=09=09     && ((unsigned long)fcb % 0x20) > 0x18)) {=0A+=09=09=09__s=
kb_pull(skb, GMAC_FCB_LEN);=0A+=09=09=09skb_checksum_help(skb);=0A+=09=09} =
else {=0A+=09=09=09lstatus |=3D BD_LFLAG(TXBD_TOE);=0A+=09=09=09gfar_tx_che=
cksum(skb, fcb);=0A+=09=09}=0A =09}=0A =0A =09if (vlan_tx_tag_present(skb))=
 {=0Adiff --git a/drivers/net/gianfar.h b/drivers/net/gianfar.h=0Aindex 54d=
e413..ec5d595 100644=0A--- a/drivers/net/gianfar.h=0A+++ b/drivers/net/gian=
far.h=0A@@ -1039,6 +1039,7 @@ enum gfar_errata {=0A =09GFAR_ERRATA_74=09=09=
=3D 0x01,=0A =09GFAR_ERRATA_76=09=09=3D 0x02,=0A =09GFAR_ERRATA_A002=09=3D =
0x04,=0A+=09GFAR_ERRATA_12=09=09=3D 0x08, /* a.k.a errata eTSEC49 */=0A };=
=0A =0A /* Struct stolen almost completely (and shamelessly) from the FCC e=
net source=0A-- =0A1.7.3.2=0A=0A=0A=0A=0A      
