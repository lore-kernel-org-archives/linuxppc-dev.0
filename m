Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D96CFDDE34
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Aug 2007 15:27:21 +1000 (EST)
In-Reply-To: <20070808110029.43c110ef@weaponx.rchland.ibm.com>
References: <20070807042050.GJ13522@localhost.localdomain>
	<BDA0DE7D-8AD8-4116-ABE0-2DF6AE72A516@kernel.crashing.org>
	<20070808110029.43c110ef@weaponx.rchland.ibm.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <57F869A4-38DE-4CC9-A07D-C3A873CE9268@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Fix small race in 44x tlbie function
Date: Thu, 9 Aug 2007 00:28:20 -0500
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Volkmar Uhlig <vuhlig@us.ibm.com>,
	Paul Mackerras <paulus@samba.org>, Todd Inglett <tinglett@us.ibm.com>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 8, 2007, at 11:00 AM, Josh Boyer wrote:

> On Wed, 8 Aug 2007 10:20:45 -0500
> Kumar Gala <galak@kernel.crashing.org> wrote:
>
>>
>> On Aug 6, 2007, at 11:20 PM, David Gibson wrote:
>>
>>> The 440 family of processors don't have a tlbie instruction.  So, we
>>> implement TLB invalidates by explicitly searching the TLB with  
>>> tlbsx.,
>>> then clobbering the relevant entry, if any.  Unfortunately the  
>>> PID for
>>> the search needs to be stored in the MMUCR register, which is also
>>> used by the TLB miss handler.  Interrupts were enabled in _tlbie 
>>> (), so
>>> an interrupt between loading the MMUCR and the tlbsx could cause
>>> incorrect search results, and thus a failure to invalide TLB entries
>>> which needed to be invalidated.
>>>
>>> This patch fixes the problem in both arch/ppc and arch/powerpc by
>>> inhibiting interrupts (even critical and debug interrupts) across  
>>> the
>>> relevant instructions.
>>>
>>> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>>> ---
>>> Paul, this one's a bugfix, which I think should go into 2.6.23.
>>
>> Did you actually see this happen?
>
> Yes.

When?

We don't have critical wired to anything, I don't expect watchdog to  
cause another fault.. so just wondering.

- k
