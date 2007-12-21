Return-Path: <rrnelson@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 61DCBDDD04
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Dec 2007 04:18:58 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id lBLHIt8O024517
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Dec 2007 12:18:55 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lBLHIo4k103208
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Dec 2007 10:18:51 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lBLHIoap024392
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Dec 2007 10:18:50 -0700
Received: from bnelson60.rchland.ibm.com (bnelson60.rchland.ibm.com
	[9.10.87.208])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	lBLHIn55024322
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Dec 2007 10:18:50 -0700
From: Bob Nelson <rrnelson@linux.vnet.ibm.com>
To: linuxppc <linuxppc-dev@ozlabs.org>
Subject: OProfile callgraph support not working correctly on PPC processors
Date: Fri, 21 Dec 2007 11:15:32 -0600
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200712211115.33238.rrnelson@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


I have been investigating why I have not been able to get callgraph code fo=
r=20
OProfile on Cell to work correctly and I am pretty sure that I have run int=
o=20
a problem that is common across all the Power platforms.  (At least the oth=
er=20
ones I have looked at.)  I have a simple test program that is attached=20
below. =A0It has a main, that calls function1, which calls function2. =A0Ea=
ch of=20
the functions has some type of loop in it so that I can catch it spending=20
some CPU time with OProfile. =A0I have also attached the objdump -d output =
for=20
the program cut down to the three pertinent functions that shows what is=20
happening. =A0In a nutshell when a terminal function (calls no other functi=
on)=20
is called the compiler is making an optimization that seems to break the AB=
I=20
convention as far as I can tell. =A0It does not store the Link Register on =
the=20
stack like any other function.  It just leaves the return address in LR,=20
knowing that nothing should change it. =A0(You can see at the top of both m=
ain=20
and function1 the first thing it does is "mflr =A0r0" to copy the link regi=
ster=20
to R0 to be saved. It does not do that in function2.) =A0 When OProfile tak=
es=20
an interrupt and needs to gather the callgraph information it does so by=20
grabbing the process' stack pointer (R1) and follows the chain back up the=
=20
stack to gather all the caller's addresses. =A0This works for most function=
s,=20
except for terminal functions for the reason noted above.

Looking at the assembly listing I drew myself a diagram of the stack while=
=20
function2 is active to convince myself of what was wrong and here is what I=
=20
see it as... =A0When the interrupt is handled OProfile grabs a copy of R1, =
it=20
ignores the first frame on the stack because there should be no address=20
stored. =A0In the second frame it expects to find function2's caller but si=
nce=20
function2 doesn't store it, it grabs some random data and proceeds. The sta=
ck=20
chain is all ok so it doesn't go off into neverland trying to follow a bad=
=20
chain, but it grabs an invalid address for the caller. =A0And that is why=20
OProfile thinks terminal functions have no callers on PPC...

Any suggestions on how this can be fixed? =A0I am guessing that changing th=
e=20
compiler and recompiling every program is probably not the answer.  I assum=
e=20
the link register has to be saved in the interrupt routine when it runs, or=
=20
else it couldn't call anything else without crashing the program that was=20
interrupted.  Is there a safe place to find it?

Thanks, Bob Nelson


top of stack =A0 ------------------------------
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0 =A0 . =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0|
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0 =A0 . =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0| <------------------------------
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0 =A0 . =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0|                               |
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|----------------------------| =A0 =A0 =A0 =
=A0 =A0                     |
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0R0 (link register) =A0 =A0 =A0| =A0=
=2D-> main's caller =A0 =A0        |
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|----------------------------| =A0 =A0 =A0 =
=A0 =A0                     |
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0flags (unused) =A0 =A0 =A0 =A0 =A0|=
 =A0 =A0 =A0 =A0 =A0 =A0                   |
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|----------------------------|=A0 =A0 =A0 =
=A0 =A0                      |
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0R1 (previous frame)     |>---------=
=2D---------------------
R1 main =A0 =A0 -> |----------------------------| 0 (Offset from R1   <----=
=2D-----
=A0 =A0(entry) =A0 =A0=A0| =A0 =A0R31 save =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0  at entry to main)  =A0       |
=A0 =A0 =A0 =A0 =A0 =A0 =A0  |----------------------------| -8 =A0 =A0 =A0=
=A0 =A0 =A0 =A0 =A0 =A0 =A0         |
=A0 =A0 =A0 =A0 =A0 =A0 =A0  | =A0 =A0 =A0 . =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0| =A0 =A0 =A0 =A0 =A0             =A0       |
=A0 =A0 =A0 =A0 =A0 =A0 =A0  | =A0 =A0 =A0 . =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0|=A0 =A0 =A0 =A0 =A0              =A0       |=20
=A0 =A0 =A0 =A0 =A0 =A0 =A0  | =A0 =A0 =A0 . =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0| =A0 =A0 =A0 =A0 =A0                    =A0|
=A0 =A0 =A0 =A0 =A0 =A0 =A0  |----------------------------| =A0 =A0 =A0 =A0=
 =A0        =A0            |
=A0 =A0 =A0 =A0 =A0 =A0 =A0  | =A0 =A0R0 (link register) =A0 =A0 =A0| =A0--=
>function1's caller (main) |
=A0 =A0 =A0 =A0 =A0 =A0 =A0  |----------------------------| =A0 =A0       =
=A0                   |
=A0 =A0 =A0 =A0 =A0 =A0 =A0  | =A0 =A0flags (not stored)=A0 =A0 =A0 |=A0 =
=A0 =A0 =A0 =A0 =A0                    |
=A0 =A0 =A0 =A0 =A0 =A0 =A0  |----------------------------| =A0 =A0 =A0 =A0=
=A0              =A0       |
=A0 =A0 =A0 =A0 =A0 =A0 =A0  | =A0 =A0R1 (previous frame)     |>-----------=
=2D-------------------
R1 function1-->|----------------------------| -144 <-----------------------=
=2D-
=A0 =A0(entry) =A0 =A0 | =A0 =A0R31 save =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0 =A0 =A0 =A0 =A0             =A0       |
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|----------------------------|=A0 =A0 =A0 =
=A0 =A0 =A0                    |
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0 =A0 . =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0| =A0 =A0 =A0 =A0 =A0 =A0                   |
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0 =A0 . =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0| =A0 =A0 =A0 =A0 =A0 =A0                   |
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0 =A0 . =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0| =A0 =A0 =A0 =A0 =A0 =A0                   |
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|----------------------------| =A0 =A0 =A0 =
=A0        =A0 =A0            |
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0nothing stored =A0 =A0 =A0 =A0 =A0|=
 (should be function2's caller |
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|----------------------------| =A0function1)=
   =A0 =A0 =A0 =A0 =A0       |
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0flags (not stored) =A0 =A0 =A0| =A0=
 =A0 =A0 =A0 =A0             =A0       |
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|----------------------------| =A0 =A0 =A0 =
=A0 =A0 =A0                   |
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0R1 (previous frame)     |>---------=
=2D---------------------
R1 function2-->|----------------------------| -288 <-----------------------=
=2D-
=A0 =A0(entry) =A0 =A0 | =A0 =A0R31 save =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0 =A0 =A0             =A0 =A0 =A0       |
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|----------------------------| =A0 =A0 =A0 =
=A0 =A0 =A0                   |
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0 =A0 . =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0| =A0 =A0 =A0 =A0 =A0 =A0                   |
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0 =A0 . =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0| =A0 =A0 =A0 =A0 =A0 =A0                   |
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0 =A0 . =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0| =A0 =A0 =A0 =A0 =A0 =A0                   |
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|----------------------------| =A0 =A0 =A0 =
=A0 =A0 =A0                   |
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0nothing stored =A0 =A0 =A0 =A0 =A0|=
 =A0would be used if function2  =A0|
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|----------------------------| =A0called any=
thing              |
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0flags (not stored) =A0 =A0 =A0| =A0=
 =A0 =A0 =A0 =A0 =A0                   |
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|----------------------------| =A0 =A0 =A0 =
=A0 =A0 =A0                   |
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0R1 (previous frame)     |>---------=
=2D---------------------
R1 function2-->|----------------------------| -368=A0 =A0(running)
               | =A0 =A0 =A0 . =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|
=A0 =A0 =A0 =A0 =A0 =A0 =A0  | =A0 =A0 =A0 . =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0|
=A0 =A0 =A0 =A0 =A0 =A0 =A0  | =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0|


/* loop.c - nonsense code for testing OProfile */
#include <stdio.h>

int function2( int count )
{
  int i, j, k;

  for ( i=3D0; i<count; i++ )
  {
    k =3D k + j * i;
  }

  return k;
}

int function1( int count )
{
  int i, j;

  i =3D function2( count );
  for ( j=3D0; j<1000; j++ ) i++;
  return i;
}

int main( int argc, char *argv[] )
{
  int   count, i, j, k;

  if ( argc > 0 )
    count =3D atoi( argv[1] );
  else
    count =3D 10000;

  for ( i=3D0; i<count; i++ )
  {
     j =3D function1( 10000 );
     for( j=3D0; j<10000; j++ ) k =3D k + j;
  }

  return 0;
}


loop.64:     file format elf64-powerpc

=2E.. deleted ...

00000000100005b0 <.function2>:
    100005b0:	fb e1 ff f8 	std     r31,-8(r1)
    100005b4:	f8 21 ff b1 	stdu    r1,-80(r1)
    100005b8:	7c 3f 0b 78 	mr      r31,r1
    100005bc:	7c 60 1b 78 	mr      r0,r3
    100005c0:	90 1f 00 80 	stw     r0,128(r31)
    100005c4:	38 00 00 00 	li      r0,0
    100005c8:	90 1f 00 38 	stw     r0,56(r31)
    100005cc:	48 00 00 2c 	b       100005f8 <.function2+0x48>
    100005d0:	81 3f 00 34 	lwz     r9,52(r31)
    100005d4:	80 1f 00 38 	lwz     r0,56(r31)
    100005d8:	7c 09 01 d6 	mullw   r0,r9,r0
    100005dc:	7c 09 07 b4 	extsw   r9,r0
    100005e0:	80 1f 00 30 	lwz     r0,48(r31)
    100005e4:	7c 00 4a 14 	add     r0,r0,r9
    100005e8:	90 1f 00 30 	stw     r0,48(r31)
    100005ec:	81 3f 00 38 	lwz     r9,56(r31)
    100005f0:	38 09 00 01 	addi    r0,r9,1
    100005f4:	90 1f 00 38 	stw     r0,56(r31)
    100005f8:	80 1f 00 38 	lwz     r0,56(r31)
    100005fc:	81 3f 00 80 	lwz     r9,128(r31)
    10000600:	7f 80 48 00 	cmpw    cr7,r0,r9
    10000604:	41 9c ff cc 	blt+    cr7,100005d0 <.function2+0x20>
    10000608:	80 1f 00 30 	lwz     r0,48(r31)
    1000060c:	7c 00 07 b4 	extsw   r0,r0
    10000610:	7c 03 03 78 	mr      r3,r0
    10000614:	e8 21 00 00 	ld      r1,0(r1)
    10000618:	eb e1 ff f8 	ld      r31,-8(r1)
    1000061c:	4e 80 00 20 	blr
	...
    10000628:	80 01 00 01 	lwz     r0,1(r1)

000000001000062c <.function1>:
    1000062c:	7c 08 02 a6 	mflr    r0
    10000630:	fb e1 ff f8 	std     r31,-8(r1)
    10000634:	f8 01 00 10 	std     r0,16(r1)
    10000638:	f8 21 ff 71 	stdu    r1,-144(r1)
    1000063c:	7c 3f 0b 78 	mr      r31,r1
    10000640:	7c 60 1b 78 	mr      r0,r3
    10000644:	90 1f 00 c0 	stw     r0,192(r31)
    10000648:	80 1f 00 c0 	lwz     r0,192(r31)
    1000064c:	7c 00 07 b4 	extsw   r0,r0
    10000650:	7c 03 03 78 	mr      r3,r0
    10000654:	4b ff ff 5d 	bl      100005b0 <.function2>
    10000658:	7c 60 1b 78 	mr      r0,r3
    1000065c:	90 1f 00 74 	stw     r0,116(r31)
    10000660:	38 00 00 00 	li      r0,0
    10000664:	90 1f 00 70 	stw     r0,112(r31)
    10000668:	48 00 00 1c 	b       10000684 <.function1+0x58>
    1000066c:	81 3f 00 74 	lwz     r9,116(r31)
    10000670:	38 09 00 01 	addi    r0,r9,1
    10000674:	90 1f 00 74 	stw     r0,116(r31)
    10000678:	81 3f 00 70 	lwz     r9,112(r31)
    1000067c:	38 09 00 01 	addi    r0,r9,1
    10000680:	90 1f 00 70 	stw     r0,112(r31)
    10000684:	80 1f 00 70 	lwz     r0,112(r31)
    10000688:	2f 80 03 e7 	cmpwi   cr7,r0,999
    1000068c:	40 9d ff e0 	ble+    cr7,1000066c <.function1+0x40>
    10000690:	80 1f 00 74 	lwz     r0,116(r31)
    10000694:	7c 00 07 b4 	extsw   r0,r0
    10000698:	7c 03 03 78 	mr      r3,r0
    1000069c:	e8 21 00 00 	ld      r1,0(r1)
    100006a0:	e8 01 00 10 	ld      r0,16(r1)
    100006a4:	7c 08 03 a6 	mtlr    r0
    100006a8:	eb e1 ff f8 	ld      r31,-8(r1)
    100006ac:	4e 80 00 20 	blr
    100006b0:	00 00 00 00 	.long 0x0
    100006b4:	00 00 00 01 	.long 0x1
    100006b8:	80 01 00 01 	lwz     r0,1(r1)

00000000100006bc <.main>:
    100006bc:	7c 08 02 a6 	mflr    r0
    100006c0:	fb e1 ff f8 	std     r31,-8(r1)
    100006c4:	f8 01 00 10 	std     r0,16(r1)
    100006c8:	f8 21 ff 71 	stdu    r1,-144(r1)
    100006cc:	7c 3f 0b 78 	mr      r31,r1
    100006d0:	7c 60 1b 78 	mr      r0,r3
    100006d4:	f8 9f 00 c8 	std     r4,200(r31)
    100006d8:	90 1f 00 c0 	stw     r0,192(r31)
    100006dc:	80 1f 00 c0 	lwz     r0,192(r31)
    100006e0:	2f 80 00 00 	cmpwi   cr7,r0,0
    100006e4:	40 9d 00 28 	ble-    cr7,1000070c <.main+0x50>
    100006e8:	e9 3f 00 c8 	ld      r9,200(r31)
    100006ec:	39 29 00 08 	addi    r9,r9,8
    100006f0:	e8 09 00 00 	ld      r0,0(r9)
    100006f4:	7c 03 03 78 	mr      r3,r0
    100006f8:	4b ff fc f9 	bl      100003f0 <._init+0x38>
    100006fc:	e8 41 00 28 	ld      r2,40(r1)
    10000700:	7c 60 1b 78 	mr      r0,r3
    10000704:	90 1f 00 7c 	stw     r0,124(r31)
    10000708:	48 00 00 0c 	b       10000714 <.main+0x58>
    1000070c:	38 00 27 10 	li      r0,10000
    10000710:	90 1f 00 7c 	stw     r0,124(r31)
    10000714:	38 00 00 00 	li      r0,0
    10000718:	90 1f 00 78 	stw     r0,120(r31)
    1000071c:	48 00 00 54 	b       10000770 <.main+0xb4>
    10000720:	38 60 27 10 	li      r3,10000
    10000724:	4b ff ff 09 	bl      1000062c <.function1>
    10000728:	7c 60 1b 78 	mr      r0,r3
    1000072c:	90 1f 00 74 	stw     r0,116(r31)
    10000730:	38 00 00 00 	li      r0,0
    10000734:	90 1f 00 74 	stw     r0,116(r31)
    10000738:	48 00 00 20 	b       10000758 <.main+0x9c>
    1000073c:	81 3f 00 70 	lwz     r9,112(r31)
    10000740:	80 1f 00 74 	lwz     r0,116(r31)
    10000744:	7c 09 02 14 	add     r0,r9,r0
    10000748:	90 1f 00 70 	stw     r0,112(r31)
    1000074c:	81 3f 00 74 	lwz     r9,116(r31)
    10000750:	38 09 00 01 	addi    r0,r9,1
    10000754:	90 1f 00 74 	stw     r0,116(r31)
    10000758:	80 1f 00 74 	lwz     r0,116(r31)
    1000075c:	2f 80 27 0f 	cmpwi   cr7,r0,9999
    10000760:	40 9d ff dc 	ble+    cr7,1000073c <.main+0x80>
    10000764:	81 3f 00 78 	lwz     r9,120(r31)
    10000768:	38 09 00 01 	addi    r0,r9,1
    1000076c:	90 1f 00 78 	stw     r0,120(r31)
    10000770:	80 1f 00 78 	lwz     r0,120(r31)
    10000774:	81 3f 00 7c 	lwz     r9,124(r31)
    10000778:	7f 80 48 00 	cmpw    cr7,r0,r9
    1000077c:	41 9c ff a4 	blt+    cr7,10000720 <.main+0x64>
    10000780:	38 00 00 00 	li      r0,0
    10000784:	7c 03 03 78 	mr      r3,r0
    10000788:	e8 21 00 00 	ld      r1,0(r1)
    1000078c:	e8 01 00 10 	ld      r0,16(r1)
    10000790:	7c 08 03 a6 	mtlr    r0
    10000794:	eb e1 ff f8 	ld      r31,-8(r1)
    10000798:	4e 80 00 20 	blr
    1000079c:	00 00 00 00 	.long 0x0
    100007a0:	00 00 00 01 	.long 0x1
    100007a4:	80 01 00 01 	lwz     r0,1(r1)
    100007a8:	60 00 00 00 	nop
    100007ac:	60 00 00 00 	nop

=2E.. deleted ...
