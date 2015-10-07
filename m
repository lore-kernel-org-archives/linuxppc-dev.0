Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BA2D91A0401
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Oct 2015 17:00:49 +1100 (AEDT)
Message-ID: <1444197649.6794.7.camel@ellerman.id.au>
Subject: Re: Missing operand for tlbie instruction on Power7
From: Michael Ellerman <mpe@ellerman.id.au>
To: Laura Abbott <labbott@redhat.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>
Date: Wed, 07 Oct 2015 17:00:49 +1100
In-Reply-To: <56141237.2040403@redhat.com>
References: <560EA623.1040300@redhat.com>
 <1444102518.16909.3.camel@ellerman.id.au> <56141237.2040403@redhat.com>
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

On Tue, 2015-10-06 at 11:25 -0700, Laura Abbott wrote:
> On 10/05/2015 08:35 PM, Michael Ellerman wrote:
> > On Fri, 2015-10-02 at 08:43 -0700, Laura Abbott wrote:
> >> Hi,
> >>
> >> We received a report (https://bugzilla.redhat.com/show_bug.cgi?id=1267395) of bad assembly
> >> when compiling on powerpc with little endian
> >
> > ...
> >
> >> After some discussion with the binutils folks, it turns out that the tlbie
> >> instruction actually requires another operand and binutils was updated to
> >> check for this https://sourceware.org/ml/binutils/2015-05/msg00133.html .
> >>
> >> The code sequence in arch/powerpc/include/asm/ppc_asm.h now needs to be updated:
> >>
> >> #if !defined(CONFIG_4xx) && !defined(CONFIG_8xx)
> >> #define tlbia                                   \
> >>           li      r4,1024;                        \
> >>           mtctr   r4;                             \
> >>           lis     r4,KERNELBASE@h;                \
> >> 0:      tlbie   r4;                             \
> >>           addi    r4,r4,0x1000;                   \
> >>           bdnz    0b
> >> #endif
> >>
> >> I don't know enough ppc assembly to properly fix this but I can test.
> >
> > How are you testing? This code is fairly old and I'm dubious if it still works.
> >
> > These days we have a ppc_md hook for flushing the TLB, ppc_md.flush_tlb().
> > Ideally the swsusp code would use that.
> 
> Testing would probably just be compile and maybe boot. I don't have regular
> access to the hardware. This problem just showed up for me when someone
> tried to compile Fedora rawhide with the latest binutils.

Right. The code in question is for software suspend, ie. hibernation, so that's
what needs testing if the code is going to change.

It was mostly written for G5 (543b9fd3528f6), though it later gained support
for 64-bit BookE (5a31057fc06c3).

I just tested it on a G5 here and amazingly it worked.

So it is working code, even if it is old and crufty.

>  From what I can tell, it looks like the .flush_tlb of the cpu_spec is only
> defined for power7 and power8 and I don't see a ppc_md.flush_tlb on the
> master branch.

Yes it's only defined for Power7 and Power8 at the moment. It definitely does
exist in Linus' master branch, but I'm not sure if that's the master branch
you're referring to.

> It's not clear what to do for the case where there is no
> flush_tlb function. Would filling in a .flush_tlb for all the PPC_BOOK3S_64
> with the existing tlbia sequence work?

It might, but it's not much of an improvement. Ideally we'd have an actually
correct sequence for each cpu type.

> It's also worth noting that the __flush_power7 uses tlbiel instead of tlbie.

Yeah that's a good point. It's not clear if the swsusp code wants to a local or
a global invalidate.


As an alternative, can you try adding a .machine push / .machine "power4" /
.machine pop, around the tlbie. That should tell the assembler to drop back to
power4 mode for that instruction, which should then do the right thing. There
are some examples in that file.

cheers
