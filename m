Return-Path: <mgreer@mvista.com>
Date: Wed, 6 Sep 2006 17:36:25 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: common flatdevtree code
Message-ID: <20060907003625.GA15533@mag.az.mvista.com>
References: <20060831184020.GA13494@mag.az.mvista.com>
	<17662.17895.852128.729679@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="2fHTh5uZTiUOsy+g"
In-Reply-To: <17662.17895.852128.729679@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>, hollisb@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 06, 2006 at 01:52:07PM +1000, Paul Mackerras wrote:
> Mark A. Greer writes:
> 
> > I'm doing some fairly massive rework to my patches so it'll take
> > another day or two (plus 4 day weekend for me).  In the meantime,
> > this is what I've done to your code.  :)
> 
> Any further progress on this?  I need an ft library for the prep
> bootwrapper changes I'm planning.
> 
> I don't like the approach of doing a malloc for the whole blob every
> time you make a property larger though.  I'm going to be adding quite
> a few nodes and properties, potentially, and with a simple-minded
> malloc (such as you get in a bootwrapper) it's likely to chew through
> a lot of memory unnecessarily.  I would rather be able to start with
> an existing blob and pull it apart once, add stuff to it, then put it
> back together, doing a small number of mallocs in the process.
> 
> > I still plan on changing it a bit to use ft_next in a few more routines
> > (e.g., ft_dump_blob).  ft_next has a clumsy interface but I like the fact
> 
> The interface might look nicer if we had a structure for the tag,
> name, value and length.  Then there would only be one parameter
> instead of the four you have at the moment.
> 
> Paul.

Paul,

Here's what I have at the moment...

- flatdevtree.[ch] are copies of what Hollis will be keeping (but I've
edited the ones attached to this email)

- flatdevtree_env.h is a bootwrapper hdr file that contains local
  defines that the generic flatdevtree.[ch] need

- flatdevtree_misc.c is other ft stuff that isn't in flatdevtree.c plus
  some bootwrapper->flatdevtree.c glue code

Mark
--

--2fHTh5uZTiUOsy+g
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="flatdevtree.c"

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

#include "flatdevtree.h"

/* Set ptrs to current one's info; return addr of next one */
static u32 *ft_next(u32 *p, const u32 *p_strings, const u32 version,
		u32 **tagpp, char **namepp, char **datapp, u32 **sizepp)
{
	u32 sz;

	*namepp = NULL;
	*datapp = NULL;
	*sizepp = NULL;
	*tagpp = p;

	switch (be32_to_cpu(*p++)) { /* Tag */
	case OF_DT_BEGIN_NODE:
		*namepp = (char *)p;
		p = (u32 *)_ALIGN((u32)p + strlen((char *)p) + 1, 4);
		break;
	case OF_DT_PROP:
		sz = be32_to_cpu(*p);
		*sizepp = p++;
		*namepp = (char *)p_strings + be32_to_cpu(*p++);
		if ((version < 0x10) && (sz >= 8))
			p = (u32 *)_ALIGN((unsigned long)p, 8);
		*datapp = (char *)p;
		p = (u32 *)_ALIGN((unsigned long)p + sz, 4);
		break;
	case OF_DT_END_NODE:
	case OF_DT_NOP:
		break;
	case OF_DT_END:
	default:
		p = NULL;
		break;
	}

	return p;
}

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
	const u32 version = be32_to_cpu(bph->version);
	u32 i, *p, *tagp, *sizep;
	char *namep, *datap;
	int depth, shift;
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

	p = (u32 *)p_struct;
	while ((p = ft_next(p, p_strings, version, &tagp, &namep, &datap,
					&sizep)) != NULL)
		switch (be32_to_cpu(*tagp)) {
		case OF_DT_BEGIN_NODE:
			printf("%*s%s {\n", depth * shift, "", namep);
			depth++;
			break;
		case OF_DT_END_NODE:
			depth--;
			printf("%*s};\n", depth * shift, "");
			break;
		case OF_DT_NOP:
			printf("%*s[NOP]\n", depth * shift, "");
			break;
		case OF_DT_END:
			break;
		case OF_DT_PROP:
			printf("%*s%s", depth * shift, "", namep);
			print_data(datap, *sizep);
			printf(";\n");
			break;
		default:
			fprintf(stderr, "%*s ** Unknown tag 0x%08x\n",
				depth * shift, "", *tagp);
			return;
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
	const u32 version = be32_to_cpu(bph->version);
	u32 *p, *tagp, *sizep;
	char *namep, *datap;
	int depth;

	if (be32_to_cpu(*(u32 *) (cxt->p - 4)) != OF_DT_END_NODE)
		return;		/* XXX only for node */

	cxt->p -= 4;

	depth = 0;
	p = p_struct;
	while ((p = ft_next(p, p_strings, version, &tagp, &namep, &datap,
					&sizep)) != NULL)
		switch (be32_to_cpu(*tagp)) {
		case OF_DT_BEGIN_NODE:
			if (depth++ > 0)
				ft_begin_node(cxt, namep);
			break;
		case OF_DT_END_NODE:
			ft_end_node(cxt);
			if (--depth == 0)
				return;
			break;
		case OF_DT_PROP:
			ft_prop(cxt, namep, datap, *sizep);
			break;
		}
}

/**********************************************************************/

void *ft_find_device(const void *bphp, const char *srch_path)
{
	const struct boot_param_header *bph = bphp;
	u32 *p_struct = (u32 *)((char *)bph + be32_to_cpu(bph->off_dt_struct));
	u32 *p_strings= (u32 *)((char *)bph + be32_to_cpu(bph->off_dt_strings));
	u32 version = be32_to_cpu(bph->version);
	u32 *p, *tagp, *sizep;
	char *namep, *datap;
	static char path[MAX_PATH_LEN];

	path[0] = '\0';
	p = p_struct;

	while ((p = ft_next(p, p_strings, version, &tagp, &namep, &datap,
					&sizep)) != NULL)
		switch (be32_to_cpu(*tagp)) {
		case OF_DT_BEGIN_NODE:
			strcat(path, namep);
			if (!strcmp(path, srch_path))
				return tagp;
			strcat(path, "/");
			break;
		case OF_DT_END_NODE:
			ft_parentize(path, 1);
			break;
		}
	return NULL;
}

int ft_get_prop(const void *bphp, const void *node, const char *propname,
		void *buf, const unsigned int buflen)
{
	const struct boot_param_header *bph = bphp;
	u32 *p_strings= (u32 *)((char *)bph + be32_to_cpu(bph->off_dt_strings));
	u32 version = be32_to_cpu(bph->version);
	u32 *p, *tagp, *sizep, size;
	char *namep, *datap;
	int depth;

	depth = 0;
	p = (u32 *)node;

	while ((p = ft_next(p, p_strings, version, &tagp, &namep, &datap,
					&sizep)) != NULL)
		switch (be32_to_cpu(*tagp)) {
		case OF_DT_BEGIN_NODE:
			depth++;
			break;
		case OF_DT_PROP:
			if ((depth == 1) && !strcmp(namep, propname)) {
				size = min(be32_to_cpu(*sizep), (u32)buflen);
				memcpy(buf, datap, size);
				return size;
			}
			break;
		case OF_DT_END_NODE:
			if (--depth <= 0)
				return -1;
			break;
		}
	return -1;
}

static void ft_modify_prop(void **bphpp, char *datap, u32 *old_prop_sizep,
		const char *buf, const unsigned int buflen)
{
	u32 old_prop_data_len, new_prop_data_len;

	old_prop_data_len = _ALIGN(be32_to_cpu(*old_prop_sizep), 4);
	new_prop_data_len = _ALIGN(buflen, 4);

	/* Check if new prop data fits in old prop data area */
	if (new_prop_data_len == old_prop_data_len) {
		memcpy(datap, buf, buflen);
		*old_prop_sizep = cpu_to_be32(buflen);
	}
	else { /* Need to alloc new area to put larger or smaller ft */
		struct boot_param_header *old_bph = *bphpp, *new_bph;
		u32 *old_tailp, *new_tailp, *new_datap;
		u32 old_total_size, new_total_size, head_len, tail_len, diff, v;

		old_total_size = be32_to_cpu(old_bph->totalsize);
		head_len = (u32)datap - (u32)old_bph;
		tail_len = old_total_size - (head_len + old_prop_data_len);
		old_tailp = (u32 *)((u32)datap + old_prop_data_len);
		new_total_size = head_len + new_prop_data_len + tail_len;

		if (!(new_bph = malloc(new_total_size))) {
			printf("Can't alloc space for new ft\n");
			exit();
		}

		new_datap = (u32 *)((u32)new_bph + head_len);
		new_tailp = (u32 *)((u32)new_datap + new_prop_data_len);

		memcpy(new_bph, *bphpp, head_len);
		memcpy(new_datap, buf, buflen);
		memcpy(new_tailp, old_tailp, tail_len);

		*(new_datap - 2) = cpu_to_be32(buflen); /* Set prop size */

		new_bph->totalsize = cpu_to_be32(new_total_size);
		diff = new_prop_data_len - old_prop_data_len;

		if (be32_to_cpu(old_bph->off_dt_strings)
				> be32_to_cpu(old_bph->off_dt_struct)) {
			v = be32_to_cpu(new_bph->off_dt_strings);
			new_bph->off_dt_strings = cpu_to_be32(v + diff);
		}

		if (be32_to_cpu(old_bph->off_mem_rsvmap)
				> be32_to_cpu(old_bph->off_dt_struct)) {
			v = be32_to_cpu(new_bph->off_mem_rsvmap);
			new_bph->off_mem_rsvmap = cpu_to_be32(v + diff);
		}

		free(*bphpp, old_total_size);
		*bphpp = new_bph;
	}
}

/*
 * - Only modifies existing properties.
 * - The dev tree passed in may be freed and a new one allocated
 *   (and *bphpp set to location of new dev tree).
 */
int ft_set_prop(void **bphpp, const void *node, const char *propname,
		const void *buf, const unsigned int buflen)
{
	struct boot_param_header *bph = *bphpp;
	u32 *p_strings= (u32 *)((char *)bph + be32_to_cpu(bph->off_dt_strings));
	u32 version = be32_to_cpu(bph->version);
	u32 *p, *tagp, *sizep;
	char *namep, *datap;
	int depth;

	depth = 0;
	p = (u32 *)node;

	while ((p = ft_next(p, p_strings, version, &tagp, &namep, &datap,
					&sizep)) != NULL)
		switch (be32_to_cpu(*tagp)) {
		case OF_DT_BEGIN_NODE:
			depth++;
			break;
		case OF_DT_PROP:
			if ((depth == 1) && !strcmp(namep, propname)) {
				ft_modify_prop(bphpp, datap, sizep, buf,
						buflen);
				return be32_to_cpu(*sizep);
			}
			break;
		case OF_DT_END_NODE:
			if (--depth <= 0)
				return -1;
			break;
		}
	return -1;
}

--2fHTh5uZTiUOsy+g
Content-Type: text/x-chdr; charset=us-ascii
Content-Disposition: attachment; filename="flatdevtree_env.h"

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


#ifndef _PPC_BOOT_FLATDEVTREE_ENV_H_
#define _PPC_BOOT_FLATDEVTREE_ENV_H_

#include <stdarg.h>
#include <stddef.h>
#include "types.h"
#include "page.h"
#include "string.h"
#include "stdio.h"
#include "ops.h"

#define	be16_to_cpu(x)		(x)
#define	cpu_to_be16(x)		(x)
#define	be32_to_cpu(x)		(x)
#define	cpu_to_be32(x)		(x)
#define	be64_to_cpu(x)		(x)
#define	cpu_to_be64(x)		(x)

#endif /* _PPC_BOOT_FLATDEVTREE_ENV_H_ */

--2fHTh5uZTiUOsy+g
Content-Type: text/x-chdr; charset=us-ascii
Content-Disposition: attachment; filename="flatdevtree.h"

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

#ifndef FLATDEVTREE_H
#define FLATDEVTREE_H

#include <flatdevtree_env.h>

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
void *ft_find_device(const void *bphp, const char *srch_path);
int ft_get_prop(const void *bphp, const void *node, const char *propname,
		void *buf, const unsigned int buflen);
int ft_set_prop(void **bphp, const void *node, const char *propname,
		const void *buf, const unsigned int buflen);

static inline char *ft_strrchr(const char *s, int c)
{
	const char *p = s + strlen(s);

	do {
		if (*p == (char)c)
			return (char *)p;
	} while (--p >= s);
	return NULL;
}

/* 'path' is modified */
static inline void ft_parentize(char *path, u8 leave_slash)
{
	char *s = &path[strlen(path) - 1];

	if (*s == '/')
		*s = '\0';
	s = ft_strrchr(path, '/');
	if (s != NULL) {
		if (leave_slash)
			s[1] = '\0';
		else if (s[0] == '/')
			s[0] = '\0';
	}
}
#endif /* FLATDEVTREE_H */

--2fHTh5uZTiUOsy+g
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="flatdevtree_misc.c"

/*
 * flatdevtree.c and flatdevtree.h come from <xxx> and are shared with Xen
 * and eventually u-boot.  However, they don't provide all the functionality
 * or the exact interface that the bootwrapper needs.  This file does the
 * necessary interface mapping and provide the functionality not provided
 * by flatdevtree.c.
 *
 * Author: Mark A. Greer <mgreer@mvista.com>
 * 	Many of the routines related to ft_translate_addr() came
 * 	from arch/powerpc/kernel/prom_parse.c which has no author or
 * 	copyright notice.
 *
 * 2006 (c) MontaVista, Software, Inc.  This file is licensed under
 * the terms of the GNU General Public License version 2.  This program
 * is licensed "as is" without any warranty of any kind, whether express
 * or implied.
 */
#include "flatdevtree.h"

#define MAX_ADDR_CELLS	4
#define BAD_ADDR	((u64)-1)

struct ft_bus {
	u64	(*map)(u32 *addr, u32 *range, int na, int ns, int pna);
	int	(*translate)(u32 *addr, u64 offset, int na);
};

static u32 ft_find_cells(char *path, char *prop)
{
	void *devp;
	u32 num;
	char p[MAX_PATH_LEN];

	strcpy(p, path);
	do {
		if ((devp = finddevice(p))
				&& (getprop(devp, prop, &num, sizeof(num)) > 0))
			return num;
		ft_parentize(p, 0);
	} while (strlen(p) > 0);
	return 1; /* default of 1 */
}

static u64 ft_read_addr(u32 *cell, int size)
{
	u64 r = 0;
	while (size--)
		r = (r << 32) | *(cell++);
	return r;
}

static u64 ft_bus_default_map(u32 *addr, u32 *range, int na, int ns, int pna)
{
	u64 cp, s, da;

	cp = ft_read_addr(range, na);
	s  = ft_read_addr(range + na + pna, ns);
	da = ft_read_addr(addr, na);

	if (da < cp || da >= (cp + s))
		return BAD_ADDR;
	return da - cp;
}

static int ft_bus_default_translate(u32 *addr, u64 offset, int na)
{
	u64 a = ft_read_addr(addr, na);
	memset(addr, 0, na * 4);
	a += offset;
	if (na > 1)
		addr[na - 2] = a >> 32;
	addr[na - 1] = a & 0xffffffffu;

	return 0;
}

static u64 ft_bus_pci_map(u32 *addr, u32 *range, int na, int ns, int pna)
{
	u64 cp, s, da;

	/* Check address type match */
	if ((addr[0] ^ range[0]) & 0x03000000)
		return BAD_ADDR;

	/* Read address values, skipping high cell */
	cp = ft_read_addr(range + 1, na - 1);
	s  = ft_read_addr(range + na + pna, ns);
	da = ft_read_addr(addr + 1, na - 1);

	if (da < cp || da >= (cp + s))
		return BAD_ADDR;
	return da - cp;
}

static int ft_bus_pci_translate(u32 *addr, u64 offset, int na)
{
	return ft_bus_default_translate(addr + 1, offset, na - 1);
}

static u64 ft_bus_isa_map(u32 *addr, u32 *range, int na, int ns, int pna)
{
	u64 cp, s, da;

	/* Check address type match */
	if ((addr[0] ^ range[0]) & 0x00000001)
		return BAD_ADDR;

	/* Read address values, skipping high cell */
	cp = ft_read_addr(range + 1, na - 1);
	s  = ft_read_addr(range + na + pna, ns);
	da = ft_read_addr(addr + 1, na - 1);

	if (da < cp || da >= (cp + s))
		return BAD_ADDR;
	return da - cp;
}

static int ft_bus_isa_translate(u32 *addr, u64 offset, int na)
{
	return ft_bus_default_translate(addr + 1, offset, na - 1);
}

static void ft_match_bus(char *path, struct ft_bus *bus)
{
	void *devp;
	char dtype[128]; /* XXXX */

	if ((devp = finddevice(path)) && (getprop(devp, "device_type", dtype,
					sizeof(dtype)) > 0)) {
		if (!strcmp(dtype, "isa")) {
			bus->map = ft_bus_isa_map;
			bus->translate = ft_bus_isa_translate;
		} else if (!strcmp(dtype, "pci")) {
			bus->map = ft_bus_pci_map;
			bus->translate = ft_bus_pci_translate;
		} else {
			bus->map = ft_bus_default_map;
			bus->translate = ft_bus_default_translate;
		}
	}
}

static int ft_translate_one(char *path, struct ft_bus *bus, struct ft_bus *pbus,
		u32 *addr, u32 na, u32 ns, u32 pna)
{
	void *devp;
	u32 ranges[10 * (na + pna + ns)]; /* XXXX */
	u32 *rp;
	unsigned int rlen;
	int rone;
	u64 offset = BAD_ADDR;

	if (!(devp = finddevice(path))
			|| ((rlen = getprop(devp, "ranges", ranges,
						sizeof(ranges))) < 0)
			|| (rlen == 0)) {
		offset = ft_read_addr(addr, na);
		memset(addr, 0, pna * 4);
		goto finish;
	}

	rlen /= 4;
	rone = na + pna + ns;
	rp = ranges;
	for (; rlen >= rone; rlen -= rone, rp += rone) {
		offset = bus->map(addr, rp, na, ns, pna);
		if (offset != BAD_ADDR)
			break;
	}
	if (offset == BAD_ADDR)
		return 1;
	memcpy(addr, rp + na, 4 * pna);

finish:
	/* Translate it into parent bus space */
	return pbus->translate(addr, offset, pna);
}

/* 'addr' is modified */
static u64 ft_translate_addr(const char *p, const u32 *in_addr,
		const u32 addr_len)
{
	struct ft_bus	bus, pbus;
	int na, ns, pna, pns;
	u32 addr[MAX_ADDR_CELLS];
	char path[MAX_PATH_LEN], ppath[MAX_PATH_LEN];

	strcpy(ppath, p);
	ft_parentize(ppath, 0);
	ft_match_bus(ppath, &bus);
	na = ft_find_cells(ppath, "#address-cells");
	ns = ft_find_cells(ppath, "#size-cells");
	memcpy(addr, in_addr, na * 4);

	for (;;) {
		strcpy(path, ppath);
		ft_parentize(ppath, 0);

		if (strlen(ppath) == 0)
			return ft_read_addr(addr, na);

		ft_match_bus(ppath, &pbus);
		pna = ft_find_cells(ppath, "#address-cells");
		pns = ft_find_cells(ppath, "#size-cells");

		if (ft_translate_one(path, &bus, &pbus, addr, na, ns, pna))
			exit();

		na = pna;
		ns = pns;
		memcpy(&bus, &pbus, sizeof(struct ft_bus));
	}
}

static void *dtb;

static void *ft_finddevice(const char *name)
{
	return ft_find_device(dtb, name);
}

static int ft_getprop(const void *node, const char *propname, void *buf,
		const int buflen)
{
	return ft_get_prop(dtb, node, propname, buf, buflen);
}

static int ft_setprop(const void *node, const char *propname, const void *buf,
		const int buflen)
{
	return ft_set_prop(&dtb, node, propname, buf, buflen);
}

static void ft_call_kernel(void *entry_addr, unsigned long a1, unsigned long a2,
		void *promptr, void *sp)
{
	void (*kernel_entry)(void *dt_blob, void *start_addr,
			void *must_be_null);

#ifdef DEBUG
	printf("kernel:\n\r"
		"        entry addr   = 0x%lx\n\r"
		"        flattened dt = 0x%lx\n\r",
		(unsigned long)entry_addr, dtb);
#endif

	kernel_entry = entry_addr;
	kernel_entry(dtb, entry_addr, NULL);
}

void ft_init(void *dt_blob)
{
	dt_ops.finddevice = ft_finddevice;
	dt_ops.getprop = ft_getprop;
	dt_ops.setprop = ft_setprop;
	dt_ops.translate_addr = ft_translate_addr;
	dt_ops.call_kernel = ft_call_kernel;

	dtb = dt_blob;
}

--2fHTh5uZTiUOsy+g--
