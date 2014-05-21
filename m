Return-Path: <sergei.shtylyov@cogentembedded.com>
Received: from mail-lb0-f169.google.com (mail-lb0-f169.google.com
 [209.85.217.169])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40FB51A082E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 May 2014 07:58:12 +1000 (EST)
Received: by mail-lb0-f169.google.com with SMTP id s7so2035862lbd.14
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 May 2014 14:58:08 -0700 (PDT)
Message-ID: <537D2174.8040405@cogentembedded.com>
Date: Thu, 22 May 2014 01:58:12 +0400
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
To: Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH RESEND net-next 5/9] fs_enet: use the new fixed PHY helpers
References: <1400708331-18088-1-git-send-email-f.fainelli@gmail.com>
 <1400708331-18088-6-git-send-email-f.fainelli@gmail.com>
In-Reply-To: <1400708331-18088-6-git-send-email-f.fainelli@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 "open list:OPEN FIRMWARE AND..." <devicetree@vger.kernel.org>,
 Aida Mynzhasova <aida.mynzhasova@skitlab.ru>,
 Richard Cochran <richardcochran@gmail.com>,
 open list <linux-kernel@vger.kernel.org>,
 Claudiu Manoil <claudiu.manoil@freescale.com>,
 Vitaly Bordug <vbordug@ru.mvista.com>, Grant Likely <grant.likely@linaro.org>,
 "open list:LINUX FOR POWERPC..." <linuxppc-dev@lists.ozlabs.org>,
 davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/22/2014 01:38 AM, Florian Fainelli wrote:

> of_phy_connect_fixed_link() is becoming obsolete, and also required
> platform code to register the fixed PHYs at the specified addresses for
> those to be usable. Get rid of it and use the new of_phy_is_fixed_link()
> plus of_phy_register_fixed_link() helpers to transition over the new
> scheme.

> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>   drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c | 16 +++++++++-------
>   1 file changed, 9 insertions(+), 7 deletions(-)

> diff --git a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c b/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
> index dc80db41d6b3..d602711e00e9 100644
> --- a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
> +++ b/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
[...]
> @@ -1029,9 +1025,15 @@ static int fs_enet_probe(struct platform_device *ofdev)
>   	fpi->use_napi = 1;
>   	fpi->napi_weight = 17;
>   	fpi->phy_node = of_parse_phandle(ofdev->dev.of_node, "phy-handle", 0);
> -	if ((!fpi->phy_node) && (!of_get_property(ofdev->dev.of_node, "fixed-link",
> -						  NULL)))
> -		goto out_free_fpi;
> +	if (!fpi->phy_node) {
> +		if (of_phy_is_fixed_link(ofdev->dev.of_node)) {

    These two *if* statements could be collapsed, reducing the indentation 
level below.

> +			err = of_phy_register_fixed_link(ofdev->dev.of_node);
> +			if (err)
> +				goto out_free_fpi;
> +
> +			fpi->phy_node = ofdev->dev.of_node;
> +		}
> +	}

WBR, Sergei
