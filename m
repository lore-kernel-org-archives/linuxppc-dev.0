Date: Fri, 24 Mar 2000 17:18:18 +0200 (EET)
From: Kostas Gewrgiou <gewrgiou@imbc.gr>
To: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
cc: Ani Joshi <ajoshi@shell.unixbox.com>, linuxppc-dev@lists.linuxppc.org,
        bh40@calva.net
Subject: Re: proper regw and regrw16?
In-Reply-To: <v03110700b50123f3f40f@[129.100.29.243]>
Message-ID: <Pine.LNX.4.21.0003241711210.1634-100000@idd-01.imbc.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 24 Mar 2000, Kevin B. Hendricks wrote:

>
> Hi Ani and Ben,
>
> I asked about the "correct" form for regr and regw to the list a while back
> (and it generated a big discussion!) and I put in the "best" suggested form
> but it obviously impacts something.
>
> So exactly what in the generated code is different about these two cases
> that makes such a big difference in performance?  I need to understand why
> the "output constraint" approach has such a bad performance impact?
>
>
> --- r128_reg.h.orig	Thu Mar 23 18:10:17 2000
> +++ r128_reg.h	Thu Mar 23 18:15:43 2000
> @@ -50,9 +50,7 @@
>
>  static inline void regw(volatile unsigned long base_addr, unsigned long
> regindex, unsigned long regdata)
>  {
> - asm volatile ("stwbrx %1,%2,%3; eieio"
> -          : "=m" (*(volatile unsigned *)(base_addr+regindex))
> -          : "r" (regdata), "b" (regindex), "r" (base_addr));
> +	asm volatile ("stwbrx %0,%1,%2; eieio" : : "r"(regdata), "b"
> (regindex), "r"(base_addr) : "memory");
>  }
>
> Could you post the assembler (.S) file that each of these makes?
>

static void R128Blank(ScrnInfoPtr pScrn) {
  R128MMIO_VARS();
  OUTREGP(R128_CRTC_EXT_CNTL, R128_CRTC_DISPLAY_DIS,~R128_CRTC_DISPLAY_DIS);
}

OUTREGP is defined as
#define OUTREGP(addr, val, mask)   \
    do {                           \
        CARD32 tmp = INREG(addr);  \
        tmp &= (mask);             \
        tmp |= (val);              \
        OUTREG(addr, tmp);         \
    } while (0)

before:
00000400 <R128Blank>:
     400:       94 21 ff e0     stwu    r1,-32(r1)
     404:       81 23 00 f8     lwz     r9,248(r3)
     408:       80 09 00 24     lwz     r0,36(r9)
     40c:       39 40 00 54     li      r10,84
     410:       90 01 00 08     stw     r0,8(r1)
     414:       81 61 00 08     lwz     r11,8(r1)
     418:       81 21 00 08     lwz     r9,8(r1)
     41c:       7d 6a 5c 2c     lwbrx   r11,r10,r11
     420:       7c 00 06 ac     eieio
     424:       90 01 00 08     stw     r0,8(r1)
     428:       81 21 00 08     lwz     r9,8(r1)
     42c:       61 6b 04 00     ori     r11,r11,1024
     430:       80 01 00 08     lwz     r0,8(r1)
     434:       7d 6a 05 2c     stwbrx  r11,r10,r0
     438:       7c 00 06 ac     eieio
     43c:       38 21 00 20     addi    r1,r1,32
     440:       4e 80 00 20     blr
after:
000003cc <R128Blank>:
     3cc:       81 23 00 f8     lwz     r9,248(r3)
     3d0:       81 69 00 24     lwz     r11,36(r9)
     3d4:       38 00 00 54     li      r0,84
     3d8:       7c 0b 04 2c     lwbrx   r0,r11,r0
     3dc:       7c 00 06 ac     eieio
     3e0:       60 00 04 00     ori     r0,r0,1024
     3e4:       39 20 00 54     li      r9,84
     3e8:       7c 0b 4f 2c     sthbrx  r0,r11,r9
     3ec:       7c 00 06 ac     eieio
     3f0:       4e 80 00 20     blr


> Thanks,
>
> Kevin
>


 Kostas

PS> This is with the generic macros that we are adding but since they
are the same with what ajoshi posted it doesn't matter


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
