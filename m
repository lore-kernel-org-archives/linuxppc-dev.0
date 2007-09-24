Return-Path: <vbarshak@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 78D0EDDE19
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Sep 2007 20:36:55 +1000 (EST)
Message-ID: <46F79305.9050300@ru.mvista.com>
Date: Mon, 24 Sep 2007 14:35:49 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Sequoia kernel crash workaround.
References: <46F16CC9.3010003@ru.mvista.com> <200709192119.48259.sr@denx.de>	
	<20070919193024.GA28163@lixom.net>	
	<20070919150818.3fecc1bc@weaponx.rchland.ibm.com>	
	<46F2A640.1000802@ru.mvista.com>
	<20070920172506.GA16354@lixom.net>	
	<20070920122919.32dd8061@weaponx.rchland.ibm.com>
	<1190535664.3723.16.camel@localhost.localdomain>
In-Reply-To: <1190535664.3723.16.camel@localhost.localdomain>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Cc: linuxppc-dev@ozlabs.org, Olof Johansson <olof@lixom.net>,
	Josh Boyer <jwboyer@gmail.com>, Stefan Roese <sr@denx.de>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Thu, 2007-09-20 at 12:29 -0500, Josh Boyer wrote:
>> On Thu, 20 Sep 2007 12:25:06 -0500
>> Olof Johansson <olof@lixom.net> wrote:
>>
>>> On Thu, Sep 20, 2007 at 08:56:32PM +0400, Valentine Barshak wrote:
>>>> I was thinking about it. Looks like it's the best place, but the code that 
>>>> actually calls setup_cpu is under ifdef CONFIG_PPC64, while lots of 
>>>> cpu_setup functions are defined for ppc32 processors.
>>>> Is it OK to remove this ifdef, or should I do CONFIG_PPC64 || CONFIG_44x?
>>> Sounds like something that went wrong at the merge of ppc and ppc64.
>>>
>>> Take out the ifdef, even if there's fallout we should deal with it
>>> instead of adding more complex ifdefs.
>> Yeah.  Looks like BenH did this in commit:
>>
>> 42c4aaadb737e0e672b3fb86b2c41ff59f0fb8bc
>>
>> Ben, any reason you ifdef'd it for ppc64?
> 
> I'll have to check on monday what's up there, but isn't setup_cpu called
> from a different place on 32 bits? There are some subtle difference with
> the way the cpu feature stuff is initialized /done between 32 and 64
> bits that we haven't fully reconciled yet. 
> 
> Ben.
> 

 From what I've seen, setup_cpu is never called for BOOKE.
Currently It's called from cputable.c for PPC64 and from head_32.S for 6xx.
Thanks,
Valentine.

> 
