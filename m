Return-Path: <glikely@secretlab.ca>
Received: from mail-wi0-f176.google.com (mail-wi0-f176.google.com
 [209.85.212.176])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3644F2C00D0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Feb 2014 04:58:45 +1100 (EST)
Received: by mail-wi0-f176.google.com with SMTP id hi5so2676152wib.15
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Feb 2014 09:58:40 -0800 (PST)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@linaro.org>
Subject: Re: [PATCH 2/2] of: search the best compatible match first in
 __of_match_node()
To: Kevin Hao <haokexin@gmail.com>, devicetree@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
In-Reply-To: <1392355366-1445-3-git-send-email-haokexin@gmail.com>
References: <1392355366-1445-1-git-send-email-haokexin@gmail.com> <
 1392355366-1445-3-git-send-email-haokexin@gmail.com>
Date: Mon, 17 Feb 2014 17:58:34 +0000
Message-Id: <20140217175834.62ED6C403C8@trevor.secretlab.ca>
Cc: Stephen N Chivers <schivers@csc.com.au>, Rob Herring <robh+dt@kernel.org>,
 Kevin Hao <haokexin@gmail.com>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 14 Feb 2014 13:22:46 +0800, Kevin Hao <haokexin@gmail.com> wrote:
> Currently, of_match_node compares each given match against all node's
> compatible strings with of_device_is_compatible.
> 
> To achieve multiple compatible strings per node with ordering from
> specific to generic, this requires given matches to be ordered from
> specific to generic. For most of the drivers this is not true and also
> an alphabetical ordering is more sane there.
> 
> Therefore, this patch introduces a function to match each of the node's
> compatible strings against all given compatible matches without type and
> name first, before checking the next compatible string. This implies
> that node's compatibles are ordered from specific to generic while
> given matches can be in any order. If we fail to find such a match
> entry, then fall-back to the old method in order to keep compatibility.
> 
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Signed-off-by: Kevin Hao <haokexin@gmail.com>
> ---
>  drivers/of/base.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 42 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index ba195fbce4c6..10b51106c854 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -730,13 +730,49 @@ out:
>  }
>  EXPORT_SYMBOL(of_find_node_with_property);
>  
> +static const struct of_device_id *
> +of_match_compatible(const struct of_device_id *matches,
> +			const struct device_node *node)
> +{
> +	const char *cp;
> +	int cplen, l;
> +	const struct of_device_id *m;
> +
> +	cp = __of_get_property(node, "compatible", &cplen);
> +	while (cp && (cplen > 0)) {
> +		m = matches;
> +		while (m->name[0] || m->type[0] || m->compatible[0]) {
> +			/* Only match for the entries without type and name */
> +			if (m->name[0] || m->type[0] ||
> +				of_compat_cmp(m->compatible, cp,
> +					 strlen(m->compatible)))
> +				m++;

This seems wrong also. The compatible order should be checked for even
when m->name or m->type are set.  You actually need to score the entries
to do this properly. The pseudo-code should look like this:

uint best_score = ~0;
of_device_id *best_match = NULL;
for_each(matches) {
	uint score = ~0;
	for_each_compatible(index) {
		if (match->compatible == compatible[index])
			score = index * 10;
	}

	/* Matching name is a bit better than not */
	if (match->name == node->name)
		score--;

	/* Matching type is better than matching name */
	/* (but matching both is even better than that */
	if (match->type == node->type)
		score -= 2;

	if (score < best_score)
		best_match = match;
}
return best_match;

This is actually very similar to the original code. It is an easy
modification. This is very similar to how the of_fdt_is_compatible()
function works.

g.
