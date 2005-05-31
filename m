Return-Path: <clemens.koller@anagramm.de>
Received: from moutvdomng.kundenserver.de (moutvdom.kundenserver.de
	[212.227.126.249]) by ozlabs.org (Postfix) with ESMTP id BB376679E9
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  1 Jun 2005 02:03:40 +1000 (EST)
Message-ID: <429C8AC4.9000801@anagramm.de>
Date: Tue, 31 May 2005 18:03:16 +0200
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: Kumar Gala <kumar.gala@freescale.com>
References: <429B2B54.1060504@anagramm.de>
	<5be2f8f42a2cfaea381a88c5de9cbb4e@freescale.com>
In-Reply-To: <5be2f8f42a2cfaea381a88c5de9cbb4e@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Complete ccsr map for mpc8540 available?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello, Kumar!

Yes, I want to add another Local Bus Address Range for our FPGA on
an extra CS line. I've tried to do that in U-Boot as the Code is already there.
But my modified (some old 1.1.2 (not the official release) version) U-Boot
didn't work (I guess compiling issues) and rendered my Board non-bootable, which
was really no fun!
I also want to play around with the bus-timing and GPCM/UPM configurations.
So, changing U-Boot for every little waitstate and re-booting just to get
a register changed is a showstopper for me. (Yes, I know, a BDI2000 would be fun).
So I decided to do all my stuff first in linux in a module to shorten the design
cycle by a factor of 1E+3 which works fine now, as I started this immr_t thingy
for mpc8540 on my own...

Now it seems that u-boot's immap_85xx.h is pretty much what I was looking
for, I will try to merge my stuff with it and get a immap_8540.h out of it.
So, you answered my question indirectly (get back to mainline) that there
is no code available on the linux side yet, right?

I can release my stuff, if anybody is interested... no problem.
The LBC part is verified (some others are dummys and untested) and in
a /works for me/ state.

Thanks and best greets,

Clemens Koller
_______________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Str. 45/1
81379 Muenchen
Germany

http://www.anagramm.de
Phone: +49-89-741518-50
Fax: +49-89-741518-19

>> Hi, There!
>>
>> I want to access the local bus controller (LBC) registers
>> of the mpc8540 from within a module.
>> Therefore I want to use similar structures as for the 8560's cpm2_immr
>> or the 8xx. However, I was not able to find a complete ccsr map for the
>> mpc8540 in the 2.6.11.x kernels. (immap_85xx.h, 8xx_immr.h, ...)
>>
>> Can someone point me to get the memc_brx / orx and friends for mpc8540?
>> (the complete CCSR map.) Or some code to recycle?
>> Or do I need to patch more into immap_85xx.h on my own? I just want to
>> avoid to do duplicate work.
>>
>> Or is it better to extend the fsl_ocp or the platform device structures?
> 
> 
> What do you plan on doing with the local bus controller in the kernel?  
> If this is only configuration of the controller for a given chip select 
> that I would suggest doing something similar to how we handle PCI.  You 
> can probably find a description of the localbus registers in the u-boot 
> source tree.
> 
> Is this a change you want to get back into the mainline kernel tree?
> 
> - kumar
> 
