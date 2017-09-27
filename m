Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out6.electric.net (smtp-out6.electric.net
 [192.162.217.183])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y2CZK3Kb5zDsPQ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Sep 2017 19:43:51 +1000 (AEST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Segher Boessenkool' <segher@kernel.crashing.org>, Michael Ellerman
 <mpe@ellerman.id.au>
CC: Cyril Bur <cyrilbur@gmail.com>, Simon Guo <wei.guo.simon@gmail.com>,
 "raji@linux.vnet.ibm.com" <raji@linux.vnet.ibm.com>, "Naveen N.  Rao"
 <naveen.n.rao@linux.vnet.ibm.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH v2 2/3] powerpc/64: enhance memcmp() with VMX
 instruction for long bytes comparision
Date: Wed, 27 Sep 2017 09:43:44 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DD0082414@AcuExch.aculab.com>
References: <1505950480-14830-1-git-send-email-wei.guo.simon@gmail.com>
 <1505950480-14830-3-git-send-email-wei.guo.simon@gmail.com>
 <1506089208.1155.32.camel@gmail.com>
 <20170923211843.GA10899@simonLocalRHEL7.x64>
 <1506383986.2918.4.camel@gmail.com>
 <87k20mf2fn.fsf@concordia.ellerman.id.au>
 <20170926112623.GZ8421@gate.crashing.org>
 <877ewkg6am.fsf@concordia.ellerman.id.au>
 <20170927092758.GL8421@gate.crashing.org>
In-Reply-To: <20170927092758.GL8421@gate.crashing.org>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Segher Boessenkool
> Sent: 27 September 2017 10:28
...
> You also need nasty code to deal with the start and end of strings, with
> conditional branches and whatnot, which quickly overwhelms the benefit
> of using vector registers at all.  This tradeoff also changes with newer
> ISA versions.

The goal posts keep moving.
For instance with modern intel x86 cpus 'rep movsb' is by far the fastest
way to copy data (from cached memory).

> Things have to become *really* cheap before it will be good to often use
> vector registers in the kernel though.

I've had thoughts about this in the past.
If the vector registers belong to the current process then you might
get away with just saving the ones you want to use.
If they belong to a different process then you also need to tell the
FPU save code where you've saved the registers.
Then the IPI code can recover all the correct values.

On X86 all the AVX registers are caller saved, the system call
entry could issue the instruction that invalidates them all.
Kernel code running in the context of a user process could then
use the registers without saving them.
It would only need to set a mark to ensure they are invalidated
again on return to user (might be cheap enough to do anyway).
Dunno about PPC though.

	David
