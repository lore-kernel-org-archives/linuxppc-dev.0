Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 73953DE7AE
	for <linuxppc-dev@ozlabs.org>; Thu, 22 May 2008 07:13:03 +1000 (EST)
Message-Id: <1941C6C3-9883-4015-91A6-35F5966AA1ED@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Rune Torgersen <runet@innovsys.com>
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B046E7AF5@ismail.innsys.innovsys.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: 1 GB lowmem
Date: Wed, 21 May 2008 16:12:40 -0500
References: <DCEAAC0833DD314AB0B58112AD99B93B046E79B3@ismail.innsys.innovsys.com>
	<DCEAAC0833DD314AB0B58112AD99B93B046E7AA0@ismail.innsys.innovsys.com>
	<DCEAAC0833DD314AB0B58112AD99B93B046E7AF5@ismail.innsys.innovsys.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 21, 2008, at 3:55 PM, Rune Torgersen wrote:

> Rune Torgersen wrote:
>> linuxppc-dev-bounces+runet=innovsys.com@ozlabs.org wrote:
>>> Hi
>>>
>>> I am trying to enable 1 GB of lowmem on a Freescale 8280.
>>> In arch/ppc this was easilly done by:
>>> CONFIG_ADVANCED_OPTIONS=y
>>> CONFIG_HIGHMEM_START=0xfe000000
>>> CONFIG_LOWMEM_SIZE_BOOL=y
>>> CONFIG_LOWMEM_SIZE=0x40000000
>>> CONFIG_KERNEL_START_BOOL=y
>>> CONFIG_KERNEL_START=0xa0000000
>>>
>>> This does not work in arch/powerpc. CPU hangs as soon as init  
>>> starts.
>>> Any ideas what to look at, what to change?
>>>
>>> The reason I want to do this is because I cannot get highmem support
>>> to work when using CONFIG_PREEMPT_RT.
>>> (hitting a bug_on in kmap_atomic)
>>
>> Scratch that. 1 GB lowmem works with vanilla 2.6.25.4, but
>> not at all with 2.6.25.4-rt[13]
>
> Argh... Found it. Had to set CONFIG_TASK_SIZE to 0x80000000. Now it
> works in both vaniulla an d RT kernel.

We should really add some sanity check on CONFIG_TASK_SIZE vs  
KERNEL_START.

- k
