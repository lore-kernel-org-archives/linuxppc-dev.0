Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8EC78DDFCD
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 16:45:56 +1100 (EST)
In-Reply-To: <20070125045617.40490.qmail@web53115.mail.yahoo.com>
References: <20070125045617.40490.qmail@web53115.mail.yahoo.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <A51B6AE8-D9B9-4DB1-901A-61CF7DA08124@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH]	I2C:	Add I2C support for the MPC8260
Date: Wed, 24 Jan 2007 23:44:57 -0600
To: jimmy liu <jimmyzhmliu@yahoo.com>
Cc: linuxppc-dev@ozlabs.org, hs@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 24, 2007, at 10:56 PM, jimmy liu wrote:

> When I add mpc8260 I2C driver to Linux Kernel 2.6.19,
> the init function looks like that
>  static int __init fsl_i2c_init(void)
>  {
>   return driver_register(&fsl_i2c_driver);
>  }
>
> I set the debug on, and found that the fsl_i2c_probe()
> function is never
> called, so there is not I2C device enabled, and the
> user space function
> open("/dev/i2c-0",O_RDWR) always return error. I set
> something wrong?

You need something to create a device to match the driver you've just  
registered.  This has usually been done with the platform bus and  
using platform_devices in the past.

- k
