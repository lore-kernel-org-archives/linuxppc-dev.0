Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 58BF81A0018
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jun 2015 13:23:46 +1000 (AEST)
Message-ID: <1435634613.26815.78.camel@kernel.crashing.org>
Subject: Re: [PATCH] Fix pSeries boot failure, by returning interrupt
 controller node when an interrupt-map property doesn't exist
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jeremy Linton <lintonrjeremy@gmail.com>
Cc: robherring2@gmail.com, grant.likely@linaro.org, devicetree@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, paulus@samba.org
Date: Tue, 30 Jun 2015 13:23:33 +1000
In-Reply-To: <CAEFTgixGKnMuMGp2DfoksqF0m_P6-EGJ0sUjg2=ReX2X0tq2nA@mail.gmail.com>
References: <CAEFTgixGKnMuMGp2DfoksqF0m_P6-EGJ0sUjg2=ReX2X0tq2nA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-06-29 at 18:50 -0500, Jeremy Linton wrote:
> This is a reformat of the patch attached to "pSeries boot failure due
> to wrong interrupt controller".
> 
> It allows of_irq_parse_raw() to return the node pointer of the
> interrupt controller, rather than the parent bus. This allows
> ics_rtas_host_match() to detect that the controller is a legacy 8259
> and avoid using xics. This avoids an RTAS assertion/crash during early
> kernel bootstrapping
> 
> Signed-off-by: Jeremy Linton <lintonrjeremy@gmail.com>

Reviewed-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Rob, do you want to take this or should we ?

> ---
>  drivers/of/irq.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/of/irq.c b/drivers/of/irq.c
> index 1a79806..cb4b9ae 100644
> --- a/drivers/of/irq.c
> +++ b/drivers/of/irq.c
> @@ -252,8 +252,6 @@ int of_irq_parse_raw(const __be32 *addr, struct
> of_phandle_args *out_irq)
>                  * Successfully parsed an interrrupt-map translation; copy new
>                  * interrupt specifier into the out_irq structure
>                  */
> -               out_irq->np = newpar;
> -
>                 match_array = imap - newaddrsize - newintsize;
>                 for (i = 0; i < newintsize; i++)
>                         out_irq->args[i] = be32_to_cpup(imap - newintsize + i);
> @@ -262,6 +260,7 @@ int of_irq_parse_raw(const __be32 *addr, struct
> of_phandle_args *out_irq)
> 
>         skiplevel:
>                 /* Iterate again with new parent */
> +               out_irq->np = newpar;
>                 pr_debug(" -> new parent: %s\n", of_node_full_name(newpar));
>                 of_node_put(ipar);
>                 ipar = newpar;
> --
> 1.8.1.4
