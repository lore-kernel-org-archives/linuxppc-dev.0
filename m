Return-Path: <tpiepho@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6B687DDE1E
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Dec 2008 09:55:31 +1100 (EST)
Date: Wed, 10 Dec 2008 14:55:18 -0800 (PST)
From: Trent Piepho <tpiepho@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC/PATCH 1/2] powerpc: Rework usage of
	_PAGE_COHERENT/NO_CACHE/GUARDED
In-Reply-To: <1228941726.22413.98.camel@pasglop>
Message-ID: <Pine.LNX.4.64.0812101416350.28806@t2.domain.actdsltmp>
References: <20081210055136.63D5FDDF5C@ozlabs.org>
	<Pine.LNX.4.64.0812101107350.28806@t2.domain.actdsltmp>
	<1228941726.22413.98.camel@pasglop>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 11 Dec 2008, Benjamin Herrenschmidt wrote:
> On Wed, 2008-12-10 at 11:33 -0800, Trent Piepho wrote:
>> On Wed, 10 Dec 2008, Benjamin Herrenschmidt wrote:
>>> This changes the logic so that instead, the PTE now contains
>>> _PAGE_COHERENT for all normal RAM pages tha have I = 0. The hash
>>> code clears it if the feature bit is not set.
>>
>> Why not check the feature bit when the PTE is made and unset _PAGE_COHERENT
>> at that point?  In fact, could you do something like:
>
> Not sure what you mean. Inside set_pte_at ? Well, the one line of asm is
> going to be in the noise in the hash code, I'm just flipping an existing
> condition. I like the PTE to represent whether it's supposed to be a
> coherent page.

In the code that does the mapping.  It's a lot cheaper to figure out if
_PAGE_COHERENT is needed once per mapping instead of per page per fault.

It sounds like getting it right is a lot more complicated than just one
instruction.  No M bit for non-SMP, except for some 74xx, or if a MPC107
bridge is used, which should be determined at runtime.  And does the MPC107
thing apply to all pages or just those PCI memory behind the bridge?  Or
DMA?

> I've been told that setting M on non-SMP will slows things down.  But
>> couldn't you just change _PAGE_BASE on non-SMP instead of clearning it in
>> the miss handler?
>
> Well, because we need it set on non SMP on some 74xx.. maybe we can
> have it set in PAGE_BASE only if CONFIG_SMP and CONFIG_6xx ?

That's what I was thinking, set it in page base for SMP and other instances
when we know it's necessary at compile time.  If/when there is a runtime
check, then it would be lot easier to put that check in the code that made
the mapping instead of the miss handler.

>> I have a patch to remove this IORESOURCE_PREFETCH hack.  The current kernel
>> creates two files, resourceN and resourceN_wc, for prefetchable BARs to
>> allow the user to choose what mode to use.
>
> Ah ? That's new ? I missed it. Has X been updated to use them ? If not,
> keep the hack for a little while more :-)

It's rather new so I bet X servers that use it aren't widely deployed yet.

commit 45aec1ae72fc592f231e9e73ed9ed4d10cfbc0b5
Author: venkatesh.pallipadi@intel.com <venkatesh.pallipadi@intel.com>
Date:   Tue Mar 18 17:00:22 2008 -0700

     x86: PAT export resource_wc in pci sysfs

Patch title is somewhat misleading, as it doesn't touch any x86 specific
code.  And people complain when I used booke instead of fsl-booke...  like
I want to make it any easier to have patches ignored.
