Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id B0A68DDE2D
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Apr 2007 01:15:41 +1000 (EST)
Mime-Version: 1.0 (Apple Message framework v624)
In-Reply-To: <20070420082714.4f10f186@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <85b6cd5d8e44d174bdcef9fbdd9e7947@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH][RFC][POWERPC] i2c: adds support for i2c bus on 8xx
Date: Fri, 20 Apr 2007 10:15:32 -0500
To: Vitaly Bordug <vitb@kernel.crashing.org>
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

At Fri Apr 20 14:27:14 EST 2007, Vitaly Bordug wrote:
> +               i2c_dev = 
> platform_device_register_simple("fsl-i2c-cpm", i, &r[0], 3);
> +               if (IS_ERR(i2c_dev)) {
> +                       ret = PTR_ERR(i2c_dev);
> +                       goto err;
> +               }
> +
> +               ret =
> +                   platform_device_add_data(i2c_dev, &i2c_data,
> +                                            sizeof(struct
> +                                                   
> fsl_i2c_platform_data));
>

This exposes a period of time where the device is registerd, but
the platform data is not available.  It might work for the
everything-in-the kernel model where the device is added before
the driver is registered, but is inherently racy.

You need to do alloc / add_resources / add_data / add.

milton
