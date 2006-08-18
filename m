Return-Path: <hollisb@us.ibm.com>
Subject: update: consolidated flat device tree code
From: Hollis Blanchard <hollisb@us.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Content-Type: multipart/mixed; boundary="=-MWo4s/U6F7bkhFm5gOr9"
Date: Thu, 17 Aug 2006 19:23:45 -0500
Message-Id: <1155860626.27466.126.camel@basalt.austin.ibm.com>
Mime-Version: 1.0
Cc: Pantelis Antoniou <pantelis@embeddedalley.com>,
	"Sachin P. Sant" <sachinp@in.ibm.com>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-MWo4s/U6F7bkhFm5gOr9
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Changes:
- converted some ints to "unsigned", since gcc was generating warnings
and negative lengths don't make sense in the flat data structure.
- added ft_set_prop(), which doesn't yet resize properties but will in
the future.
- added an explicit copyright statement.

Still haven't looked to merge Matt's changes (because I'm busy, the
current code works for me, and they haven't been accepted in u-boot
yet).

Current users: Xen
Future users: Mark's Linux bootwrapper code
Potential users: kexec, u-boot

-- 
Hollis Blanchard
IBM Linux Technology Center

--=-MWo4s/U6F7bkhFm5gOr9
Content-Disposition: attachment; filename=ft_build.c
Content-Type: text/x-csrc; name=ft_build.c; charset=UTF-8
Content-Transfer-Encoding: 7bit

/*
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 *
 * Copyright Pantelis Antoniou 2006
 * Copyright (C) IBM Corporation 2006
 *
 * Authors: Pantelis Antoniou <pantelis@embeddedalley.com>
 *          Hollis Blanchard <hollisb@us.ibm.com>
 */

#include <stddef.h>
#include <string.h>
#include <stdio.h>
#include <asm/errno.h>

#include "ft_build.h"

#define _ALIGN(addr,size)       (((addr)+(size)-1)&(~((size)-1)))

static void ft_put_word(struct ft_cxt *cxt, u32 v)
{
	if (cxt->overflow)	/* do nothing */
		return;

	/* check for overflow */
	if (cxt->p + 4 > cxt->pstr) {
		cxt->overflow = 1;
		return;
	}

	*(u32 *) cxt->p = cpu_to_be32(v);
	cxt->p += 4;
}

static inline void ft_put_bin(struct ft_cxt *cxt, const void *data, int sz)
{
	char *p;

	if (cxt->overflow)	/* do nothing */
		return;

	/* next pointer pos */
	p = (char *) _ALIGN((unsigned long)cxt->p + sz, 4);

	/* check for overflow */
	if (p > cxt->pstr) {
		cxt->overflow = 1;
		return;
	}

	memcpy(cxt->p, data, sz);
	if ((sz & 3) != 0)
		memset(cxt->p + sz, 0, 4 - (sz & 3));
	cxt->p = p;
}

void ft_begin_node(struct ft_cxt *cxt, const char *name)
{
	ft_put_word(cxt, OF_DT_BEGIN_NODE);
	ft_put_bin(cxt, name, strlen(name) + 1);
}

void ft_end_node(struct ft_cxt *cxt)
{
	ft_put_word(cxt, OF_DT_END_NODE);
}

void ft_nop(struct ft_cxt *cxt)
{
	ft_put_word(cxt, OF_DT_NOP);
}

static int lookup_string(struct ft_cxt *cxt, const char *name)
{
	char *p;

	p = cxt->pstr;
	while (p < cxt->pstr_begin) {
		if (strcmp(p, (char *)name) == 0)
			return p - cxt->p_begin;
		p += strlen(p) + 1;
	}

	return -1;
}

void ft_prop(struct ft_cxt *cxt, const char *name,
             const void *data, unsigned int sz)
{
	int len, off;

	if (cxt->overflow)
		return;

	len = strlen(name) + 1;

	off = lookup_string(cxt, name);
	if (off == -1) {
		/* check if we have space */
		if (cxt->p + 12 + sz + len > cxt->pstr) {
			cxt->overflow = 1;
			return;
		}

		cxt->pstr -= len;
		memcpy(cxt->pstr, name, len);
		off = cxt->pstr - cxt->p_begin;
	}

	/* now put offset from beginning of *STRUCTURE* */
	/* will be fixed up at the end */
	ft_put_word(cxt, OF_DT_PROP);
	ft_put_word(cxt, sz);
	ft_put_word(cxt, off);
	ft_put_bin(cxt, data, sz);
}

void ft_prop_str(struct ft_cxt *cxt, const char *name, const char *str)
{
	ft_prop(cxt, name, str, strlen(str) + 1);
}

void ft_prop_int(struct ft_cxt *cxt, const char *name, unsigned int val)
{
	u32 v = cpu_to_be32((u32) val);

	ft_prop(cxt, name, &v, 4);
}

/* start construction of the flat OF tree */
void ft_begin(struct ft_cxt *cxt, void *blob, unsigned int max_size)
{
	struct boot_param_header *bph = blob;
	u32 off;

	/* clear the cxt */
	memset(cxt, 0, sizeof(*cxt));

	cxt->bph = bph;
	cxt->max_size = max_size;

	/* zero everything in the header area */
	memset(bph, 0, sizeof(*bph));

	bph->magic = cpu_to_be32(OF_DT_HEADER);
	bph->version = cpu_to_be32(0x10);
	bph->last_comp_version = cpu_to_be32(0x10);

	/* start pointers */
	cxt->pres_begin = (char *) _ALIGN((unsigned long)(bph + 1), 8);
	cxt->pres = cxt->pres_begin;

	off = (unsigned long)cxt->pres_begin - (unsigned long)bph;
	bph->off_mem_rsvmap = cpu_to_be32(off);

	((u64 *) cxt->pres)[0] = 0;	/* phys = 0, size = 0, terminate */
	((u64 *) cxt->pres)[1] = 0;

	cxt->p_anchor = cxt->pres + 16;	/* over the terminator */
}

/* add a reserver physical area to the rsvmap */
void ft_add_rsvmap(struct ft_cxt *cxt, u64 physaddr, u64 size)
{
	((u64 *) cxt->pres)[0] = cpu_to_be64(physaddr);	/* phys = 0, size = 0, terminate */
	((u64 *) cxt->pres)[1] = cpu_to_be64(size);

	cxt->pres += 18;	/* advance */

	((u64 *) cxt->pres)[0] = 0;	/* phys = 0, size = 0, terminate */
	((u64 *) cxt->pres)[1] = 0;

	/* keep track of size */
	cxt->res_size = cxt->pres + 16 - cxt->pres_begin;

	cxt->p_anchor = cxt->pres + 16;	/* over the terminator */
}

void ft_begin_tree(struct ft_cxt *cxt)
{
	cxt->p_begin = cxt->p_anchor;
	cxt->pstr_begin = (char *)cxt->bph + cxt->max_size;	/* point at the end */

	cxt->p = cxt->p_begin;
	cxt->pstr = cxt->pstr_begin;
}

int ft_end_tree(struct ft_cxt *cxt)
{
	struct boot_param_header *bph = cxt->bph;
	int off, sz, sz1;
	u32 tag, v;
	char *p;

	ft_put_word(cxt, OF_DT_END);

	if (cxt->overflow)
		return -ENOMEM;

	/* size of the areas */
	cxt->struct_size = cxt->p - cxt->p_begin;
	cxt->strings_size = cxt->pstr_begin - cxt->pstr;

	/* the offset we must move */
	off = (cxt->pstr_begin - cxt->p_begin) - cxt->strings_size;

	/* the new strings start */
	cxt->pstr_begin = cxt->p_begin + cxt->struct_size;

	/* move the whole string area */
	memmove(cxt->pstr_begin, cxt->pstr, cxt->strings_size);

	/* now perform the fixup of the strings */
	p = cxt->p_begin;
	while ((tag = be32_to_cpu(*(u32 *) p)) != OF_DT_END) {
		p += 4;

		if (tag == OF_DT_BEGIN_NODE) {
			p = (char *) _ALIGN((unsigned long)p + strlen(p) + 1, 4);
			continue;
		}

		if (tag == OF_DT_END_NODE || tag == OF_DT_NOP)
			continue;

		if (tag != OF_DT_PROP)
			return -EINVAL;

		sz = be32_to_cpu(*(u32 *) p);
		p += 4;

		v = be32_to_cpu(*(u32 *) p);
		v -= off;
		*(u32 *) p = cpu_to_be32(v);	/* move down */
		p += 4;

		p = (char *) _ALIGN((unsigned long)p + sz, 4);
	}

	/* fix sizes */
	p = (char *)cxt->bph;
	sz = (cxt->pstr_begin + cxt->strings_size) - p;
	sz1 = _ALIGN(sz, 16);	/* align at 16 bytes */
	if (sz != sz1)
		memset(p + sz, 0, sz1 - sz);
	bph->totalsize = cpu_to_be32(sz1);
	bph->off_dt_struct = cpu_to_be32(cxt->p_begin - p);
	bph->off_dt_strings = cpu_to_be32(cxt->pstr_begin - p);

	/* the new strings start */
	cxt->pstr_begin = cxt->p_begin + cxt->struct_size;
	cxt->pstr = cxt->pstr_begin + cxt->strings_size;

	return 0;
}

/**********************************************************************/

static inline int isprint(int c)
{
	return c >= 0x20 && c <= 0x7e;
}

static int is_printable_string(const void *data, int len)
{
	const char *s = data;
	const char *ss;

	/* zero length is not */
	if (len == 0)
		return 0;

	/* must terminate with zero */
	if (s[len - 1] != '\0')
		return 0;

	ss = s;
	while (*s && isprint(*s))
		s++;

	/* not zero, or not done yet */
	if (*s != '\0' || (s + 1 - ss) < len)
		return 0;

	return 1;
}

static void print_data(const void *data, int len)
{
	int i;
	const char *s;

	/* no data, don't print */
	if (len == 0)
		return;

	if (is_printable_string(data, len)) {
		printf(" = \"%s\"", (char *)data);
		return;
	}

	switch (len) {
	case 1:		/* byte */
		printf(" = <0x%02x>", (*(char *) data) & 0xff);
		break;
	case 2:		/* half-word */
		printf(" = <0x%04x>", be16_to_cpu(*(u16 *) data) & 0xffff);
		break;
	case 4:		/* word */
		printf(" = <0x%08x>", be32_to_cpu(*(u32 *) data) & 0xffffffffU);
		break;
	case 8:		/* double-word */
		printf(" = <0x%16llx>", be64_to_cpu(*(u64 *) data));
		break;
	default:		/* anything else... hexdump */
		printf(" = [");
		for (i = 0, s = data; i < len; i++)
			printf("%02x%s", s[i], i < len - 1 ? " " : "");
		printf("]");

		break;
	}
}

void ft_dump_blob(const void *bphp)
{
	const struct boot_param_header *bph = bphp;
	const u64 *p_rsvmap = (const u64 *)
		((const char *)bph + be32_to_cpu(bph->off_mem_rsvmap));
	const u32 *p_struct = (const u32 *)
		((const char *)bph + be32_to_cpu(bph->off_dt_struct));
	const u32 *p_strings = (const u32 *)
		((const char *)bph + be32_to_cpu(bph->off_dt_strings));
	u32 tag;
	const u32 *p;
	const char *s, *t;
	int depth, sz, shift;
	int i;
	u64 addr, size;

	if (be32_to_cpu(bph->magic) != OF_DT_HEADER) {
		/* not valid tree */
		return;
	}

	depth = 0;
	shift = 4;

	for (i = 0;; i++) {
		addr = be64_to_cpu(p_rsvmap[i * 2]);
		size = be64_to_cpu(p_rsvmap[i * 2 + 1]);
		if (addr == 0 && size == 0)
			break;

		printf("/memreserve/ 0x%llx 0x%llx;\n", addr, size);
	}

	p = p_struct;
	while ((tag = be32_to_cpu(*p++)) != OF_DT_END) {

		/* printf("tag: 0x%08x (%d)\n", tag, p - p_struct); */

		if (tag == OF_DT_BEGIN_NODE) {
			s = (const char *)p;
			p = (u32 *) _ALIGN((unsigned long)p + strlen(s) + 1, 4);

			printf("%*s%s {\n", depth * shift, "", s);

			depth++;
			continue;
		}

		if (tag == OF_DT_END_NODE) {
			depth--;

			printf("%*s};\n", depth * shift, "");
			continue;
		}

		if (tag == OF_DT_NOP) {
			printf("%*s[NOP]\n", depth * shift, "");
			continue;
		}

		if (tag != OF_DT_PROP) {
			fprintf(stderr, "%*s ** Unknown tag 0x%08x\n",
				depth * shift, "", tag);
			break;
		}
		sz = be32_to_cpu(*p++);
		s = (const char *)p_strings + be32_to_cpu(*p++);
		t = (const char *)p;
		p = (const u32 *)_ALIGN((unsigned long)p + sz, 4);
		printf("%*s%s", depth * shift, "", s);
		print_data(t, sz);
		printf(";\n");
	}
}

void ft_backtrack_node(struct ft_cxt *cxt)
{
	if (be32_to_cpu(*(u32 *) (cxt->p - 4)) != OF_DT_END_NODE)
		return;		/* XXX only for node */

	cxt->p -= 4;
}

/* note that the root node of the blob is "peeled" off */
void ft_merge_blob(struct ft_cxt *cxt, void *blob)
{
	struct boot_param_header *bph = (struct boot_param_header *)blob;
	u32 *p_struct = (u32 *) ((char *)bph + be32_to_cpu(bph->off_dt_struct));
	u32 *p_strings =
	    (u32 *) ((char *)bph + be32_to_cpu(bph->off_dt_strings));
	u32 tag, *p;
	char *s, *t;
	int depth, sz;

	if (be32_to_cpu(*(u32 *) (cxt->p - 4)) != OF_DT_END_NODE)
		return;		/* XXX only for node */

	cxt->p -= 4;

	depth = 0;
	p = p_struct;
	while ((tag = be32_to_cpu(*p++)) != OF_DT_END) {

		/* printf("tag: 0x%08x (%d) - %d\n", tag, p - p_struct, depth); */

		if (tag == OF_DT_BEGIN_NODE) {
			s = (char *)p;
			p = (u32 *) _ALIGN((unsigned long)p + strlen(s) + 1, 4);

			if (depth++ > 0)
				ft_begin_node(cxt, s);

			continue;
		}

		if (tag == OF_DT_END_NODE) {
			ft_end_node(cxt);
			if (--depth == 0)
				break;
			continue;
		}

		if (tag == OF_DT_NOP)
			continue;

		if (tag != OF_DT_PROP)
			break;

		sz = be32_to_cpu(*p++);
		s = (char *)p_strings + be32_to_cpu(*p++);
		t = (char *)p;
		p = (u32 *) _ALIGN((unsigned long)p + sz, 4);

		ft_prop(cxt, s, t, sz);
	}
}

void *ft_get_prop(void *bphp, const char *propname, unsigned int *szp)
{
	struct boot_param_header *bph = bphp;
	u32 *p_struct =
	    (u32 *) ((char *)bph + be32_to_cpu(bph->off_dt_struct));
	u32 *p_strings =
	    (u32 *) ((char *)bph + be32_to_cpu(bph->off_dt_strings));
	u32 version = be32_to_cpu(bph->version);
	u32 tag;
	u32 *p;
	char *s, *t;
	char *ss;
	int sz;
	static char path[256], prop[256];

	path[0] = '\0';

	p = p_struct;
	while ((tag = be32_to_cpu(*p++)) != OF_DT_END) {

		if (tag == OF_DT_BEGIN_NODE) {
			s = (char *)p;
			p = (u32 *) _ALIGN((unsigned long)p + strlen(s) +
						1, 4);
			strcat(path, s);
			strcat(path, "/");
			continue;
		}

		if (tag == OF_DT_END_NODE) {
			path[strlen(path) - 1] = '\0';
			ss = strrchr(path, '/');
			if (ss != NULL)
				ss[1] = '\0';
			continue;
		}

		if (tag == OF_DT_NOP)
			continue;

		if (tag != OF_DT_PROP)
			break;

		sz = be32_to_cpu(*p++);
		s = (char *)p_strings + be32_to_cpu(*p++);
		if (version < 0x10 && sz >= 8)
			p = (u32 *) _ALIGN((unsigned long)p, 8);
		t = (char *)p;
		p = (u32 *) _ALIGN((unsigned long)p + sz, 4);

		strcpy(prop, path);
		strcat(prop, s);

		if (strcmp(prop, propname) == 0) {
			*szp = sz;
			return t;
		}
	}

	return NULL;
}

int ft_set_prop(void *bphp, const char *propname, const void *val,
		unsigned int len)
{
	void *prop;
	unsigned int proplen;

	prop = ft_get_prop(bphp, propname, &proplen);
	if (prop == NULL)
		return -ENOENT;

	if (proplen != len)
		/* XXX to be removed when property resize is supported */
		return -EINVAL;

	memcpy(prop, val, len);
	return 0;
}

--=-MWo4s/U6F7bkhFm5gOr9
Content-Disposition: attachment; filename=ft_build.h
Content-Type: text/x-chdr; name=ft_build.h; charset=UTF-8
Content-Transfer-Encoding: 7bit

/*
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */

#ifndef FT_BUILD_H
#define FT_BUILD_H

#include <endian.h>

typedef unsigned short u16;
typedef unsigned int u32;
typedef unsigned long long u64;

static inline u16 swab16(u16 x)
{
	return  (((u16)(x) & (u16)0x00ffU) << 8) |
			(((u16)(x) & (u16)0xff00U) >> 8);
}

static inline u32 swab32(u32 x)
{
	return  (((u32)(x) & (u32)0x000000ffUL) << 24) |
			(((u32)(x) & (u32)0x0000ff00UL) <<  8) |
			(((u32)(x) & (u32)0x00ff0000UL) >>  8) |
			(((u32)(x) & (u32)0xff000000UL) >> 24);
}

static inline u64 swab64(u64 x)
{
	return  (u64)(((u64)(x) & (u64)0x00000000000000ffULL) << 56) |
			(u64)(((u64)(x) & (u64)0x000000000000ff00ULL) << 40) |
			(u64)(((u64)(x) & (u64)0x0000000000ff0000ULL) << 24) |
			(u64)(((u64)(x) & (u64)0x00000000ff000000ULL) <<  8) |
			(u64)(((u64)(x) & (u64)0x000000ff00000000ULL) >>  8) |
			(u64)(((u64)(x) & (u64)0x0000ff0000000000ULL) >> 24) |
			(u64)(((u64)(x) & (u64)0x00ff000000000000ULL) >> 40) |
			(u64)(((u64)(x) & (u64)0xff00000000000000ULL) >> 56);
}

#if __BYTE_ORDER == __LITTLE_ENDIAN
#define cpu_to_be16(x) swab16(x)
#define be16_to_cpu(x) swab16(x)
#define cpu_to_be32(x) swab32(x)
#define be32_to_cpu(x) swab32(x)
#define cpu_to_be64(x) swab64(x)
#define be64_to_cpu(x) swab64(x)
#else
#define cpu_to_be16(x) (x)
#define be16_to_cpu(x) (x)
#define cpu_to_be32(x) (x)
#define be32_to_cpu(x) (x)
#define cpu_to_be64(x) (x)
#define be64_to_cpu(x) (x)
#endif

/* Definitions used by the flattened device tree */
#define OF_DT_HEADER            0xd00dfeed      /* marker */
#define OF_DT_BEGIN_NODE        0x1     /* Start of node, full name */
#define OF_DT_END_NODE          0x2     /* End node */
#define OF_DT_PROP              0x3     /* Property: name off, size, content */
#define OF_DT_NOP               0x4     /* nop */
#define OF_DT_END               0x9

#define OF_DT_VERSION           0x10

struct boot_param_header {
	u32 magic;              /* magic word OF_DT_HEADER */
	u32 totalsize;          /* total size of DT block */
	u32 off_dt_struct;      /* offset to structure */
	u32 off_dt_strings;     /* offset to strings */
	u32 off_mem_rsvmap;     /* offset to memory reserve map */
	u32 version;            /* format version */
	u32 last_comp_version;  /* last compatible version */
	/* version 2 fields below */
	u32 boot_cpuid_phys;    /* Physical CPU id we're booting on */
	/* version 3 fields below */
	u32 dt_strings_size;    /* size of the DT strings block */
};

struct ft_cxt {
	struct boot_param_header *bph;
	int max_size;           /* maximum size of tree */
	int overflow;           /* set when this happens */
	char *p, *pstr, *pres;  /* running pointers */
	char *p_begin, *pstr_begin, *pres_begin;        /* starting pointers */
	char *p_anchor;         /* start of constructed area */
	int struct_size, strings_size, res_size;
};

void ft_begin_node(struct ft_cxt *cxt, const char *name);
void ft_end_node(struct ft_cxt *cxt);

void ft_begin_tree(struct ft_cxt *cxt);
int ft_end_tree(struct ft_cxt *cxt);

void ft_nop(struct ft_cxt *cxt);
void ft_prop(struct ft_cxt *cxt, const char *name,
             const void *data, unsigned int sz);
void ft_prop_str(struct ft_cxt *cxt, const char *name, const char *str);
void ft_prop_int(struct ft_cxt *cxt, const char *name, unsigned int val);
void ft_begin(struct ft_cxt *cxt, void *blob, unsigned int max_size);
void ft_add_rsvmap(struct ft_cxt *cxt, u64 physaddr, u64 size);

void ft_dump_blob(const void *bphp);
void ft_merge_blob(struct ft_cxt *cxt, void *blob);
void *ft_get_prop(void *bphp, const char *propname, unsigned int *szp);
int ft_set_prop(void *bphp, const char *propname, const void *val,
		unsigned int len);

#endif

--=-MWo4s/U6F7bkhFm5gOr9--
