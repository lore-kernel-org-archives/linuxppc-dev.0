Return-Path: <jakob.viketoft@bitsim.se>
Received: from amsfep20-int.chello.nl (amsfep20-int.chello.nl [213.46.243.18])
	by ozlabs.org (Postfix) with ESMTP id 9B90567A2F
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 31 Mar 2005 02:12:34 +1000 (EST)
Message-ID: <424ACFF1.5000403@bitsim.se>
Date: Wed, 30 Mar 2005 18:12:33 +0200
From: Jakob Viketoft <jakob.viketoft@bitsim.se>
MIME-Version: 1.0
To: Kumar Gala <kumar.gala@freescale.com>
References: <424AAF09.9050706@ru.mvista.com>
	<5a325f210dccfd254541824008e8c5a1@freescale.com>
In-Reply-To: <5a325f210dccfd254541824008e8c5a1@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Andrei Konovalov <akonovalov@ru.mvista.com>,
	Sylvain Munaut <tnt@246tNt.com>,
	Linux PPC Embedded list <linuxppc-embedded@ozlabs.org>
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

Kumar Gala wrote:
> On Mar 30, 2005, at 7:52 AM, Andrei Konovalov wrote:
>> Do I understand correct that the ppc_sys model used by 85xx, 83xx, and 
>> 52xx
>>  SOCs is not so well suited for Virtex-II Pro (which Jakob and me bear 
>> in mind)?
>>  In case of Xilinx ???_devices.c could be the list of all the IPs 
>> supported in linux.
>>  But ???_sys.c has little sense as for any given combination of the 
>> particular
>>  Virtex-II Pro chip and the particular board the set of IPs (as well 
>> as the memory
>> map, interrupt numbers, some hardware options (if ethernet has SGDMA 
>> or not))
>>  is not fixed. I.e. ideally we would need some kind of run time system 
>> configuration
>>  instead of compiled time system configuration implemented by ???_sys.c.
> 
> 
> This is correct.  There is nothing that precludes us from building up a 
> way to dynamically create the information.  Is there some way to query 
> the hardware itself, or is the information implied something else?
> 
> - kumar

My intention was to give a device tree structure to the kernel at boot 
time via a (pseudo?) pointer in bd_info or similar. Then you would only 
need to recompile a little bootloader (which is needed for setting up 
the FPGA anyway) with this structure for every specific card. You could 
even be shrewd enough to have a single kernel image but several 
structures to launch several processors on the same chip. Does it sound 
like a sane solution?

Otherwise, I'm a bit unsure as to whether a system with a gigantic list 
of devices in ???_devices.c is the right way to go. In the Xilinx case, 
not only is a list of possible IP:s needed, but also the usual standard 
circuits which can be connected from outside to the chip. Wouldn't it be 
more realistic to have knowledge of the compiled in drivers somehow?

	/Jakob
