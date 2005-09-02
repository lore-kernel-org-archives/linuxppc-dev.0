Return-Path: <pantelis.antoniou@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.204])
	by ozlabs.org (Postfix) with ESMTP id 14C606818E
	for <linuxppc-dev@ozlabs.org>; Sat,  3 Sep 2005 01:20:55 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id i11so532751wra
	for <linuxppc-dev@ozlabs.org>; Fri, 02 Sep 2005 08:20:53 -0700 (PDT)
From: Pantelis Antoniou <pantelis.antoniou@gmail.com>
To: Wolfgang Denk <wd@denx.de>, u-boot-users@lists.sourceforge.net,
	linuxppc-embedded@ozlabs.org, linuxppc-dev@ozlabs.org
Date: Fri, 2 Sep 2005 18:14:07 +0300
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_/wGGDZ67YEIC0t0"
Message-Id: <200509021814.08001.pantelis.antoniou@gmail.com>
Subject: [PATCH] Add Flat OF tree support.
Reply-To: pantelis.antoniou@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Boundary-00=_/wGGDZ67YEIC0t0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all.

As you well know, as part of the ongoing cleanup of the linux trees
regarding PPC, it has been decreed that the preferred way to pass 
bootloader information shall be the flat OF tree.

  http://ozlabs.org/pipermail/linuxppc-dev/2005-August/019408.html
  http://ozlabs.org/pipermail/linuxppc-dev/2005-August/019362.html

The following patch (broken in two parts), implements just that.

Please be aware that in order to test it, you'll need a fairly recent
dtc tool, which is available by git at

  rsync://ozlabs.org/dtc/dtc.git

The xxd binary dumper is needed too which I got from

  ftp://ftp.uni-erlangen.de/pub/utilities/etc/xxd-1.10.tar.gz

Linux patches will follow...

Awaiting comments.

Regards

Pantelis

P.S. Sorry for cross-posting, but it seems to be appropriate at this time.

--Boundary-00=_/wGGDZ67YEIC0t0
Content-Type: text/plain;
  charset="us-ascii";
  name="of-uboot-base.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="of-uboot-base.patch"

diff --git a/common/Makefile b/common/Makefile
--- a/common/Makefile
+++ b/common/Makefile
@@ -51,7 +51,7 @@ COBJS	= main.o ACEX1K.o altera.o bedbug.
 	  memsize.o miiphybb.o miiphyutil.o \
 	  s_record.o serial.o soft_i2c.o soft_spi.o spartan2.o \
 	  usb.o usb_kbd.o usb_storage.o \
-	  virtex2.o xilinx.o
+	  virtex2.o xilinx.o ft_build.o
 
 OBJS	= $(AOBJS) $(COBJS)
 
diff --git a/common/cmd_bootm.c b/common/cmd_bootm.c
--- a/common/cmd_bootm.c
+++ b/common/cmd_bootm.c
@@ -34,6 +34,10 @@
 #include <environment.h>
 #include <asm/byteorder.h>
 
+#ifdef CONFIG_OF_FLAT_TREE
+#include <ft_build.h>
+#endif
+
  /*cmd_boot.c*/
  extern int do_reset (cmd_tbl_t *cmdtp, int flag, int argc, char *argv[]);
 
@@ -487,6 +491,9 @@ fixup_silent_linux ()
 }
 #endif /* CONFIG_SILENT_CONSOLE */
 
+extern const unsigned char oftree_dtb[];
+extern const unsigned int oftree_dtb_len;
+
 #ifdef CONFIG_PPC
 static void
 do_bootm_linux (cmd_tbl_t *cmdtp, int flag,
@@ -509,6 +516,9 @@ do_bootm_linux (cmd_tbl_t *cmdtp, int fl
 	bd_t	*kbd;
 	void	(*kernel)(bd_t *, ulong, ulong, ulong, ulong);
 	image_header_t *hdr = &header;
+#ifdef CONFIG_OF_FLAT_TREE
+	char	*of_flat_tree;
+#endif
 
 	if ((s = getenv ("initrd_high")) != NULL) {
 		/* a value of "no" or a similar string will act like 0,
@@ -773,16 +783,24 @@ do_bootm_linux (cmd_tbl_t *cmdtp, int fl
 		initrd_start = 0;
 		initrd_end = 0;
 	}
-
+#ifdef CONFIG_OF_FLAT_TREE
+	if (initrd_start == 0)
+		of_flat_tree = (char *)(((ulong)kbd - OF_FLAT_TREE_MAX_SIZE) & ~0xF);
+	else
+		of_flat_tree = (char *)((initrd_start - OF_FLAT_TREE_MAX_SIZE) & ~0xF);
+#endif
 
 	debug ("## Transferring control to Linux (at address %08lx) ...\n",
 		(ulong)kernel);
 
 	SHOW_BOOT_PROGRESS (15);
 
+#ifndef CONFIG_OF_FLAT_TREE
+
 #if defined(CFG_INIT_RAM_LOCK) && !defined(CONFIG_E500)
 	unlock_ram_in_cache();
 #endif
+
 	/*
 	 * Linux Kernel Parameters:
 	 *   r3: ptr to board info data
@@ -792,6 +810,25 @@ do_bootm_linux (cmd_tbl_t *cmdtp, int fl
 	 *   r7: End   of command line string
 	 */
 	(*kernel) (kbd, initrd_start, initrd_end, cmd_start, cmd_end);
+#else
+
+	ft_setup(of_flat_tree, OF_FLAT_TREE_MAX_SIZE, kbd);
+	/* ft_dump_blob(of_flat_tree); */
+
+#if defined(CFG_INIT_RAM_LOCK) && !defined(CONFIG_E500)
+	unlock_ram_in_cache();
+#endif
+	/*
+	 * Linux Kernel Parameters:
+	 *   r3: ptr to board info data
+	 *   r4: initrd_start or 0 if no initrd
+	 *   r5: initrd_end - unused if r4 is 0
+	 *   r6: Start of command line string
+	 *   r7: End   of command line string
+	 */
+	(*kernel) ((bd_t *)of_flat_tree, initrd_start, initrd_end, cmd_start, cmd_end);
+
+#endif
 }
 #endif /* CONFIG_PPC */
 
diff --git a/common/ft_build.c b/common/ft_build.c
new file mode 100644
--- /dev/null
+++ b/common/ft_build.c
@@ -0,0 +1,751 @@
+/*
+ * OF flat tree builder
+ */
+
+#include <common.h>
+#include <malloc.h>
+#include <environment.h>
+
+#include <asm/errno.h>
+
+#include <ft_build.h>
+
+#ifdef CONFIG_OF_FLAT_TREE
+
+/* align addr on a size boundary - adjust address up if needed -- Cort */
+#define _ALIGN(addr,size)       (((addr)+(size)-1)&(~((size)-1)))
+
+static void ft_put_word(struct ft_cxt *cxt, u32 v)
+{
+	if (cxt->overflow)	/* do nothing */
+		return;
+
+	/* check for overflow */
+	if (cxt->p + 4 > cxt->pstr) {
+		cxt->overflow = 1;
+		return;
+	}
+
+	*(u32 *) cxt->p = cpu_to_be32(v);
+	cxt->p += 4;
+}
+
+static inline void ft_put_bin(struct ft_cxt *cxt, const void *data, int sz)
+{
+	u8 *p;
+
+	if (cxt->overflow)	/* do nothing */
+		return;
+
+	/* next pointer pos */
+	p = (u8 *) _ALIGN((unsigned long)cxt->p + sz, 4);
+
+	/* check for overflow */
+	if (p > cxt->pstr) {
+		cxt->overflow = 1;
+		return;
+	}
+
+	memcpy(cxt->p, data, sz);
+	if ((sz & 3) != 0)
+		memset(cxt->p + sz, 0, 4 - (sz & 3));
+	cxt->p = p;
+}
+
+void ft_begin_node(struct ft_cxt *cxt, const char *name)
+{
+	ft_put_word(cxt, OF_DT_BEGIN_NODE);
+	ft_put_bin(cxt, name, strlen(name) + 1);
+}
+
+void ft_end_node(struct ft_cxt *cxt)
+{
+	ft_put_word(cxt, OF_DT_END_NODE);
+}
+
+void ft_nop(struct ft_cxt *cxt)
+{
+	ft_put_word(cxt, OF_DT_NOP);
+}
+
+static int lookup_string(struct ft_cxt *cxt, const char *name)
+{
+	u8 *p;
+
+	p = cxt->pstr;
+	while (p < cxt->pstr_begin) {
+		if (strcmp(p, name) == 0)
+			return p - cxt->p_begin;
+		p += strlen(p) + 1;
+	}
+
+	return -1;
+}
+
+void ft_prop(struct ft_cxt *cxt, const char *name, const void *data, int sz)
+{
+	int len, off;
+
+	if (cxt->overflow)
+		return;
+
+	len = strlen(name) + 1;
+
+	off = lookup_string(cxt, name);
+	if (off == -1) {
+		/* check if we have space */
+		if (cxt->p + 12 + sz + len > cxt->pstr) {
+			cxt->overflow = 1;
+			return;
+		}
+
+		cxt->pstr -= len;
+		memcpy(cxt->pstr, name, len);
+		off = cxt->pstr - cxt->p_begin;
+	}
+
+	/* now put offset from beginning of *STRUCTURE* */
+	/* will be fixed up at the end */
+	ft_put_word(cxt, OF_DT_PROP);
+	ft_put_word(cxt, sz);
+	ft_put_word(cxt, off);
+	ft_put_bin(cxt, data, sz);
+}
+
+void ft_prop_str(struct ft_cxt *cxt, const char *name, const char *str)
+{
+	ft_prop(cxt, name, str, strlen(str) + 1);
+}
+
+void ft_prop_int(struct ft_cxt *cxt, const char *name, int val)
+{
+	u32 v = cpu_to_be32((u32) val);
+
+	ft_prop(cxt, name, &v, 4);
+}
+
+/* start construction of the flat OF tree */
+void ft_begin(struct ft_cxt *cxt, void *blob, int max_size)
+{
+	struct boot_param_header *bph = blob;
+	u32 off;
+
+	/* clear the cxt */
+	memset(cxt, 0, sizeof(*cxt));
+
+	cxt->bph = bph;
+	cxt->max_size = max_size;
+
+	/* zero everything in the header area */
+	memset(bph, 0, sizeof(*bph));
+
+	bph->magic = cpu_to_be32(OF_DT_HEADER);
+	bph->version = cpu_to_be32(0x10);
+	bph->last_comp_version = cpu_to_be32(0x10);
+
+	/* start pointers */
+	cxt->pres_begin = (u8 *) _ALIGN((unsigned long)(bph + 1), 8);
+	cxt->pres = cxt->pres_begin;
+
+	off = (unsigned long)cxt->pres_begin - (unsigned long)bph;
+	bph->off_mem_rsvmap = cpu_to_be32(off);
+
+	((u64 *) cxt->pres)[0] = 0;	/* phys = 0, size = 0, terminate */
+	((u64 *) cxt->pres)[1] = 0;
+
+	cxt->p_anchor = cxt->pres + 16;	/* over the terminator */
+}
+
+/* add a reserver physical area to the rsvmap */
+void ft_add_rsvmap(struct ft_cxt *cxt, u64 physaddr, u64 size)
+{
+	((u64 *) cxt->pres)[0] = cpu_to_be64(physaddr);	/* phys = 0, size = 0, terminate */
+	((u64 *) cxt->pres)[1] = cpu_to_be64(size);
+
+	cxt->pres += 18;	/* advance */
+
+	((u64 *) cxt->pres)[0] = 0;	/* phys = 0, size = 0, terminate */
+	((u64 *) cxt->pres)[1] = 0;
+
+	/* keep track of size */
+	cxt->res_size = cxt->pres + 16 - cxt->pres_begin;
+
+	cxt->p_anchor = cxt->pres + 16;	/* over the terminator */
+}
+
+void ft_begin_tree(struct ft_cxt *cxt)
+{
+	cxt->p_begin = cxt->p_anchor;
+	cxt->pstr_begin = (char *)cxt->bph + cxt->max_size;	/* point at the end */
+
+	cxt->p = cxt->p_begin;
+	cxt->pstr = cxt->pstr_begin;
+}
+
+int ft_end_tree(struct ft_cxt *cxt)
+{
+	struct boot_param_header *bph = cxt->bph;
+	int off, sz, sz1;
+	u32 tag, v;
+	u8 *p;
+
+	ft_put_word(cxt, OF_DT_END);
+
+	if (cxt->overflow)
+		return -ENOMEM;
+
+	/* size of the areas */
+	cxt->struct_size = cxt->p - cxt->p_begin;
+	cxt->strings_size = cxt->pstr_begin - cxt->pstr;
+
+	/* the offset we must move */
+	off = (cxt->pstr_begin - cxt->p_begin) - cxt->strings_size;
+
+	/* the new strings start */
+	cxt->pstr_begin = cxt->p_begin + cxt->struct_size;
+
+	/* move the whole string area */
+	memmove(cxt->pstr_begin, cxt->pstr, cxt->strings_size);
+
+	/* now perform the fixup of the strings */
+	p = cxt->p_begin;
+	while ((tag = be32_to_cpu(*(u32 *) p)) != OF_DT_END) {
+		p += 4;
+
+		if (tag == OF_DT_BEGIN_NODE) {
+			p = (u8 *) _ALIGN((unsigned long)p + strlen(p) + 1, 4);
+			continue;
+		}
+
+		if (tag == OF_DT_END_NODE || tag == OF_DT_NOP)
+			continue;
+
+		if (tag != OF_DT_PROP)
+			return -EINVAL;
+
+		sz = be32_to_cpu(*(u32 *) p);
+		p += 4;
+
+		v = be32_to_cpu(*(u32 *) p);
+		v -= off;
+		*(u32 *) p = cpu_to_be32(v);	/* move down */
+		p += 4;
+
+		p = (u8 *) _ALIGN((unsigned long)p + sz, 4);
+	}
+
+	/* fix sizes */
+	p = (char *)cxt->bph;
+	sz = (cxt->pstr_begin + cxt->strings_size) - p;
+	sz1 = _ALIGN(sz, 16);	/* align at 16 bytes */
+	if (sz != sz1)
+		memset(p + sz, 0, sz1 - sz);
+	bph->totalsize = cpu_to_be32(sz1);
+	bph->off_dt_struct = cpu_to_be32(cxt->p_begin - p);
+	bph->off_dt_strings = cpu_to_be32(cxt->pstr_begin - p);
+
+	/* the new strings start */
+	cxt->pstr_begin = cxt->p_begin + cxt->struct_size;
+	cxt->pstr = cxt->pstr_begin + cxt->strings_size;
+
+	return 0;
+}
+
+/**********************************************************************/
+
+static inline int isprint(int c)
+{
+	return c >= 0x20 && c <= 0x7e;
+}
+
+static int is_printable_string(const void *data, int len)
+{
+	const char *s = data;
+	const char *ss;
+
+	/* zero length is not */
+	if (len == 0)
+		return 0;
+
+	/* must terminate with zero */
+	if (s[len - 1] != '\0')
+		return 0;
+
+	ss = s;
+	while (*s && isprint(*s))
+		s++;
+
+	/* not zero, or not done yet */
+	if (*s != '\0' || (s + 1 - ss) < len)
+		return 0;
+
+	return 1;
+}
+
+static void print_data(const void *data, int len)
+{
+	int i;
+	const u8 *s;
+
+	/* no data, don't print */
+	if (len == 0)
+		return;
+
+	if (is_printable_string(data, len)) {
+		printf(" = \"%s\"", (char *)data);
+		return;
+	}
+
+	switch (len) {
+	case 1:		/* byte */
+		printf(" = <0x%02x>", (*(u8 *) data) & 0xff);
+		break;
+	case 2:		/* half-word */
+		printf(" = <0x%04x>", be16_to_cpu(*(u16 *) data) & 0xffff);
+		break;
+	case 4:		/* word */
+		printf(" = <0x%08x>", be32_to_cpu(*(u32 *) data) & 0xffffffffU);
+		break;
+	case 8:		/* double-word */
+		printf(" = <0x%16llx>", be64_to_cpu(*(uint64_t *) data));
+		break;
+	default:		/* anything else... hexdump */
+		printf(" = [");
+		for (i = 0, s = data; i < len; i++)
+			printf("%02x%s", s[i], i < len - 1 ? " " : "");
+		printf("]");
+
+		break;
+	}
+}
+
+void ft_dump_blob(const void *bphp)
+{
+	const struct boot_param_header *bph = bphp;
+	const uint64_t *p_rsvmap = (const uint64_t *)
+		((const char *)bph + be32_to_cpu(bph->off_mem_rsvmap));
+	const u32 *p_struct = (const u32 *)
+		((const char *)bph + be32_to_cpu(bph->off_dt_struct));
+	const u32 *p_strings = (const u32 *)
+		((const char *)bph + be32_to_cpu(bph->off_dt_strings));
+	u32 tag;
+	const u32 *p;
+	const char *s, *t;
+	int depth, sz, shift;
+	int i;
+	uint64_t addr, size;
+
+	depth = 0;
+	shift = 4;
+
+	for (i = 0;; i++) {
+		addr = be64_to_cpu(p_rsvmap[i * 2]);
+		size = be64_to_cpu(p_rsvmap[i * 2 + 1]);
+		if (addr == 0 && size == 0)
+			break;
+
+		printf("/memreserve/ 0x%llx 0x%llx;\n", addr, size);
+	}
+
+	p = p_struct;
+	while ((tag = be32_to_cpu(*p++)) != OF_DT_END) {
+
+		/* printf("tag: 0x%08x (%d)\n", tag, p - p_struct); */
+
+		if (tag == OF_DT_BEGIN_NODE) {
+			s = (const char *)p;
+			p = (u32 *) _ALIGN((unsigned long)p + strlen(s) + 1, 4);
+
+			printf("%*s%s {\n", depth * shift, "", s);
+
+			depth++;
+			continue;
+		}
+
+		if (tag == OF_DT_END_NODE) {
+			depth--;
+
+			printf("%*s};\n", depth * shift, "");
+			continue;
+		}
+
+		if (tag == OF_DT_NOP) {
+			printf("%*s[NOP]\n", depth * shift, "");
+			continue;
+		}
+
+		if (tag != OF_DT_PROP) {
+			fprintf(stderr, "%*s ** Unknown tag 0x%08x\n",
+				depth * shift, "", tag);
+			break;
+		}
+		sz = be32_to_cpu(*p++);
+		s = (const char *)p_strings + be32_to_cpu(*p++);
+		t = (const char *)p;
+		p = (const u32 *)_ALIGN((unsigned long)p + sz, 4);
+		printf("%*s%s", depth * shift, "", s);
+		print_data(t, sz);
+		printf(";\n");
+	}
+}
+
+void ft_backtrack_node(struct ft_cxt *cxt)
+{
+	if (be32_to_cpu(*(u32 *) (cxt->p - 4)) != OF_DT_END_NODE)
+		return;		/* XXX only for node */
+
+	cxt->p -= 4;
+}
+
+/* note that the root node of the blob is "peeled" off */
+void ft_merge_blob(struct ft_cxt *cxt, void *blob)
+{
+	struct boot_param_header *bph = (struct boot_param_header *)blob;
+	u32 *p_struct = (u32 *) ((char *)bph + be32_to_cpu(bph->off_dt_struct));
+	u32 *p_strings =
+	    (u32 *) ((char *)bph + be32_to_cpu(bph->off_dt_strings));
+	u32 tag, *p;
+	char *s, *t;
+	int depth, sz;
+
+	if (be32_to_cpu(*(u32 *) (cxt->p - 4)) != OF_DT_END_NODE)
+		return;		/* XXX only for node */
+
+	cxt->p -= 4;
+
+	depth = 0;
+	p = p_struct;
+	while ((tag = be32_to_cpu(*p++)) != OF_DT_END) {
+
+		/* printf("tag: 0x%08x (%d) - %d\n", tag, p - p_struct, depth); */
+
+		if (tag == OF_DT_BEGIN_NODE) {
+			s = (char *)p;
+			p = (u32 *) _ALIGN((unsigned long)p + strlen(s) + 1, 4);
+
+			if (depth++ > 0)
+				ft_begin_node(cxt, s);
+
+			continue;
+		}
+
+		if (tag == OF_DT_END_NODE) {
+			ft_end_node(cxt);
+			if (--depth == 0)
+				break;
+			continue;
+		}
+
+		if (tag == OF_DT_NOP)
+			continue;
+
+		if (tag != OF_DT_PROP)
+			break;
+
+		sz = be32_to_cpu(*p++);
+		s = (char *)p_strings + be32_to_cpu(*p++);
+		t = (char *)p;
+		p = (u32 *) _ALIGN((unsigned long)p + sz, 4);
+
+		ft_prop(cxt, s, t, sz);
+	}
+}
+
+void *ft_get_prop(void *bphp, const char *propname, int *szp)
+{
+	struct boot_param_header *bph = bphp;
+	uint32_t *p_struct =
+	    (uint32_t *) ((char *)bph + be32_to_cpu(bph->off_dt_struct));
+	uint32_t *p_strings =
+	    (uint32_t *) ((char *)bph + be32_to_cpu(bph->off_dt_strings));
+	uint32_t version = be32_to_cpu(bph->version);
+	uint32_t tag;
+	uint32_t *p;
+	char *s, *t;
+	char *ss;
+	int sz;
+	static char path[256], prop[256];
+
+	path[0] = '\0';
+
+	p = p_struct;
+	while ((tag = be32_to_cpu(*p++)) != OF_DT_END) {
+
+		if (tag == OF_DT_BEGIN_NODE) {
+			s = (char *)p;
+			p = (uint32_t *) _ALIGN((unsigned long)p + strlen(s) +
+						1, 4);
+			strcat(path, s);
+			strcat(path, "/");
+			continue;
+		}
+
+		if (tag == OF_DT_END_NODE) {
+			path[strlen(path) - 1] = '\0';
+			ss = strrchr(path, '/');
+			if (ss != NULL)
+				ss[1] = '\0';
+			continue;
+		}
+
+		if (tag == OF_DT_NOP)
+			continue;
+
+		if (tag != OF_DT_PROP)
+			break;
+
+		sz = be32_to_cpu(*p++);
+		s = (char *)p_strings + be32_to_cpu(*p++);
+		if (version < 0x10 && sz >= 8)
+			p = (uint32_t *) _ALIGN((unsigned long)p, 8);
+		t = (char *)p;
+		p = (uint32_t *) _ALIGN((unsigned long)p + sz, 4);
+
+		strcpy(prop, path);
+		strcat(prop, s);
+
+		if (strcmp(prop, propname) == 0) {
+			*szp = sz;
+			return t;
+		}
+	}
+
+	return NULL;
+}
+
+/********************************************************************/
+
+extern unsigned char oftree_dtb[];
+extern unsigned int oftree_dtb_len;
+
+/* Function that returns a character from the environment */
+extern uchar(*env_get_char) (int);
+
+void ft_setup(void *blob, int size, bd_t * bd)
+{
+	DECLARE_GLOBAL_DATA_PTR;
+	u8 *end;
+	u32 *p;
+	int len;
+	struct ft_cxt cxt;
+	int i, k, nxt;
+	static char tmpenv[256];
+	char *s, *lval, *rval;
+	ulong clock;
+
+	ft_begin(&cxt, blob, size);
+
+	/* fs_add_rsvmap not used */
+
+	ft_begin_tree(&cxt);
+
+	ft_begin_node(&cxt, "");
+
+	ft_end_node(&cxt);
+
+	/* copy RO tree */
+	ft_merge_blob(&cxt, oftree_dtb);
+
+	/* back into root */
+	ft_backtrack_node(&cxt);
+
+	ft_begin_node(&cxt, "u-boot-env");
+
+	for (i = 0; env_get_char(i) != '\0'; i = nxt + 1) {
+		for (nxt = i; env_get_char(nxt) != '\0'; ++nxt) ;
+		s = tmpenv;
+		for (k = i; k < nxt && s < &tmpenv[sizeof(tmpenv) - 1]; ++k)
+			*s++ = env_get_char(k);
+		*s++ = '\0';
+		lval = tmpenv;
+		s = strchr(tmpenv, '=');
+		if (s != NULL) {
+			*s++ = '\0';
+			rval = s;
+		} else
+			continue;
+		ft_prop_str(&cxt, lval, rval);
+	}
+
+	ft_end_node(&cxt);
+
+	ft_begin_node(&cxt, "chosen");
+
+	ft_prop_str(&cxt, "name", "chosen");
+	ft_prop_str(&cxt, "bootargs", getenv("bootargs"));
+	ft_prop_int(&cxt, "linux,platform", 0x600);	/* what is this? */
+
+	ft_end_node(&cxt);
+
+	ft_end_node(&cxt);	/* end root */
+
+	ft_end_tree(&cxt);
+
+	/*
+	   printf("merged OF-tree\n");
+	   ft_dump_blob(blob);
+	 */
+
+	/* paste the bd_t at the end of the flat tree */
+	end = (char *)blob +
+	    be32_to_cpu(((struct boot_param_header *)blob)->totalsize);
+	memcpy(end, bd, sizeof(*bd));
+
+#ifdef __powerpc__
+
+	p = ft_get_prop(blob, "/u-boot-bd_t/memstart", &len);
+	if (p != NULL)
+		*p = cpu_to_be32(bd->bi_memstart);
+
+	p = ft_get_prop(blob, "/u-boot-bd_t/memsize", &len);
+	if (p != NULL)
+		*p = cpu_to_be32(bd->bi_memsize);
+
+	p = ft_get_prop(blob, "/u-boot-bd_t/flashstart", &len);
+	if (p != NULL)
+		*p = cpu_to_be32(bd->bi_flashstart);
+
+	p = ft_get_prop(blob, "/u-boot-bd_t/flashsize", &len);
+	if (p != NULL)
+		*p = cpu_to_be32(bd->bi_flashsize);
+
+	p = ft_get_prop(blob, "/u-boot-bd_t/flashoffset", &len);
+	if (p != NULL)
+		*p = cpu_to_be32(bd->bi_flashoffset);
+
+	p = ft_get_prop(blob, "/u-boot-bd_t/sramstart", &len);
+	if (p != NULL)
+		*p = cpu_to_be32(bd->bi_sramstart);
+
+	p = ft_get_prop(blob, "/u-boot-bd_t/sramsize", &len);
+	if (p != NULL)
+		*p = cpu_to_be32(bd->bi_sramsize);
+
+#if defined(CONFIG_5xx) || defined(CONFIG_8xx) || defined(CONFIG_8260) \
+	|| defined(CONFIG_E500)
+	p = ft_get_prop(blob, "/u-boot-bd_t/immr_base", &len);
+	if (p != NULL)
+		*p = cpu_to_be32(bd->bi_immr_base);
+#endif
+
+#if defined(CONFIG_MPC5xxx)
+	p = ft_get_prop(blob, "/u-boot-bd_t/mbar_base", &len);
+	if (p != NULL)
+		*p = cpu_to_be32(bd->bi_mbar_base);
+#endif
+
+#if defined(CONFIG_MPC83XX)
+	p = ft_get_prop(blob, "/u-boot-bd_t/immrbar", &len);
+	if (p != NULL)
+		*p = cpu_to_be32(bd->bi_immrbar);
+#endif
+
+#if defined(CONFIG_MPC8220)
+	p = ft_get_prop(blob, "/u-boot-bd_t/mbar_base", &len);
+	if (p != NULL)
+		*p = cpu_to_be32(bd->bi_mbar_base);
+
+	p = ft_get_prop(blob, "/u-boot-bd_t/inpfreq", &len);
+	if (p != NULL)
+		*p = cpu_to_be32(bd->bi_nipfreq);
+
+	p = ft_get_prop(blob, "/u-boot-bd_t/pcifreq", &len);
+	if (p != NULL)
+		*p = cpu_to_be32(bd->bi_pcifreq);
+
+	p = ft_get_prop(blob, "/u-boot-bd_t/pevfreq", &len);
+	if (p != NULL)
+		*p = cpu_to_be32(bd->bi_pevfreq);
+
+	p = ft_get_prop(blob, "/u-boot-bd_t/flbfreq", &len);
+	if (p != NULL)
+		*p = cpu_to_be32(bd->bi_flbfreq);
+
+	p = ft_get_prop(blob, "/u-boot-bd_t/vcofreq", &len);
+	if (p != NULL)
+		*p = cpu_to_be32(bd->bi_vcofreq);
+#endif
+
+	p = ft_get_prop(blob, "/u-boot-bd_t/bootflags", &len);
+	if (p != NULL)
+		*p = cpu_to_be32(bd->bi_bootflags);
+
+	p = ft_get_prop(blob, "/u-boot-bd_t/ip_addr", &len);
+	if (p != NULL)
+		*p = cpu_to_be32(bd->bi_ip_addr);
+
+	p = ft_get_prop(blob, "/u-boot-bd_t/enetaddr", &len);
+	if (p != NULL)
+		memcpy(p, bd->bi_enetaddr, 6);
+
+	p = ft_get_prop(blob, "/u-boot-bd_t/ethspeed", &len);
+	if (p != NULL)
+		*p = cpu_to_be32((uint32_t) bd->bi_ethspeed);
+
+	p = ft_get_prop(blob, "/u-boot-bd_t/intfreq", &len);
+	if (p != NULL)
+		*p = cpu_to_be32(bd->bi_intfreq);
+
+	p = ft_get_prop(blob, "/u-boot-bd_t/busfreq", &len);
+	if (p != NULL)
+		*p = cpu_to_be32(bd->bi_busfreq);
+
+#ifdef CONFIG_CPM2
+
+	p = ft_get_prop(blob, "/u-boot-bd_t/cpmfreq", &len);
+	if (p != NULL)
+		*p = cpu_to_be32(bd->bi_cpmfreq);
+
+	p = ft_get_prop(blob, "/u-boot-bd_t/brgfreq", &len);
+	if (p != NULL)
+		*p = cpu_to_be32(bd->bi_brgfreq);
+
+	p = ft_get_prop(blob, "/u-boot-bd_t/sccfreq", &len);
+	if (p != NULL)
+		*p = cpu_to_be32(bd->bi_sccfreq);
+
+	p = ft_get_prop(blob, "/u-boot-bd_t/vco", &len);
+	if (p != NULL)
+		*p = cpu_to_be32(bd->bi_vco);
+#endif
+
+#if defined(CONFIG_MPC5xxx)
+
+	p = ft_get_prop(blob, "/u-boot-bd_t/ipbfreq", &len);
+	if (p != NULL)
+		*p = cpu_to_be32(bd->bi_ipbfreq);
+
+	p = ft_get_prop(blob, "/u-boot-bd_t/pcifreq", &len);
+	if (p != NULL)
+		*p = cpu_to_be32(bd->bi_pcifreq);
+#endif
+
+	p = ft_get_prop(blob, "/u-boot-bd_t/baudrate", &len);
+	if (p != NULL)
+		*p = cpu_to_be32(bd->bi_baudrate);
+
+#if defined(CONFIG_8xx)
+	clock = gd->cpu_clk;
+#elif defined(CONFIG_8260)
+	clock = gd->brg_clk;
+#else
+	clock = 0;
+#endif
+	p = ft_get_prop(blob, "/cpus/" OF_CPU "/clock-frequency", &len);
+	if (p != NULL)
+		*p = cpu_to_be32(clock);
+
+	p = ft_get_prop(blob, "/cpus/" OF_CPU "/timebase-frequency", &len);
+	if (p != NULL)
+		*p = cpu_to_be32(clock / 4);	/* XXX I'm just guessing */
+
+#endif				/* __powerpc__ */
+
+	/*
+	   printf("final OF-tree\n");
+	   ft_dump_blob(blob);
+	 */
+
+}
+
+#endif
diff --git a/include/ft_build.h b/include/ft_build.h
new file mode 100644
--- /dev/null
+++ b/include/ft_build.h
@@ -0,0 +1,66 @@
+/*
+ * OF Flat tree builder
+ *
+ */
+
+#ifndef FT_BUILD_H
+#define FT_BUILD_H
+
+#include <linux/types.h>
+#include <asm/u-boot.h>
+
+/* Definitions used by the flattened device tree */
+#define OF_DT_HEADER		0xd00dfeed	/* marker */
+#define OF_DT_BEGIN_NODE	0x1	/* Start of node, full name */
+#define OF_DT_END_NODE		0x2	/* End node */
+#define OF_DT_PROP		0x3	/* Property: name off, size,
+					 * content */
+#define OF_DT_NOP		0x4	/* nop */
+#define OF_DT_END		0x9
+
+#define OF_DT_VERSION		0x10
+
+struct boot_param_header {
+	u32 magic;		/* magic word OF_DT_HEADER */
+	u32 totalsize;		/* total size of DT block */
+	u32 off_dt_struct;	/* offset to structure */
+	u32 off_dt_strings;	/* offset to strings */
+	u32 off_mem_rsvmap;	/* offset to memory reserve map */
+	u32 version;		/* format version */
+	u32 last_comp_version;	/* last compatible version */
+	/* version 2 fields below */
+	u32 boot_cpuid_phys;	/* Physical CPU id we're booting on */
+	/* version 3 fields below */
+	u32 dt_strings_size;	/* size of the DT strings block */
+};
+
+struct ft_cxt {
+	struct boot_param_header *bph;
+	int max_size;		/* maximum size of tree */
+	int overflow;		/* set when this happens */
+	u8 *p, *pstr, *pres;	/* running pointers */
+	u8 *p_begin, *pstr_begin, *pres_begin;	/* starting pointers */
+	u8 *p_anchor;		/* start of constructed area */
+	int struct_size, strings_size, res_size;
+};
+
+void ft_begin_node(struct ft_cxt *cxt, const char *name);
+void ft_end_node(struct ft_cxt *cxt);
+
+void ft_begin_tree(struct ft_cxt *cxt);
+int ft_end_tree(struct ft_cxt *cxt);
+
+void ft_nop(struct ft_cxt *cxt);
+void ft_prop(struct ft_cxt *cxt, const char *name, const void *data, int sz);
+void ft_prop_str(struct ft_cxt *cxt, const char *name, const char *str);
+void ft_prop_int(struct ft_cxt *cxt, const char *name, int val);
+void ft_begin(struct ft_cxt *cxt, void *blob, int max_size);
+void ft_add_rsvmap(struct ft_cxt *cxt, u64 physaddr, u64 size);
+
+void ft_setup(void *blob, int size, bd_t * bd);
+
+void ft_dump_blob(const void *bphp);
+void ft_merge_blob(struct ft_cxt *cxt, void *blob);
+void *ft_get_prop(void *bphp, const char *propname, int *szp);
+
+#endif

--Boundary-00=_/wGGDZ67YEIC0t0
Content-Type: text/plain; charset="us-ascii"; name="of-uboot-stxxtc.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="of-uboot-stxxtc.patch"

diff --git a/board/stxxtc/Makefile b/board/stxxtc/Makefile
--- a/board/stxxtc/Makefile
+++ b/board/stxxtc/Makefile
@@ -25,11 +25,19 @@ include $(TOPDIR)/config.mk
 
 LIB	= lib$(BOARD).a
 
-OBJS	= $(BOARD).o
+OBJS	= $(BOARD).o oftree.o
 
 $(LIB):	.depend $(OBJS)
 	$(AR) crv $@ $(OBJS)
 
+%.dtb: %.dts
+	dtc -f -V 0x10 -I dts -O dtb $< >$@
+
+%.c: %.dtb
+	xxd -i $< \
+	   | sed -e "s/^unsigned char/const unsigned char/g" \
+	   | sed -e "s/^unsigned int/const unsigned int/g" > $@
+
 #########################################################################
 
 .depend:	Makefile $(SOBJS:.o=.S) $(OBJS:.o=.c)
@@ -38,3 +46,4 @@ $(LIB):	.depend $(OBJS)
 sinclude .depend
 
 #########################################################################
+
diff --git a/board/stxxtc/oftree.dts b/board/stxxtc/oftree.dts
new file mode 100644
--- /dev/null
+++ b/board/stxxtc/oftree.dts
@@ -0,0 +1,52 @@
+/ {
+	model = "STXXTC V1";
+	compatible = "STXXTC";
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	cpus {
+		linux,phandle = <1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		PowerPC,MPC870@0 {
+			linux,phandle = <3>;
+			name = "PowerPC,MPC870";
+			device_type = "cpu";
+			reg = <0>;
+			clock-frequency = <0>;		/* place-holder for runtime fillup */
+			timebase-frequency = <0>;	/* dido */
+			linux,boot-cpu;
+			i-cache-size = <2000>;
+			d-cache-size = <2000>;
+			32-bit;
+		};
+	};
+
+	memory@0 {
+		device_type = "memory";
+		reg = <00000000 00000000 00000000 20000000>;
+	};
+
+	/* copy of the bd_t information (place-holders) */
+	u-boot-bd_t {
+		memstart	= <0>;
+		memsize		= <0>;
+		flashstart	= <0>;
+		flashsize	= <0>;
+		flashoffset	= <0>;
+		sramstart	= <0>;
+		sramsize	= <0>;
+
+		immr_base	= <0>;
+
+		bootflags	= <0>;
+		ip_addr		= <0>;
+		enetaddr	= [ 00 00 00 00 00 00 ];
+		ethspeed	= <0>;
+		intfreq		= <0>;
+		busfreq		= <0>;
+
+		baudrate	= <0>;
+	};
+
+};
diff --git a/board/stxxtc/stxxtc.c b/board/stxxtc/stxxtc.c
--- a/board/stxxtc/stxxtc.c
+++ b/board/stxxtc/stxxtc.c
@@ -38,6 +38,13 @@
 #include <watchdog.h>
 #endif
 
+#include <ft_build.h>
+
+/****************************************************************/
+
+extern const unsigned char oftree_dtb[];
+extern const unsigned int oftree_dtb_len;
+
 /****************************************************************/
 
 /* some sane bit macros */
diff --git a/include/configs/stxxtc.h b/include/configs/stxxtc.h
--- a/include/configs/stxxtc.h
+++ b/include/configs/stxxtc.h
@@ -574,19 +574,14 @@ typedef unsigned int led_id_t;
 #define CONFIG_CRC32_VERIFY	1
 #define CONFIG_HUSH_OLD_PARSER_COMPATIBLE	1
 
-/* Note: change below for your network setting!!!
- * This was done just to facilitate manufacturing test and configuration.
- */
-#define CONFIG_ETHADDR	 00:e0:0c:07:9b:8a
+/*****************************************************************************/
 
-#define CONFIG_SERVERIP 	192.168.08.1
-#define CONFIG_IPADDR  		192.168.08.85
-#define CONFIG_GATEWAYIP	192.168.08.1
-#define CONFIG_NETMASK		255.255.255.0
-#define CONFIG_HOSTNAME 	stx_xtc
-#define CONFIG_ROOTPATH 	/xtcroot
-#define CONFIG_BOOTFILE 	uImage
-#define CONFIG_LOADADDR		0x1000000
+/* pass open firmware flat tree */
+#define CONFIG_OF_FLAT_TREE	1
 
+/* maximum size of the flat tree (8K) */
+#define OF_FLAT_TREE_MAX_SIZE	8192
+
+#define OF_CPU			"PowerPC,MPC870@0"
 
 #endif	/* __CONFIG_H */

--Boundary-00=_/wGGDZ67YEIC0t0--
