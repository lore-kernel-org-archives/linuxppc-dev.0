Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s7ZxH579GzDqQq
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Aug 2016 10:32:35 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, chzigotzky@xenosoft.de,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/pci: Only do fixed PHB numbering on powernv
In-Reply-To: <57A88661.2000606@linux.vnet.ibm.com>
References: <1470379256-24266-1-git-send-email-mpe@ellerman.id.au>
 <20160807234824.GA4628@gwshan> <57A88661.2000606@linux.vnet.ibm.com>
Date: Tue, 09 Aug 2016 10:32:35 +1000
Message-ID: <87bn12srx8.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com> writes:

> On 08/07/2016 08:48 PM, Gavin Shan wrote:
>> On Fri, Aug 05, 2016 at 04:40:56PM +1000, Michael Ellerman wrote:
>>> The recent commit 63a72284b159 ("powerpc/pci: Assign fixed PHB number
>>> based on device-tree properties"), added code to read a 64-bit property
>>>from the device tree, and if not found read a 32-bit property (reg).
>>>
>>> There was a bug in the 32-bit case, on big endian machines, due to the
>>> use of the 64-bit value to read the 32-bit property. The cast of &prop
>>> means we end up writing to the high 32-bit of prop, leaving the low
>>> 32-bits containing whatever junk was on the stack.
>>>
>>> If that junk value was non-zero, and < MAX_PHBS, we would end up using
>>> it as the PHB id.
>>>
>>> This exposed a second problem, which is that Xorg can't cope with a
>>> domain number > 256.
>>>
>>> So for now drop the fallback to reg, and only use "ibm,opal-phbid" for
>>> PHB numbering.
>>>
>>> Fixes: 63a72284b159 ("powerpc/pci: Assign fixed PHB number based on device-tree properties")
>>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>>> ---
>>> arch/powerpc/kernel/pci-common.c | 24 +++++++++---------------
>>> 1 file changed, 9 insertions(+), 15 deletions(-)
>>>
>>>
>>> This is my bad. Guilherme limited the reg case to pseries only, but I made it
>>> generic. I tested it on G5, Cell etc. which all booted - but that's not really
>>> a good enough test.
>
> Michael and Gavin, thanks very much for fixing and commenting on the 
> issue. I'm sorry about the bug on Big Endian machines, my mistake! I'll 
> fix it in a future patch, but right now I have 2 questions so I can 
> investigate better the issue found on Xorg:
>
> (i) What is the specific issue? Do you have some logs or at least a 
> "high-level" description of the problem in Xorg? I took a look in its 
> code and PCI domain is coded as u16, which is correct/expected. So it 
> seems a subtle bug we should investigate and hopefully fix.

It was reported here:

  https://lists.ozlabs.org/pipermail/linuxppc-dev/2016-August/147062.html

It seems xorg just has a hard coded limit of 256 domains.

> (ii) Why is it related to the absence of pseries check?! You said this 
> was your bad, but as far as I understand, Xorg runs in pSeries too so 
> the issue should also be there heheh

Well yes I guess it would, if anyone had tested Xorg on pseries :)

> The bug was reported/found in another platform?

Yeah pasemi, see the email above.

On closer inspection I also see it on my G5, ie. the domain numbers are
random, but the machine doesn't mind (because I don't run xorg).

> As Gavin pointed, the important/interesting part of the patch is related 
> to pSeries, in which we have PHB hotplug and so the patch allows network 
> adapters to work well in PHB hotplug scenario, even if using predictable 
> naming. For now, I guess this fix is pretty good, but would be really 
> important to have this feature on pSeries too - I'll put some effort in 
> solving the Xorg bug.

I think for now I'm going to apply this, and we'll work out something
else later.

cheers
