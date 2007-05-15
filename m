Return-Path: <khali@linux-fr.org>
Received: from kellthuzad.dmz.nerim.net (smtp-dmz-232-tuesday.dmz.nerim.net
	[195.5.254.232]) by ozlabs.org (Postfix) with ESMTP id B5BA8DDEE2
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 23:25:35 +1000 (EST)
Received: from mallaury.nerim.net (smtp-102-tuesday.noc.nerim.net
	[62.4.17.102])
	by kellthuzad.dmz.nerim.net (Postfix) with ESMTP id 4376B1A7B7
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 15:25:28 +0200 (CEST)
Date: Tue, 15 May 2007 15:26:26 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [i2c] [PATCH] Make i2c-mpc driver use i2c_add_numbered_adapter
Message-ID: <20070515152626.199f9d6b@hyperion.delvare>
In-Reply-To: <20070514190545.32739.72083.stgit@trillian.secretlab.ca>
References: <20070514190545.32739.72083.stgit@trillian.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: rtc-linux@googlegroups.com, James Chapman <jchapman@katalix.com>,
	David Brownell <david-b@pacbell.net>, linuxppc-dev@ozlabs.org,
	i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 14 May 2007 13:11:23 -0600, Grant Likely wrote:
> Move the i2c-mpc driver over to using the new i2c infrastructure.
> Specifically, it now uses i2c_add_numberd_adapter so that the bus number

i2c_add_numbered_adapter (missing e)

> can be determined ahead of time and used to register i2c clients before
> the bus is instantiated.
> 
> Tested on an MPC5200 based board
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

Acked-by: Jean Delvare <khali@linux-fr.org>

> ---
> This patch will need to be tested to make sure it does not break any 8xxx
> board ports.
> 
> Work still to be done (in another patch): support for pulling i2c client
> registrations out of the device tree.
> 
>  drivers/i2c/busses/i2c-mpc.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
> index c6b6898..a769efc 100644
> --- a/drivers/i2c/busses/i2c-mpc.c
> +++ b/drivers/i2c/busses/i2c-mpc.c
> @@ -327,9 +327,10 @@ static int fsl_i2c_probe(struct platform_device *pdev)
>  	platform_set_drvdata(pdev, i2c);
>  
>  	i2c->adap = mpc_ops;
> +	i2c->adap.nr = pdev->id;
>  	i2c_set_adapdata(&i2c->adap, i2c);
>  	i2c->adap.dev.parent = &pdev->dev;
> -	if ((result = i2c_add_adapter(&i2c->adap)) < 0) {
> +	if ((result = i2c_add_numbered_adapter(&i2c->adap)) < 0) {
>  		printk(KERN_ERR "i2c-mpc - failed to add adapter\n");
>  		goto fail_add;
>  	}

-- 
Jean Delvare
