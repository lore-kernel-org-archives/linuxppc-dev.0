Content-Type: text/plain;
  charset="iso-8859-1"
From: Arun Dharankar <ADharankar@attbi.com>
Reply-To: ADharankar@attbi.com
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Question about MPC7410/MPC7455 Altivec and performance.
Date: Sun, 16 Feb 2003 12:57:34 -0500
References: <200302132225.05307.ADharankar@ATTBI.Com>
In-Reply-To: <200302132225.05307.ADharankar@ATTBI.Com>
MIME-Version: 1.0
Message-Id: <200302161257.34771.ADharankar@ATTBI.Com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Greetings... this turns out to be a vectorizer issue. If
the "float" arrays (the sample/test C code) are moved out
into global/extern scope, the program functions almost 100%
better than the non-vectorized code (on 745x and 7410).


Best regards,
-Arun.


On Thursday 13 February 2003 10:25 pm, I wrote:
> Greetings!
>
> On a PowerMAC G4 (7455) a test C code as shown towards the
> end of this file was tried: with standard gcc, and other with
> gcc with Altivec enabled (and C code preprocessed with a
> Altivec preprocessor).
>
> The Altivec/vectorized code functions better than non-vectorized
> by about 40%.
>
>
> The same binaries (statically linked) were tried on a MPC7410
> based board. The performance of the vectorized program was
> observed to be 18% slower than the non-vectorized code.
>
>
>
> The board is MPC7410 with 8260 in companion mode (core disabled),
> and the Linux kernel has been Altivec enabled (the program anyway
> will not work if Altivec is disabled in the Linux kernel).
>
>
>
> There is one change I have made to the Linux kernel, which can
> be described as follows. I dont see how it can affect the Altivec,
> but mentioning it here - just in case I am missing something.
>
> The memory controller is MPC8260, and does not recognize TLBIE
> transaction type (0x18) as a special case. The Linux kernel code
> performaing the TLBIEs currently provided the virtual/effective
> address whose TLBE needs invalidation. To work around this, I
> modify address passed to tlbie so that only bits 14 to 19 remain the
> same as the original address, and other bits are zero'd (essentially,
> the address is guaranteed to fall in the physical memory address
> range, and the memory controller responds).
>
> Anyway, this seems to work quite well under different combinations
> of non-Altivec/non-vectorized load conditions.
>
>
> The Linux kernel version is 2.4.20, and GCC is 2.95.2 (with patch
> to support for "-fvec" option, availabel at altivec.org).
>
>
> Any ideas why 7410 performance would degrade as described above?
> Or how this could be debugged?
>
>
> Best regards,
> -Arun.
>
> -------------------------------------------------------------
> int
> main(int ac, char *av[]) {
>
>         float a[99], b[99], x;
>         int i, j, n = atoi(av[1]);
>
>         for ( i=0; i < n; i++ )
>                 for(j=0; j<99; j++)
>                         x += a[j]*b[j];
>
>         return 0;
> }
> --------------------------------------------------------------
>  int  main( int ac, char *av[] )
>  {
>     float a[99], b[99], x;
>     int i, j, n = atoi(av[1]);
>     for ( i=0; i < n; i++  )
>     {
>        if ( (((int )&a[0] | (int )&b[0]) & 15) != 0 )
>        {
>           {
>              {
>                 int j1, j2, j3, j4, j5, j6, j7;
>                 vector float a1v, b1v, x1v, r2v;
>                 vector float x2v = (vector float )(0);
>                 vector float r6v = (vector float )(0);
>                 vector float r1v = (vector float )(0.);
>                 vector float a9v, a10v, b9v, b10v;
>                 vector float r5v = (vector float )(0);
>                 vector float a7v, a8v, b7v, b8v;
>                 vector float r4v = (vector float )(0);
>                 vector float a5v, a6v, b5v, b6v;
>                 vector float r3v = (vector float )(0);
>                 vector float a2v, a3v;
>                 vector unsigned char a4v = vec_lvsl(0, &a[0]);
>                 vector float b2v, b3v;
>                 vector unsigned char b4v = vec_lvsl(0, &b[0]);
>                 static vector unsigned long j1v[3] =  { (
>                 vector unsigned long )(0, 0XFFFFFFFF, 0XFFFFFFFF,
>                 0XFFFFFFFF), (vector unsigned long )(0, 0, 0XFFFFFFFF,
>                 0XFFFFFFFF), (vector unsigned long )(0, 0, 0, 0XFFFFFFFF)
>                 } ;
>                 vector float r7v;
>                 vector signed short k1v = (vector signed short )(0, 0, 0,
>                 0, 0, 0, 1, 0);
>                 vec_mtvscr( k1v );
>                 *((float *)&x2v) = x;
>                 x1v = vec_splat(x2v, 0);
>                 a2v = vec_ld(0, &a[0]);
>                 b2v = vec_ld(0, &b[0]);
>                 for ( j1 = 0; j1 < (99 - 4 * 4) + 1; j1 += 4 * 4 )
>                 {
>                    j3 = j1 * sizeof(int );
>                    j2 = j3 + 4 * sizeof(int );
>                    a3v = vec_ld(j2, &a[0]);
>                    b3v = vec_ld(j2, &b[0]);
>                    a5v = vec_ld(j2 + 16, &a[0]);
>                    b5v = vec_ld(j2 + 16, &b[0]);
>                    a7v = vec_ld(j2 + 32, &a[0]);
>                    b7v = vec_ld(j2 + 32, &b[0]);
>                    a1v = vec_perm(a2v, a3v, a4v);
>                    a2v = vec_ld(j2 + 48, &a[0]);
>                    b1v = vec_perm(b2v, b3v, b4v);
>                    b2v = vec_ld(j2 + 48, &b[0]);
>                    r1v = vec_madd(a1v, b1v, r1v);
>                    a6v = vec_perm(a3v, a5v, a4v);
>                    b6v = vec_perm(b3v, b5v, b4v);
>                    r3v = vec_madd(a6v, b6v, r3v);
>                    a8v = vec_perm(a5v, a7v, a4v);
>                    b8v = vec_perm(b5v, b7v, b4v);
>                    r4v = vec_madd(a8v, b8v, r4v);
>                    a10v = vec_perm(a7v, a2v, a4v);
>                    b10v = vec_perm(b7v, b2v, b4v);
>                    r5v = vec_madd(a10v, b10v, r5v);
>                 }
>                 if ( j1 )
>                 {
>                    r1v = vec_add(r1v, r3v);
>                    r1v = vec_add(r1v, r4v);
>                    r1v = vec_add(r1v, r5v);
>                 }
>                 j3 = j1 * sizeof(int );
>                 j2 = j3 + 4 * sizeof(int );
>                 a3v = vec_ld(j2, &a[0]);
>                 a1v = vec_perm(a2v, a3v, a4v);
>                 b3v = vec_ld(j2, &b[0]);
>                 b1v = vec_perm(b2v, b3v, b4v);
>                 r7v = vec_sel(a1v, r6v, j1v[3-1]);
>                 r1v = vec_madd(r7v, b1v, r1v);
>                 r2v = vec_sld(r1v, r1v, 8);
>                 r1v = vec_add(r1v, r2v);
>                 r2v = vec_sld(r1v, r1v, 4);
>                 r1v = vec_add(r1v, r2v);
>                 r1v = vec_add(r1v, x1v);
>                 vec_ste(r1v, 0, &x);
>              }
>           }
>        }
>        else
>        {
>           {
>              {
>                 int j8, j9, j10, j11, j12, j13, j14;
>                 vector float a11v, b11v, x3v, r9v;
>                 vector float x4v = (vector float )(0);
>                 vector float r13v = (vector float )(0);
>                 vector float r8v = (vector float )(0.);
>                 vector float a14v, b14v;
>                 vector float r12v = (vector float )(0);
>                 vector float a13v, b13v;
>                 vector float r11v = (vector float )(0);
>                 vector float a12v, b12v;
>                 vector float r10v = (vector float )(0);
>                 static vector unsigned long j2v[3] =  { (
>                 vector unsigned long )(0, 0XFFFFFFFF, 0XFFFFFFFF,
>                 0XFFFFFFFF), (vector unsigned long )(0, 0, 0XFFFFFFFF,
>                 0XFFFFFFFF), (vector unsigned long )(0, 0, 0, 0XFFFFFFFF)
>                 } ;
>                 vector float r14v;
>                 vector signed short k2v = (vector signed short )(0, 0, 0,
>                 0, 0, 0, 1, 0);
>                 vec_mtvscr( k2v );
>                 *((float *)&x4v) = x;
>                 x3v = vec_splat(x4v, 0);
>                 for ( j8 = 0; j8 < (99 - 4 * 4) + 1; j8 += 4 * 4 )
>                 {
>                    j10 = j8 * sizeof(int );
>                    j9 = j10;
>                    a11v = vec_ld(j10, &a[0]);
>                    b11v = vec_ld(j10, &b[0]);
>                    a12v = vec_ld(j10 + 16, &a[0]);
>                    b12v = vec_ld(j10 + 16, &b[0]);
>                    a13v = vec_ld(j10 + 32, &a[0]);
>                    b13v = vec_ld(j10 + 32, &b[0]);
>                    a14v = vec_ld(j10 + 48, &a[0]);
>                    b14v = vec_ld(j10 + 48, &b[0]);
>                    r8v = vec_madd(a11v, b11v, r8v);
>                    r10v = vec_madd(a12v, b12v, r10v);
>                    r11v = vec_madd(a13v, b13v, r11v);
>                    r12v = vec_madd(a14v, b14v, r12v);
>                 }
>                 if ( j8 )
>                 {
>                    r8v = vec_add(r8v, r10v);
>                    r8v = vec_add(r8v, r11v);
>                    r8v = vec_add(r8v, r12v);
>                 }
>                 j10 = j8 * sizeof(int );
>                 j9 = j10;
>                 a11v = vec_ld(j10, &a[0]);
>                 b11v = vec_ld(j10, &b[0]);
>                 r14v = vec_sel(a11v, r13v, j2v[3-1]);
>                 r8v = vec_madd(r14v, b11v, r8v);
>                 r9v = vec_sld(r8v, r8v, 8);
>                 r8v = vec_add(r8v, r9v);
>                 r9v = vec_sld(r8v, r8v, 4);
>                 r8v = vec_add(r8v, r9v);
>                 r8v = vec_add(r8v, x3v);
>                 vec_ste(r8v, 0, &x);
>              }
>           }
>        }
>     }
>     return 0;
>  }
>
> --------------------------------------------------------------
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
