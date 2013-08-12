Return-Path: <sergei.shtylyov@cogentembedded.com>
Received: from mail-la0-f45.google.com (mail-la0-f45.google.com
 [209.85.215.45])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E2C492C00DA
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Aug 2013 04:16:06 +1000 (EST)
Received: by mail-la0-f45.google.com with SMTP id fj20so5049991lab.18
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Aug 2013 11:16:02 -0700 (PDT)
Message-ID: <52092662.6040507@cogentembedded.com>
Date: Mon, 12 Aug 2013 22:16:02 +0400
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
To: Libo Chen <clbchenlibo.chen@huawei.com>
Subject: Re: [PATCH 4/8] net: fs_enet: use platform_{get,set}_drvdata()
References: <5208E222.60300@huawei.com>
In-Reply-To: <5208E222.60300@huawei.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Li Zefan <lizefan@huawei.com>, vbordug@ru.mvista.com,
 linuxppc-dev@lists.ozlabs.org, David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/12/2013 05:24 PM, Libo Chen wrote:

> Use the wrapper functions for getting and setting the driver data using
> platform_device instead of using dev_{get,set}_drvdata() with &pdev->dev,
> so we can directly pass a struct platform_device.

> Signed-off-by: Libo Chen <libo.chen@huawei.com>
> ---
>   .../net/ethernet/freescale/fs_enet/fs_enet-main.c  |    1 -
>   1 files changed, 0 insertions(+), 1 deletions(-)

> diff --git a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c b/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
> index 8de53a1..7e3de10 100644
> --- a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
> +++ b/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
> @@ -1122,7 +1122,6 @@ static int fs_enet_remove(struct platform_device *ofdev)
>
>   	fep->ops->free_bd(ndev);
>   	fep->ops->cleanup_data(ndev);
> -	dev_set_drvdata(fep->dev, NULL);
>   	of_node_put(fep->fpi->phy_node);
>   	free_netdev(ndev);
>   	return 0;

    Changelog simply doesn't match the patch.

WBR, Sergei
