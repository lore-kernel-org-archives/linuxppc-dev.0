Return-Path: <mlcreech@gmail.com>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by ozlabs.org (Postfix) with ESMTP id 0CFA6B71B0
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 19 Nov 2010 06:31:55 +1100 (EST)
Received: by ewy2 with SMTP id 2so2207888ewy.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 18 Nov 2010 11:31:53 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20101118.090615.71123752.davem@davemloft.net>
References: <AANLkTi=-ZAL-to4qZ0vA20L589fMQm89E9mH9WWOvX0c@mail.gmail.com>
	<20101118.090615.71123752.davem@davemloft.net>
Date: Thu, 18 Nov 2010 14:31:46 -0500
Message-ID: <AANLkTi=fZnj94761L_=1DpPAErVG8EHESObtd+d5xJfK@mail.gmail.com>
Subject: Re: Gianfar TCP checksumming broken in 2.6.35+
From: "Matthew L. Creech" <mlcreech@gmail.com>
To: David Miller <davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 18, 2010 at 12:06 PM, David Miller <davem@davemloft.net> wrote:
>
> Can someone please follow up Matthew to get this bug resolved? =A0It has
> been sitting around for a long time.
>
> I suspect the gianfar driver, for these chip revisions, will need to
> do a software checksum when the offset matches the criteria mentioned
> in the errata above.
>

I added a patch for this which fixes our affected systems; however, I
don't know if this is a good way to perform checksum offloading, I
just kind of dug around until I found a function that seemed like it
worked.  :)  Patch against 2.6.36 is below for reference.


---
 gianfar.c |   21 +++++++++++++++++++--
 gianfar.h |    1 +
 2 files changed, 20 insertions(+), 2 deletions(-)

diff -purN orig/drivers/net/gianfar.c linux-2.6.36/drivers/net/gianfar.c
--- orig/drivers/net/gianfar.c	2010-11-03 15:10:29.287140651 -0400
+++ linux-2.6.36/drivers/net/gianfar.c	2010-11-03 16:01:03.754321896 -0400
@@ -937,6 +937,10 @@ static void gfar_detect_errata(struct gf
 	unsigned int mod =3D (svr >> 16) & 0xfff6; /* w/o E suffix */
 	unsigned int rev =3D svr & 0xffff;

+	/* MPC8313 Rev < 2.0 */
+	if (pvr =3D=3D 0x80850010 && mod =3D=3D 0x80b0 && rev < 0x0020)
+		priv->errata |=3D GFAR_ERRATA_12;
+
 	/* MPC8313 Rev 2.0 and higher; All MPC837x */
 	if ((pvr =3D=3D 0x80850010 && mod =3D=3D 0x80b0 && rev >=3D 0x0020) ||
 			(pvr =3D=3D 0x80861010 && (mod & 0xfff9) =3D=3D 0x80c0))
@@ -1984,7 +1988,8 @@ static inline struct txfcb *gfar_add_fcb
 	return fcb;
 }

-static inline void gfar_tx_checksum(struct sk_buff *skb, struct txfcb *fcb=
)
+static inline void gfar_tx_checksum(struct sk_buff *skb, struct txfcb *fcb=
,
+				int has_csum_bug)
 {
 	u8 flags =3D 0;

@@ -1994,6 +1999,17 @@ static inline void gfar_tx_checksum(stru
 	 */
 	flags =3D TXFCB_DEFAULT;

+	/* If using old-rev silicon, the alignment of the TXFCB may be off,
+	 * causing TCP checksumming to fail (errata eTSEC12).  In that case,
+	 * we compute the checksum manually.
+	 */
+	if (has_csum_bug) {
+		/* Disable handling of TCP/UDP header (checksumming) */
+		flags &=3D ~TXFCB_TUP;
+		/* Manually add checksum */
+		skb_checksum_help(skb);
+	}
+
 	/* Tell the controller what the protocol is */
 	/* And provide the already calculated phcs */
 	if (ip_hdr(skb)->protocol =3D=3D IPPROTO_UDP) {
@@ -2159,7 +2175,8 @@ static int gfar_start_xmit(struct sk_buf
 	if (CHECKSUM_PARTIAL =3D=3D skb->ip_summed) {
 		fcb =3D gfar_add_fcb(skb);
 		lstatus |=3D BD_LFLAG(TXBD_TOE);
-		gfar_tx_checksum(skb, fcb);
+		gfar_tx_checksum(skb, fcb,
+				gfar_has_errata(priv, GFAR_ERRATA_12));
 	}

 	if (priv->vlgrp && vlan_tx_tag_present(skb)) {
diff -purN orig/drivers/net/gianfar.h linux-2.6.36/drivers/net/gianfar.h
--- orig/drivers/net/gianfar.h	2010-11-03 15:10:29.257142194 -0400
+++ linux-2.6.36/drivers/net/gianfar.h	2010-11-03 15:48:10.117134959 -0400
@@ -1029,6 +1029,7 @@ enum gfar_errata {
 	GFAR_ERRATA_74		=3D 0x01,
 	GFAR_ERRATA_76		=3D 0x02,
 	GFAR_ERRATA_A002	=3D 0x04,
+	GFAR_ERRATA_12		=3D 0x08,
 };

 /* Struct stolen almost completely (and shamelessly) from the FCC enet sou=
rce

--=20
Matthew L. Creech
