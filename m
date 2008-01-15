Return-Path: <dgibson@ozlabs.org>
Date: Tue, 15 Jan 2008 11:16:57 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [DTC PATCH] libfdt: Add ft_get_next_node(),
	ft_get_next_prop(), and ft_getprop_offset().
Message-ID: <20080115001657.GC20649@localhost.localdomain>
References: <20080114163004.GA27880@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080114163004.GA27880@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, jdl@jdl.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jan 14, 2008 at 10:30:04AM -0600, Scott Wood wrote:
> ft_get_next_node() enumerates children of a given node.
> ft_get_next_prop() enumerates propreties of a given node.
> 
> ft_getprop_offset() is like ft_getprop(), but takes a property offset rather
> than a node offset and property name; it is primarily intended for use
> with ft_get_next_prop().

Urg... this kind of serves me right for not getting my act together on
iterator functions yet.  I really don't like this approach much.  I'll
see if I can come up with something I prefer this afternoon.

The biggest thing I dislike is that I've deliberately avoided having
any offsets-to-properties exposed to the library user.  That's because
the whole offsets change when you write the tree problem is worse for
properties than nodes (in that likely idiomatic uses will be bitten by
changes in property offsets).

Some more specific comments on the patch below.

[snip]
> +const void *fdt_getprop_offset(const void *fdt, int propoffset,
> +                               const char **name, int *lenp)
> +{
> +	uint32_t tag;
> +	const struct fdt_property *prop;
> +	int namestroff;
> +	int err, len;
> +
> +	err = fdt_check_header(fdt);
> +	if (err)
> +		goto fail;
> +
> +	tag = fdt_next_tag(fdt,propoffset, NULL);
> +	if (tag != FDT_PROP) {
> +		err = -FDT_ERR_BADOFFSET;
> +		goto fail;
> +	}
> +
> +	err = -FDT_ERR_BADSTRUCTURE;
> +	prop = fdt_offset_ptr(fdt, propoffset, sizeof(*prop));
> +	if (!prop)
> +		goto fail;
> +
> +	if (name) {
> +		namestroff = fdt32_to_cpu(prop->nameoff);
> +		*name = fdt_string(fdt, namestroff);
> +	}
> +
> +	len = fdt32_to_cpu(prop->len);
> +	if (lenp)
> +		*lenp = len;
> +
> +	prop = fdt_offset_ptr(fdt, propoffset, sizeof(*prop) + len);
> +	if (!prop)
> +		goto fail;

This juggling to call fdt_offset_ptr() over the whole length of the
property representation should be rolled up into an internal function
and used within fdt_get_property() as well.

[snip]
> +int fdt_get_next_node(const void *fdt, int startoffset,
> +                      int *depth, int recursive)
> +{
> +	uint32_t tag;
> +	int offset, nextoffset;
> +
> +	CHECK_HEADER(fdt);
> +
> +	if (startoffset >= 0) {
> +		tag = fdt_next_tag(fdt, startoffset, &nextoffset);
> +		if (tag != FDT_BEGIN_NODE)
> +			return -FDT_ERR_BADOFFSET;
> +	} else {
> +		nextoffset = 0;
> +	}
> +
> +	do {
> +		offset = nextoffset;
> +		tag = fdt_next_tag(fdt, offset, &nextoffset);
> +
> +		switch (tag) {
> +		case FDT_BEGIN_NODE:
> +			if ((*depth)++ == 0 || recursive) {
> +				return offset;
> +			}
> +
> +			break;
> +
> +		case FDT_END_NODE:
> +			if (--*depth < 0)
> +				return -FDT_ERR_NOTFOUND;
> +
> +			break;
> +
> +		case FDT_PROP:
> +		case FDT_END:
> +		case FDT_NOP:
> +			break;
> +
> +		default:
> +			return -FDT_ERR_BADSTRUCTURE;
> +		}
> +	} while (tag != FDT_END);
> +
> +	if (depth != 0)
> +		return -FDT_ERR_BADSTRUCTURE;

I think this should be FDT_ERR_TRUNCATED.

> +	return -FDT_ERR_NOTFOUND;

In fact, so should this.  This function should never actually reach
the FDT_END tag.

> +}
> +
> +int fdt_get_next_prop(const void *fdt, int startoffset)
> +{
> +	uint32_t tag;
> +	int offset, nextoffset;
> +
> +	CHECK_HEADER(fdt);
> +
> +	if (startoffset >= 0) {
> +		tag = fdt_next_tag(fdt, startoffset, &nextoffset);
> +		if (tag != FDT_BEGIN_NODE && tag != FDT_PROP)
> +			return -FDT_ERR_BADOFFSET;
> +	} else {
> +		nextoffset = 0;

This alternate case shouldn't be here.  For properties, the given
offset should always be either the node offset to find within, or
another property offset.  This other case simply makes negative and 0
startoffset equivalent.  Instead, negative startoffset should cause
FDT_ERR_BADOFFSET.

> +	}
> +
> +	do {
> +		offset = nextoffset;
> +		tag = fdt_next_tag(fdt, offset, &nextoffset);
> +
> +		switch (tag) {
> +		case FDT_BEGIN_NODE:
> +		case FDT_END_NODE:
> +			return -FDT_ERR_NOTFOUND;
> +
> +		case FDT_PROP:
> +			return offset;
> +
> +		case FDT_END:
> +		case FDT_NOP:
> +			break;
> +
> +		default:
> +			return -FDT_ERR_BADSTRUCTURE;
> +		}
> +	} while (tag != FDT_END);
> +
> +	return -FDT_ERR_BADSTRUCTURE;

Should be FDT_ERR_TRUNCATED again.

> +}
> diff --git a/libfdt/fdt_strerror.c b/libfdt/fdt_strerror.c
> index f9d32ef..4e87550 100644
> --- a/libfdt/fdt_strerror.c
> +++ b/libfdt/fdt_strerror.c
> @@ -70,6 +70,7 @@ static struct errtabent errtable[] = {
>  	ERRTABENT(FDT_ERR_BADOFFSET),
>  	ERRTABENT(FDT_ERR_BADPATH),
>  	ERRTABENT(FDT_ERR_BADSTATE),
> +	ERRTABENT(FDT_ERR_BADDEPTH),
>  
>  	ERRTABENT(FDT_ERR_TRUNCATED),
>  	ERRTABENT(FDT_ERR_BADMAGIC),
> diff --git a/libfdt/libfdt.h b/libfdt/libfdt.h
> index d053689..6c5d4a9 100644
> --- a/libfdt/libfdt.h
> +++ b/libfdt/libfdt.h
> @@ -85,25 +85,28 @@
>  	/* FDT_ERR_BADSTATE: Function was passed an incomplete device
>  	 * tree created by the sequential-write functions, which is
>  	 * not sufficiently complete for the requested operation. */
> +#define FDT_ERR_BADDEPTH	8
> +	/* FDT_ERR_BADDEPTH: Function was passed a negative
> +	 * (or otherwise invalid) depth. */

You've added this error code, but you don't actually return it
anywhere...

[snip]
>  /**
> + * fdt_getprop_offset - retrieve the value of a given property by offset
> + * @fdt: pointer to the device tree blob
> + * @propoffset: offset of the property to read
> + * @name: pointer to a character pointer (will be overwritten) or NULL
> + * @lenp: pointer to an integer variable (will be overwritten) or NULL
> + *
> + * fdt_getprop() retrieves a pointer to the value of the property
> + * named 'name' of the node at offset nodeoffset (this will be a
> + * pointer to within the device blob itself, not a copy of the value).
> + * If lenp is non-NULL, the length of the property value also
> + * returned, in the integer pointed to by lenp.

This description is incorrect - you've copied the fdt_getprop()
description and forgotten to update it.

[snip]

And finally, new libfdt functions should have testcases.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
