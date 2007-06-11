Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 85624DDEFB
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Jun 2007 01:27:25 +1000 (EST)
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <10a84b95ad7ec502b5ca8c5af5d9d497@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: racy calls to platform_device_add_data after
	platform_device_register_simple
Date: Mon, 11 Jun 2007 10:27:21 -0500
To: Mark Zhan <rongkai.zhan@windriver.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri Jun 8 18:54:38 EST 2007, Mark Zhan wrote:
> @@ -775,38 +774,42 @@ static int __init cpm_uart_of_init(void)
> +               if (strstr(model, "SMC")) {
> +                       cpm_uart_dev = 
> platform_device_register_simple("fsl-cpm-smc:uart",
> +                                                       i, &r[0], 3);
> +               } else if (strstr(model, "SCC")) {
> +                       cpm_uart_dev = 
> platform_device_register_simple("fsl-cpm-scc:uart",
> +                                                       i, &r[0], 3);
> +               }
> +
> +               if (IS_ERR(cpm_uart_dev)) {
> +                       ret = PTR_ERR(cpm_uart_dev);
> +                       goto err;
> +               }
>
> +               cpm_uart_data.uart_clk = ppc_proc_freq;
>                 cpm_uart_data.tx_num_fifo = 4;
>                 cpm_uart_data.tx_buf_size = 32;
>                 cpm_uart_data.rx_num_fifo = 4;
> @@ -816,10 +819,8 @@ static int __init cpm_uart_of_init(void)
>                 cpm_uart_data.clk_tx = *((u32 *)of_get_property(np,
>                                                 "tx-clock", NULL));
>
> -               ret =
> -                   platform_device_add_data(cpm_uart_dev, 
> &cpm_uart_data,
> -                                            sizeof(struct
> -                                                   
> fs_uart_platform_info));
> +               ret = platform_device_add_data(cpm_uart_dev, 
> &cpm_uart_data,
> +                                       sizeof(struct 
> fs_uart_platform_info));

This code (and others like the ethernet code above it) is racy in that 
the device is visible to the device layer without all of the data 
needed by the driver.  Since its being run as an arch_initcall, the 
driver is not yet registered so its not quite a bug yet.

Since this seems to be appearing frequently as we add wrappers from the 
device tree to the subsystem layer drivers, we should create an 
extended function that takes a data pointer and size (NULL/zero would 
mean none), and define platform_device_register_simple in terms of it.

milton
