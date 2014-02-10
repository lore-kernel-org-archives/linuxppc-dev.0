Return-Path: <paubert@iram.es>
Received: from rudy.puc.rediris.es (rudy.puc.rediris.es
 [IPv6:2001:720:418:ca01::132])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7462D2C00AD
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Feb 2014 22:03:58 +1100 (EST)
Date: Mon, 10 Feb 2014 12:03:42 +0100
From: Gabriel Paubert <paubert@iram.es>
To: James Yang <James.Yang@freescale.com>
Subject: Re: arch/powerpc/math-emu/mtfsf.c - incorrect mask?
Message-ID: <20140210110342.GA15806@visitor2.iram.es>
References: <OF784BA598.ACFE9DA4-ONCA257C76.00827472-CA257C77.000BCFAD@csc.com>
 <20140206082635.GA7048@visitor2.iram.es>
 <OFA4C1AF9F.B23E83EC-ONCA257C78.00044235-CA257C78.00080D50@csc.com>
 <20140207101036.GA823@visitor2.iram.es>
 <alpine.LRH.2.00.1402071348380.10318@ra8135-ec1.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LRH.2.00.1402071348380.10318@ra8135-ec1.am.freescale.net>
Cc: Chris Proctor <cproctor@csc.com.au>,
 Stephen N Chivers <schivers@csc.com.au>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Feb 07, 2014 at 02:49:40PM -0600, James Yang wrote:
> On Fri, 7 Feb 2014, Gabriel Paubert wrote:
> 
> > 	Hi Stephen,
> > 
> > On Fri, Feb 07, 2014 at 11:27:57AM +1000, Stephen N Chivers wrote:
> > > Gabriel Paubert <paubert@iram.es> wrote on 02/06/2014 07:26:37 PM:
> > > 
> > > > From: Gabriel Paubert <paubert@iram.es>
> > > > To: Stephen N Chivers <schivers@csc.com.au>
> > > > Cc: linuxppc-dev@lists.ozlabs.org, Chris Proctor <cproctor@csc.com.au>
> > > > Date: 02/06/2014 07:26 PM
> > > > Subject: Re: arch/powerpc/math-emu/mtfsf.c - incorrect mask?
> > > > 
> > > > On Thu, Feb 06, 2014 at 12:09:00PM +1000, Stephen N Chivers wrote:
> 
> > > > > 
> > > > >                 mask = 0;
> > > > >                 if (FM & (1 << 0))
> > > > >                         mask |= 0x0000000f;
> > > > >                 if (FM & (1 << 1))
> > > > >                         mask |= 0x000000f0;
> > > > >                 if (FM & (1 << 2))
> > > > >                         mask |= 0x00000f00;
> > > > >                 if (FM & (1 << 3))
> > > > >                         mask |= 0x0000f000;
> > > > >                 if (FM & (1 << 4))
> > > > >                         mask |= 0x000f0000;
> > > > >                 if (FM & (1 << 5))
> > > > >                         mask |= 0x00f00000;
> > > > >                 if (FM & (1 << 6))
> > > > >                         mask |= 0x0f000000;
> > > > >                 if (FM & (1 << 7))
> > > > >                         mask |= 0x90000000;
> > > > > 
> > > > > With the above mask computation I get consistent results for 
> > > > > both the MPC8548 and MPC7410 boards.
> > > > > 
> > > > > Am I missing something subtle?
> > > > 
> > > > No I think you are correct. This said, this code may probably be 
> > > optimized 
> > > > to eliminate a lot of the conditional branches. I think that:
> 
> 
> If the compiler is enabled to generate isel instructions, it would not 
> use a conditional branch for this code. (ignore the andi's values, 
> this is an old compile)
> 
> c0037c2c <mtfsf>:
> c0037c2c:       2c 03 00 00     cmpwi   r3,0
> c0037c30:       41 82 01 1c     beq-    c0037d4c <mtfsf+0x120>
> c0037c34:       2f 83 00 ff     cmpwi   cr7,r3,255
> c0037c38:       41 9e 01 28     beq-    cr7,c0037d60 <mtfsf+0x134>
> c0037c3c:       70 66 00 01     andi.   r6,r3,1
> c0037c40:       3d 00 90 00     lis     r8,-28672
> c0037c44:       7d 20 40 9e     iseleq  r9,r0,r8
> c0037c48:       70 6a 00 02     andi.   r10,r3,2
> c0037c4c:       65 28 0f 00     oris    r8,r9,3840
> c0037c50:       7d 29 40 9e     iseleq  r9,r9,r8
> c0037c54:       70 66 00 04     andi.   r6,r3,4
> c0037c58:       65 28 00 f0     oris    r8,r9,240
> c0037c5c:       7d 29 40 9e     iseleq  r9,r9,r8
> c0037c60:       70 6a 00 08     andi.   r10,r3,8
> c0037c64:       65 28 00 0f     oris    r8,r9,15
> c0037c68:       7d 29 40 9e     iseleq  r9,r9,r8
> c0037c6c:       70 66 00 10     andi.   r6,r3,16
> c0037c70:       61 28 f0 00     ori     r8,r9,61440
> c0037c74:       7d 29 40 9e     iseleq  r9,r9,r8
> c0037c78:       70 6a 00 20     andi.   r10,r3,32
> c0037c7c:       61 28 0f 00     ori     r8,r9,3840
> c0037c80:       54 6a cf fe     rlwinm  r10,r3,25,31,31
> c0037c84:       7d 29 40 9e     iseleq  r9,r9,r8
> c0037c88:       2f 8a 00 00     cmpwi   cr7,r10,0
> c0037c8c:       70 66 00 40     andi.   r6,r3,64
> c0037c90:       61 28 00 f0     ori     r8,r9,240
> c0037c94:       7d 29 40 9e     iseleq  r9,r9,r8
> c0037c98:       41 9e 00 08     beq-    cr7,c0037ca0 <mtfsf+0x74>
> c0037c9c:       61 29 00 0f     ori     r9,r9,15
> 	...
>  
> However, your other solutions are better.
> 
> 
> > > > 
> > > > mask = (FM & 1);
> > > > mask |= (FM << 3) & 0x10;
> > > > mask |= (FM << 6) & 0x100;
> > > > mask |= (FM << 9) & 0x1000;
> > > > mask |= (FM << 12) & 0x10000;
> > > > mask |= (FM << 15) & 0x100000;
> > > > mask |= (FM << 18) & 0x1000000;
> > > > mask |= (FM << 21) & 0x10000000;
> > > > mask *= 15;
> > > > 
> > > > should do the job, in less code space and without a single branch.
> > > > 
> > > > Each one of the "mask |=" lines should be translated into an
> > > > rlwinm instruction followed by an "or". Actually it should be possible
> > > > to transform each of these lines into a single "rlwimi" instruction
> > > > but I don't know how to coerce gcc to reach this level of optimization.
> > > > 
> > > > Another way of optomizing this could be:
> > > > 
> > > > mask = (FM & 0x0f) | ((FM << 12) & 0x000f0000);
> > > > mask = (mask & 0x00030003) | ((mask << 6) & 0x03030303);
> > > > mask = (mask & 0x01010101) | ((mask << 3) & 0x10101010);
> > > > mask *= 15;
> > > > 
> 
> 
> > Ok, I finally edited my sources and test compiled the suggestions
> > I gave. I'd say that method2 is the best overall indeed. You can
> > actually save one more instruction by setting mask to all ones in 
> > the case FM=0xff, but that's about all in this area.
> 
> 
> My measurements show method1 to be smaller and faster than method2 due 
> to the number of instructions needed to generate the constant masks in 
> method2, but it may depend upon your compiler and hardware.  Both are 
> faster than the original with isel.

Ok, if you have measured that method1 is faster than method2, let us go for it.
I believe method2 would be faster if you had a large out-of-order execution
window, because more parallelism can be extracted from it, but this is probably
only true for high end cores, which do not need FPU emulation in the first place.

The other place where we can optimize is the generation of FEX. Here is 
my current patch:


diff --git a/arch/powerpc/math-emu/mtfsf.c b/arch/powerpc/math-emu/mtfsf.c
index dbce92e..b57b3fa8 100644
--- a/arch/powerpc/math-emu/mtfsf.c
+++ b/arch/powerpc/math-emu/mtfsf.c
@@ -11,48 +11,35 @@ mtfsf(unsigned int FM, u32 *frB)
 	u32 mask;
 	u32 fpscr;
 
-	if (FM == 0)
+	if (likely(FM == 0xff))
+		mask = 0xffffffff;
+	else if (unlikely(FM == 0))
 		return 0;
-
-	if (FM == 0xff)
-		mask = 0x9fffffff;
 	else {
-		mask = 0;
-		if (FM & (1 << 0))
-			mask |= 0x90000000;
-		if (FM & (1 << 1))
-			mask |= 0x0f000000;
-		if (FM & (1 << 2))
-			mask |= 0x00f00000;
-		if (FM & (1 << 3))
-			mask |= 0x000f0000;
-		if (FM & (1 << 4))
-			mask |= 0x0000f000;
-		if (FM & (1 << 5))
-			mask |= 0x00000f00;
-		if (FM & (1 << 6))
-			mask |= 0x000000f0;
-		if (FM & (1 << 7))
-			mask |= 0x0000000f;
+		mask = (FM & 1);
+		mask |= (FM << 3) & 0x10;
+		mask |= (FM << 6) & 0x100;
+		mask |= (FM << 9) & 0x1000;
+		mask |= (FM << 12) & 0x10000;
+		mask |= (FM << 15) & 0x100000;
+		mask |= (FM << 18) & 0x1000000;
+		mask |= (FM << 21) & 0x10000000;
+		mask *= 15;
 	}
 
-	__FPU_FPSCR &= ~(mask);
-	__FPU_FPSCR |= (frB[1] & mask);
+	fpscr = ((__FPU_FPSCR & ~mask) | (frB[1] & mask)) &
+		~(FPSCR_VX | FPSCR_FEX);
 
-	__FPU_FPSCR &= ~(FPSCR_VX);
-	if (__FPU_FPSCR & (FPSCR_VXSNAN | FPSCR_VXISI | FPSCR_VXIDI |
+	if (fpscr & (FPSCR_VXSNAN | FPSCR_VXISI | FPSCR_VXIDI |
 		     FPSCR_VXZDZ | FPSCR_VXIMZ | FPSCR_VXVC |
 		     FPSCR_VXSOFT | FPSCR_VXSQRT | FPSCR_VXCVI))
-		__FPU_FPSCR |= FPSCR_VX;
-
-	fpscr = __FPU_FPSCR;
-	fpscr &= ~(FPSCR_FEX);
-	if (((fpscr & FPSCR_VX) && (fpscr & FPSCR_VE)) ||
-	    ((fpscr & FPSCR_OX) && (fpscr & FPSCR_OE)) ||
-	    ((fpscr & FPSCR_UX) && (fpscr & FPSCR_UE)) ||
-	    ((fpscr & FPSCR_ZX) && (fpscr & FPSCR_ZE)) ||
-	    ((fpscr & FPSCR_XX) && (fpscr & FPSCR_XE)))
-		fpscr |= FPSCR_FEX;
+		fpscr |= FPSCR_VX;
+
+	/* The bit order of exception enables and exception status
+	 * is the same. Simply shift and mask to check for enabled
+	 * exceptions.
+	 */
+	if (fpscr & (fpscr >> 22) &  0xf8) fpscr |= FPSCR_FEX;
 	__FPU_FPSCR = fpscr;
 
 #ifdef DEBUG
 mtfsf.c |   57 ++++++++++++++++++++++-----------------------------------
 1 file changed, 22 insertions(+), 35 deletions(-)


Notes: 

1) I'm really unsure on whether 0xff is frequent or not. So the likely()
statement at the beginning may be wrong. Actually, if it is not very likely,
it might be better to remove the special casef for FM==0xff. A look at 
GCC sources shows that it never generates a mask of 0xff. From glibc
sources, there vast majority of cases uses 0x1, only isnan() uses 0xff.

2) it may be better to remove the check for FM==0, after all, the instruction
efectively becomes a nop, and generating the instruction in the first place
would be too stupid for words.

3) if might be better to #define the magic constants (22 and 0xf8) used 
in the last if statement.

	Gabriel
> 
