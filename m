Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2180BDDE27
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Sep 2007 23:38:40 +1000 (EST)
In-Reply-To: <AE678FA4-5ABF-4EAC-B691-CCE5D277955F@kernel.crashing.org>
References: <46F88896.50706@au1.ibm.com>	
	<E4CA12E1-888D-4A8B-B687-02F9D2850E1F@kernel.crashing.org>	
	<46F94CBA.2060901@genesi-usa.com>
	<1190758712.23457.0.camel@localhost.localdomain>
	<46FA3CDD.2070409@genesi-usa.com>
	<997c015e13649d06e246d3d2c1369100@kernel.crashing.org>
	<AE678FA4-5ABF-4EAC-B691-CCE5D277955F@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <859030d435cf9990c7a582cde8fe670c@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] add Altivec/VMX state to coredumps
Date: Wed, 26 Sep 2007 15:38:03 +0200
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>>> Why not put the PVR in core dumps that'd make it all easier..
>>>>
>>>> PVR wouldn't be very useful...  What if you have altivec disabled ?
>>>> Also
>>>> that would mean your gdb has to know about all new processors...
>>>
>>> Is that such a big deal? :D
>>>
>>> Hypothetically it would be impossible to determine if you were 
>>> running
>>> on a G5 with the FPU and AltiVec turned off or an e500 core with SPE,
>>> given the data saved.
>>
>> And that is exactly as should be: a core dump represents the execution
>> state of a user program, it has nothing to do with the machine it was
>> generated on; it even is possible to restart a core dump generated on
>> e.g. an e500 on a 970, as long as it doesn't use facilities (e.g., 
>> SPE)
>> that the latter processor / execution environment doesn't provide.
>>
>>> Is that a misfeature of GDB that we even have to
>>> worry about this, or some noble plus point of a unified ISA? You
>>> decide :)
>>
>> We don't have to worry about it :-)
>
> We should worry about it.  If one misinterprets the core file you will 
> get unexpected behavior.

I read this as "worry about the PVR".

> I see no reason not to do this properly and mark the sections such 
> that its clear if its AltiVec or SPE state, rather than overloading 
> the x86 XFPU type.

Yes, certainly, I thought we all agreed on that automatically :-)


Segher
