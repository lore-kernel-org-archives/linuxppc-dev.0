Message-ID: <20000524134355.B9100@lx.c-side.com>
Date: Wed, 24 May 2000 13:43:55 -0700
From: Neil Russell <caret@c-side.com>
To: diekema_jon <diekema@bucks.si.com>
Cc: all@cideas.com, linuxppc-embedded@lists.linuxppc.org
Subject: Re: Floating Point problems with Linux on the EST SBC8260
References: <m12uh7W-001SyaC@bucks>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <m12uh7W-001SyaC@bucks>; from diekema_jon on Wed, May 24, 2000 at 03:47:10PM -0400
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, May 24, 2000 at 03:47:10PM -0400, diekema_jon wrote:
>
> Floating Point problems with Linux on the EST SBC8260:
>
>
> Questions:
>
> - What is the state of floating point support with Linux on the
>   MPC8260?
>
> - Does anybody have hard-float applications running on the MPC8260?
>
> - I am looking for a floating point validation test suite written in
>   C.  The test suite should start with the fundamentals and work out
>   from there.
>
>   Does anybody have any leads?  This is what I have found so far:
>
> 1) TestFloat-2a
>
> Package Overview for TestFloat Release 2a
>
> John R. Hauser
> 1998 December 16
>
>
> TestFloat is a program for testing that a floating-point implementation
> conforms to the IEC/IEEE Standard for Binary Floating-Point Arithmetic.
> TestFloat is distributed in the form of C source code.  The TestFloat
> package actually provides two related programs:
>
> -- The `testfloat' program tests a system's floating-point for conformance
>    to the IEC/IEEE Standard.  This program uses the SoftFloat software
>    floating-point implementation as a basis for comparison.
>
> -- The `testsoftfloat' program tests SoftFloat itself for conformance to
>    the IEC/IEEE Standard.  These tests are performed by comparing against a
>    separate, slower software floating-point that is included in the TestFloat
>    package.
>
> 2) UCBTEST
>
>      UCBTEST is a suite of programs for testing certain difficult cases of
> IEEE 754 floating-point arithmetic.  Some of the difficult test cases are
> obtained from number-theoretic algorithms developed by Turing Award winner
> Prof. W. Kahan, Department of Electrical Engineering and Computer Science,
> University of California, Berkeley, as part of ongoing research into test
> methods for computer arithmetic.
>
>
> Either TestFloat or UCBTEST will require some porting effort to run
> on the PPC.  I would like to work smarter rather than harder. I can't
> even get the rights answers from printf, *, or /.
>
>
> Environment:
>
> Platform: EST SBC8260 w/ MPC8260 Rev A.1 running at 166 Mhz
> Ethernet: 10 Mbs (SCC)
> Linux kernel: 2.3.99-pre9
> root filesystem (NFS mounted): MontaVista Hard Hat Linux version 1.1
> Toolset: Denx Software CDK recompiled with gcc configured for
>          --with-cpu=603e and hard-float (i.e. no --nfp)
>
>
> Application:
>
> Note: The executable was statically linked to pull in the hard-float
>       C runtime libraries.
>
> dell 403} cat z.c
> #include "stdio.h"
>
> double x, y, z;
>
> main ()
>
> {
>   x = 1234.33;
>   printf("x %lf (1234.33) 0x%08lX\n", x , x);
>
>   y = 4444.2;
>   printf("y %lf (4444.2)  0x%08lX\n", y , y);
>
>   z = x * y;
>   printf("z = x * y, %lf %lf %lf\n", x , y, z);
>
>   z = x / y;
>   printf("z = x / y, %lf %lf %lf\n", x , y, z);
> }
>
> dell 404} cat z.s
> 	.file	"z.c"
> gcc2_compiled.:
> 	.section	".rodata"
> 	.align 2
> .LC1:
> 	.string	"x %lf (1234.33) 0x%08lX\n"
> 	.align 2
> .LC3:
> 	.string	"y %lf (4444.2)  0x%08lX\n"
> 	.align 2
> .LC4:
> 	.string	"z = x * y, %lf %lf %lf\n"
> 	.align 2
> .LC5:
> 	.string	"z = x / y, %lf %lf %lf\n"
> 	.align 3
> .LC0:
> 	.long 0x40934951
> 	.long 0xeb851eb8
> 	.align 3
> .LC2:
> 	.long 0x40b15c33
> 	.long 0x33333333
> 	.section	".text"
> 	.align 2
> 	.globl main
> 	.type	 main,@function
> main:
> 	stwu 1,-16(1)
> 	mflr 0
> 	stw 31,12(1)
> 	stw 0,20(1)
> 	mr 31,1
> 	lis 9,x@ha
> 	lis 11,.LC0@ha
> 	lfd 0,.LC0@l(11)
> 	stfd 0,x@l(9)
> 	lis 9,x@ha
> 	lis 11,x@ha
> 	lis 10,.LC1@ha
> 	la 3,.LC1@l(10)
> 	lfd 1,x@l(9)
> 	lfd 2,x@l(11)
> 	creqv 6,6,6
> 	bl printf
> 	lis 9,y@ha
> 	lis 11,.LC2@ha
> 	lfd 0,.LC2@l(11)
> 	stfd 0,y@l(9)
> 	lis 9,y@ha
> 	lis 11,y@ha
> 	lis 10,.LC3@ha
> 	la 3,.LC3@l(10)
> 	lfd 1,y@l(9)
> 	lfd 2,y@l(11)
> 	creqv 6,6,6
> 	bl printf
> 	lis 9,z@ha
> 	lis 11,x@ha
> 	lis 10,y@ha
> 	lfd 0,x@l(11)
> 	lfd 13,y@l(10)
> 	fmul 0,0,13
> 	stfd 0,z@l(9)
> 	lis 9,x@ha
> 	lis 11,y@ha
> 	lis 10,z@ha
> 	lis 8,.LC4@ha
> 	la 3,.LC4@l(8)
> 	lfd 1,x@l(9)
> 	lfd 2,y@l(11)
> 	lfd 3,z@l(10)
> 	creqv 6,6,6
> 	bl printf
> 	lis 9,z@ha
> 	lis 11,x@ha
> 	lis 10,y@ha
> 	lfd 0,x@l(11)
> 	lfd 13,y@l(10)
> 	fdiv 0,0,13
> 	stfd 0,z@l(9)
> 	lis 9,x@ha
> 	lis 11,y@ha
> 	lis 10,z@ha
> 	lis 8,.LC5@ha
> 	la 3,.LC5@l(8)
> 	lfd 1,x@l(9)
> 	lfd 2,y@l(11)
> 	lfd 3,z@l(10)
> 	creqv 6,6,6
> 	bl printf
> .L2:
> 	lwz 11,0(1)
> 	lwz 0,4(11)
> 	mtlr 0
> 	lwz 31,-4(11)
> 	mr 1,11
> 	blr
> .Lfe1:
> 	.size	 main,.Lfe1-main
> 	.comm	x,8,8
> 	.comm	y,8,8
> 	.comm	z,8,8
> 	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
>
>
> On the target:
>
> > ./a.out
> x nan (1234.33) 0x00000000
> y 0.000000 (4444.2)  0x1003FBCC
> z = x * y, 0.000000 0.000000 0.000000
> z = x / y, 0.000000 0.000000 0.000000
>
>
> The expected results should look something like:
>
> dell 420} ./a.out
> x 1234.330000 (1234.33) 0xEB851EB8
> y 4444.200000 (4444.2)  0x33333333
> z = x * y, 1234.330000 4444.200000 5485609.386000
> z = x / y, 1234.330000 4444.200000 0.277740
>
> We aren't even close to reasonable answers yet.
>

--
Neil Russell <caret@c-side.com>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
