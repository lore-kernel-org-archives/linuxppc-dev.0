Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound7-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id C06C7DDECA
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jan 2008 06:23:42 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [RFC] Add of_find_matching_node() helper function
Date: Mon, 7 Jan 2008 11:23:36 -0800
In-Reply-To: <20080107181418.11906.13427.stgit@trillian.secretlab.ca>
References: <20080107181418.11906.13427.stgit@trillian.secretlab.ca>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "Grant Likely" <grant.likely@secretlab.ca>, <paulus@samba.org>,
	<sfr@canb.auug.org.au>, <linuxppc-dev@ozlabs.org>
Message-Id: <20080107192337.02CED8D8065@mail9-blu.bigfish.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I wanted such function too, but stopped short of writing it because
of_match_node was in the wrong place.

Steve

> -----Original Message-----
> From: =
linuxppc-dev-bounces+stephen.neuendorffer=3Dxilinx.com@ozlabs.org
[mailto:linuxppc-dev-
> bounces+stephen.neuendorffer=3Dxilinx.com@ozlabs.org] On Behalf Of =
Grant
Likely
> Sent: Monday, January 07, 2008 10:16 AM
> To: paulus@samba.org; sfr@canb.auug.org.au; linuxppc-dev@ozlabs.org
> Subject: [RFC] Add of_find_matching_node() helper function
>=20
> From: Grant Likely <grant.likely@secretlab.ca>
>=20
> Similar to of_find_compatible_node(), of_find_matching_node() and
> for_each_matching_node() allow you to iterate over the device tree
> looking for specific nodes except that it accepts a of_device_id
> table instead of strings.
>=20
> This patch also moves of_match_node() from driver/of/device.c to
> driver/of/base.c to colocate it with the of_find_matching_node which
> depends on it.
>=20
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---
>=20
> I've found this change useful for the 5200 board ports to clean up the
> platform matching code.  It works well in my environment, but it could
> have farther reaching consequences.  Please review and comment.
>=20
> Cheers,
> g.
>=20
>  drivers/of/base.c         |   58
+++++++++++++++++++++++++++++++++++++++++++++
>  drivers/of/device.c       |   29 -----------------------
>  include/linux/of.h        |    8 ++++++
>  include/linux/of_device.h |    2 --
>  4 files changed, 66 insertions(+), 31 deletions(-)
>=20
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index 9377f3b..b306fef 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -273,3 +273,61 @@ struct device_node
*of_find_compatible_node(struct device_node *from,
>  	return np;
>  }
>  EXPORT_SYMBOL(of_find_compatible_node);
> +
> +/**
> + * of_match_node - Tell if an device_node has a matching of_match
structure
> + *	@matches:	array of of device match structures to search in
> + *	@node:		the of device structure to match against
> + *
> + *	Low level utility function used by device matching.
> + */
> +const struct of_device_id *of_match_node(const struct of_device_id
*matches,
> +					 const struct device_node *node)
> +{
> +	while (matches->name[0] || matches->type[0] ||
matches->compatible[0]) {
> +		int match =3D 1;
> +		if (matches->name[0])
> +			match &=3D node->name
> +				&& !strcmp(matches->name, node->name);
> +		if (matches->type[0])
> +			match &=3D node->type
> +				&& !strcmp(matches->type, node->type);
> +		if (matches->compatible[0])
> +			match &=3D of_device_is_compatible(node,
> +						matches->compatible);
> +		if (match)
> +			return matches;
> +		matches++;
> +	}
> +	return NULL;
> +}
> +EXPORT_SYMBOL(of_match_node);
> +
> +/**
> + *	of_find_matching_node - Find a node based on an of_device_id
match
> + *				table.
> + *	@from:		The node to start searching from or NULL, the
node
> + *			you pass will not be searched, only the next one
> + *			will; typically, you pass what the previous call
> + *			returned. of_node_put() will be called on it
> + *	@matches:	array of of device match structures to search in
> + *
> + *	Returns a node pointer with refcount incremented, use
> + *	of_node_put() on it when done.
> + */
> +struct device_node *of_find_matching_node(struct device_node *from,
> +					  const struct of_device_id
*matches)
> +{
> +	struct device_node *np;
> +
> +	read_lock(&devtree_lock);
> +	np =3D from ? from->allnext : allnodes;
> +	for (; np; np =3D np->allnext) {
> +		if (of_match_node(matches, np) && of_node_get(np))
> +			break;
> +	}
> +	of_node_put(from);
> +	read_unlock(&devtree_lock);
> +	return np;
> +}
> +EXPORT_SYMBOL(of_find_matching_node);
> diff --git a/drivers/of/device.c b/drivers/of/device.c
> index 6245f06..29681c4 100644
> --- a/drivers/of/device.c
> +++ b/drivers/of/device.c
> @@ -10,35 +10,6 @@
>  #include <asm/errno.h>
>=20
>  /**
> - * of_match_node - Tell if an device_node has a matching of_match
structure
> - * @ids: array of of device match structures to search in
> - * @node: the of device structure to match against
> - *
> - * Low level utility function used by device matching.
> - */
> -const struct of_device_id *of_match_node(const struct of_device_id
*matches,
> -					 const struct device_node *node)
> -{
> -	while (matches->name[0] || matches->type[0] ||
matches->compatible[0]) {
> -		int match =3D 1;
> -		if (matches->name[0])
> -			match &=3D node->name
> -				&& !strcmp(matches->name, node->name);
> -		if (matches->type[0])
> -			match &=3D node->type
> -				&& !strcmp(matches->type, node->type);
> -		if (matches->compatible[0])
> -			match &=3D of_device_is_compatible(node,
> -						matches->compatible);
> -		if (match)
> -			return matches;
> -		matches++;
> -	}
> -	return NULL;
> -}
> -EXPORT_SYMBOL(of_match_node);
> -
> -/**
>   * of_match_device - Tell if an of_device structure has a matching
>   * of_match structure
>   * @ids: array of of device match structures to search in
> diff --git a/include/linux/of.h b/include/linux/of.h
> index c65af7b..b5f33ef 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -17,6 +17,7 @@
>   */
>  #include <linux/types.h>
>  #include <linux/bitops.h>
> +#include <linux/mod_devicetable.h>
>=20
>  #include <asm/prom.h>
>=20
> @@ -41,6 +42,11 @@ extern struct device_node
*of_find_compatible_node(struct device_node *from,
>  #define for_each_compatible_node(dn, type, compatible) \
>  	for (dn =3D of_find_compatible_node(NULL, type, compatible); dn; \
>  	     dn =3D of_find_compatible_node(dn, type, compatible))
> +extern struct device_node *of_find_matching_node(struct device_node
*from,
> +	const struct of_device_id *matches);
> +#define for_each_matching_node(dn, matches) \
> +	for (dn =3D of_find_matching_node(NULL, matches); dn; \
> +	     dn =3D of_find_matching_node(dn, matches))
>  extern struct device_node *of_find_node_by_path(const char *path);
>  extern struct device_node *of_find_node_by_phandle(phandle handle);
>  extern struct device_node *of_get_parent(const struct device_node
*node);
> @@ -60,5 +66,7 @@ extern const void *of_get_property(const struct
device_node *node,
>  				int *lenp);
>  extern int of_n_addr_cells(struct device_node *np);
>  extern int of_n_size_cells(struct device_node *np);
> +extern const struct of_device_id *of_match_node(
> +	const struct of_device_id *matches, const struct device_node
*node);
>=20
>  #endif /* _LINUX_OF_H */
> diff --git a/include/linux/of_device.h b/include/linux/of_device.h
> index 212bffb..6dc1195 100644
> --- a/include/linux/of_device.h
> +++ b/include/linux/of_device.h
> @@ -10,8 +10,6 @@
>=20
>  #define	to_of_device(d) container_of(d, struct of_device, dev)
>=20
> -extern const struct of_device_id *of_match_node(
> -	const struct of_device_id *matches, const struct device_node
*node);
>  extern const struct of_device_id *of_match_device(
>  	const struct of_device_id *matches, const struct of_device
*dev);
>=20
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
