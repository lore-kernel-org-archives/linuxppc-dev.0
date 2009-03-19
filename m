Return-Path: <glikely@secretlab.ca>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.30])
	by ozlabs.org (Postfix) with ESMTP id AB95CDF8AA
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Mar 2009 16:05:23 +1100 (EST)
Received: by yw-out-2324.google.com with SMTP id 9so251590ywe.39
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Mar 2009 22:05:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090319050015.11320.61641.stgit@localhost.localdomain>
References: <20090319050015.11320.61641.stgit@localhost.localdomain>
Date: Wed, 18 Mar 2009 23:05:21 -0600
Message-ID: <fa686aa40903182205w231e17e9wbd0dcc05d994d46e@mail.gmail.com>
Subject: Re: [PATCH 1/9] of: add of_parse_phandle() helper for parsing phandle
	properties
From: Grant Likely <grant.likely@secretlab.ca>
To: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org, afleming@freescale.com,
	avorontsov@ru.mvista.com, davem@davemloft.net, galak@kernel.crashing.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Bah!  Messed up the 'stg mail' command when sending this series and
the 'RFC' tag didn't get added.

This is firmly in the RFC category.  Please don't apply.  It doesn't
have the level of polish that I'm happy with.

This series is intended to make phy_device connecting simpler and more
robust by using the PHY's device_node as the search key when
connecting to PHY.  Changes are made to both the MDIO busses to
extract the PHY data out of the device tree, and to the drivers to use
a common helper function for finding the PHY it is interested in.

Comments please.
g.

On Wed, Mar 18, 2009 at 11:00 PM, Grant Likely
<grant.likely@secretlab.ca> wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
>
> of_parse_phandle() is a helper function to read and parse a phandle
> property and return a pointer to the resulting device_node.
>
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---
>
> =A0drivers/of/base.c =A0| =A0 23 +++++++++++++++++++++++
> =A0include/linux/of.h | =A0 =A03 +++
> =A02 files changed, 26 insertions(+), 0 deletions(-)
>
>
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index cd17092..1eaada4 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -494,6 +494,29 @@ int of_modalias_node(struct device_node *node, char =
*modalias, int len)
> =A0EXPORT_SYMBOL_GPL(of_modalias_node);
>
> =A0/**
> + * of_parse_phandle - Resolve a phandle property to a device_node pointe=
r
> + * @np: Pointer to device node holding phandle property
> + * @phandle_name: Name of property holding a phandle value
> + * @index: For properties holding a table of phandles, this is the index=
 into
> + * =A0 =A0 =A0 =A0 the table
> + *
> + * Returns the device_node pointer pointed to by the phandle, or NULL
> + */
> +struct device_node *
> +of_parse_phandle(struct device_node *np, const char *phandle_name, int i=
ndex)
> +{
> + =A0 =A0 =A0 const phandle *phandle;
> + =A0 =A0 =A0 int size;
> +
> + =A0 =A0 =A0 phandle =3D of_get_property(np, phandle_name, &size);
> + =A0 =A0 =A0 if ((!phandle) || (size < sizeof(*phandle) * (index + 1)))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
> +
> + =A0 =A0 =A0 return of_find_node_by_phandle(phandle[index]);
> +}
> +EXPORT_SYMBOL(of_parse_phandle);
> +
> +/**
> =A0* of_parse_phandles_with_args - Find a node pointed by phandle in a li=
st
> =A0* @np: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pointer to a device tree node co=
ntaining a list
> =A0* @list_name: property name that contains a list
> diff --git a/include/linux/of.h b/include/linux/of.h
> index 6a7efa2..7be2d10 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -77,6 +77,9 @@ extern int of_n_size_cells(struct device_node *np);
> =A0extern const struct of_device_id *of_match_node(
> =A0 =A0 =A0 =A0const struct of_device_id *matches, const struct device_no=
de *node);
> =A0extern int of_modalias_node(struct device_node *node, char *modalias, =
int len);
> +extern struct device_node *of_parse_phandle(struct device_node *np,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 const char *phandle_name,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 int index);
> =A0extern int of_parse_phandles_with_args(struct device_node *np,
> =A0 =A0 =A0 =A0const char *list_name, const char *cells_name, int index,
> =A0 =A0 =A0 =A0struct device_node **out_node, const void **out_args);
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
