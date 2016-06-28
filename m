Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rdxwZ1SG6zDqRd
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 17:18:06 +1000 (AEST)
Message-ID: <1467098279.28062.8.camel@ellerman.id.au>
Subject: Re: arch/powerpc/xmon/dis-asm.h: 2 * wrong specifiers ?
From: Michael Ellerman <mpe@ellerman.id.au>
To: David Binderman <linuxdev.baldrick@gmail.com>
Cc: benh@kernel.crashing.org, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org,  Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, dcb314@hotmail.com
Date: Tue, 28 Jun 2016 17:17:59 +1000
In-Reply-To: <CAMzoambZ9wu3orkFfYemTQiMpf+OWPdk8v6_SXsJapS74HE13A@mail.gmail.com>
References: <CAMzoama3BkAfxqzEt2khiPOcKxkOP1JVSx5UcCwWvGJLGrzLtA@mail.gmail.com>
 <1467086888.32607.9.camel@ellerman.id.au>
 <CAMzoambZ9wu3orkFfYemTQiMpf+OWPdk8v6_SXsJapS74HE13A@mail.gmail.com>
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

On Tue, 2016-06-28 at 08:06 +0100, David Binderman wrote:
> On Tue, Jun 28, 2016 at 5:08 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> > What config / toolchain are you using? I've never seen these.
> 
> A static analyser for C & C++ called cppcheck. Available from sourceforge.
> 
> I think you can also get a similar warning if you tweek the gcc compiler warning
> flags. -Wformat=2 maybe.
 
Ah OK. I've heard of it.

> > > static inline int print_insn_powerpc(unsigned long insn, unsigned long memaddr)
> > > {
> > >     printf("%.8x", insn);
> > >     return 0;
> > > }
> > 
> > Send me a patch to cast insn to unsigned int?
> 
> I don't know the code, but given that insn is unsigned long and so can go
> past 32 bits, using a cast to unsigned int might throw away the
> possibly important upper bits.

powerpc instructions are always 32-bit.

We could change the signature for the function to take u32. Except it's the
fallback implementation for the real version which comes from binutils and we'd
prefer to keep that code the same as the binutils version.

cheers
