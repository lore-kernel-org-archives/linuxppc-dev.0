Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F2560DDD07
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 05:44:44 +1000 (EST)
In-Reply-To: <65BEA2C0-2494-490E-B0EE-B51C96B64075@freescale.com>
References: <Pine.LNX.4.64.0708170003210.21006@blarg.am.freescale.net>
	<20070911172000.GC10743@lixom.net>
	<9C9F1918-1B55-4426-8138-842B9AAA5BD5@kernel.crashing.org>
	<20070911182234.GA12802@lixom.net>
	<424B650B-C272-45FC-BBC6-F090A9474082@kernel.crashing.org>
	<24F46474-1425-4C8B-A400-4D18D28932F2@freescale.com>
	<6EF5E5F8-703B-4C49-B458-92CD0CDF89A0@kernel.crashing.org>
	<65BEA2C0-2494-490E-B0EE-B51C96B64075@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <DF6729AB-C85F-4505-9CAC-E35F5D6D7164@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] Fix interrupt routing and setup of ULI M1575 on
	FSL boards
Date: Tue, 11 Sep 2007 14:47:28 -0500
To: Becky Bruce <becky.bruce@freescale.com>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>> Would you feel better if it was in platforms/common/ or  
>>>> platforms/fsl
>>>>
>>>>> Maybe it would make more sense for you guys to slice the platforms
>>>>> differently, and have a common platform for the eval boards you  
>>>>> have
>>>>> with ULi on them instead of grouping it by core used by the  
>>>>> processor
>>>>> on the board.
>>>>>
>>>>> (In other words, move 86xx over under 85xx, since there  
>>>>> wouldn't be
>>>>> much
>>>>> left over anyway).
>>>>
>>>> Moving 86xx (classic 74xx core) under 85xx (book e500 core) makes
>>>> even less sense to me.
>>>
>>> Yeah, that makes *no* sense to me either.  It's an unfortunate  
>>> artifact of the naming of boards to include the core name.  While  
>>> the devices and boards may be similar, once you have bookE vs non- 
>>> bookE cores, they become quite different.
>>>
>>> I still don't see why this isn't in "sysdev".  We intended that  
>>> to be the device "kitchen sink".  If we really don't want to put  
>>> it there, then I would prefer creating a "fsl_common" or "common"  
>>> directory under platforms.
>
> You still haven't, in my opinion, answered my question about why it  
> can't go in sysdev, when I believe the original intent was for  
> stuff like this to go there.

I think sysdev should be related to chipsets and soc functionality.   
It seems odd to me that the Kconfig for these things lives in arch/ 
powerpc/platforms

>>> I'm also guilty of not noticing the original patch - my apologies.
>>
>> maybe we should just have a platforms/fsl for all boards from  
>> freescale.  Not having things broken up by which processor family  
>> they are for.
>
> What do you envision as being under there?  Subdirs?  How's it  
> organized? In some ways that might make sense, but I think we'd  
> need to sit down and think it through with all the twisted  
> combinations our hardware people come up with.  The fact is that  
> there's really no clean way to deal with all the wackiness.  So we  
> just pick something that fits OK and go with it.

Just a flat directory.

I don't really care that much about all this.  If someone wants to  
clean it up feel free to, but not sure what the value of that is.   
However, if you are going to fix the Kconfig issue I just mentioned  
as well.

- k
