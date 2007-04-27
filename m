Return-Path: <mita@fixstars.com>
Date: Fri, 27 Apr 2007 14:22:06 +0900
From: Akinobu Mita <mita@fixstars.com>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [Cbe-oss-dev] [PATCH] cell: cbe_cpufreq cleanup and crash fix
Message-ID: <20070427052206.GA5486@localhost.localdomain>
References: <20070425204633.GC19781@lixom.net>
	<200704260147.35878.arnd@arndb.de>
	<20070426065644.GA24799@lixom.net>
	<20070426230754.GB30000@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070426230754.GB30000@lixom.net>
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
	Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 26, 2007 at 06:07:54PM -0500, Olof Johansson wrote:
> @@ -303,6 +303,9 @@ static int __init cbe_cpufreq_init(void)
>  {
>  	struct device_node *np;
>  
> +	if (!machine_is(cell))
> +		return 0;
> +

Please return -ENODEV to prevent loading module.

Otherwise it will cause crash when unloading the module
because of cpufreq_unregister_driver() with unregistered driver.

> @@ -315,7 +318,7 @@ static int __init cbe_cpufreq_init(void)
>  
>  static void __exit cbe_cpufreq_exit(void)
>  {
> -	if(pmi_dev)
> +	if (pmi_dev)
>  		pmi_unregister_handler(pmi_dev, &cbe_pmi_handler);
>  
>  	cpufreq_unregister_driver(&cbe_cpufreq_driver);
