Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 694BEB7BC3
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 27 Nov 2009 09:59:30 +1100 (EST)
In-Reply-To: <20091126081724.GA6538@iram.es>
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-4-git-send-email-albert_herranz@yahoo.es>
	<CE435D2F-8C67-4045-942D-4AA08BF784D0@kernel.crashing.org>
	<4B0C1A25.8030401@yahoo.es>
	<CC1D5EB1-27C2-47A1-96D8-D007D86C4881@kernel.crashing.org>
	<1259210216.16367.249.camel@pasglop>
	<20091126081724.GA6538@iram.es>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <9D0F5136-B8A5-4519-BF32-70E881A57F49@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC PATCH 03/19] powerpc: gamecube: bootwrapper bits
Date: Fri, 27 Nov 2009 00:06:22 +0100
To: Gabriel Paubert <paubert@iram.es>
Cc: Albert Herranz <albert_herranz@yahoo.es>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>>> Sure, the memory controllers don't do coherency.  I'm slightly  
>>> worried
>>> about two things:
>>> 1) Will the generic code use M=0 as well?  Is it a problem if it
>>> doesn't?
>>
>> We can make it not do it.
>>
>>> 2) Do lwarx. etc. work in M=0?
>>
>> They should hopefully... as long as you don't rely on the reservation
>> blowing as a result of a DMA write.
>
> Hmm, this really depends on whether the DMA transfers generate bus  
> cycles
> that require coherency or not.

They do not; device DMA never goes to the 6xx bus with this bridge.

> Not the other way around. M=1 only forces
> bus cycles to be snooped by other processors (asserting the GBL signal
> on 603/604/750 busses).

Right, it enables sending probes, not receiving them.  On this CPU  
anyway.
The architecture specification is quite silent on this all.


Segher
