Return-Path: <glikely@secretlab.ca>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 446D21A0023
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Nov 2014 23:44:42 +1100 (AEDT)
Received: from mail-ig0-f177.google.com (mail-ig0-f177.google.com
 [209.85.213.177])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A8B7D1400D2
 for <linuxppc-dev@ozlabs.org>; Thu, 13 Nov 2014 23:44:41 +1100 (AEDT)
Received: by mail-ig0-f177.google.com with SMTP id hl2so4846209igb.4
 for <linuxppc-dev@ozlabs.org>; Thu, 13 Nov 2014 04:44:39 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1415839522.5124.58.camel@kernel.crashing.org>
References: <1415771461.5124.33.camel@kernel.crashing.org>
 <20141113091036.4e9ec43d@canb.auug.org.au>
 <1415833725.5124.53.camel@kernel.crashing.org>
 <1415839522.5124.58.camel@kernel.crashing.org>
From: Grant Likely <grant.likely@linaro.org>
Date: Thu, 13 Nov 2014 12:44:19 +0000
Message-ID: <CACxGe6s0CXL2oRKCLhzzycOKWJStxdZsc1pn_X8fLuAqCguBMA@mail.gmail.com>
Subject: Re: [PATCH] of/base: Fix PowerPC address parsing hack
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>, Rob Herring <robherring2@gmail.com>,
 Olof Johansson <olof@lixom.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 13, 2014 at 12:45 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> What about this one instead ? I want to cache it because that function
> can be called quite a while and doing two additional property lookup
> and string compares every time might hurt some platforms.
>
> ----
>
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

How far back does this need to go? I assume I need to get this in for v3.18.

>
> diff --git a/drivers/of/address.c b/drivers/of/address.c
> index e371825..5eae0cd 100644
> --- a/drivers/of/address.c
> +++ b/drivers/of/address.c
> @@ -403,6 +403,17 @@ static struct of_bus *of_match_bus(struct device_node *np)
>         return NULL;
>  }
>
> +static int of_empty_ranges_quirk(void)
> +{
> +       /* To save cycles, we cache the result */
> +       static int quirk_state = -1;
> +

if (IS_ENABLED(CONFIG_POWERPC)) {

> +       if (quirk_state < 0)
> +               quirk_state = of_machine_is_compatible("Power Macintosh") ||
> +                       of_machine_is_compatible("MacRISC");
> +       return quirk_state;

}
return 0;

So it gets compiled out for non powerpc.

> +}
> +
>  static int of_translate_one(struct device_node *parent, struct of_bus *bus,
>                             struct of_bus *pbus, __be32 *addr,
>                             int na, int ns, int pna, const char *rprop)
> @@ -428,12 +439,10 @@ static int of_translate_one(struct device_node *parent, struct of_bus *bus,
>          * This code is only enabled on powerpc. --gcl
>          */
>         ranges = of_get_property(parent, rprop, &rlen);
> -#if !defined(CONFIG_PPC)
> -       if (ranges == NULL) {
> +       if (ranges == NULL && !of_empty_ranges_quirk()) {
>                 pr_err("OF: no ranges; cannot translate\n");
>                 return 1;
>         }
> -#endif /* !defined(CONFIG_PPC) */
>         if (ranges == NULL || rlen == 0) {
>                 offset = of_read_number(addr, na);
>                 memset(addr, 0, pna * 4);
>
>
