Return-Path: <tnt@246tNt.com>
Received: from outmx006.isp.belgacom.be (outmx006.isp.belgacom.be
	[195.238.2.99]) by ozlabs.org (Postfix) with ESMTP id 6A64167A6D
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Mar 2005 19:54:24 +1000 (EST)
Received: from outmx006.isp.belgacom.be (localhost [127.0.0.1])
	by outmx006.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id j2U9sK3q017025
	for <linuxppc-embedded@ozlabs.org>; Wed, 30 Mar 2005 11:54:20 +0200
	(envelope-from <tnt@246tNt.com>)
Message-ID: <424A7749.3040604@246tNt.com>
Date: Wed, 30 Mar 2005 11:54:17 +0200
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Jakob Viketoft <jakob.viketoft@bitsim.se>
References: <424A5C89.2030504@bitsim.se>
In-Reply-To: <424A5C89.2030504@bitsim.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Linux PPC Embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: Platform bus/ppc sys model...
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,


> Is there some good documentation about how to use the platform bus / ppc
> sys model or is it only possible to read and try to understand the code
> for the freescale devices?

I'm not aware on documentation for the ppc_sys model in particular but
the code is pretty easy to understand/read.

Basically you have a ???_devices.c that describe all the devices you can
find in a family of devices (by family I mean basically the same 
processors but with slightly different options/peripheral), then a 
???_sys.c that describe each particular variant with the devices that 
are really implemented in that variant). Then somewhere in platform init 
code, you need to identify the ppc system  you're runngin on ( by a 
identify_ppc_sys_by_id(mfspr(SPRN_SVR)); for e.g. ).

Kumar, if I got it wrong, please correct ;)


> Specifically, how do you make the kernel aware of a certain device and
> what else is required? Do I have to "connect" the device and the driver
> or will the new model find this out automagically? I'm looking at adding 
> the usual serials, emacs etc...

It's "automatic" by using matching of strings. The driver name has to be
the same as the device name. More specifically by matching the name 
field in struct platform_device with the name field in struct 
device_driver. The code for this magic is in drivers/base/platform.c


> Lastly, I suppose this will be the way all platforms should connect
> their boards with the devices "from now on", right?

It seems to be the trend yes.
The OCP and platform bus model have the same base idea/concept. The 
advantage of platform bus is that it's common in multiple arch, the rest 
  is mainly style. The ppc sys model is based on platform bus to ease 
working with SoC variants.



	Sylvain.
