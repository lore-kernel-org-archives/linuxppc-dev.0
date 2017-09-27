Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y23SL0W6xzDqNm
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Sep 2017 13:38:10 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Cyril Bur <cyrilbur@gmail.com>, Simon Guo <wei.guo.simon@gmail.com>,
 raji@linux.vnet.ibm.com, "Naveen N.  Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 David Laight <David.Laight@ACULAB.COM>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 2/3] powerpc/64: enhance memcmp() with VMX instruction
 for long bytes comparision
In-Reply-To: <20170926112623.GZ8421@gate.crashing.org>
References: <1505950480-14830-1-git-send-email-wei.guo.simon@gmail.com>
 <1505950480-14830-3-git-send-email-wei.guo.simon@gmail.com>
 <1506089208.1155.32.camel@gmail.com>
 <20170923211843.GA10899@simonLocalRHEL7.x64>
 <1506383986.2918.4.camel@gmail.com> <87k20mf2fn.fsf@concordia.ellerman.id.au>
 <20170926112623.GZ8421@gate.crashing.org>
Date: Wed, 27 Sep 2017 13:38:09 +1000
Message-ID: <877ewkg6am.fsf@concordia.ellerman.id.au>
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

Segher Boessenkool <segher@kernel.crashing.org> writes:

> On Tue, Sep 26, 2017 at 03:34:36PM +1000, Michael Ellerman wrote:
>> Cyril Bur <cyrilbur@gmail.com> writes:
>> > This was written for userspace which doesn't have to explicitly enable
>> > VMX in order to use it - we need to be smarter in the kernel.
>> 
>> Well the kernel has to do it for them after a trap, which is actually
>> even more expensive, so arguably the glibc code should be smarter too
>> and the threshold before using VMX should probably be higher than in the
>> kernel (to cover the cost of the trap).
>
> A lot of userspace code uses V*X, more and more with newer CPUs and newer
> compiler versions.  If you already paid the price for using vector
> registers you do not need to again :-)

True, but you don't know if you've paid the price already.

You also pay the price on every context switch (more state to switch),
so it's not free even once enabled. Which is why the kernel will
eventually turn it off if it's unused again.

But now that I've actually looked at the glibc version, it does do some
checks for minimum length before doing any vector instructions, so
that's probably all we want. The exact trade off between checking some
bytes without vector vs turning on vector depends on your input data, so
it's tricky to tune in general.

>> But I digress :)
>
> Yeah sorry :-)

:)

cheers
