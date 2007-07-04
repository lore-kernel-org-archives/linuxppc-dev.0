Return-Path: <akinobu.mita@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.183])
	by ozlabs.org (Postfix) with ESMTP id 23FC6DDE30
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Jul 2007 22:53:40 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id a29so4783385pyi
	for <linuxppc-dev@ozlabs.org>; Wed, 04 Jul 2007 05:53:39 -0700 (PDT)
Message-ID: <961aa3350707040553m12ff1bccw9421e714337c80d1@mail.gmail.com>
Date: Wed, 4 Jul 2007 21:53:39 +0900
From: "Akinobu Mita" <akinobu.mita@gmail.com>
To: "Jan-Bernd Themann" <ossthema@de.ibm.com>
Subject: Re: [PATCH 1/2] eHEA: Capability flag for DLPAR support
In-Reply-To: <200707041209.37127.ossthema@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <200707041209.37127.ossthema@de.ibm.com>
Cc: Thomas Klein <tklein@de.ibm.com>, Jeff Garzik <jeff@garzik.org>,
	Jan-Bernd Themann <themann@de.ibm.com>, netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-ppc <linuxppc-dev@ozlabs.org>, Christoph Raisch <raisch@de.ibm.com>,
	Marcus Eder <meder@de.ibm.com>, Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

2007/7/4, Jan-Bernd Themann <ossthema@de.ibm.com>:

> diff --git a/drivers/net/ehea/ehea_main.c b/drivers/net/ehea/ehea_main.c
> index bdb5241..f8c0908 100644
> --- a/drivers/net/ehea/ehea_main.c
> +++ b/drivers/net/ehea/ehea_main.c
> @@ -2923,6 +2923,15 @@ static int check_module_parm(void)
>         return ret;
>  }
>
> +static ssize_t ehea_show_capabilities(struct device_driver *drv,
> +                                     char *buf)
> +{
> +       return sprintf(buf, "%d", EHEA_CAPABILITIES);
> +}
> +
> +static DRIVER_ATTR(capabilities, S_IRUSR | S_IRGRP | S_IROTH,
> +                  ehea_show_capabilities, NULL);
> +
>  int __init ehea_module_init(void)
>  {
>         int ret;
> @@ -2937,12 +2946,20 @@ int __init ehea_module_init(void)
>         if (ret)
>                 ehea_error("failed registering eHEA device driver on ebus");
>

You forgot to put:
                return ret;
or
                goto out;

> +       ret = driver_create_file(&ehea_driver.driver, &driver_attr_capabilities);
> +       if (ret) {
> +               ehea_error("failed to register capabilities attribute, ret=%d", ret);
> +               ibmebus_unregister_driver(&ehea_driver);
> +               goto out;
> +       }
> +
>  out:
>         return ret;
>  }
>
