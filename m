Return-Path: <info@schihei.de>
In-Reply-To: <20070423202223.549bf53a@localhost>
References: <20070423202223.549bf53a@localhost>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <F0EE9F3B-8504-4F73-A8CD-E5713206699B@schihei.de>
From: Heiko J Schick <info@schihei.de>
Subject: Re: [patch 1/2] powerpc: add check for initialized driver data to pmi
	driver
Date: Tue, 24 Apr 2007 07:53:49 +0200
To: Christian Krafft <krafft@de.ibm.com>
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Acked-by: Heiko J Schick <schickhj@de.ibm.com>

On 23.04.2007, at 20:22, Christian Krafft wrote:

> From: Christian Krafft <krafft@de.ibm.com>
> This patch adds a check for the private driver data to be initialized.
> The bug showed up, as the caller found a pmi device by it's type.
> Whereas the pmi driver probes for the type and the name.
> Since the name was not as the driver expected, it did not initialize.
> A more relaxed probing will be supplied with an extra patch, too.
>
> Signed-off-by: Christian Krafft <krafft@de.ibm.com>
> Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
>
> Index: sdk3/arch/powerpc/sysdev/pmi.c
> ===================================================================
> --- sdk3.orig/arch/powerpc/sysdev/pmi.c
> +++ sdk3/arch/powerpc/sysdev/pmi.c
> @@ -264,6 +264,9 @@ void pmi_register_handler(struct of_devi
>  	struct pmi_data *data;
>  	data = device->dev.driver_data;
>
> +	if (!data)
> +		return;
> +
>  	spin_lock(&data->handler_spinlock);
>  	list_add_tail(&handler->node, &data->handler);
>  	spin_unlock(&data->handler_spinlock);
> @@ -274,10 +277,12 @@ void pmi_unregister_handler(struct of_de
>  			    struct pmi_handler *handler)
>  {
>  	struct pmi_data *data;
> +	data = device->dev.driver_data;
>
> -	pr_debug("pmi: unregistering handler %p\n", handler);
> +	if (!data)
> +		return;
>
> -	data = device->dev.driver_data;
> +	pr_debug("pmi: unregistering handler %p\n", handler);
>
>  	spin_lock(&data->handler_spinlock);
>  	list_del(&handler->node);
>
>
> -- 
> Mit freundlichen Gruessen,
> kind regards,
>
> Christian Krafft
> IBM Systems & Technology Group,
> Linux Kernel Development
> IT Specialist
>
>
> Vorsitzender des Aufsichtsrats:	Johann Weihen
> Geschaeftsfuehrung:		Herbert Kircher
> Sitz der Gesellschaft:		Boeblingen
> Registriergericht:		Amtsgericht Stuttgart, HRB 243294
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
