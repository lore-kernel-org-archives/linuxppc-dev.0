Return-Path: <matt@genesi-usa.com>
Received: from mail.genesi-usa.com (mithrandir.softwarenexus.net
	[66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id ED9C1DDE37
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Sep 2007 23:58:52 +1000 (EST)
Message-ID: <46FA65FC.4000208@genesi-usa.com>
Date: Wed, 26 Sep 2007 15:00:28 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] add Altivec/VMX state to coredumps
References: <46F88896.50706@au1.ibm.com>	
	<E4CA12E1-888D-4A8B-B687-02F9D2850E1F@kernel.crashing.org>	
	<46F94CBA.2060901@genesi-usa.com>
	<1190758712.23457.0.camel@localhost.localdomain>
	<46FA3CDD.2070409@genesi-usa.com>
	<997c015e13649d06e246d3d2c1369100@kernel.crashing.org>
In-Reply-To: <997c015e13649d06e246d3d2c1369100@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Segher Boessenkool wrote:
>>>> Why not put the PVR in core dumps that'd make it all easier..
>>>
>>> PVR wouldn't be very useful...  What if you have altivec disabled ? Also
>>> that would mean your gdb has to know about all new processors...
>>
>> Is that such a big deal? :D
>>
>> Hypothetically it would be impossible to determine if you were running
>> on a G5 with the FPU and AltiVec turned off or an e500 core with SPE,
>> given the data saved.
> 
> And that is exactly as should be: a core dump represents the execution
> state of a user program, it has nothing to do with the machine it was
> generated on; it even is possible to restart a core dump generated on
> e.g. an e500 on a 970, as long as it doesn't use facilities (e.g., SPE)
> that the latter processor / execution environment doesn't provide.

A hypothetical question for you then..

What happens if you get a core dump for a G4 app which dynamically detects
AltiVec presence (from PVR or /proc) then crashes before AltiVec is enabled
in the kernel for that task (i.e. before any vector exception) and you run
it on your G3 and it magically carries on (maybe a race condition or so)
and causes a vector exception later?

Isn't that kind of useless? Wouldn't it?

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
