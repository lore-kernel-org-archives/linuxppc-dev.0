Return-Path: <dgibson@ozlabs.org>
Date: Fri, 7 Nov 2008 13:31:40 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: dtc: Add python source code output
Message-ID: <20081107023140.GJ6692@yookeroo.seuss>
References: <1225958144.25986.9.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1225958144.25986.9.camel@localhost>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, devicetree-discuss@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Nov 06, 2008 at 06:55:44PM +1100, Michael Ellerman wrote:
> This commit adds an output format, which produces python
> code. When run, the python produces a data structure that
> can then be inspected in order to do various things.
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> ---
> 
> I'm not sure if this is generally useful (or sane) but it was for me so
> I thought I'd post it.

Hrm, well the idea of langauge source output seems reasonable.  But
the actual data structure emitted, and the method of construction in
Python both seem a bit odd to me.

> I have a dts that I want to use to configure a simulator, and this
> seemed like the nicest way to get there. dtc spits out the pythonised
> device tree, and then I have a 10 line python script that does the
> configuring.

[snip]
> diff --git a/python.c b/python.c
> new file mode 100644
> index 0000000..8ad0433
> --- /dev/null
> +++ b/python.c

AFAICT this is based roughly on the output side of treesource.c.  It
would be kind of nice if the two could be combined, with the same
basic structure looping over the device tree, and different emitters
for either python or dts source.  This would be similar to what we do
in flattree.c to emit either binary or asm versions of the flat tree.

> @@ -0,0 +1,129 @@
> +/*
> + * (C) Copyright David Gibson <dwg@au1.ibm.com>, IBM Corporation.  2005.
> + * (C) Copyright Michael Ellerman, IBM Corporation.  2008.
> + *
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of the
> + * License, or (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + *  General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, write to the Free Software
> + *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
> + *                                                                   USA
> + */
> +
> +#include "dtc.h"
> +#include "srcpos.h"
> +
> +
> +static void write_propval_cells(FILE *f, struct property *prop)
> +{
> +	cell_t *cp = (cell_t *)prop->val.val;
> +	int i;
> +
> +	fprintf(f, "    p = Property('%s', [", prop->name);
> +
> +	for (i = 0; i < prop->val.len / sizeof(cell_t); i++)
> +		fprintf(f, "0x%x, ", fdt32_to_cpu(cp[i]));
> +
> +	fprintf(f, "])\n");
> +}
> +
> +static int isstring(char c)
> +{
> +	return (isprint(c)
> +		|| (c == '\0')
> +		|| strchr("\a\b\t\n\v\f\r", c));
> +}
> +
> +static void write_property(FILE *f, struct property *prop)
> +{
> +	const char *p = prop->val.val;
> +	int i, strtype, len = prop->val.len;
> +
> +	if (len == 0) {
> +		fprintf(f, "    p = Property('%s', None)\n", prop->name);
> +		goto out;
> +	}
> +
> +	strtype = 1;
> +	for (i = 0; i < len; i++) {
> +		if (!isstring(p[i])) {
> +			strtype = 0;
> +			break;
> +		}
> +	}
> +
> +	if (strtype)
> +		fprintf(f, "    p = Property('%s', '%s')\n", prop->name,
> +			prop->val.val);

This isn't correct.  The property value could contain \0s or other
control characters which won't be preserved properly if emitted
directly into the python source.  You'd need to escape the string, as
write_propval_string() does in treesource.c.

Uh.. there's also an interesting ambiguity here.  In OF and flat
trees, strings are NUL-terminated and the final '\0' is included as
part of the property length.  Python strings are not NUL-terminated,
they're bytestrings that know their own length.  I think making sure
all the conversions correctly preserve the presence/lack of a terminal
NUL, requires a bit more care here..

> +	else if (len == 4)
> +		fprintf(f, "    p = Property('%s', 0x%x)\n", prop->name,
> +			fdt32_to_cpu(*(const cell_t *)p));

There's a propval_cell() function in livetree.c you can use to
simplify this.

> +	else
> +		write_propval_cells(f, prop);

Uh.. this branch could be called in the case where prop is not a
string, but also doesn't have length a multiple of 4, which
write_propval_cells() won't correctly deal with.

These branches also result in the value having different Python types
depending on the context.  That's not necessarily a bad thing, but
since which Python type is chosen depends on a heuristic only, it
certainly needs some care.  You certainly need to be certain that you
can always deduce the exact, byte-for-byte correct version of the
property value from whatever you put into the Python data structure.

> +	
> +out:
> +	fprintf(f, "    n.properties.append(p)\n");

So, emitting Python procedural code to build up the data structure,
rather than a great big Python literal that the Python parser will
just turn into the right thing seems a bit of a roundabout way of
doing this.

> +}
> +
> +static void write_tree_source_node(FILE *f, struct node *tree, int level)
> +{
> +	char name[MAX_NODENAME_LEN + 1] = "root";

Why not just have the root node's name be the empty string, as we do
in the flat tree?

> +	struct property *prop;
> +	struct node *child;
> +
> +	if (tree->name && (*tree->name))
> +		strncpy(name, tree->name, MAX_NODENAME_LEN);
> +
> +	fprintf(f, "    n = Node('%s', parents[-1])\n", name);
> +
> +	if (level > 0)
> +		fprintf(f, "    parents[-1].children.append(n)\n");
> +	else
> +		fprintf(f, "    root = n\n");
> +
> +	for_each_property(tree, prop)
> +		write_property(f, prop);
> +
> +	fprintf(f, "    parents.append(n)\n");
> +
> +	for_each_child(tree, child) {
> +		write_tree_source_node(f, child, level + 1);
> +	}
> +
> +	fprintf(f, "    parents.pop()\n");
> +}
> +
> +
> +static char *header = "#!/usr/bin/python\n\
> +\n\
> +class Node(object):\n\
> +    def __init__(self, name, parent, unitaddr=None):\n\

The unitaddr parameter is never used afaict.

> +        self.__dict__.update(locals())\n\
> +        self.children = []\n\
> +        self.properties = []\n\
> +\n\
> +class Property(object):\n\
> +    def __init__(self, name, value):\n\
> +        self.__dict__.update(locals())\n\
> +";
> +
> +void dt_to_python(FILE *f, struct boot_info *bi, int version)
> +{
> +	fprintf(f, "%s\n", header);
> +	fprintf(f, "def generate_tree():\n");
> +	fprintf(f, "    parents = [None]\n");
> +
> +	write_tree_source_node(f, bi->dt, 0);
> +
> +	fprintf(f, "    root.version = %d\n", version);

Since you're not emitting a flat tree, the version is not relevant
here, and should not be a parameter (again, like dt_to_source()).

> +	fprintf(f, "    return root\n");
> +}

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
