Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id ACE662C00B7
 for <linuxppc-dev@ozlabs.org>; Tue, 27 Aug 2013 17:42:13 +1000 (EST)
Message-ID: <1377589325.3819.118.camel@pasglop>
Subject: Re: [PATCH] i2c: powermac: fix return path on error
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Wolfram Sang <wsa@the-dreams.de>
Date: Tue, 27 Aug 2013 17:42:05 +1000
In-Reply-To: <1376918295-6961-1-git-send-email-wsa@the-dreams.de>
References: <1376918295-6961-1-git-send-email-wsa@the-dreams.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-i2c@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-08-19 at 15:18 +0200, Wolfram Sang wrote:
> We want to bail out immediately if i2c_add_adapter failed and not try to
> register child nodes with a nilled adapter structure.
> 
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>  drivers/i2c/busses/i2c-powermac.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-powermac.c b/drivers/i2c/busses/i2c-powermac.c
> index 8dc90da..bb81773 100644
> --- a/drivers/i2c/busses/i2c-powermac.c
> +++ b/drivers/i2c/busses/i2c-powermac.c
> @@ -446,6 +446,7 @@ static int i2c_powermac_probe(struct platform_device *dev)
>  		printk(KERN_ERR "i2c-powermac: Adapter %s registration "
>  		       "failed\n", adapter->name);
>  		memset(adapter, 0, sizeof(*adapter));
> +		return rc;
>  	}
>  
>  	printk(KERN_INFO "PowerMac i2c bus %s registered\n", adapter->name);
> @@ -455,7 +456,7 @@ static int i2c_powermac_probe(struct platform_device *dev)
>  	 */
>  	i2c_powermac_register_devices(adapter, bus);
>  
> -	return rc;
> +	return 0;
>  }
>  
>  static struct platform_driver i2c_powermac_driver = {
