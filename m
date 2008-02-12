Return-Path: <sean.maclennan@pikatech.com>
Received: from fusion.kanatek.com (fusion.kanatek.com [207.107.229.150])
	by ozlabs.org (Postfix) with ESMTP id 3C89FDDE09
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Feb 2008 11:07:57 +1100 (EST)
Received: from [207.107.229.5] (helo=pks00005.kanatek.com)
	by fusion.kanatek.com with esmtp (Exim 4.66)
	(envelope-from <sean.maclennan@pikatech.com>) id 1JOihP-0006Co-Uw
	for linuxppc-dev@ozlabs.org; Mon, 11 Feb 2008 19:08:36 -0500
Message-ID: <47B0F142.40206@pikatech.com>
Date: Mon, 11 Feb 2008 20:07:14 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
MIME-Version: 1.0
To: LinuxPPC-dev <linuxppc-dev@ozlabs.org>
Subject: Re: Could the DTS experts look at this?
References: <47ACE630.8090101@pikatech.com>
	<20080211001451.GA11572@localhost.localdomain>
	<47AFB593.30805@pikatech.com>
	<20080211031110.GD11572@localhost.localdomain>
	<47AFC5E3.20101@pikatech.com>
	<20080211235958.GD18348@localhost.localdomain>
In-Reply-To: <20080211235958.GD18348@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
> But the partitions are all the same size, so in Map 2 there's a great
> big gap between Env and U-boot?  Or there's a great big gap before
> FPGA?
>   
There's a great big gap before the FPGA, 63M worth. Before we got the 
NAND working, we stored the kernel, the ramdisk image, and a persistent 
store there. But we moved everything to the NAND and are now going to a 
much smaller NOR chip.
>   
>> The u-boot, env, and FPGA are anchored at the bottom of the flash. 
>> Kernel is anchored at the top. Everything else goes in the middle.
>>     
>
> Um.. so "bottom" actually means "high addresses" in the above?
>   
Yes. Top = offset 0, bottom = size-of-flash.

And there is a bug in the initial code, I have to update the reg length 
field. I now have a Rev B board in my hands and tested that it works for 
both Rev A and Rev B.

Cheers,
   Sean
