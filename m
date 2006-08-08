Return-Path: <msm@freescale.com>
Subject: Re: [RFC] consolidated libdt proposal
From: Matthew McClintock <msm@freescale.com>
To: Hollis Blanchard <hollisb@us.ibm.com>
In-Reply-To: <1155062792.5572.5.camel@localhost>
References: <20060719230544.GD3887@mag.az.mvista.com>
	<1154911082.27074.104.camel@diesel>
	<1154987921.24455.32.camel@basalt.austin.ibm.com>
	<1155062792.5572.5.camel@localhost>
Content-Type: text/plain
Date: Tue, 08 Aug 2006 14:12:50 -0500
Message-Id: <1155064370.5572.11.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Pantelis Antoniou <pantelis@embeddedalley.com>,
	"xen-ppc-devel@lists.xensource.com" <xen-ppc-devel@lists.xensource.com>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a patch to u-boot with the changes.

* Patch to modify ft_build.c to update flat device trees in place
  Patch by Matthew McClintock 26-June-2006

Signed-off-by: Matthew McClintock <msm@freescale.com>
---
 common/cmd_bootm.c |    2 
 common/ft_build.c  |  341
++++++++++++++++------------------------------------
 include/ft_build.h |   19 ++-
 3 files changed, 115 insertions(+), 247 deletions(-)

diff --git a/common/cmd_bootm.c b/common/cmd_bootm.c
index a472a1d..f1c0eb4 100644
--- a/common/cmd_bootm.c
+++ b/common/cmd_bootm.c
@@ -836,7 +836,7 @@ #endif
 	(*kernel) (kbd, initrd_start, initrd_end, cmd_start, cmd_end);
 
 #else
-	ft_setup(of_flat_tree, OF_FLAT_TREE_MAX_SIZE, kbd, initrd_start,
initrd_end);
+	ft_setup(of_flat_tree, kbd, initrd_start, initrd_end);
 	/* ft_dump_blob(of_flat_tree); */
 
 #if defined(CFG_INIT_RAM_LOCK) && !defined(CONFIG_E500)
diff --git a/common/ft_build.c b/common/ft_build.c
index 9e9c906..b5a997c 100644
--- a/common/ft_build.c
+++ b/common/ft_build.c
@@ -1,5 +1,22 @@
 /*
  * OF flat tree builder
+ * Written by: Pantelis Antoniou <pantelis.antoniou@gmail.com>
+ * Updated by: Matthew McClintock <msm@freescale.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
+ * MA 02111-1307 USA
  */
 
 #include <common.h>
@@ -13,44 +30,39 @@ #include <stddef.h>
 
 #include <ft_build.h>
 
+#undef DEBUG
+
 /* align addr on a size boundary - adjust address up if needed -- Cort
*/
 #define _ALIGN(addr,size)       (((addr)+(size)-1)&(~((size)-1)))
+#ifndef CONFIG_OF_BOOT_CPU
+#define CONFIG_OF_BOOT_CPU 0
+#endif
+#define SIZE_OF_RSVMAP_ENTRY (2*sizeof(u64))
 
 static void ft_put_word(struct ft_cxt *cxt, u32 v)
 {
-	if (cxt->overflow)	/* do nothing */
-		return;
-
-	/* check for overflow */
-	if (cxt->p + 4 > cxt->pstr) {
-		cxt->overflow = 1;
-		return;
-	}
+	memmove(cxt->p + sizeof(u32), cxt->p, cxt->p_end - cxt->p);
 
 	*(u32 *) cxt->p = cpu_to_be32(v);
-	cxt->p += 4;
+	cxt->p += sizeof(u32);
+	cxt->p_end += sizeof(u32);
 }
 
 static inline void ft_put_bin(struct ft_cxt *cxt, const void *data, int
sz)
 {
-	u8 *p;
+	int aligned_size = ((u8 *)_ALIGN((unsigned long)cxt->p + sz,
+					sizeof(u32))) - cxt->p;
 
-	if (cxt->overflow)	/* do nothing */
-		return;
-
-	/* next pointer pos */
-	p = (u8 *) _ALIGN((unsigned long)cxt->p + sz, 4);
+	memmove(cxt->p + aligned_size, cxt->p, cxt->p_end - cxt->p);
 
-	/* check for overflow */
-	if (p > cxt->pstr) {
-		cxt->overflow = 1;
-		return;
-	}
+	/* make sure the last bytes are zeroed */
+	memset(cxt->p + aligned_size - (aligned_size % sizeof(u32)), 0,
+			(aligned_size % sizeof(u32)));
 
 	memcpy(cxt->p, data, sz);
-	if ((sz & 3) != 0)
-		memset(cxt->p + sz, 0, 4 - (sz & 3));
-	cxt->p = p;
+
+	cxt->p += aligned_size;
+	cxt->p_end += aligned_size;
 }
 
 void ft_begin_node(struct ft_cxt *cxt, const char *name)
@@ -73,10 +85,10 @@ static int lookup_string(struct ft_cxt *
 {
 	u8 *p;
 
-	p = cxt->pstr;
-	while (p < cxt->pstr_begin) {
+	p = cxt->p;
+	while (p < cxt->p_end) {
 		if (strcmp(p, name) == 0)
-			return p - cxt->p_begin;
+			return p - cxt->p;
 		p += strlen(p) + 1;
 	}
 
@@ -85,24 +97,13 @@ static int lookup_string(struct ft_cxt *
 
 void ft_prop(struct ft_cxt *cxt, const char *name, const void *data,
int sz)
 {
-	int len, off;
-
-	if (cxt->overflow)
-		return;
-
-	len = strlen(name) + 1;
+	int off = 0;
 
 	off = lookup_string(cxt, name);
 	if (off == -1) {
-		/* check if we have space */
-		if (cxt->p + 12 + sz + len > cxt->pstr) {
-			cxt->overflow = 1;
-			return;
-		}
-
-		cxt->pstr -= len;
-		memcpy(cxt->pstr, name, len);
-		off = cxt->pstr - cxt->p_begin;
+		memcpy(cxt->p_end, name, strlen(name) + 1);
+		off = cxt->p_end - cxt->p;
+		cxt->p_end += strlen(name) + 2;
 	}
 
 	/* now put offset from beginning of *STRUCTURE* */
@@ -122,138 +123,63 @@ void ft_prop_int(struct ft_cxt *cxt, con
 {
 	u32 v = cpu_to_be32((u32) val);
 
-	ft_prop(cxt, name, &v, 4);
+	ft_prop(cxt, name, &v, sizeof(u32));
 }
 
-/* start construction of the flat OF tree */
-void ft_begin(struct ft_cxt *cxt, void *blob, int max_size)
+/* pick up and start working on a tree in place */
+void ft_init_cxt(struct ft_cxt *cxt, void *blob)
 {
 	struct boot_param_header *bph = blob;
-	u32 off;
 
-	/* clear the cxt */
 	memset(cxt, 0, sizeof(*cxt));
 
 	cxt->bph = bph;
-	cxt->max_size = max_size;
-
-	/* zero everything in the header area */
-	memset(bph, 0, sizeof(*bph));
-
-	bph->magic = cpu_to_be32(OF_DT_HEADER);
-	bph->version = cpu_to_be32(0x10);
-	bph->last_comp_version = cpu_to_be32(0x10);
+	bph->boot_cpuid_phys = CONFIG_OF_BOOT_CPU;
 
-	/* start pointers */
-	cxt->pres_begin = (u8 *) _ALIGN((unsigned long)(bph + 1), 8);
-	cxt->pres = cxt->pres_begin;
-
-	off = (unsigned long)cxt->pres_begin - (unsigned long)bph;
-	bph->off_mem_rsvmap = cpu_to_be32(off);
-
-	((u64 *) cxt->pres)[0] = 0;	/* phys = 0, size = 0, terminate */
-	((u64 *) cxt->pres)[1] = 0;
+	/* find beginning and end of reserve map table (zeros in last entry)
*/
+	cxt->p_rsvmap = (u8 *)bph + bph->off_mem_rsvmap;
+	while ( ((uint64_t *)cxt->p_rsvmap)[0] != 0 &&
+		     ((uint64_t *)cxt->p_rsvmap)[1] != 0 ) {
+	cxt->p_rsvmap += SIZE_OF_RSVMAP_ENTRY;
+	}
 
-	cxt->p_anchor = cxt->pres + 16;	/* over the terminator */
+	cxt->p_start = (char*)bph + bph->off_dt_struct;
+	cxt->p_end = (char *)bph + bph->totalsize;
+	cxt->p = (char *)bph + bph->off_dt_strings;
 }
 
 /* add a reserver physical area to the rsvmap */
-void ft_add_rsvmap(struct ft_cxt *cxt, u64 physaddr, u64 size)
+void ft_add_rsvmap(struct ft_cxt *cxt, u64 physstart, u64 physend)
 {
-	((u64 *) cxt->pres)[0] = cpu_to_be64(physaddr);	/* phys = 0, size = 0,
terminate */
-	((u64 *) cxt->pres)[1] = cpu_to_be64(size);
-
-	cxt->pres += 16;	/* advance */
-
-	((u64 *) cxt->pres)[0] = 0;	/* phys = 0, size = 0, terminate */
-	((u64 *) cxt->pres)[1] = 0;
-
-	/* keep track of size */
-	cxt->res_size = cxt->pres + 16 - cxt->pres_begin;
-
-	cxt->p_anchor = cxt->pres + 16;	/* over the terminator */
+	memmove(cxt->p_rsvmap + SIZE_OF_RSVMAP_ENTRY, cxt->p_rsvmap,
+				 cxt->p_end - cxt->p_rsvmap);
+
+	((u64 *)cxt->p_rsvmap)[0] = cpu_to_be64(physstart);
+	((u64 *)cxt->p_rsvmap)[1] = cpu_to_be64(physend);
+	((u64 *)cxt->p_rsvmap)[2] = 0;
+	((u64 *)cxt->p_rsvmap)[3] = 0;
+
+	cxt->p_rsvmap += SIZE_OF_RSVMAP_ENTRY;
+	cxt->p_start += SIZE_OF_RSVMAP_ENTRY;
+	cxt->p += SIZE_OF_RSVMAP_ENTRY;
+	cxt->p_end += SIZE_OF_RSVMAP_ENTRY;
 }
 
-void ft_begin_tree(struct ft_cxt *cxt)
+void ft_end_tree(struct ft_cxt *cxt)
 {
-	cxt->p_begin = cxt->p_anchor;
-	cxt->pstr_begin = (char *)cxt->bph + cxt->max_size;	/* point at the
end */
-
-	cxt->p = cxt->p_begin;
-	cxt->pstr = cxt->pstr_begin;
+	ft_put_word(cxt, OF_DT_END);
 }
 
-int ft_end_tree(struct ft_cxt *cxt)
-{
+/* update the boot param header with correct values */
+void ft_finalize_tree(struct ft_cxt *cxt) {
 	struct boot_param_header *bph = cxt->bph;
-	int off, sz, sz1;
-	u32 tag, v;
-	u8 *p;
-
-	ft_put_word(cxt, OF_DT_END);
-
-	if (cxt->overflow)
-		return -ENOMEM;
-
-	/* size of the areas */
-	cxt->struct_size = cxt->p - cxt->p_begin;
-	cxt->strings_size = cxt->pstr_begin - cxt->pstr;
-
-	/* the offset we must move */
-	off = (cxt->pstr_begin - cxt->p_begin) - cxt->strings_size;
-
-	/* the new strings start */
-	cxt->pstr_begin = cxt->p_begin + cxt->struct_size;
-
-	/* move the whole string area */
-	memmove(cxt->pstr_begin, cxt->pstr, cxt->strings_size);
 
-	/* now perform the fixup of the strings */
-	p = cxt->p_begin;
-	while ((tag = be32_to_cpu(*(u32 *) p)) != OF_DT_END) {
-		p += 4;
-
-		if (tag == OF_DT_BEGIN_NODE) {
-			p = (u8 *) _ALIGN((unsigned long)p + strlen(p) + 1, 4);
-			continue;
-		}
-
-		if (tag == OF_DT_END_NODE || tag == OF_DT_NOP)
-			continue;
-
-		if (tag != OF_DT_PROP)
-			return -EINVAL;
-
-		sz = be32_to_cpu(*(u32 *) p);
-		p += 4;
-
-		v = be32_to_cpu(*(u32 *) p);
-		v -= off;
-		*(u32 *) p = cpu_to_be32(v);	/* move down */
-		p += 4;
-
-		p = (u8 *) _ALIGN((unsigned long)p + sz, 4);
-	}
-
-	/* fix sizes */
-	p = (char *)cxt->bph;
-	sz = (cxt->pstr_begin + cxt->strings_size) - p;
-	sz1 = _ALIGN(sz, 16);	/* align at 16 bytes */
-	if (sz != sz1)
-		memset(p + sz, 0, sz1 - sz);
-	bph->totalsize = cpu_to_be32(sz1);
-	bph->off_dt_struct = cpu_to_be32(cxt->p_begin - p);
-	bph->off_dt_strings = cpu_to_be32(cxt->pstr_begin - p);
-
-	/* the new strings start */
-	cxt->pstr_begin = cxt->p_begin + cxt->struct_size;
-	cxt->pstr = cxt->pstr_begin + cxt->strings_size;
-
-	return 0;
+	bph->totalsize = cxt->p_end - (u8 *)bph;
+	bph->off_dt_struct = cxt->p_start - (u8 *)bph;
+	bph->off_dt_strings = cxt->p - (u8 *)bph;
+	bph->dt_strings_size = cxt->p_end - cxt->p;
 }
 
-/**********************************************************************/
-
 static inline int isprint(int c)
 {
 	return c >= 0x20 && c <= 0x7e;
@@ -299,16 +225,16 @@ static void print_data(const void *data,
 
 	switch (len) {
 	case 1:		/* byte */
-		printf(" = <0x%02x>", (*(u8 *) data) & 0xff);
+		printf(" = <%02x>", (*(u8 *) data) & 0xff);
 		break;
 	case 2:		/* half-word */
-		printf(" = <0x%04x>", be16_to_cpu(*(u16 *) data) & 0xffff);
+		printf(" = <%04x>", be16_to_cpu(*(u16 *) data) & 0xffff);
 		break;
 	case 4:		/* word */
-		printf(" = <0x%08x>", be32_to_cpu(*(u32 *) data) & 0xffffffffU);
+		printf(" = <%x>", be32_to_cpu(*(u32 *) data) & 0xffffffffU);
 		break;
 	case 8:		/* double-word */
-		printf(" = <0x%16llx>", be64_to_cpu(*(uint64_t *) data));
+		printf(" = <%qx>", be64_to_cpu(*(uint64_t *) data));
 		break;
 	default:		/* anything else... hexdump */
 		printf(" = [");
@@ -350,7 +276,7 @@ void ft_dump_blob(const void *bphp)
 		if (addr == 0 && size == 0)
 			break;
 
-		printf("/memreserve/ 0x%llx 0x%llx;\n", addr, size);
+		printf("/memreserve/ %qx %qx;\n", addr, size);
 	}
 
 	p = p_struct;
@@ -381,8 +307,8 @@ void ft_dump_blob(const void *bphp)
 		}
 
 		if (tag != OF_DT_PROP) {
-			fprintf(stderr, "%*s ** Unknown tag 0x%08x\n",
-				depth * shift, "", tag);
+			fprintf(stderr, "%*s ** Unknown tag 0x%08x at 0x%x\n",
+				depth * shift, "", tag, --p);
 			break;
 		}
 		sz = be32_to_cpu(*p++);
@@ -397,64 +323,15 @@ void ft_dump_blob(const void *bphp)
 
 void ft_backtrack_node(struct ft_cxt *cxt)
 {
-	if (be32_to_cpu(*(u32 *) (cxt->p - 4)) != OF_DT_END_NODE)
-		return;		/* XXX only for node */
-
-	cxt->p -= 4;
-}
-
-/* note that the root node of the blob is "peeled" off */
-void ft_merge_blob(struct ft_cxt *cxt, void *blob)
-{
-	struct boot_param_header *bph = (struct boot_param_header *)blob;
-	u32 *p_struct = (u32 *) ((char *)bph +
be32_to_cpu(bph->off_dt_struct));
-	u32 *p_strings =
-	    (u32 *) ((char *)bph + be32_to_cpu(bph->off_dt_strings));
-	u32 tag, *p;
-	char *s, *t;
-	int depth, sz;
-
-	if (be32_to_cpu(*(u32 *) (cxt->p - 4)) != OF_DT_END_NODE)
-		return;		/* XXX only for node */
-
-	cxt->p -= 4;
-
-	depth = 0;
-	p = p_struct;
-	while ((tag = be32_to_cpu(*p++)) != OF_DT_END) {
-
-		/* printf("tag: 0x%08x (%d) - %d\n", tag, p - p_struct, depth); */
-
-		if (tag == OF_DT_BEGIN_NODE) {
-			s = (char *)p;
-			p = (u32 *) _ALIGN((unsigned long)p + strlen(s) + 1, 4);
-
-			if (depth++ > 0)
-				ft_begin_node(cxt, s);
-
-			continue;
-		}
-
-		if (tag == OF_DT_END_NODE) {
-			ft_end_node(cxt);
-			if (--depth == 0)
-				break;
-			continue;
-		}
-
-		if (tag == OF_DT_NOP)
-			continue;
+	int i = 4;
 
-		if (tag != OF_DT_PROP)
-			break;
+	while (be32_to_cpu(*(u32 *) (cxt->p - i)) != OF_DT_END_NODE)
+		i += 4;
 
-		sz = be32_to_cpu(*p++);
-		s = (char *)p_strings + be32_to_cpu(*p++);
-		t = (char *)p;
-		p = (u32 *) _ALIGN((unsigned long)p + sz, 4);
+	memmove (cxt->p - i, cxt->p, cxt->p_end - cxt->p);
 
-		ft_prop(cxt, s, t, sz);
-	}
+	cxt->p_end -= i;
+	cxt->p -= i;
 }
 
 void *ft_get_prop(void *bphp, const char *propname, int *szp)
@@ -521,9 +398,6 @@ void *ft_get_prop(void *bphp, const char
 
 /********************************************************************/
 
-extern unsigned char oftree_dtb[];
-extern unsigned int oftree_dtb_len;
-
 /* Function that returns a character from the environment */
 extern uchar(*env_get_char) (int);
 
@@ -577,7 +451,7 @@ #endif
 };
 #endif
 
-void ft_setup(void *blob, int size, bd_t * bd, ulong initrd_start,
ulong initrd_end)
+void ft_setup(void *blob, bd_t * bd, ulong initrd_start, ulong
initrd_end)
 {
 	u32 *p;
 	int len;
@@ -600,20 +474,16 @@ #endif
 		return;
 	}
 
-	ft_begin(&cxt, blob, size);
+#ifdef DEBUG
+	printf ("recieved oftree\n");
+	ft_dump_blob(blob);
+#endif
+
+	ft_init_cxt(&cxt, blob);
 
 	if (initrd_start && initrd_end)
 		ft_add_rsvmap(&cxt, initrd_start, initrd_end - initrd_start + 1);
 
-	ft_begin_tree(&cxt);
-
-	ft_begin_node(&cxt, "");
-
-	ft_end_node(&cxt);
-
-	/* copy RO tree */
-	ft_merge_blob(&cxt, oftree_dtb);
-
 	/* back into root */
 	ft_backtrack_node(&cxt);
 
@@ -642,8 +512,8 @@ #ifdef CONFIG_OF_HAS_UBOOT_ENV
 #endif
 
 	ft_begin_node(&cxt, "chosen");
-
 	ft_prop_str(&cxt, "name", "chosen");
+
 	ft_prop_str(&cxt, "bootargs", getenv("bootargs"));
 	ft_prop_int(&cxt, "linux,platform", 0x600);	/* what is this? */
 	if (initrd_start && initrd_end) {
@@ -659,11 +529,7 @@ #endif
 	ft_end_node(&cxt);	/* end root */
 
 	ft_end_tree(&cxt);
-
-	/*
-	   printf("merged OF-tree\n");
-	   ft_dump_blob(blob);
-	 */
+	ft_finalize_tree(&cxt);
 
 #ifdef CONFIG_OF_HAS_BD_T
 	/* paste the bd_t at the end of the flat tree */
@@ -712,11 +578,12 @@ #ifdef CONFIG_OF_BOARD_SETUP
 	ft_board_setup(blob, bd);
 #endif
 
-	/*
-	   printf("final OF-tree\n");
-	   ft_dump_blob(blob);
-	 */
+	/* in case the size changed in the platform code */
+	ft_finalize_tree(&cxt);
 
+#ifdef DEBUG
+	printf("final OF-tree\n");
+	ft_dump_blob(blob);
+#endif
 }
-
 #endif
diff --git a/include/ft_build.h b/include/ft_build.h
index 47ca575..f515687 100644
--- a/include/ft_build.h
+++ b/include/ft_build.h
@@ -36,19 +36,18 @@ struct boot_param_header {
 
 struct ft_cxt {
 	struct boot_param_header *bph;
-	int max_size;		/* maximum size of tree */
-	int overflow;		/* set when this happens */
-	u8 *p, *pstr, *pres;	/* running pointers */
-	u8 *p_begin, *pstr_begin, *pres_begin;	/* starting pointers */
-	u8 *p_anchor;		/* start of constructed area */
-	int struct_size, strings_size, res_size;
+	u8 *p_rsvmap;
+	u8 *p_start;  /* pointer to beginning of dt_struct */
+	u8 *p_end; /* pointer to end of dt_strings */
+	u8 *p; /* pointer to end of dt_struct and beginning of dt_strings */
 };
 
 void ft_begin_node(struct ft_cxt *cxt, const char *name);
+void ft_init_cxt(struct ft_cxt *cxt, void *blob);
 void ft_end_node(struct ft_cxt *cxt);
 
-void ft_begin_tree(struct ft_cxt *cxt);
-int ft_end_tree(struct ft_cxt *cxt);
+void ft_end_tree(struct ft_cxt *cxt);
+void ft_finalize_tree(struct ft_cxt *cxt);
 
 void ft_nop(struct ft_cxt *cxt);
 void ft_prop(struct ft_cxt *cxt, const char *name, const void *data,
int sz);
@@ -57,12 +56,14 @@ void ft_prop_int(struct ft_cxt *cxt, con
 void ft_begin(struct ft_cxt *cxt, void *blob, int max_size);
 void ft_add_rsvmap(struct ft_cxt *cxt, u64 physaddr, u64 size);
 
-void ft_setup(void *blob, int size, bd_t * bd, ulong initrd_start,
ulong initrd_end);
+void ft_setup(void *blob, bd_t * bd, ulong initrd_start, ulong
initrd_end);
 
 void ft_dump_blob(const void *bphp);
 void ft_merge_blob(struct ft_cxt *cxt, void *blob);
 void *ft_get_prop(void *bphp, const char *propname, int *szp);
 
+#ifdef CONFIG_OF_BOARD_SETUP
 void ft_board_setup(void *blob, bd_t *bd);
+#endif
 
 #endif
-- 
2006_06_07.01.gittree_pull-dirty
