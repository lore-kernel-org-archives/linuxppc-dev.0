Return-Path: <mgreer@mvista.com>
Date: Thu, 12 Oct 2006 20:57:23 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] powerpc: realloc & other bug fixes for flatdevtree
Message-ID: <20061013035722.GA32327@mag.az.mvista.com>
References: <20061012013223.GA9143@mag.az.mvista.com>
	<20061012013427.GC9143@mag.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061012013427.GC9143@mag.az.mvista.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Fix some bugs in flatdevtree.c:
 - ft_reorder should update cxt->p.
 - ft_make_space didn't follow realloc() semantics properly and
   accessed freed memory.
 - Fix some other bugs in ft_make_space.
 - Don't set cxt->isordered in ft_open to force an ft_reorder the first
   time ft_make_space is called.  Required so that a malloc is used to
   get a pointer that the the realloc in ft_make_space can validly use
   later.
 - Make ft_end_tree only call adjust_string_offsets if the offsets changed.

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
---

 flatdevtree.c |   22 +++++++++++++---------
 1 files changed, 13 insertions(+), 9 deletions(-)
---

diff --git a/arch/powerpc/boot/flatdevtree.c b/arch/powerpc/boot/flatdevtree.c
index 0d24f50..c76c194 100644
--- a/arch/powerpc/boot/flatdevtree.c
+++ b/arch/powerpc/boot/flatdevtree.c
@@ -176,6 +176,7 @@ static int ft_reorder(struct ft_cxt *cxt
 	memcpy(p, cxt->rgn[FT_STRUCT].start, cxt->rgn[FT_STRUCT].size);
 	ft_node_update_after(cxt, cxt->rgn[FT_STRUCT].start,
 			p - cxt->rgn[FT_STRUCT].start);
+	cxt->p += p - cxt->rgn[FT_STRUCT].start;
 	cxt->rgn[FT_STRUCT].start = p;
 
 	p = pend - cxt->rgn[FT_STRINGS].size;
@@ -281,7 +282,7 @@ static int ft_make_space(struct ft_cxt *
 	/* cast is to shut gcc up; we know nextra >= 0 */
 	if (tot < (unsigned int)nextra) {
 		/* have to reallocate */
-		char *newp, *oldp, *new_start;
+		char *newp, *new_start;
 		int shift;
 
 		if (!cxt->realloc)
@@ -291,21 +292,18 @@ static int ft_make_space(struct ft_cxt *
 		if (!newp)
 			return 0;
 		cxt->max_size = size;
-		oldp = (char *)cxt->bph;
-		shift = newp - oldp;
+		shift = newp - (char *)cxt->bph;
 
-		if (shift != 0) {	/* realloc can return same addr */
+		if (shift) { /* realloc can return same addr */
 			cxt->bph = (struct boot_param_header *)newp;
-			memmove(newp, oldp, sizeof(struct boot_param_header));
 			ft_node_update_after(cxt, cxt->rgn[FT_STRUCT].start,
 					shift);
-			for (r = FT_RSVMAP; r <= FT_STRUCT; ++r) {
+			for (r = FT_RSVMAP; r <= FT_STRINGS; ++r) {
 				new_start = cxt->rgn[r].start + shift;
-				memmove(new_start, cxt->rgn[r].start,
-					cxt->rgn[r].size);
 				cxt->rgn[r].start = new_start;
 			}
 			*pp += shift;
+			cxt->str_anchor += shift;
 		}
 
 		/* move strings up to the end */
@@ -561,7 +559,10 @@ int ft_open(struct ft_cxt *cxt, void *bl
 	cxt->rgn[FT_STRUCT].size = struct_size(cxt);
 	cxt->rgn[FT_STRINGS].start = blob + be32_to_cpu(bph->off_dt_strings);
 	cxt->rgn[FT_STRINGS].size = be32_to_cpu(bph->dt_strings_size);
+	/* Leave as '0' to force first ft_make_space call to do a ft_reorder
+	 * and move dt to an area allocated by realloc.
 	cxt->isordered = ft_ordered(cxt);
+	*/
 
 	cxt->p = cxt->rgn[FT_STRUCT].start;
 	cxt->str_anchor = cxt->rgn[FT_STRINGS].start;
@@ -597,13 +598,16 @@ void ft_end_tree(struct ft_cxt *cxt)
 	struct boot_param_header *bph = cxt->bph;
 	char *p, *oldstr, *str, *endp;
 	unsigned long ssize;
+	int adj;
 
 	if (!cxt->isordered)
 		return;		/* we haven't touched anything */
 
 	/* adjust string offsets */
 	oldstr = cxt->rgn[FT_STRINGS].start;
-	adjust_string_offsets(cxt, cxt->str_anchor - oldstr);
+	adj = cxt->str_anchor - oldstr;
+	if (adj)
+		adjust_string_offsets(cxt, adj);
 
 	/* make strings end on 8-byte boundary */
 	ssize = cxt->rgn[FT_STRINGS].size;
