Return-Path: <stern+5260885c@rowland.harvard.edu>
Received: from iolanthe.rowland.org (iolanthe.rowland.org [192.131.102.54])
 by ozlabs.org (Postfix) with SMTP id D8ECF2C0439
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Nov 2013 02:11:01 +1100 (EST)
Date: Tue, 5 Nov 2013 10:04:19 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
To: Alistair Popple <alistair@popple.id.au>
Subject: Re: [PATCH 5/7] IBM Akebono: Add support to the EHCI platform driver
 for Akebono
In-Reply-To: <1383629471-16979-5-git-send-email-alistair@popple.id.au>
Message-ID: <Pine.LNX.4.44L0.1311051004080.1360-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 5 Nov 2013, Alistair Popple wrote:

> The IBM Akebono board has an EHCI compliant USB host interface. This
> patch adds support for it to the EHCI platform driver.
> 
> Signed-off-by: Alistair Popple <alistair@popple.id.au>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: linux-usb@vger.kernel.org
> ---
>  drivers/usb/host/ehci-platform.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
> index f6b790c..0a67616 100644
> --- a/drivers/usb/host/ehci-platform.c
> +++ b/drivers/usb/host/ehci-platform.c
> @@ -203,9 +203,10 @@ static int ehci_platform_resume(struct device *dev)
>  #define ehci_platform_resume	NULL
>  #endif /* CONFIG_PM */
>  
> -static const struct of_device_id vt8500_ehci_ids[] = {
> +static const struct of_device_id ehci_platform_ids[] = {
>  	{ .compatible = "via,vt8500-ehci", },
>  	{ .compatible = "wm,prizm-ehci", },
> +	{ .compatible = "ibm,akebono-ehci", },
>  	{}
>  };
>  
> @@ -229,7 +230,7 @@ static struct platform_driver ehci_platform_driver = {
>  		.owner	= THIS_MODULE,
>  		.name	= "ehci-platform",
>  		.pm	= &ehci_platform_pm_ops,
> -		.of_match_table = vt8500_ehci_ids,
> +		.of_match_table = ehci_platform_ids,
>  	}
>  };

Acked-by: Alan Stern <stern@rowland.harvard.edu>
