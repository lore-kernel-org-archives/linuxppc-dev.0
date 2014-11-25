Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8A22A1A04ED
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Nov 2014 10:08:19 +1100 (AEDT)
Message-ID: <1416956874.5089.13.camel@kernel.crashing.org>
Subject: Re: [PATCH v2 07/14] of/reconfig: Always use the same structure for
 notifiers
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@linaro.org>
Date: Wed, 26 Nov 2014 10:07:54 +1100
In-Reply-To: <1416868422-22103-8-git-send-email-grant.likely@linaro.org>
References: <1416868422-22103-1-git-send-email-grant.likely@linaro.org>
 <1416868422-22103-8-git-send-email-grant.likely@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: devicetree@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Mark Brown <broonie@kernel.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-11-24 at 22:33 +0000, Grant Likely wrote:
> The OF_RECONFIG notifier callback uses a different structure depending
> on whether it is a node change or a property change. This is silly, and
> not very safe. Rework the code to use the same data structure regardless
> of the type of notifier.

I fell pretty good about this one except...

> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
> index b9d1dfdbe5bb..9fe6002c1d5a 100644
> --- a/arch/powerpc/mm/numa.c
> +++ b/arch/powerpc/mm/numa.c
> @@ -1711,12 +1711,11 @@ static void stage_topology_update(int core_id)
>  static int dt_update_callback(struct notifier_block *nb,
>  				unsigned long action, void *data)
>  {
> -	struct of_prop_reconfig *update;
> +	struct of_reconfig_data *update = data;
>  	int rc = NOTIFY_DONE;
>  
>  	switch (action) {
>  	case OF_RECONFIG_UPDATE_PROPERTY:
> -		update = (struct of_prop_reconfig *)data;

Should we assert/bug on !update->dn / update->prop ?

(Same for the rest of the patch)

Or do you reckon it's pointless ?

Ben.
