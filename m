Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rsPsf3R63zDqGv
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Jul 2016 08:55:18 +1000 (AEST)
Message-ID: <1468709715.20552.161.camel@kernel.crashing.org>
Subject: Re: [PATCH 02/14] powerpc/irq: Add support for HV virtualization
 interrupts
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Date: Sat, 16 Jul 2016 17:55:15 -0500
In-Reply-To: <1468704837.20552.146.camel@kernel.crashing.org>
References: <1467959838-6900-1-git-send-email-benh@kernel.crashing.org>
 <1467959838-6900-2-git-send-email-benh@kernel.crashing.org>
 <87ziphamta.fsf@@concordia.ellerman.id.au>
 <1468704837.20552.146.camel@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2016-07-16 at 16:33 -0500, Benjamin Herrenschmidt wrote:
> On Sat, 2016-07-16 at 20:40 +1000, Michael Ellerman wrote:s
> > This is breaking allmodconfig with:
> > 
> > arch/powerpc/kernel/exceptions-64s.S:778: Error: attempt to move
> > .org backwards
> > arch/powerpc/kernel/exceptions-64s.S:779: Error: attempt to move
> > .org backwards
> > arch/powerpc/kernel/exceptions-64s.S:803: Error: attempt to move
> > .org backwards
> > arch/powerpc/kernel/exceptions-64s.S:804: Error: attempt to move
> > .org backwards
> > arch/powerpc/kernel/exceptions-64s.S:823: Error: attempt to move
> > .org backwards
> > arch/powerpc/kernel/exceptions-64s.S:833: Error: attempt to move
> > .org backwards
> > 
> > http://kisskb.ozlabs.ibm.com/kisskb/buildresult/12746513/
> 
> Yuck. Is that even fixable without completely shuffling all the
> IRQ stuff ? We really need to find a way to sort that shit once
> and for all...

I reproduced... We need to move more of the "common" ones out of the
way, without making the conditional branches lose it. Ugh.... 

Another quick and easy option: Get rid of Cell :-) There is 3 cell
ones right there  we could get rid of ;-)

 ... except that's not enough. Now the OOL handlers are bumping
into the FWNMI page. Argh. Moved a couple more, seems to work,

I'm sending you a patch in the next few monites to test that needs to
be added *before* the HV virtualization interrupts one. It works
with the few variants of allmodconfigs I managed to try on the laptop
(basically with and without RELOCATABLE).

Let me know how it goes in kisskb.

Cheers,
Ben.
