Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 422TTV6GM0zF39C
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Sep 2018 18:11:42 +1000 (AEST)
Subject: Re: [PATCH v2 6/6] net/wan/fsl_ucc_hdlc: tx timeout handler
To: David Gounaris <david.gounaris@infinera.com>, qiang.zhao@nxp.com,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, robh+dt@kernel.org
References: <20180828110921.2542-2-david.gounaris@infinera.com>
 <20180829131328.27901-1-david.gounaris@infinera.com>
 <20180829131328.27901-7-david.gounaris@infinera.com>
From: christophe leroy <christophe.leroy@c-s.fr>
Message-ID: <20f78b19-9407-85ea-5de1-cb6e0a9950f4@c-s.fr>
Date: Sat, 1 Sep 2018 10:10:12 +0200
MIME-Version: 1.0
In-Reply-To: <20180829131328.27901-7-david.gounaris@infinera.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 29/08/2018 à 15:13, David Gounaris a écrit :
> Added tx timerout handler. This helps
> when troubleshooting.
> 
> Signed-off-by: David Gounaris <david.gounaris@infinera.com>
> ---
>   drivers/net/wan/fsl_ucc_hdlc.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
> index 248f1f5bcd04..629ef5049d27 100644
> --- a/drivers/net/wan/fsl_ucc_hdlc.c
> +++ b/drivers/net/wan/fsl_ucc_hdlc.c
> @@ -1002,11 +1002,15 @@ static const struct dev_pm_ops uhdlc_pm_ops = {
>   #define HDLC_PM_OPS NULL
>   
>   #endif
> +static void uhdlc_tx_timeout(struct net_device *ndev) {

ERROR:OPEN_BRACE: open brace '{' following function definitions go on 
the next line
#22: FILE: drivers/net/wan/fsl_ucc_hdlc.c:1004:
+static void uhdlc_tx_timeout(struct net_device *ndev) {

> +	netdev_err(ndev, "%s\n", __FUNCTION__);

WARNING:USE_FUNC: __func__ should be used instead of gcc specific 
__FUNCTION__
#23: FILE: drivers/net/wan/fsl_ucc_hdlc.c:1005:
+	netdev_err(ndev, "%s\n", __FUNCTION__);

> +}
>   static const struct net_device_ops uhdlc_ops = {
>   	.ndo_open       = uhdlc_open,
>   	.ndo_stop       = uhdlc_close,
>   	.ndo_start_xmit = hdlc_start_xmit,
>   	.ndo_do_ioctl   = uhdlc_ioctl,
> +	.ndo_tx_timeout	= uhdlc_tx_timeout,
>   };
>   
>   static int ucc_hdlc_probe(struct platform_device *pdev)
> @@ -1125,6 +1129,7 @@ static int ucc_hdlc_probe(struct platform_device *pdev)
>   	hdlc = dev_to_hdlc(dev);
>   	dev->tx_queue_len = 16;
>   	dev->netdev_ops = &uhdlc_ops;
> +	dev->watchdog_timeo = 2*HZ;

CHECK:SPACING: spaces preferred around that '*' (ctx:VxV)
#38: FILE: drivers/net/wan/fsl_ucc_hdlc.c:1131:
+	dev->watchdog_timeo = 2*HZ;

>   	hdlc->attach = ucc_hdlc_attach;
>   	hdlc->xmit = ucc_hdlc_tx;
>   	netif_napi_add(dev, &uhdlc_priv->napi, ucc_hdlc_poll, 32);
> 

---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
https://www.avast.com/antivirus
