Message-Id: <v03110706b505609771ce@[129.100.29.243]>
In-Reply-To: <Pine.LNX.4.10.10003270958530.10064-100000@shell.unixbox.com>
References: <20000328024133B.roikawa@rr.iij4u.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Mon, 27 Mar 2000 14:06:35 -0500
To: Ani Joshi <ajoshi@shell.unixbox.com>,
        Ryuichi Oikawa <roikawa@rr.iij4u.or.jp>
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Subject: Re: Some issues to resolve with XFree 4.0 yet
Cc: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Ani and Ryuichi,

>are you using the patch I posted last week?  If not, then I suggest you
>do.  I fixed the improper load/stores in r128 and it shows a 200% increase
>in almost all x11perf tests.

Actually, you might want to try Gabriel Paubert's patch which simply
removes the "volatile" from the base_addr parameter.  The incirrectly
specified volatile on the parameter (which really makes no sense if you
think about it ;-)) is what was causing all the problems with inefficiency.

Interestingly, with this patch you can actually save one extra instruction
over Ani's patch but either one is a big big improvement.

Kevin


----snip-here-for Gabriel_Paubert's_e-mail_with_patch----

> Hi,
>
> >From comparing the performance of the XFree 4.0 r128 drivers across x86 and
> ppc we noticed that the ppc version was much slower.  The following patch
> made a huge change in x11perf results (improivement).  This is on a ppc
> with glibc 2.1.3 and the latest gcc 2.95.2 from Franz Sirl.
>
> Did I write the output constraint version incorrectly?  Is this what you
> expected the generated code to look like?

I have just made a test with suppressing the volatile in the parameter to
the regr/regw/regr16/regw16 macros and the code is even better (one
instruction less than with the memory clobber):

000003d4 <R128Blank>:
     3d4:       81 43 00 f8     lwz     r10,248(r3)
     3d8:       81 6a 00 24     lwz     r11,36(r10)
     3dc:       39 20 00 54     li      r9,84
     3e0:       7c 09 5c 2c     lwbrx   r0,r9,r11
     3e4:       7c 00 06 ac     eieio
     3e8:       60 00 04 00     ori     r0,r0,1024
     3ec:       7c 09 5d 2c     stwbrx  r0,r9,r11
     3f0:       7c 00 06 ac     eieio
     3f4:       4e 80 00 20     blr

the diff is:
--- r128_reg.h~	Sat Feb 26 06:38:43 2000
+++ r128_reg.h	Fri Mar 24 23:47:31 2000
@@ -48,19 +48,19 @@

 #if defined(__powerpc__)

-static inline void regw(volatile unsigned long base_addr, unsigned long
regindex, unsigned long regdata)
+static inline void regw(unsigned long base_addr, unsigned long regindex,
unsigned long regdata)
 {
  asm volatile ("stwbrx %1,%2,%3; eieio"
           : "=m" (*(volatile unsigned *)(base_addr+regindex))
           : "r" (regdata), "b" (regindex), "r" (base_addr));
 }

-static inline void regw16(volatile unsigned long base_addr, unsigned long
regindex, unsigned short regdata)
+static inline void regw16(unsigned long base_addr, unsigned long regindex,
unsigned short regdata)
 {
   asm volatile ("sthbrx %0,%1,%2; eieio": : "r"(regdata), "b"(regindex),
"r"(base_addr));
 }

-static inline unsigned long regr(volatile unsigned long base_addr,
unsigned long regindex)
+static inline unsigned long regr(unsigned long base_addr, unsigned long
regindex)
 {
   register unsigned long val;
   asm volatile ("lwbrx %0,%1,%2; eieio"
@@ -70,7 +70,7 @@
   return(val);
 }

-static inline unsigned short regr16(volatile unsigned long base_addr,
unsigned long regindex)
+static inline unsigned short regr16(unsigned long base_addr, unsigned long
regindex)
 {
   register unsigned short val;
   asm volatile ("lhbrx %0,%1,%2; eieio": "=r"(val):"b"(regindex),
"r"(base_addr));


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
