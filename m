Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y2fvR5XgdzDsM9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Sep 2017 13:15:14 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id f84so252621pfj.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Sep 2017 20:15:14 -0700 (PDT)
Date: Thu, 28 Sep 2017 00:22:44 +0800
From: Simon Guo <wei.guo.simon@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Segher Boessenkool <segher@kernel.crashing.org>,
 Cyril Bur <cyrilbur@gmail.com>, raji@linux.vnet.ibm.com,
 "Naveen N.  Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 David Laight <David.Laight@ACULAB.COM>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 2/3] powerpc/64: enhance memcmp() with VMX instruction
 for long bytes comparision
Message-ID: <20170927162243.GA2752@simonLocalRHEL7.x64>
References: <1505950480-14830-1-git-send-email-wei.guo.simon@gmail.com>
 <1505950480-14830-3-git-send-email-wei.guo.simon@gmail.com>
 <1506089208.1155.32.camel@gmail.com>
 <20170923211843.GA10899@simonLocalRHEL7.x64>
 <1506383986.2918.4.camel@gmail.com>
 <87k20mf2fn.fsf@concordia.ellerman.id.au>
 <20170926112623.GZ8421@gate.crashing.org>
 <877ewkg6am.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
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

Hi Michael,
On Wed, Sep 27, 2017 at 01:38:09PM +1000, Michael Ellerman wrote:
> Segher Boessenkool <segher@kernel.crashing.org> writes:
> 
> > On Tue, Sep 26, 2017 at 03:34:36PM +1000, Michael Ellerman wrote:
> >> Cyril Bur <cyrilbur@gmail.com> writes:
> >> > This was written for userspace which doesn't have to explicitly enable
> >> > VMX in order to use it - we need to be smarter in the kernel.
> >> 
> >> Well the kernel has to do it for them after a trap, which is actually
> >> even more expensive, so arguably the glibc code should be smarter too
> >> and the threshold before using VMX should probably be higher than in the
> >> kernel (to cover the cost of the trap).
> >
> > A lot of userspace code uses V*X, more and more with newer CPUs and newer
> > compiler versions.  If you already paid the price for using vector
> > registers you do not need to again :-)
> 
> True, but you don't know if you've paid the price already.
> 
> You also pay the price on every context switch (more state to switch),
> so it's not free even once enabled. Which is why the kernel will
> eventually turn it off if it's unused again.
> 
> But now that I've actually looked at the glibc version, it does do some
> checks for minimum length before doing any vector instructions, so

Looks the glibc version will use VSX instruction and lead to trap in a 
9 bytes size cmp with src/dst 16 bytes aligned. 
 132         /* Now both rSTR1 and rSTR2 are aligned to QW.  */
 133         .align  4
 134 L(qw_align):
 135         vspltisb        v0, 0
 136         srdi.   r6, rN, 6
 137         li      r8, 16
 138         li      r10, 32
 139         li      r11, 48
 140         ble     cr0, L(lessthan64)
 141         mtctr   r6
 142         vspltisb        v8, 0
 143         vspltisb        v6, 0
 144         /* Aligned vector loop.  */
 145         .align  4
line 135 is the VSX instruction causing trap. Did I miss anything?

> that's probably all we want. The exact trade off between checking some
> bytes without vector vs turning on vector depends on your input data, so
> it's tricky to tune in general.

Discussed offline with Cyril. The plan is to use (>=4KB) as the minimum len 
before vector regs steps at v3. Cyril will consolidate his existing work on 
KSM optimization later, which is probably making 64bytes comparison-ahead to 
determine whether it is an early or late matching pattern.

Cyril has also some other valuable comments and I will rework on v3.

Is it OK for you?

Thanks,
- Simon
