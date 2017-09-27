Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y2CDM5XDYzDsPQ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Sep 2017 19:28:19 +1000 (AEST)
Date: Wed, 27 Sep 2017 04:27:58 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Cyril Bur <cyrilbur@gmail.com>, Simon Guo <wei.guo.simon@gmail.com>,
 raji@linux.vnet.ibm.com,
 "Naveen N.  Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 David Laight <David.Laight@ACULAB.COM>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 2/3] powerpc/64: enhance memcmp() with VMX instruction
 for long bytes comparision
Message-ID: <20170927092758.GL8421@gate.crashing.org>
References: <1505950480-14830-1-git-send-email-wei.guo.simon@gmail.com>
 <1505950480-14830-3-git-send-email-wei.guo.simon@gmail.com>
 <1506089208.1155.32.camel@gmail.com>
 <20170923211843.GA10899@simonLocalRHEL7.x64>
 <1506383986.2918.4.camel@gmail.com> <87k20mf2fn.fsf@concordia.ellerman.id.au>
 <20170926112623.GZ8421@gate.crashing.org>
 <877ewkg6am.fsf@concordia.ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <877ewkg6am.fsf@concordia.ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 27, 2017 at 01:38:09PM +1000, Michael Ellerman wrote:
> Segher Boessenkool <segher@kernel.crashing.org> writes:
> > A lot of userspace code uses V*X, more and more with newer CPUs and newer
> > compiler versions.  If you already paid the price for using vector
> > registers you do not need to again :-)
> 
> True, but you don't know if you've paid the price already.
> 
> You also pay the price on every context switch (more state to switch),
> so it's not free even once enabled. Which is why the kernel will
> eventually turn it off if it's unused again.

Yup.  But my point is that because user space code uses vector registers
more and more, the penalty for user space code to use vector registers
even more keeps shrinking.

> But now that I've actually looked at the glibc version, it does do some
> checks for minimum length before doing any vector instructions, so
> that's probably all we want. The exact trade off between checking some
> bytes without vector vs turning on vector depends on your input data, so
> it's tricky to tune in general.

You also need nasty code to deal with the start and end of strings, with
conditional branches and whatnot, which quickly overwhelms the benefit
of using vector registers at all.  This tradeoff also changes with newer
ISA versions.

Things have to become *really* cheap before it will be good to often use
vector registers in the kernel though.


Segher
