Date: Fri, 24 Mar 2000 21:13:51 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
cc: gcc@gcc.gnu.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: Problem with gcc on ppc? was Re: proper regw and regrw16?
In-Reply-To: <v03110703b5014d1a9f37@[129.100.29.243]>
Message-ID: <Pine.HPX.4.10.10003242108570.14656-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 24 Mar 2000, Kevin B. Hendricks wrote:

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

-static inline void regw(volatile unsigned long base_addr, unsigned long regindex, unsigned long regdata)
+static inline void regw(unsigned long base_addr, unsigned long regindex, unsigned long regdata)
 {
  asm volatile ("stwbrx %1,%2,%3; eieio"
           : "=m" (*(volatile unsigned *)(base_addr+regindex))
           : "r" (regdata), "b" (regindex), "r" (base_addr));
 }

-static inline void regw16(volatile unsigned long base_addr, unsigned long regindex, unsigned short regdata)
+static inline void regw16(unsigned long base_addr, unsigned long regindex, unsigned short regdata)
 {
   asm volatile ("sthbrx %0,%1,%2; eieio": : "r"(regdata), "b"(regindex), "r"(base_addr));
 }

-static inline unsigned long regr(volatile unsigned long base_addr, unsigned long regindex)
+static inline unsigned long regr(unsigned long base_addr, unsigned long regindex)
 {
   register unsigned long val;
   asm volatile ("lwbrx %0,%1,%2; eieio"
@@ -70,7 +70,7 @@
   return(val);
 }

-static inline unsigned short regr16(volatile unsigned long base_addr, unsigned long regindex)
+static inline unsigned short regr16(unsigned long base_addr, unsigned long regindex)
 {
   register unsigned short val;
   asm volatile ("lhbrx %0,%1,%2; eieio": "=r"(val):"b"(regindex), "r"(base_addr));

>
> The generated code difference here are quite striking.  It literally
> allocates a variable on the local stack frame to store the constraint
> calculation for each regr and regw and even takes the time to load r9 twice
> for no apparent reason (once at address 418: and once at address 428:) and
> then has to unwrap the local variable storage too.
>
> What is r9 being used for at 418: and 428: and why didn't the compiler
> optimization figure out how to just move things from register to register?
>
> Is this a compiler optimization "bug"?

Neve use volatile where it is not justified. In this case you declare as
volatile a value which is used to compute the address while what is
volatile is what is pointe at. This does not completely explain the
differences in my eyes however...

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
