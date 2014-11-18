Return-Path: <glikely@secretlab.ca>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 514BE1A05F3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Nov 2014 03:52:46 +1100 (AEDT)
Received: from mail-wi0-f170.google.com (mail-wi0-f170.google.com
 [209.85.212.170])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 95790140174
 for <linuxppc-dev@ozlabs.org>; Wed, 19 Nov 2014 03:52:45 +1100 (AEDT)
Received: by mail-wi0-f170.google.com with SMTP id bs8so6900455wib.5
 for <linuxppc-dev@ozlabs.org>; Tue, 18 Nov 2014 08:52:42 -0800 (PST)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@linaro.org>
Subject: Re: [PATCH v3] of/base: Fix PowerPC address parsing hack
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1415948103.666.47.camel@kernel.crashing.org>
References: <1415771461.5124.33.camel@kernel.crashing.org>
 <20141113091036.4e9ec43d@canb.auug.org.au>
 <1415833725.5124.53.camel@kernel.crashing.org>
 <1415839522.5124.58.camel@kernel.crashing.org>
 <CACxGe6s0CXL2oRKCLhzzycOKWJStxdZsc1pn_X8fLuAqCguBMA@mail.gmail.com>
 <1415883227.666.6.camel@kernel.crashing.org>
 <1415948103.666.47.camel@kernel.crashing.org>
Date: Tue, 18 Nov 2014 16:52:38 +0000
Message-Id: <20141118165238.3C4FEC40966@trevor.secretlab.ca>
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

On Fri, 14 Nov 2014 17:55:03 +1100
, Benjamin Herrenschmidt <benh@kernel.crashing.org>
 wrote:
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

Acked-by: Grant Likely <grant.likely@linaro.org>

Rob will pick up this patch and send it to Linus in his fixups tree for
v3.18

g.

> ---
> 
> V2: Make it less horrendously ugly
> 
> V3: use IS_ENABLED()
> 
>  drivers/of/address.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/of/address.c b/drivers/of/address.c
> index e371825..42e416a 100644
> --- a/drivers/of/address.c
> +++ b/drivers/of/address.c
> @@ -403,6 +403,21 @@ static struct of_bus *of_match_bus(struct device_node *np)
>  	return NULL;
>  }
>  
> +static int of_empty_ranges_quirk(void)
> +{
> +	if (IS_ENABLED(CONFIG_PPC)) {
> +		/* To save cycles, we cache the result */
> +		static int quirk_state = -1;
> +
> +		if (quirk_state < 0)
> +			quirk_state =
> +				of_machine_is_compatible("Power Macintosh") ||
> +				of_machine_is_compatible("MacRISC");
> +		return quirk_state;
> +	}
> +	return false;
> +}
> +
>  static int of_translate_one(struct device_node *parent, struct of_bus *bus,
>  			    struct of_bus *pbus, __be32 *addr,
>  			    int na, int ns, int pna, const char *rprop)
> @@ -428,12 +443,10 @@ static int of_translate_one(struct device_node *parent, struct of_bus *bus,
>  	 * This code is only enabled on powerpc. --gcl
>  	 */
>  	ranges = of_get_property(parent, rprop, &rlen);
> -#if !defined(CONFIG_PPC)
> -	if (ranges == NULL) {
> +	if (ranges == NULL && !of_empty_ranges_quirk()) {
>  		pr_err("OF: no ranges; cannot translate\n");
>  		return 1;
>  	}
> -#endif /* !defined(CONFIG_PPC) */
>  	if (ranges == NULL || rlen == 0) {
>  		offset = of_read_number(addr, na);
>  		memset(addr, 0, pna * 4);
> 
> 
> 
