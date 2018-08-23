Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41wqhW3bG2zF2Ps
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Aug 2018 13:31:39 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/2] macintosh: therm_windtunnel: drop using attach_adapter
In-Reply-To: <20180821150240.19964-2-wsa@the-dreams.de>
References: <20180821150240.19964-1-wsa@the-dreams.de>
 <20180821150240.19964-2-wsa@the-dreams.de>
Date: Thu, 23 Aug 2018 13:31:39 +1000
Message-ID: <87ftz5lpwk.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Wolfram Sang <wsa@the-dreams.de> writes:

> As we now have deferred probing, we can use a custom mechanism and
> finally get rid of the legacy interface from the i2c core.
>
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> ---
>  drivers/macintosh/therm_windtunnel.c | 25 +++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)

I don't have a G4 to test this on, so merge it and if it breaks we can
fix it up later.

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers

> diff --git a/drivers/macintosh/therm_windtunnel.c b/drivers/macintosh/therm_windtunnel.c
> index 68dcbcb4fc5b..8c744578122a 100644
> --- a/drivers/macintosh/therm_windtunnel.c
> +++ b/drivers/macintosh/therm_windtunnel.c
> @@ -432,7 +432,6 @@ static struct i2c_driver g4fan_driver = {
>  	.driver = {
>  		.name	= "therm_windtunnel",
>  	},
> -	.attach_adapter = do_attach,
>  	.probe		= do_probe,
>  	.remove		= do_remove,
>  	.id_table	= therm_windtunnel_id,
> @@ -445,7 +444,29 @@ static struct i2c_driver g4fan_driver = {
>  
>  static int therm_of_probe(struct platform_device *dev)
>  {
> -	return i2c_add_driver( &g4fan_driver );
> +	struct i2c_adapter *adap;
> +	int ret, i = 0;
> +
> +	adap = i2c_get_adapter(0);
> +	if (!adap)
> +		return -EPROBE_DEFER;
> +
> +	ret = i2c_add_driver(&g4fan_driver);
> +	if (ret) {
> +		i2c_put_adapter(adap);
> +		return ret;
> +	}
> +
> +	/* We assume Macs have consecutive I2C bus numbers starting at 0 */
> +	while (adap) {
> +		do_attach(adap);
> +		if (x.running)
> +			return 0;
> +		i2c_put_adapter(adap);
> +		adap = i2c_get_adapter(++i);
> +	}
> +
> +	return -ENODEV;
>  }
>  
>  static int
> -- 
> 2.11.0
