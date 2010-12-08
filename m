Return-Path: <B07421@freescale.com>
Received: from AM1EHSOBE001.bigfish.com (am1ehsobe001.messaging.microsoft.com
	[213.199.154.204])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E3003B70A5
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  9 Dec 2010 08:01:17 +1100 (EST)
Received: from mail72-am1 (localhost.localdomain [127.0.0.1])	by
	mail72-am1-R.bigfish.com (Postfix) with ESMTP id 998C019004EC	for
	<linuxppc-dev@lists.ozlabs.org>; Wed,  8 Dec 2010 21:01:10 +0000 (UTC)
Received: from AM1EHSMHS005.bigfish.com (unknown [10.3.201.246])	by
	mail72-am1.bigfish.com (Postfix) with ESMTP id 2B54FE7804F	for
	<linuxppc-dev@lists.ozlabs.org>; Wed,  8 Dec 2010 21:01:10 +0000 (UTC)
Received: from az33smr02.freescale.net (az33smr02.freescale.net
	[10.64.34.200])	by de01egw01.freescale.net (8.14.3/8.14.3) with ESMTP
	id oB8L3IJS017604	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 8 Dec 2010 14:03:18 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id
	oB8L15Mo003046	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 8 Dec 2010 15:01:05 -0600 (CST)
Date: Wed, 8 Dec 2010 15:01:02 -0600
From: Scott Wood <scottwood@freescale.com>
To: Deepak Saxena <deepak_saxena@mentor.com>
Subject: Re: [PATCH 3/5] of/device: Make of_get_next_child() check status
	properties
Message-ID: <20101208150102.69b8062b@udp111988uds.am.freescale.net>
In-Reply-To: <20101208192944.GE32473@mentor.com>
References: <cover.1291799069.git.deepak_saxena@mentor.com>
	<20101208192944.GE32473@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: devicetree-discuss@ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 8 Dec 2010 11:29:44 -0800
Deepak Saxena <deepak_saxena@mentor.com> wrote:

> We only return the next child if the device is available.
> 
> Signed-off-by: Hollis Blanchard <hollis_blanchard@mentor.com>
> Signed-off-by: Deepak Saxena <deepak_saxena@mentor.com>
> ---
>  drivers/of/base.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index 5d269a4..81b2601 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -321,6 +321,8 @@ struct device_node *of_get_next_parent(struct device_node *node)
>   *
>   *	Returns a node pointer with refcount incremented, use
>   *	of_node_put() on it when done.
> + *
> + *	Does not return nodes marked unavailable by a status property.
>   */
>  struct device_node *of_get_next_child(const struct device_node *node,
>  	struct device_node *prev)
> @@ -330,7 +332,7 @@ struct device_node *of_get_next_child(const struct device_node *node,
>  	read_lock(&devtree_lock);
>  	next = prev ? prev->sibling : node->child;
>  	for (; next; next = next->sibling)
> -		if (of_node_get(next))
> +		if (of_device_is_available(next) && of_node_get(next))
>  			break;
>  	of_node_put(prev);
>  	read_unlock(&devtree_lock);

This seems like too low-level a place to put this.  Some code may know
how to un-disable a device in certain situations, or it may be part of
debug code trying to dump the whole device tree, etc.  Looking
further[1], I see a raw version of this function, but not other things
like of_find_compatible_node.

Could this be done more othogonally, so that the caller specifies in a
parameter whether to skip based on status?

-Scott

[1] For some reason I received some of these patches from
linuxppc-dev, and others from devicetree-discuss.  I wish lists
wouldn't try to be "smart" about discarding duplicates -- it messes with
filters.
