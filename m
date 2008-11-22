Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CCFB0DDDF5
	for <linuxppc-dev@ozlabs.org>; Sun, 23 Nov 2008 08:52:49 +1100 (EST)
Subject: Re: [PATCH 13/32] rackmeter section fixes
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Al Viro <viro@ftp.linux.org.uk>
In-Reply-To: <E1L3wOC-0006T5-Ji@ZenIV.linux.org.uk>
References: <E1L3wOC-0006T5-Ji@ZenIV.linux.org.uk>
Content-Type: text/plain
Date: Sun, 23 Nov 2008 08:52:00 +1100
Message-Id: <1227390720.7185.276.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2008-11-22 at 17:35 +0000, Al Viro wrote:
> * rackmeter_remove() reference needs devexit_p
> * rackmeter_setup() is calls devinit and is called only from devinit
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

>  drivers/macintosh/rack-meter.c |   10 +++++-----
>  1 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/macintosh/rack-meter.c b/drivers/macintosh/rack-meter.c
> --- a/drivers/macintosh/rack-meter.c
> +++ b/drivers/macintosh/rack-meter.c
> @@ -288,7 +288,7 @@ static void __devexit rackmeter_stop_cpu_sniffer(struct rackmeter *rm)
>  	cancel_rearming_delayed_work(&rm->cpu[1].sniffer);
>  }
>  
> -static int rackmeter_setup(struct rackmeter *rm)
> +static int __devinit rackmeter_setup(struct rackmeter *rm)
>  {
>  	pr_debug("rackmeter: setting up i2s..\n");
>  	rackmeter_setup_i2s(rm);
> @@ -582,12 +582,12 @@ static struct of_device_id rackmeter_match[] = {
>  	{ }
>  };
>  
> -static struct macio_driver rackmeter_drv = {
> +static struct macio_driver rackmeter_driver = {
>  	.name = "rackmeter",
>  	.owner = THIS_MODULE,
>  	.match_table = rackmeter_match,
>  	.probe = rackmeter_probe,
> -	.remove = rackmeter_remove,
> +	.remove = __devexit_p(rackmeter_remove),
>  	.shutdown = rackmeter_shutdown,
>  };
>  
> @@ -596,14 +596,14 @@ static int __init rackmeter_init(void)
>  {
>  	pr_debug("rackmeter_init()\n");
>  
> -	return macio_register_driver(&rackmeter_drv);
> +	return macio_register_driver(&rackmeter_driver);
>  }
>  
>  static void __exit rackmeter_exit(void)
>  {
>  	pr_debug("rackmeter_exit()\n");
>  
> -	macio_unregister_driver(&rackmeter_drv);
> +	macio_unregister_driver(&rackmeter_driver);
>  }
>  
>  module_init(rackmeter_init);
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
