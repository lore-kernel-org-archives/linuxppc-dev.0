Return-Path: <b07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 163B2DE107
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Feb 2007 10:01:45 +1100 (EST)
Date: Wed, 7 Feb 2007 17:01:30 -0600
From: Scott Wood <scottwood@freescale.com>
To: paulus@samba.org
Subject: [PATCH 09/19] bootwrapper: Rename p and pp to anchor and anchorptr.
Message-ID: <20070207230130.GI3849@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070207230017.GA3758@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This makes the meaning of "p" clearer, and increases the visual
difference between the two to avoid bugs such as the one fixed in
"Modify *pp, not *p, in ft_shuffle()".

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/flatdevtree.c |   44 +++++++++++++++++++++-----------------
 1 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/boot/flatdevtree.c b/arch/powerpc/boot/flatdevtree.c
index f2a29ca..0c8970e 100644
--- a/arch/powerpc/boot/flatdevtree.c
+++ b/arch/powerpc/boot/flatdevtree.c
@@ -215,23 +215,25 @@ static inline char *next_start(struct ft
  * See if we can expand region rgn by nextra bytes by using up
  * free space after or before the region.
  */
-static int ft_shuffle(struct ft_cxt *cxt, char **pp, enum ft_rgn_id rgn,
-		int nextra)
+static int ft_shuffle(struct ft_cxt *cxt, char **anchorptr,
+                      enum ft_rgn_id rgn, int nextra)
 {
-	char *p = *pp;
+	char *anchor = *anchorptr;
 	char *rgn_start, *rgn_end;
 
 	rgn_start = cxt->rgn[rgn].start;
 	rgn_end = rgn_start + cxt->rgn[rgn].size;
 	if (nextra <= 0 || rgn_end + nextra <= next_start(cxt, rgn)) {
 		/* move following stuff */
-		if (p < rgn_end) {
+		if (anchor < rgn_end) {
 			if (nextra < 0)
-				memmove(p, p - nextra, rgn_end - p + nextra);
+				memmove(anchor, anchor - nextra,
+				        rgn_end - anchor + nextra);
 			else
-				memmove(p + nextra, p, rgn_end - p);
+				memmove(anchor + nextra, anchor,
+				        rgn_end - anchor);
 			if (rgn == FT_STRUCT)
-				ft_node_update_after(cxt, p, nextra);
+				ft_node_update_after(cxt, anchor, nextra);
 		}
 		cxt->rgn[rgn].size += nextra;
 		if (rgn == FT_STRINGS)
@@ -241,12 +243,13 @@ static int ft_shuffle(struct ft_cxt *cxt
 	}
 	if (prev_end(cxt, rgn) <= rgn_start - nextra) {
 		/* move preceding stuff */
-		if (p > rgn_start) {
-			memmove(rgn_start - nextra, rgn_start, p - rgn_start);
+		if (anchor > rgn_start) {
+			memmove(rgn_start - nextra, rgn_start,
+			        anchor - rgn_start);
 			if (rgn == FT_STRUCT)
-				ft_node_update_before(cxt, p, -nextra);
+				ft_node_update_before(cxt, anchor, -nextra);
 		}
-		*pp -= nextra;
+		*anchorptr -= nextra;
 		cxt->rgn[rgn].start -= nextra;
 		cxt->rgn[rgn].size += nextra;
 		return 1;
@@ -254,22 +257,22 @@ static int ft_shuffle(struct ft_cxt *cxt
 	return 0;
 }
 
-static int ft_make_space(struct ft_cxt *cxt, char **pp, enum ft_rgn_id rgn,
-			 int nextra)
+static int ft_make_space(struct ft_cxt *cxt, char **anchorptr,
+                         enum ft_rgn_id rgn, int nextra)
 {
 	unsigned long size, ssize, tot;
 	char *str, *next;
 	enum ft_rgn_id r;
 
 	if (!cxt->isordered) {
-		unsigned long rgn_off = *pp - cxt->rgn[rgn].start;
+		unsigned long rgn_off = *anchorptr - cxt->rgn[rgn].start;
 
 		if (!ft_reorder(cxt, nextra))
 			return 0;
 
-		*pp = cxt->rgn[rgn].start + rgn_off;
+		*anchorptr = cxt->rgn[rgn].start + rgn_off;
 	}
-	if (ft_shuffle(cxt, pp, rgn, nextra))
+	if (ft_shuffle(cxt, anchorptr, rgn, nextra))
 		return 1;
 
 	/* See if there is space after the strings section */
@@ -282,7 +285,8 @@ static int ft_make_space(struct ft_cxt *
 		memmove(str, cxt->rgn[FT_STRINGS].start, ssize);
 		cxt->rgn[FT_STRINGS].start = str;
 		/* enough space now? */
-		if (rgn >= FT_STRUCT && ft_shuffle(cxt, pp, rgn, nextra))
+		if (rgn >= FT_STRUCT &&
+		    ft_shuffle(cxt, anchorptr, rgn, nextra))
 			return 1;
 	}
 
@@ -316,7 +320,7 @@ static int ft_make_space(struct ft_cxt *
 				new_start = cxt->rgn[r].start + shift;
 				cxt->rgn[r].start = new_start;
 			}
-			*pp += shift;
+			*anchorptr += shift;
 			cxt->str_anchor += shift;
 		}
 
@@ -326,7 +330,7 @@ static int ft_make_space(struct ft_cxt *
 		memmove(str, cxt->rgn[FT_STRINGS].start, ssize);
 		cxt->rgn[FT_STRINGS].start = str;
 
-		if (ft_shuffle(cxt, pp, rgn, nextra))
+		if (ft_shuffle(cxt, anchorptr, rgn, nextra))
 			return 1;
 	}
 
@@ -341,7 +345,7 @@ static int ft_make_space(struct ft_cxt *
 		ft_node_update_after(cxt, cxt->rgn[FT_STRUCT].start, nextra);
 		cxt->rgn[FT_STRUCT].start = next;
 
-		if (ft_shuffle(cxt, pp, rgn, nextra))
+		if (ft_shuffle(cxt, anchorptr, rgn, nextra))
 			return 1;
 	}
 
-- 
1.4.4
