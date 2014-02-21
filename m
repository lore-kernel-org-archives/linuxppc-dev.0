Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
 [212.227.126.171]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 693842C046F
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Feb 2014 01:22:24 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Alistair Popple <alistair@popple.id.au>
Subject: Re: [PATCH 3/7] IBM Akebono: Add support to the OHCI platform driver
 for PPC476GTR
Date: Fri, 21 Feb 2014 15:16:52 +0100
Message-ID: <16991392.luyzl1NYP3@wuerfel>
In-Reply-To: <1392964293-13687-4-git-send-email-alistair@popple.id.au>
References: <1392964293-13687-1-git-send-email-alistair@popple.id.au>
 <1392964293-13687-4-git-send-email-alistair@popple.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Friday 21 February 2014 17:31:29 Alistair Popple wrote:
> 
> +static const struct of_device_id ohci_of_match[] = {
> +       { .compatible = "usb-ohci", },
> +       {},
> +};
> +
>  static const struct platform_device_id ohci_platform_table[] = {
>         { "ohci-platform", 0 },
>         { }
> @@ -198,6 +209,7 @@ static struct platform_driver ohci_platform_driver = {
>                 .owner  = THIS_MODULE,
>                 .name   = "ohci-platform",
>                 .pm     = &ohci_platform_pm_ops,
> +               .of_match_table = ohci_of_match,
>         }
>  };
>  
> 

Linux-next already has a patch to add an of_match_table in this driver,
using 

static const struct of_device_id ohci_platform_ids[] = {
        { .compatible = "generic-ohci", },
        { }
};

I think you should just use that string on your platform.

	Arnd
