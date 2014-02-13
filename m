Return-Path: <robherring2@gmail.com>
Received: from mail-vc0-x22f.google.com (mail-vc0-x22f.google.com
 [IPv6:2607:f8b0:400c:c03::22f])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D8CC02C0089
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Feb 2014 06:01:46 +1100 (EST)
Received: by mail-vc0-f175.google.com with SMTP id ij19so8543499vcb.34
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Feb 2014 11:01:42 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1392205084-2351-1-git-send-email-haokexin@gmail.com>
References: <1392205084-2351-1-git-send-email-haokexin@gmail.com>
Date: Thu, 13 Feb 2014 13:01:42 -0600
Message-ID: <CAL_JsqKMi2H=vwoxrOt8QRA2xJeiLqBKKfLtt4QRCRoFk6JUHg@mail.gmail.com>
Subject: Re: [PATCH] of: give priority to the compatible match in
 __of_match_node()
From: Rob Herring <robherring2@gmail.com>
To: Kevin Hao <haokexin@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Chris Proctor <cproctor@csc.com.au>,
 Stephen N Chivers <schivers@csc.com.au>,
 Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Scott Wood <scottwood@freescale.com>,
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

On Wed, Feb 12, 2014 at 5:38 AM, Kevin Hao <haokexin@gmail.com> wrote:
> When the device node do have a compatible property, we definitely
> prefer the compatible match besides the type and name. Only if
> there is no such a match, we then consider the candidate which
> doesn't have compatible entry but do match the type or name with
> the device node.
>
> This is based on a patch from Sebastian Hesselbarth.
>   http://patchwork.ozlabs.org/patch/319434/
>
> I did some code refactoring and also fixed a bug in the original patch.

I'm inclined to just revert this once again and avoid possibly
breaking yet another platform.

However, I think I would like to see this structured differently. We
basically have 2 ways of matching: the existing pre-3.14 way and the
desired match on best compatible only. All new bindings should match
with the new way and the old way needs to be kept for compatibility.
So lets structure the code that way. Search the match table first for
best compatible with name and type NULL, then search the table the old
way. I realize it appears you are doing this, but it is not clear this
is the intent of the code. I would like to see this written as a patch
with commit 105353145eafb3ea919 reverted first and you add a new match
function to call first and then fallback to the existing function.

Rob

>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Signed-off-by: Kevin Hao <haokexin@gmail.com>
> ---
>  drivers/of/base.c | 55 +++++++++++++++++++++++++++++++++++++------------------
>  1 file changed, 37 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index ff85450d5683..9d655df458bd 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -730,32 +730,45 @@ out:
>  }
>  EXPORT_SYMBOL(of_find_node_with_property);
>
> +static int of_match_type_or_name(const struct device_node *node,
> +                               const struct of_device_id *m)
> +{
> +       int match = 1;
> +
> +       if (m->name[0])
> +               match &= node->name && !strcmp(m->name, node->name);
> +
> +       if (m->type[0])
> +               match &= node->type && !strcmp(m->type, node->type);
> +
> +       return match;
> +}
> +
>  static
>  const struct of_device_id *__of_match_node(const struct of_device_id *matches,
>                                            const struct device_node *node)
>  {
>         const char *cp;
>         int cplen, l;
> +       const struct of_device_id *m;
> +       int match;
>
>         if (!matches)
>                 return NULL;
>
>         cp = __of_get_property(node, "compatible", &cplen);
> -       do {
> -               const struct of_device_id *m = matches;
> +       while (cp && (cplen > 0)) {
> +               m = matches;
>
>                 /* Check against matches with current compatible string */
>                 while (m->name[0] || m->type[0] || m->compatible[0]) {
> -                       int match = 1;
> -                       if (m->name[0])
> -                               match &= node->name
> -                                       && !strcmp(m->name, node->name);
> -                       if (m->type[0])
> -                               match &= node->type
> -                                       && !strcmp(m->type, node->type);
> -                       if (m->compatible[0])
> -                               match &= cp
> -                                       && !of_compat_cmp(m->compatible, cp,
> +                       if (!m->compatible[0]) {
> +                               m++;
> +                               continue;
> +                       }
> +
> +                       match = of_match_type_or_name(node, m);
> +                       match &= cp && !of_compat_cmp(m->compatible, cp,
>                                                         strlen(m->compatible));
>                         if (match)
>                                 return m;
> @@ -763,12 +776,18 @@ const struct of_device_id *__of_match_node(const struct of_device_id *matches,
>                 }
>
>                 /* Get node's next compatible string */
> -               if (cp) {
> -                       l = strlen(cp) + 1;
> -                       cp += l;
> -                       cplen -= l;
> -               }
> -       } while (cp && (cplen > 0));
> +               l = strlen(cp) + 1;
> +               cp += l;
> +               cplen -= l;
> +       }
> +
> +       m = matches;
> +       /* Check against matches without compatible string */
> +       while (m->name[0] || m->type[0] || m->compatible[0]) {
> +               if (!m->compatible[0] && of_match_type_or_name(node, m))
> +                       return m;
> +               m++;
> +       }
>
>         return NULL;
>  }
> --
> 1.8.5.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
