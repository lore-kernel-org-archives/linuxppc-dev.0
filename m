Date: Fri, 24 Mar 2000 19:09:21 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Kostas Gewrgiou <gewrgiou@imbc.gr>
cc: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>,
        Ani Joshi <ajoshi@shell.unixbox.com>, linuxppc-dev@lists.linuxppc.org,
        bh40@calva.net
Subject: Re: proper regw and regrw16?
In-Reply-To: <Pine.LNX.4.21.0003241711210.1634-100000@idd-01.imbc.gr>
Message-ID: <Pine.HPX.4.10.10003241852180.14656-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 24 Mar 2000, Kostas Gewrgiou wrote:

> > --- r128_reg.h.orig	Thu Mar 23 18:10:17 2000
> > +++ r128_reg.h	Thu Mar 23 18:15:43 2000
> > @@ -50,9 +50,7 @@
> >
> >  static inline void regw(volatile unsigned long base_addr, unsigned long
> > regindex, unsigned long regdata)
> >  {
> > - asm volatile ("stwbrx %1,%2,%3; eieio"
> > -          : "=m" (*(volatile unsigned *)(base_addr+regindex))
> > -          : "r" (regdata), "b" (regindex), "r" (base_addr));
> > +	asm volatile ("stwbrx %0,%1,%2; eieio" : : "r"(regdata), "b"
> > (regindex), "r"(base_addr) : "memory");
> >  }
> >
> > Could you post the assembler (.S) file that each of these makes?
> >

Hmmm, I had a look at the regr/regw macros, why do they pass a parameter
as volatile. This unsigned long is not itslef volatile, it is used as a
parameter to compute an address to volatile data and as such the accesses
should not be optimized by the compiler. See what happens if you suppress
volatile from the parameters to regr/regw/regr16/regw16.

I don't understand why the compiler does this exatcly but the volatile in
the baase_addr parameter definitely is not required and won't help the
optimizer.

>
> static void R128Blank(ScrnInfoPtr pScrn) {
>   R128MMIO_VARS();
>   OUTREGP(R128_CRTC_EXT_CNTL, R128_CRTC_DISPLAY_DIS,~R128_CRTC_DISPLAY_DIS);
> }
>
> OUTREGP is defined as
[snipped...]
> before:
[snipped]
>      434:       7d 6a 05 2c     stwbrx  r11,r10,r0
>      438:       7c 00 06 ac     eieio
>      43c:       38 21 00 20     addi    r1,r1,32
>      440:       4e 80 00 20     blr
> after:
> 000003cc <R128Blank>:
>      3cc:       81 23 00 f8     lwz     r9,248(r3)
>      3d0:       81 69 00 24     lwz     r11,36(r9)
>      3d4:       38 00 00 54     li      r0,84
>      3d8:       7c 0b 04 2c     lwbrx   r0,r11,r0
>      3dc:       7c 00 06 ac     eieio
>      3e0:       60 00 04 00     ori     r0,r0,1024
>      3e4:       39 20 00 54     li      r9,84
>      3e8:       7c 0b 4f 2c     sthbrx  r0,r11,r9
				  ^^^^^^
If it's stHbrx and not stWbrx then you'll probably be in trouble later.
and it looks it is sthbrx from the HEX value, otherwise it would be
7c0b4d2c.


	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
