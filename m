Return-Path: <schivers@csc.com.au>
Received: from mail1.bemta12.messagelabs.com (mail1.bemta12.messagelabs.com
 [216.82.251.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id EEFD82C008F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Feb 2014 07:42:39 +1100 (EST)
In-Reply-To: <1392205084-2351-1-git-send-email-haokexin@gmail.com>
References: <1392205084-2351-1-git-send-email-haokexin@gmail.com>
To: Kevin Hao <haokexin@gmail.com>
MIME-Version: 1.0
Subject: Re: [PATCH] of: give priority to the compatible match in
 __of_match_node()
From: Stephen N Chivers <schivers@csc.com.au>
Message-ID: <OFDE2BD1C1.39A6B15F-ONCA257C7D.006F7E2F-CA257C7D.0071BCDF@csc.com>
Date: Thu, 13 Feb 2014 06:42:19 +1000
Content-Type: text/plain; charset="US-ASCII"
Cc: Chris Proctor <cproctor@csc.com.au>, Arnd Bergmann <arnd@arndb.de>,
 devicetree@vger.kernel.org, Stephen N Chivers <schivers@csc.com.au>,
 Scott Wood <scottwood@freescale.com>, Rob Herring <robh+dt@kernel.org>,
 Grant Likely <grant.likely@linaro.org>, linuxppc-dev@lists.ozlabs.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Kevin Hao <haokexin@gmail.com> wrote on 02/12/2014 10:38:04 PM:

> From: Kevin Hao <haokexin@gmail.com>
> To: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Stephen
> N Chivers <schivers@csc.com.au>, Chris Proctor 
> <cproctor@csc.com.au>, Arnd Bergmann <arnd@arndb.de>, Scott Wood 
> <scottwood@freescale.com>, Grant Likely <grant.likely@linaro.org>, 
> Rob Herring <robh+dt@kernel.org>
> Date: 02/12/2014 10:38 PM
> Subject: [PATCH] of: give priority to the compatible match in 
> __of_match_node()
> 
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
> 
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Signed-off-by: Kevin Hao <haokexin@gmail.com>
Tested-by: Stephen Chivers <schivers@csc.com>

Patch works for both orderings. Platform boots without problems and
I get the normal serial console.
> ---
>  drivers/of/base.c | 55 ++++++++++++++++++++++++++++++++++++
> +------------------
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
> +            const struct of_device_id *m)
> +{
> +   int match = 1;
> +
> +   if (m->name[0])
> +      match &= node->name && !strcmp(m->name, node->name);
> +
> +   if (m->type[0])
> +      match &= node->type && !strcmp(m->type, node->type);
> +
> +   return match;
> +}
> +
>  static
>  const struct of_device_id *__of_match_node(const struct 
> of_device_id *matches,
>                    const struct device_node *node)
>  {
>     const char *cp;
>     int cplen, l;
> +   const struct of_device_id *m;
> +   int match;
> 
>     if (!matches)
>        return NULL;
> 
>     cp = __of_get_property(node, "compatible", &cplen);
> -   do {
> -      const struct of_device_id *m = matches;
> +   while (cp && (cplen > 0)) {
> +      m = matches;
> 
>        /* Check against matches with current compatible string */
>        while (m->name[0] || m->type[0] || m->compatible[0]) {
> -         int match = 1;
> -         if (m->name[0])
> -            match &= node->name
> -               && !strcmp(m->name, node->name);
> -         if (m->type[0])
> -            match &= node->type
> -               && !strcmp(m->type, node->type);
> -         if (m->compatible[0])
> -            match &= cp
> -               && !of_compat_cmp(m->compatible, cp,
> +         if (!m->compatible[0]) {
> +            m++;
> +            continue;
> +         }
> +
> +         match = of_match_type_or_name(node, m);
> +         match &= cp && !of_compat_cmp(m->compatible, cp,
>                       strlen(m->compatible));
>           if (match)
>              return m;
> @@ -763,12 +776,18 @@ const struct of_device_id *__of_match_node
> (const struct of_device_id *matches,
>        }
> 
>        /* Get node's next compatible string */ 
> -      if (cp) {
> -         l = strlen(cp) + 1;
> -         cp += l;
> -         cplen -= l;
> -      }
> -   } while (cp && (cplen > 0));
> +      l = strlen(cp) + 1;
> +      cp += l;
> +      cplen -= l;
> +   }
> +
> +   m = matches;
> +   /* Check against matches without compatible string */
> +   while (m->name[0] || m->type[0] || m->compatible[0]) {
> +      if (!m->compatible[0] && of_match_type_or_name(node, m))
> +         return m;
> +      m++;
> +   }
> 
>     return NULL;
>  }
> -- 
> 1.8.5.3
> 
