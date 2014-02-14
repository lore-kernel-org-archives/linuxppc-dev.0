Return-Path: <robherring2@gmail.com>
Received: from mail-vc0-x233.google.com (mail-vc0-x233.google.com
 [IPv6:2607:f8b0:400c:c03::233])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id CF4AF2C007C
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Feb 2014 02:53:44 +1100 (EST)
Received: by mail-vc0-f179.google.com with SMTP id lh14so9277882vcb.24
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Feb 2014 07:53:40 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1392355366-1445-3-git-send-email-haokexin@gmail.com>
References: <1392355366-1445-1-git-send-email-haokexin@gmail.com>
 <1392355366-1445-3-git-send-email-haokexin@gmail.com>
Date: Fri, 14 Feb 2014 09:53:40 -0600
Message-ID: <CAL_JsqKq4_1K8EF+PZoP=0=H6tiRxbgdzs9UHHVdbHS014n74Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] of: search the best compatible match first in
 __of_match_node()
From: Rob Herring <robherring2@gmail.com>
To: Kevin Hao <haokexin@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Stephen N Chivers <schivers@csc.com.au>, Rob Herring <robh+dt@kernel.org>,
 Kumar Gala <galak@codeaurora.org>, Grant Likely <grant.likely@linaro.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Feb 13, 2014 at 11:22 PM, Kevin Hao <haokexin@gmail.com> wrote:
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

Looks good to me. I'll put this in next for a few days. I'd really
like to see some acks and tested-by's before sending to Linus.

We could be a bit more strict here and fallback to the old matching if
the match table has any entries with name or type. I don't think that
should be necessary though.

Rob

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
> +                       const struct device_node *node)
> +{
> +       const char *cp;
> +       int cplen, l;
> +       const struct of_device_id *m;
> +
> +       cp = __of_get_property(node, "compatible", &cplen);
> +       while (cp && (cplen > 0)) {
> +               m = matches;
> +               while (m->name[0] || m->type[0] || m->compatible[0]) {
> +                       /* Only match for the entries without type and name */
> +                       if (m->name[0] || m->type[0] ||
> +                               of_compat_cmp(m->compatible, cp,
> +                                        strlen(m->compatible)))
> +                               m++;
> +                       else
> +                               return m;
> +               }
> +
> +               /* Get node's next compatible string */
> +               l = strlen(cp) + 1;
> +               cp += l;
> +               cplen -= l;
> +       }
> +
> +       return NULL;
> +}
> +
>  static
>  const struct of_device_id *__of_match_node(const struct of_device_id *matches,
>                                            const struct device_node *node)
>  {
> +       const struct of_device_id *m;
> +
>         if (!matches)
>                 return NULL;
>
> +       m = of_match_compatible(matches, node);
> +       if (m)
> +               return m;
> +
>         while (matches->name[0] || matches->type[0] || matches->compatible[0]) {
>                 int match = 1;
>                 if (matches->name[0])
> @@ -760,7 +796,12 @@ const struct of_device_id *__of_match_node(const struct of_device_id *matches,
>   *     @matches:       array of of device match structures to search in
>   *     @node:          the of device structure to match against
>   *
> - *     Low level utility function used by device matching.
> + *     Low level utility function used by device matching. We have two ways
> + *     of matching:
> + *     - Try to find the best compatible match by comparing each compatible
> + *       string of device node with all the given matches respectively.
> + *     - If the above method failed, then try to match the compatible by using
> + *       __of_device_is_compatible() besides the match in type and name.
>   */
>  const struct of_device_id *of_match_node(const struct of_device_id *matches,
>                                          const struct device_node *node)
> --
> 1.8.5.3
>
