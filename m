Return-Path: <david-b@pacbell.net>
Received: from smtp115.sbc.mail.sp1.yahoo.com (smtp115.sbc.mail.sp1.yahoo.com
	[69.147.64.88]) by ozlabs.org (Postfix) with SMTP id C8095DDEFB
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Oct 2008 17:15:29 +1100 (EST)
From: David Brownell <david-b@pacbell.net>
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH 4/7] gpiolib: implement dev_gpiochip_{add,remove} calls
Date: Wed, 22 Oct 2008 23:15:26 -0700
References: <20081016171222.GA24812@oksana.dev.rtsoft.ru>
	<20081022104606.GA510@oksana.dev.rtsoft.ru>
	<20081022183218.GA19025@oksana.dev.rtsoft.ru>
In-Reply-To: <20081022183218.GA19025@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200810222315.26576.david-b@pacbell.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, i2c@lm-sensors.org,
	Jean Delvare <khali@linux-fr.org>, David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 22 October 2008, Anton Vorontsov wrote:
> --- a/drivers/gpio/pcf857x.c
> +++ b/drivers/gpio/pcf857x.c
> @@ -187,7 +187,7 @@ static int pcf857x_probe(struct i2c_client *client,
>         struct pcf857x                  *gpio;
>         int                             status;
>  
> -       pdata = client->dev.platform_data;
> +       pdata = pcf857x_get_pdata(client);
>         if (!pdata)
>                 return -ENODEV;
>  

I suppose that can work.  Regardless, some OF-specific code will
need to map device tree state into a generic format that's fully
decoupled from OF.  (And there's something to be said to having
that mapping sit in the same directory as the driver needing it.)
