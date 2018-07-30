Return-Path: <srs0=lxf2=ko=kernel.org=robh+dt@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41fLwm4JpMzF09Y
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jul 2018 00:07:04 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 41fLwk3mHmz8syR
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jul 2018 00:07:02 +1000 (AEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 41fLwj03c1z9s1R
 for <linuxppc-dev@ozlabs.org>; Tue, 31 Jul 2018 00:07:00 +1000 (AEST)
Received: from mail-qt0-f175.google.com (mail-qt0-f175.google.com
 [209.85.216.175])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 239F4208A1
 for <linuxppc-dev@ozlabs.org>; Mon, 30 Jul 2018 14:06:59 +0000 (UTC)
Received: by mail-qt0-f175.google.com with SMTP id a5-v6so12163952qtp.2
 for <linuxppc-dev@ozlabs.org>; Mon, 30 Jul 2018 07:06:59 -0700 (PDT)
MIME-Version: 1.0
References: <20180730131516.18406-1-mpe@ellerman.id.au>
In-Reply-To: <20180730131516.18406-1-mpe@ellerman.id.au>
From: Rob Herring <robh+dt@kernel.org>
Date: Mon, 30 Jul 2018 08:06:46 -0600
Message-ID: <CAL_JsqKYFk6-ofDFvaiy3a+r8Zyzw2UuMQUHb-RrgeWfpjom5w@mail.gmail.com>
Subject: Re: [PATCH 1/2] of: Add of_machine_compatible_match()
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 30, 2018 at 7:15 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> We have of_machine_is_compatible() to check if a machine is compatible
> with a single compatible string. However some code is able to support
> multiple compatible boards, and so wants to check for one of many
> compatible strings.
>
> So add of_machine_compatible_match() which takes a NULL terminated
> array of compatible strings to check against the root node's
> compatible property.
>
> Compared to an open coded match this is slightly more self
> documenting, and also avoids the caller needing to juggle the root
> node either directly or via of_find_node_by_path().
>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  drivers/of/base.c  | 21 +++++++++++++++++++++
>  include/linux/of.h |  6 ++++++
>  2 files changed, 27 insertions(+)
>
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index 848f549164cd..603716ba8513 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -505,6 +505,27 @@ int of_device_compatible_match(struct device_node *device,
>         return score;
>  }
>
> +/**
> + * of_machine_compatible_match - Test root of device tree against a compatible array
> + * @compats: NULL terminated array of compatible strings to look for in root node's compatible property.
> + *
> + * Returns true if the root node has any of the given compatible values in its
> + * compatible property.
> + */
> +bool of_machine_compatible_match(const char *const *compats)
> +{
> +       struct device_node *root;
> +       int rc = 0;
> +
> +       root = of_node_get(of_root);
> +       if (root) {
> +               rc = of_device_compatible_match(root, compats);
> +               of_node_put(root);
> +       }
> +
> +       return rc != 0;
> +}
> +
>  /**
>   * of_machine_is_compatible - Test root of device tree for a given compatible value
>   * @compat: compatible string to look for in root node's compatible property.
> diff --git a/include/linux/of.h b/include/linux/of.h
> index 4d25e4f952d9..05e3e23a3a57 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -389,6 +389,7 @@ extern int of_alias_get_id(struct device_node *np, const char *stem);
>  extern int of_alias_get_highest_id(const char *stem);
>
>  extern int of_machine_is_compatible(const char *compat);
> +extern bool of_machine_compatible_match(const char *const *compats);

Would be nice if of_machine_is_compatible could be implemented in
terms of of_machine_compatible_match like this:

int of_machine_is_compatible(const char *compat)
{
  const char *compats[] = { compat, NULL };
  return of_machine_is_compatible(compats);
}

Probably can be inline too.

Rob
