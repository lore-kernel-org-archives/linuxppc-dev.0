Return-Path: <akonovalov@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (RT-soft-2.Moscow.itn.ru [80.240.96.70])
	by ozlabs.org (Postfix) with SMTP id 9688667A6C
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Mar 2005 23:46:18 +1000 (EST)
Message-ID: <424AAF09.9050706@ru.mvista.com>
Date: Wed, 30 Mar 2005 17:52:09 +0400
From: Andrei Konovalov <akonovalov@ru.mvista.com>
MIME-Version: 1.0
To: Sylvain Munaut <tnt@246tNt.com>
References: <424A5C89.2030504@bitsim.se> <424A7749.3040604@246tNt.com>
In-Reply-To: <424A7749.3040604@246tNt.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Linux PPC Embedded list <linuxppc-embedded@ozlabs.org>,
	Jakob Viketoft <jakob.viketoft@bitsim.se>
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

Sylvain Munaut wrote:
> Hi,
> 
> 
>> Is there some good documentation about how to use the platform bus / ppc
>> sys model or is it only possible to read and try to understand the code
>> for the freescale devices?
> 
> 
> I'm not aware on documentation for the ppc_sys model in particular but
> the code is pretty easy to understand/read.
> 
> Basically you have a ???_devices.c that describe all the devices you can
> find in a family of devices (by family I mean basically the same 
> processors but with slightly different options/peripheral), then a 
> ???_sys.c that describe each particular variant with the devices that 
> are really implemented in that variant). Then somewhere in platform init 
> code, you need to identify the ppc system  you're runngin on ( by a 
> identify_ppc_sys_by_id(mfspr(SPRN_SVR)); for e.g. ).
> 
> Kumar, if I got it wrong, please correct ;)

Do I understand correct that the ppc_sys model used by 85xx, 83xx, and 52xx
SOCs is not so well suited for Virtex-II Pro (which Jakob and me bear in mind)?
In case of Xilinx ???_devices.c could be the list of all the IPs supported in linux.
But ???_sys.c has little sense as for any given combination of the particular
Virtex-II Pro chip and the particular board the set of IPs (as well as the memory
map, interrupt numbers, some hardware options (if ethernet has SGDMA or not))
is not fixed. I.e. ideally we would need some kind of run time system configuration
instead of compiled time system configuration implemented by ???_sys.c.

Thanks,
Andrei

>> Specifically, how do you make the kernel aware of a certain device and
>> what else is required? Do I have to "connect" the device and the driver
>> or will the new model find this out automagically? I'm looking at 
>> adding the usual serials, emacs etc...
> 
> 
> It's "automatic" by using matching of strings. The driver name has to be
> the same as the device name. More specifically by matching the name 
> field in struct platform_device with the name field in struct 
> device_driver. The code for this magic is in drivers/base/platform.c
> 
> 
>> Lastly, I suppose this will be the way all platforms should connect
>> their boards with the devices "from now on", right?
> 
> 
> It seems to be the trend yes.
> The OCP and platform bus model have the same base idea/concept. The 
> advantage of platform bus is that it's common in multiple arch, the rest 
>  is mainly style. The ppc sys model is based on platform bus to ease 
> working with SoC variants.
> 
> 
> 
>     Sylvain.
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
