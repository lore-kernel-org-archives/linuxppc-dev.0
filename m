Return-Path: <tcminyard@gmail.com>
Received: from mail-oi0-x235.google.com (mail-oi0-x235.google.com
 [IPv6:2607:f8b0:4003:c06::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47CA31A058C
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 May 2015 03:43:18 +1000 (AEST)
Received: by oign205 with SMTP id n205so39454450oig.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 May 2015 10:43:15 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Message-ID: <554BA42F.6070001@acm.org>
Date: Thu, 07 May 2015 12:43:11 -0500
From: Corey Minyard <minyard@acm.org>
Reply-To: minyard@acm.org
MIME-Version: 1.0
To: Alistair Popple <alistair@popple.id.au>,
 linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
Subject: Re: [PATCH v3 2/8] ipmi/powernv: Convert to irq event interface
References: <1430968578-23527-1-git-send-email-alistair@popple.id.au>
 <1430968578-23527-2-git-send-email-alistair@popple.id.au>
In-Reply-To: <1430968578-23527-2-git-send-email-alistair@popple.id.au>
Content-Type: text/plain; charset=windows-1252
Cc: openipmi-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/06/2015 10:16 PM, Alistair Popple wrote:
> Convert the opal ipmi driver to use the new irq interface for events.
>
> Signed-off-by: Alistair Popple <alistair@popple.id.au>
> Cc: Corey Minyard <minyard@acm.org>
> Cc: openipmi-developer@lists.sourceforge.net
> ---
>
> Corey,
>
> If this looks ok can you please ack it? Michael Ellerman will then take
> the whole series via the powerpc tree. Thanks.

This looks fine; I don't really understand much of this, but I don't see
any issues.

The only thing I would suggest is passing the irq level
(IRQ_TYPE_LEVEL_HIGH) as
part of the openfirmware data instead of hard-coding it.

Acked-by: Corey Minyard <cminyard@mvista.com>

>
>  drivers/char/ipmi/ipmi_powernv.c | 39 ++++++++++++++++++++++-----------------
>  1 file changed, 22 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/char/ipmi/ipmi_powernv.c b/drivers/char/ipmi/ipmi_powernv.c
> index 8753b0f..9b409c0 100644
> --- a/drivers/char/ipmi/ipmi_powernv.c
> +++ b/drivers/char/ipmi/ipmi_powernv.c
> @@ -15,6 +15,8 @@
>  #include <linux/list.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/of_irq.h>
> +#include <linux/interrupt.h>
>
>  #include <asm/opal.h>
>
> @@ -23,8 +25,7 @@ struct ipmi_smi_powernv {
>  	u64			interface_id;
>  	struct ipmi_device_id	ipmi_id;
>  	ipmi_smi_t		intf;
> -	u64			event;
> -	struct notifier_block	event_nb;
> +	unsigned int		irq;
>
>  	/**
>  	 * We assume that there can only be one outstanding request, so
> @@ -197,15 +198,12 @@ static struct ipmi_smi_handlers ipmi_powernv_smi_handlers = {
>  	.poll			= ipmi_powernv_poll,
>  };
>
> -static int ipmi_opal_event(struct notifier_block *nb,
> -			  unsigned long events, void *change)
> +static irqreturn_t ipmi_opal_event(int irq, void *data)
>  {
> -	struct ipmi_smi_powernv *smi = container_of(nb,
> -					struct ipmi_smi_powernv, event_nb);
> +	struct ipmi_smi_powernv *smi = data;
>
> -	if (events & smi->event)
> -		ipmi_powernv_recv(smi);
> -	return 0;
> +	ipmi_powernv_recv(smi);
> +	return IRQ_HANDLED;
>  }
>
>  static int ipmi_powernv_probe(struct platform_device *pdev)
> @@ -240,13 +238,16 @@ static int ipmi_powernv_probe(struct platform_device *pdev)
>  		goto err_free;
>  	}
>
> -	ipmi->event = 1ull << prop;
> -	ipmi->event_nb.notifier_call = ipmi_opal_event;
> +	ipmi->irq = irq_of_parse_and_map(dev->of_node, 0);
> +	if (!ipmi->irq) {
> +		dev_info(dev, "Unable to map irq from device tree\n");
> +		ipmi->irq = opal_event_request(prop);
> +	}
>
> -	rc = opal_notifier_register(&ipmi->event_nb);
> -	if (rc) {
> -		dev_warn(dev, "OPAL notifier registration failed (%d)\n", rc);
> -		goto err_free;
> +	if (request_irq(ipmi->irq, ipmi_opal_event, IRQ_TYPE_LEVEL_HIGH,
> +				"opal-ipmi", ipmi)) {
> +		dev_warn(dev, "Unable to request irq\n");
> +		goto err_dispose;
>  	}
>
>  	ipmi->opal_msg = devm_kmalloc(dev,
> @@ -271,7 +272,9 @@ static int ipmi_powernv_probe(struct platform_device *pdev)
>  err_free_msg:
>  	devm_kfree(dev, ipmi->opal_msg);
>  err_unregister:
> -	opal_notifier_unregister(&ipmi->event_nb);
> +	free_irq(ipmi->irq, ipmi);
> +err_dispose:
> +	irq_dispose_mapping(ipmi->irq);
>  err_free:
>  	devm_kfree(dev, ipmi);
>  	return rc;
> @@ -282,7 +285,9 @@ static int ipmi_powernv_remove(struct platform_device *pdev)
>  	struct ipmi_smi_powernv *smi = dev_get_drvdata(&pdev->dev);
>
>  	ipmi_unregister_smi(smi->intf);
> -	opal_notifier_unregister(&smi->event_nb);
> +	free_irq(smi->irq, smi);
> +	irq_dispose_mapping(smi->irq);
> +
>  	return 0;
>  }
>
> --
> 1.8.3.2
>
