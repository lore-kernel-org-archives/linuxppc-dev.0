Return-Path: <bgill@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 49677DDEED
	for <linuxppc-dev@ozlabs.org>; Sat, 12 May 2007 03:49:49 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l4BHnicM023899
	for <linuxppc-dev@ozlabs.org>; Fri, 11 May 2007 10:49:44 -0700 (MST)
From: Becky Bruce <becky.bruce@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Remove ft_ordered from flatdevtree.c
Date: Fri, 11 May 2007 12:49:39 -0500
Message-Id: <11789057794165-git-send-email-becky.bruce@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

AFAICT, nobody is using this function, and it causes a build warning
to be generated.  This patch cleans that up by removing the function
and the commented-out code that calls it.

Signed-off-by: Becky Bruce <becky.bruce@freescale.com>
---
If anybody has a good reason that this code has been left in, yell!
I'm not *dying* to remove it, but the build warning is annoying.
I've asked around, in email, and on IRC, and not gotten anything
interesting as a response.  If someone wants to keep the code around
for some reason, we can comment it out instead to drop the warning.

 arch/powerpc/boot/flatdevtree.c |   18 ------------------
 1 files changed, 0 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/boot/flatdevtree.c b/arch/powerpc/boot/flatdevtree.c
index d00fbd9..eba2ddc 100644
--- a/arch/powerpc/boot/flatdevtree.c
+++ b/arch/powerpc/boot/flatdevtree.c
@@ -134,20 +134,6 @@ static char *ft_next(struct ft_cxt *cxt, char *p, struct ft_atom *ret)
 #define HDR_SIZE	_ALIGN(sizeof(struct boot_param_header), 8)
 #define EXPAND_INCR	1024	/* alloc this much extra when expanding */
 
-/* See if the regions are in the standard order and non-overlapping */
-static int ft_ordered(struct ft_cxt *cxt)
-{
-	char *p = (char *)cxt->bph + HDR_SIZE;
-	enum ft_rgn_id r;
-
-	for (r = FT_RSVMAP; r <= FT_STRINGS; ++r) {
-		if (p > cxt->rgn[r].start)
-			return 0;
-		p = cxt->rgn[r].start + cxt->rgn[r].size;
-	}
-	return p <= (char *)cxt->bph + cxt->max_size;
-}
-
 /* Copy the tree to a newly-allocated region and put things in order */
 static int ft_reorder(struct ft_cxt *cxt, int nextra)
 {
@@ -573,10 +559,6 @@ int ft_open(struct ft_cxt *cxt, void *blob, unsigned int max_size,
 	cxt->rgn[FT_STRUCT].size = struct_size(cxt);
 	cxt->rgn[FT_STRINGS].start = blob + be32_to_cpu(bph->off_dt_strings);
 	cxt->rgn[FT_STRINGS].size = be32_to_cpu(bph->dt_strings_size);
-	/* Leave as '0' to force first ft_make_space call to do a ft_reorder
-	 * and move dt to an area allocated by realloc.
-	cxt->isordered = ft_ordered(cxt);
-	*/
 
 	cxt->p = cxt->rgn[FT_STRUCT].start;
 	cxt->str_anchor = cxt->rgn[FT_STRINGS].start;
-- 
1.5.0.3
