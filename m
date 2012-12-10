Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Jimi Xenidis <jimix@pobox.com>
Subject: Re: [RFC] Add IBM Blue Gene/Q Platform
In-reply-to: <FAE4A73A-BDC0-43E3-A416-E8F0F161C5B4@pobox.com>
References: <958841B4-9626-48A2-A28A-13EA3F1D52AE@pobox.com>
 <22874.1354859652@neuling.org>
 <F49F5B26-671F-4D3F-BAC3-67F852E03798@pobox.com>
 <1ECB6402-9BC0-4468-B405-A6F6E971486B@pobox.com>
 <3051.1355100425@neuling.org>
 <FAE4A73A-BDC0-43E3-A416-E8F0F161C5B4@pobox.com>
Date: Mon, 10 Dec 2012 17:06:06 +1100
Message-ID: <12948.1355119566@neuling.org>
Cc: Andrew T Tauferner <ataufer@us.ibm.com>, Kumar Gala <kumar.gala@gmail.com>,
 Jay Bryant <jsbryant@us.ibm.com>, Josh Boyer <jwboyer@linux.vnet.ibm.com>,
 Todd Inglett <tinglett@us.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Jimi Xenidis <jimix@pobox.com> wrote:

> 
> 
> On Dec 9, 2012, at 6:47 PM, Michael Neuling <mikey@neuling.org> wrote:
> 
> > Jimi Xenidis <jimix@pobox.com> wrote:
> > 
> >> 
> >> On Dec 7, 2012, at 7:38 AM, Jimi Xenidis <jimix@pobox.com> wrote:
> >> 
> >>> 
> >>> On Dec 6, 2012, at 11:54 PM, Michael Neuling <mikey@neuling.org> wrote:
> >>> 
> >>>>> commit 279c0615917b959a652e81f4ad0d886e2d426d85
> >>>>> Author: Jimi Xenidis <jimix@pobox.com>
> >>>>> Date:   Wed Dec 5 13:43:22 2012 -0500
> >>>>> 
> >>>>>  powerpc/book3e: IBM Blue Gene/Q Quad Processing eXtention (QPX)
> >>>>> 
> >>>>>  This enables kernel support for the QPX extention and is intended for
> >>>>>  processors that support it, usually an IBM Blue Gene processor.
> >>>>>  Turning it on does not effect other processors but it does add code
> >>>>>  and will quadruple the per thread save and restore area for the FPU
> >>>>>  (hense the name).  If you have enabled VSX it will only double the
> >>>>>  space.
> >>>>> 
> >>>>>  Signed-off-by: Jimi Xenidis <jimix@pobox.com>
> >> 
> >> <<snip>>
> >>>> 
> >>>> 
> >>>> 
> >>>> +BEGIN_FTR_SECTION                            \
> >>>> +    SAVE_32VSRS(n,c,base);                        \
> >>>> +END_FTR_SECTION_IFSET(CPU_FTR_VSX);                    \
> >>>> +BEGIN_FTR_SECTION                            \
> >>>> +    SAVE_32QRS(n,c,base);                        \
> >>>> +END_FTR_SECTION_IFSET(CPU_FTR_QPX);    
> >>>> 
> >>>> I don't think we want to do this.  We are going to end up with 64
> >>>> NOPS here somewhere.
> >>> 
> >>> Excellent point, NOPs are cheap on most processors but not A2 and a lot of embedded, I can wrap some branches with the FTR instead.
> >>> Do you have a concern on the code size?
> >> 
> >> Thought about it a bit and came up with this solution for arch/powerpc/kernel/fpu.S.
> >> This should address the following issues
> >> - MSR_VSX vs MSR_VEC
> >> - Big chunks of NOPs in the code path
> >> - Less FTR space fixups at boot time.
> >> - IMNHSO easier to read especially when disassembled
> > 
> > Indeed, I think it looks better.  I was going to mention that it was
> > already pretty complex to read, so a rewrite like this was probably
> > needed.  So thanks!!
> > 
> > That being said, there is a pretty complex testing matrix of
> > CONFIG_VSX/VMX/FPU/QPX/SMP/64/32 CPU_FTR/VSX/FPU/QPX/VMX so I'd need to
> > look/test more carefully to make sure all of these are covered.
> > 
> > Also, transactional memory (see
> > http://lists.ozlabs.org/pipermail/linuxppc-dev/2012-November/102216.html)
> > will change this code.  You should rebase on top of that if you really
> > want it considered for upstream.
> 
> Is this in a git tree anywhere? perhaps BenH's next branch?

It's not in benh's tree as yet (so could change).

Grab the power8 branch here git://github.com/mikey/linux.git
or checkout https://github.com/mikey/linux/commits/power8.

It's about 20 patches on top of benh's next tree.  Also includes the
power8 doorbell changes from Ian.

Mikey
