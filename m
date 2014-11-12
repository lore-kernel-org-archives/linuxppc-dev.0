Return-Path: <robherring2@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EE0E31A0061
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Nov 2014 01:39:57 +1100 (AEDT)
Received: from mail-la0-x233.google.com (mail-la0-x233.google.com
 [IPv6:2a00:1450:4010:c03::233])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 22ED71400B6
 for <linuxppc-dev@ozlabs.org>; Thu, 13 Nov 2014 01:39:57 +1100 (AEDT)
Received: by mail-la0-f51.google.com with SMTP id q1so11491324lam.38
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Nov 2014 06:39:52 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1415771461.5124.33.camel@kernel.crashing.org>
References: <1415771461.5124.33.camel@kernel.crashing.org>
From: Rob Herring <robherring2@gmail.com>
Date: Wed, 12 Nov 2014 08:39:32 -0600
Message-ID: <CAL_JsqKfBGdpFV_XuE4DEhFrkhN33kOMkiZE_TOnAZDm2qjwMw@mail.gmail.com>
Subject: Re: [PATCH] of/base: Fix PowerPC address parsing hack
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, linuxppc-dev <linuxppc-dev@ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Olof Johansson <olof@lixom.net>, Grant Likely <grant.likely@linaro.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Nov 11, 2014 at 11:51 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> We have a historical hack that treats missing ranges properties as the
> equivalent of an empty one. This is needed for ancient PowerMac "bad"
> device-trees, and shouldn't be enabled for any other PowerPC platform,
> otherwise we get some nasty layout of devices in sysfs or even
> duplication when a set of otherwise identically named devices is
> created multiple times under a different parent node with no ranges
> property.
>
> This fix is needed for the PowerNV i2c busses to be exposed properly
> and will fix a number of other embedded cases.
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> CC: <stable@vger.kernel.org>
> ---
>
> diff --git a/drivers/of/address.c b/drivers/of/address.c
> index e371825..e37f017 100644
> --- a/drivers/of/address.c
> +++ b/drivers/of/address.c
> @@ -7,6 +7,10 @@
>  #include <linux/pci_regs.h>
>  #include <linux/string.h>
>
> +#ifdef CONFIG_PPC
> +#include <asm/machdep.h>
> +#endif
> +
>  /* Max address size we deal with */
>  #define OF_MAX_ADDR_CELLS      4
>  #define OF_CHECK_ADDR_COUNT(na)        ((na) > 0 && (na) <= OF_MAX_ADDR_CELLS)
> @@ -428,12 +432,13 @@ static int of_translate_one(struct device_node *parent, struct of_bus *bus,
>          * This code is only enabled on powerpc. --gcl
>          */
>         ranges = of_get_property(parent, rprop, &rlen);
> -#if !defined(CONFIG_PPC)
> +#if defined(CONFIG_PPC)
> +       if (!machine_is(powermac))

Can we use a machine compatible here or something not PPC specific?
Then we can use IS_ENABLED(CONFIG_PPC) instead of ifdefs.

Rob

> +#endif /* defined(CONFIG_PPC) */
>         if (ranges == NULL) {
> -               pr_err("OF: no ranges; cannot translate\n");
> +               pr_debug("OF: no ranges; cannot translate\n");
>                 return 1;
>         }
> -#endif /* !defined(CONFIG_PPC) */
>         if (ranges == NULL || rlen == 0) {
>                 offset = of_read_number(addr, na);
>                 memset(addr, 0, pna * 4);
>
