Return-Path: <aik@ozlabs.ru>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zMVj81pFJzF0fK
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jan 2018 15:04:59 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id i66so13282357pfd.7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jan 2018 20:04:59 -0800 (PST)
Subject: Re: [PATCH -next] ipmi/powernv: Fix error return code in
 ipmi_powernv_probe()
To: Wei Yongjun <weiyongjun1@huawei.com>, Corey Minyard <minyard@acm.org>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: openipmi-developer@lists.sourceforge.net, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <1516188311-144227-1-git-send-email-weiyongjun1@huawei.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <fb154ee5-4934-f6f8-dae5-168c03f0d3a5@ozlabs.ru>
Date: Thu, 18 Jan 2018 15:04:50 +1100
MIME-Version: 1.0
In-Reply-To: <1516188311-144227-1-git-send-email-weiyongjun1@huawei.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 17/01/18 22:25, Wei Yongjun wrote:
> Fix to return a negative error code from the request_irq() error
> handling case instead of 0, as done elsewhere in this function.
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>


Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>



> ---
>  drivers/char/ipmi/ipmi_powernv.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_powernv.c b/drivers/char/ipmi/ipmi_powernv.c
> index c687c8d..bcf493d 100644
> --- a/drivers/char/ipmi/ipmi_powernv.c
> +++ b/drivers/char/ipmi/ipmi_powernv.c
> @@ -250,8 +250,9 @@ static int ipmi_powernv_probe(struct platform_device *pdev)
>  		ipmi->irq = opal_event_request(prop);
>  	}
>  
> -	if (request_irq(ipmi->irq, ipmi_opal_event, IRQ_TYPE_LEVEL_HIGH,
> -				"opal-ipmi", ipmi)) {
> +	rc = request_irq(ipmi->irq, ipmi_opal_event, IRQ_TYPE_LEVEL_HIGH,
> +			 "opal-ipmi", ipmi);
> +	if (rc) {
>  		dev_warn(dev, "Unable to request irq\n");
>  		goto err_dispose;
>  	}
> 


-- 
Alexey
