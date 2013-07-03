Return-Path: <robherring2@gmail.com>
Message-ID: <51D430C7.8030100@gmail.com>
Date: Wed, 03 Jul 2013 09:10:15 -0500
From: Rob Herring <robherring2@gmail.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] of: Fix address decoding on Bimini and js2x machines
References: <1372831270.4122.36.camel@pasglop>
In-Reply-To: <1372831270.4122.36.camel@pasglop>
Content-Type: text/plain; charset=UTF-8
Cc: Grant Likely <grant.likely@linaro.org>, devicetree-discuss@lists.ozlabs.org,
 Thierry Reding <thierry.reding@avionic-design.de>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/03/2013 01:01 AM, Benjamin Herrenschmidt wrote:
>  Commit:
>     
>   e38c0a1fbc5803cbacdaac0557c70ac8ca5152e7
>   of/address: Handle #address-cells > 2 specially
>     
> broke real time clock access on Bimini, js2x, and similar powerpc
> machines using the "maple" platform. That code was indirectly relying
> on the old (broken) behaviour of the translation for the hypertransport
> to ISA bridge.
>     
> This fixes it by treating hypertransport as a PCI bus
>     
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> CC: <stable@vger.kernel.org> [v3.6+]
> ---
> 
> Rob, if you have no objection I will put that in powerpc -next

NP.

Acked-by: Rob Herring <rob.herring@calxeda.com>

Rob

> 
> diff --git a/drivers/of/address.c b/drivers/of/address.c
> index 04da786..7c8221d 100644
> --- a/drivers/of/address.c
> +++ b/drivers/of/address.c
> @@ -106,8 +106,12 @@ static unsigned int of_bus_default_get_flags(const __be32 *
>  
>  static int of_bus_pci_match(struct device_node *np)
>  {
> -       /* "vci" is for the /chaos bridge on 1st-gen PCI powermacs */
> -       return !strcmp(np->type, "pci") || !strcmp(np->type, "vci");
> +       /*
> +        * "vci" is for the /chaos bridge on 1st-gen PCI powermacs
> +        * "ht" is hypertransport
> +        */
> +       return !strcmp(np->type, "pci") || !strcmp(np->type, "vci") ||
> +               !strcmp(np->type, "ht");
>  }
>  
>  static void of_bus_pci_count_cells(struct device_node *np,
> 
> 
