Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 18435DDDA5
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Feb 2009 04:15:18 +1100 (EST)
Message-ID: <499AF08B.6010702@freescale.com>
Date: Tue, 17 Feb 2009 11:14:51 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Vijay Nikam <vijay.t.nikam@gmail.com>
Subject: Re: Regarding irq_of_parse_and_map
References: <f234e2140902160355p148c99d1qc2e5b6f6ae9a716f@mail.gmail.com>	
	<20090216180857.GA18069@ld0162-tx32.am.freescale.net>
	<f234e2140902170341y31662e8fla8a8cf87473ed419@mail.gmail.com>
In-Reply-To: <f234e2140902170341y31662e8fla8a8cf87473ed419@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Vijay Nikam wrote:
> I added the gpio node as follows to mpc8313erdb.dts;
> 
> gpio@c00 {
> 	linux,phandle = <c00>;

Don't specify this explicitly.  Please base new development off of the 
device tree that is in upstream Linux, not the very old tree in your BSP.

> 	device_type = "gpio";

No device_type.

> The only thing I need to know what should I write at 'compatible' tag
> ? ? ? the compatible tag format is "manufacturer,model" the
> manufacturer is 'fsl' i.e. I think freescale but the model, as it is
> the model number where I can find this model ? ? ? Please let me know
> ... thanks ...

compatible = "fsl,mpc8313-gpio", "fsl,mpc8349-gpio";

> Also I would like to ask if the above device node is written according
> to bindings ... I think it should be right as I referred
> 'bootingwithout-of.txt' ... but please correct me if I am worng ? ? ?

See also Documentation/powerpc/dts-bindings/fsl/8xxx_gpio.txt.

Also note that current Linux has a driver in 
arch/powerpc/sysdev/mpc8xxx_gpio.c.

-Scott
