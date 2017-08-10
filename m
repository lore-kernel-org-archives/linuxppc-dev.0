Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xSpTn09mpzDqs4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Aug 2017 23:13:01 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>,
 Benjamin Herrenschmidt <benh@au1.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 08/13] powerpc/64s: irq replay remove spurious irq reason
In-Reply-To: <20170806105106.1362d100@roar.ozlabs.ibm.com>
References: <20170805170241.22966-1-npiggin@gmail.com>
 <20170805170241.22966-9-npiggin@gmail.com>
 <1501974032.2664.135.camel@au1.ibm.com>
 <20170806105106.1362d100@roar.ozlabs.ibm.com>
Date: Thu, 10 Aug 2017 23:12:57 +1000
Message-ID: <87378zmuqu.fsf@concordia.ellerman.id.au>
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

Nicholas Piggin <npiggin@gmail.com> writes:

> On Sun, 06 Aug 2017 09:00:32 +1000
> Benjamin Herrenschmidt <benh@au1.ibm.com> wrote:
>
>> On Sun, 2017-08-06 at 03:02 +1000, Nicholas Piggin wrote:
>> > HVI interrupts have always used 0x500, so remove the dead branch.  
>> 
>> Maybe we should fix that and "catch" in incorrect entry via 0x500
>> which would mean the XIVE is trying to deliver guest irqs to the OS...
>
> I should be more clear, when I say 0x500, it is only in reference to
> the constant used by the soft-irq replay. After patch 6 the replay is
> sent to the 0xea0 common handler.
>
>> That can happen if some LPCR bits aren't set properly and/or KVM
>> doesn't pull the guest in time. I had bugs like that in my early
>> dev so I've been running with a b . at 0x500 for a while :-)
>
> So that's a separate issue of hardware actually doing a 0x500. I
> had this
>
> http://patchwork.ozlabs.org/patch/750033/

Hmm, yeah I was going to merge that.

But I got side tracked by HVICE, ie. the "interrupts don't go to 0x500"
is only true if we set HVICE.

Which we currently always do, in __setup_cpu_power9(), but then we have
a DT CPU feature for it, so we really shouldn't be always enabling
HVICE, we should leave it up to the DT CPU feature code.

And then it becomes controlled by the device tree, which makes your
patch potentially wrong depending on the device tree CPU features.

Ugh.

cheers
