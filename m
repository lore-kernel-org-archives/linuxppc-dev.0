Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DE29D2C0092
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Aug 2012 07:58:10 +1000 (EST)
Message-ID: <502C1B64.8050505@freescale.com>
Date: Wed, 15 Aug 2012 16:57:56 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH V7 1/3] powerpc/pci: Make sure ISA IO base is not zero
References: <1345021026-10886-1-git-send-email-B38951@freescale.com>
 <1345021026-10886-2-git-send-email-B38951@freescale.com>
 <502BDC6B.4090800@freescale.com> <1345066379.11596.1.camel@pasglop>
In-Reply-To: <1345066379.11596.1.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Cc: B07421@freescale.com, linuxppc-dev@lists.ozlabs.org,
 Jia Hongtao <B38951@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/15/2012 04:32 PM, Benjamin Herrenschmidt wrote:
> On Wed, 2012-08-15 at 12:29 -0500, Scott Wood wrote:
>>> ---
>>>  arch/powerpc/kernel/pci-common.c |    2 +-
>>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
>>> index 0f75bd5..2a09aa5 100644
>>> --- a/arch/powerpc/kernel/pci-common.c
>>> +++ b/arch/powerpc/kernel/pci-common.c
>>> @@ -734,7 +734,7 @@ void __devinit pci_process_bridge_OF_ranges(struct pci_controller *hose,
>>>  			hose->io_base_virt = ioremap(cpu_addr, size);
>>>  
>>>  			/* Expect trouble if pci_addr is not 0 */
>>> -			if (primary)
>>> +			if (primary || !isa_io_base)
>>>  				isa_io_base =
>>>  					(unsigned long)hose->io_base_virt;
>>>  #endif /* CONFIG_PPC32 */
>>>
>>
>> Didn't I already point out that this has problems when the primary bus
>> is not the first to be probed?  If your answer is that you fix that in a
>> later patch, that breaks bisectability.
> 
> Is it though ? ie, we will override it with the real primary in the
> above test, so it will only very temporarily be set to the "wrong" bus
> no ? IE, the test will still trip on the actual "primary" if there's
> one

Is there no lasting remnant of that temporary wrong isa_io_base?  We
won't have I/O resources that were calculated relative to that, which
stop working once isa_io_base changes?  Or does that happen later, after
this function has been called on all buses (and would that continue to
be the case if we change the PCI bus to a platform device)?

-Scott
