Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B2580B6F1A
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 27 Nov 2009 10:18:54 +1100 (EST)
In-Reply-To: <1259269265.18084.14.camel@pasglop>
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-4-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-5-git-send-email-albert_herranz@yahoo.es>
	<49436.84.105.60.153.1259171377.squirrel@gate.crashing.org>
	<1259211061.16367.260.camel@pasglop> <4B0E9C5F.50304@yahoo.es>
	<1259269265.18084.14.camel@pasglop>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <A31276B2-3BAC-4F03-9DB1-2A383A2E4E5B@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC PATCH 04/19] powerpc: wii: device tree
Date: Fri, 27 Nov 2009 00:25:49 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Albert Herranz <albert_herranz@yahoo.es>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>> There you can find the hardware interface that supports the IPC  
>> mechanism.
>> It is made up of a pair of registers to pass data between the  
>> processors and a
>> pair of control/flags registers.
>> The hardware can interrupt the PowerPC side when there is data  
>> available for it.
>
> Ok. So the right way to do that would be to have a node purely
> representing the HW IPC, unrelated to whatever is running on the
> secondary processor.

Or you can keep it implicit in the Hollywood control registers.
It is one 512-byte block with lots of things thrown together (and
then mixed up real good).

> However, it's ok to have -below- that node, a set of device nodes or a
> node with properties or whatever representing the FW in there and the
> function it exposes.

That's not really useful though, it's easy to probe for.

> What might do however is to have a way for that FW itself to  
> provide you
> with the nodes and properties for the functions it provides :-)

You get a pointer at the very last word of memory.  It point to an
info header that has everything you need to know (most importantly,
a version identifier).

> Of course that wouldn't work with FW we don't have control on. Can  
> Linux
> run on the wii with the original N. FW on the aux. processor ?

It _can_, but there are no advantages to doing that, and lots and  
lots of
disadvantages, so the plan is to not add support for that in mainline.

> Can we
> detect what is running there ? Do we care ?

You can detect this for anything that uses a mini-compatible interface.
You shouldn't care for anything else ;-)


Segher
