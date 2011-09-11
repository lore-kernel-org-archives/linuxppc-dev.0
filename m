Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [195.58.98.146])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 882F3B7233
	for <linuxppc-dev@ozlabs.org>; Sun, 11 Sep 2011 19:32:38 +1000 (EST)
In-Reply-To: <1315646679.455.38.camel@pasglop>
References: <1315570258-12275-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<1315646679.455.38.camel@pasglop>
Subject: Re: [PATCH] powerpc: Optimize __arch_swab32 and __arch_swab16
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <OF325566ED.72C2FC40-ONC1257908.00327CBA-C1257908.00346A94@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Sun, 11 Sep 2011 11:32:31 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote on 2011/09/10 11:24:39:
>
> On Fri, 2011-09-09 at 14:10 +0200, Joakim Tjernlund wrote:
> > PPC __arch_swab32 and __arch_swab16 generates non optimal code.
> > They do not schedule very well, need to copy its input register
> > and swab16 needs an extra insn to clear its upper bits.
> > Fix this with better inline ASM.
> >
> > Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
> > ---
> >  arch/powerpc/include/asm/swab.h |   28 ++++++++++++++--------------
> >  1 files changed, 14 insertions(+), 14 deletions(-)
> >
> > diff --git a/arch/powerpc/include/asm/swab.h b/arch/powerpc/include/asm/swab.h
> > index c581e3e..3b9a200 100644
> > --- a/arch/powerpc/include/asm/swab.h
> > +++ b/arch/powerpc/include/asm/swab.h
> > @@ -61,25 +61,25 @@ static inline void __arch_swab32s(__u32 *addr)
> >
> >  static inline __attribute_const__ __u16 __arch_swab16(__u16 value)
> >  {
> > -   __u16 result;
> > -
> > -   __asm__("rlwimi %0,%1,8,16,23"
> > -       : "=r" (result)
> > -       : "r" (value), "0" (value >> 8));
> > -   return result;
> > +   __asm__("rlwimi %0,%0,16,0x00ff0000\n\t"
> > +      "rlwinm %0,%0,24,0x0000ffff"
> > +      : "+r"(value));
> > +   return value;
> >  }
> >  #define __arch_swab16 __arch_swab16
>
> I don't quite get the thing about needing to clear the high bits.
>
> Value is a u16 to start with, %0 is pre-filled with value >> 8 which
> won't add anything to the upper bits, neither will rlwimi, so why would
> you need to clear upper bits ?
>
> Now I do see why gcc might generate something sub-optimal here, but can
> you provide examples of asm output before/after in the patch commit ?

I did a simple test earlier like so:

unsigned short __arch_swab16(unsigned short value)
{
		 unsigned short result;

		 __asm__("rlwimi %0,%1,8,16,23"
		     : "=r" (result)
		     : "r" (value), "0" (value >> 8));
		 return result;
}

unsigned short my__arch_swab16(unsigned short value)
{
		 __asm__("rlwimi %0,%0,16,0x00ff0000\n\t"
			 "rlwinm %0,%0,24,0x0000ffff"
			 : "+r"(value));
		 return value;
}

gcc -O2 -S outputs:

	.file	"my_swab.c"
	.section	".text"
	.align 2
	.globl __arch_swab16
	.type	__arch_swab16, @function
__arch_swab16:
	mr 0,3
	srwi 3,3,8
#APP
	rlwimi 3,0,8,16,23
#NO_APP
	rlwinm 3,3,0,0xffff
	blr
	.size	__arch_swab16, .-__arch_swab16
	.align 2
	.globl my__arch_swab16
	.type	my__arch_swab16, @function
my__arch_swab16:
#APP
	rlwimi 3,3,16,0x00ff0000
	rlwinm 3,3,24,0x0000ffff
#NO_APP
	blr
	.size	my__arch_swab16, .-my__arch_swab16
	.section	.note.GNU-stack,"",@progbits
	.ident	"GCC: (GNU) 3.4.6 (Gentoo 3.4.6-r2, ssp-3.4.6-1.0, pie-8.7.9)"

However I recently installed gcc 4.5.2 to do some tests and that gives
me this instead:
	.file	"my_swab.c"
	.gnu_attribute 4, 2
	.gnu_attribute 8, 1
	.gnu_attribute 12, 2
	.section	".text"
	.align 2
	.globl __arch_swab16
	.type	__arch_swab16, @function
__arch_swab16:
	srwi 0,3,8
#APP
 # 5 "my_swab.c" 1
	rlwimi 0,3,8,16,23
 # 0 "" 2
#NO_APP
	rlwinm 3,0,0,0xffff
	blr
	.size	__arch_swab16, .-__arch_swab16
	.align 2
	.globl my__arch_swab16
	.type	my__arch_swab16, @function
my__arch_swab16:
#APP
 # 13 "my_swab.c" 1
	rlwimi 3,3,16,0x00ff0000
	rlwinm 3,3,24,0x0000ffff
 # 0 "" 2
#NO_APP
	rlwinm 3,3,0,0xffff
	blr
	.size	my__arch_swab16, .-my__arch_swab16
	.ident	"GCC: (Gentoo 4.5.2 p1.1, pie-0.4.5) 4.5.2"
	.section	.note.GNU-stack,"",@progbits

So now both versions mask off the high bits, strange.
Not sure what is going on here?

 Jocke
