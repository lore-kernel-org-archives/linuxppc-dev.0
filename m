Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AD04DDDE03
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Nov 2008 02:02:13 +1100 (EST)
Message-ID: <491846A9.8080709@freescale.com>
Date: Mon, 10 Nov 2008 08:35:21 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Bruce_Leonard@selinc.com
Subject: Re: Using DMA
References: <OFA76D8B60.24A9D6A0-ON882574FC.0082F8AB-882574FD.0000DE16@selinc.com>
In-Reply-To: <OFA76D8B60.24A9D6A0-ON882574FC.0082F8AB-882574FD.0000DE16@selinc.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: timur.tabi@gmail.com, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Bruce_Leonard@selinc.com wrote:

> Is there something else I need to do?  Or is there something wrong with my 
> device tree (always a possibility :)  ).  Any help is appreciated.

You might need to add something like this:

static struct of_device_id __initdata mpc8610_ids[] = {
         { .compatible = "fsl,mpc8610-immr", },
         { .compatible = "simple-bus", },
         {}
};
static int __init mpc8610_declare_of_platform_devices(void)
{
         /* Without this call, the SSI device driver won't get probed. */
         of_platform_bus_probe(NULL, mpc8610_ids, NULL);
         return 0;
}
machine_device_initcall(mpc86xx_hpcd, mpc8610_declare_of_platform_devices);

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
