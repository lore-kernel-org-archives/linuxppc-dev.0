Return-Path: <ebony.zhu@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 42BC0DDE3A
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Jan 2007 19:41:15 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l0F8fDYC006399
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Jan 2007 01:41:13 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l0F8fAwj027731
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Jan 2007 02:41:11 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="GB2312"
Subject: RE: [patch][0/5] powerpc: Add support to fully comply with IEEE-754
	standard
Date: Mon, 15 Jan 2007 16:41:09 +0800
Message-ID: <32F3CC26D4DAC44E8ECD07155727A46E816C03@zch01exm20.fsl.freescale.net>
In-Reply-To: <00d809d44c8e8286fd4bf9de16ee6b10@kernel.crashing.org>
From: "Zhu Ebony-r57400" <ebony.zhu@freescale.com>
To: "Segher Boessenkool" <segher@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=20

> -----Original Message-----
> From: Segher Boessenkool [mailto:segher@kernel.crashing.org]=20
> Sent: 2007=C4=EA1=D4=C212=C8=D5 20:06
> To: Zhu Ebony-r57400
> Cc: Kumar Gala; Paul Mackerras; linuxppc-dev@ozlabs.org
> Subject: Re: [patch][0/5] powerpc: Add support to fully=20
> comply with IEEE-754 standard
>=20
> > I wrote some cases for testing. For SPFP and DPFP exception=20
> testing,=20
> > the test cases included plus, minus, multiply, divide, comparisons,=20
> > conversions, DBZ... for Nan/Denorm/Inf numbers. I also tested the=20
> > cases that the operation result would generate=20
> > Nan/Denorm/Inf/overflow/underflow numbers. For Vector SPFP=20
> exception=20
> > testing, I wrote inline asm based testing program to test the=20
> > instructions directly.
>=20
> Any chance you could submit that testing code too?  Would be=20
> useful for others :-)
>=20
>=20
> Segher
>=20
>=20

The below snipped code just tests limited instructions. On actural =
developing
process all instructrions were tested, FYI.

--------------------------Snip-------------------------------------------=
----------
/* compile with freescale gcc for MPC8548 powerpc platform
/opt/mtwk/usr/local/gcc-3_4-e500-glibc-2.3.4-dp/powerpc-linux-gnuspe/bin/=

powerpc-linux-gnuspe-gcc -mcpu=3D8548 -mhard-float -ffloat-store=20
-fno-strict-aliasing  -o Mult Mult.c -lm
*/
                                                                         =
                                                                         =
          =20
#include <stdio.h>
#include <math.h>
                                                                         =
                                                                         =
          =20
int main() {

float j =3D0.0;
float k =3D0.0;
float result, result0, result1, result2, result3;
                                                                         =
                                                                         =
          =20
printf ("Invalid operation (denorm) 1:\n");
k =3D 2.1E-44;
j =3D 1.5666666;

result0 =3D k * j;
result1 =3D k + j;
result2 =3D k - j ;
result3 =3D k / j ;

printf("after %g * %g  result is %g  \n",k,j,result0 );
printf("after %g + %g  result is %g  \n",k,j,result1 );
printf("after %g - %g  result is %g  \n",k,j,result2 );
printf("after %g / %g  result is %g  \n",k,j,result3 );

if (k>j) {=09
printf("The bigger one is %g\n",k);
}
if (k<j) {
printf("The smaller one is %g\n",k);
}=20
if (k =3D=3D j) {
printf("equal\n");
}
}
--------------------------Snip-------------------------------------------=
----------


To test VSPFT instructions, inline asm based C code is used like:


--------------------------Snip-------------------------------------------=
----------
#include <stdlib.h>
#include <asm/reg.h>


static void write_reg(volatile unsigned *addr, float val);
static float read_reg(volatile unsigned *addr);


static void
write_reg(volatile unsigned *addr, float val)
{
	__asm__ __volatile__("stwx %1,0,%2; eieio" : "=3Dm" (*addr) :
			     "r" (val), "r" (addr));
}

static void
write_reg_dbl(volatile unsigned *addr, double val)
{
	__asm__ __volatile__("evstddx %1,0,%2; eieio" : "=3Dm" (*addr) :
			     "r" (val), "r" (addr));
}

static float
read_reg(volatile unsigned *addr)
{
	float ret;
	__asm__ __volatile__("lwzx %0,0,%1; eieio" : "=3Dr" (ret) :
			     "r" (addr), "m" (*addr));
	return ret;
}

static int
read_reg_int(volatile unsigned *addr)
{
	unsigned int ret;
	__asm__ __volatile__("lwzx %0,0,%1; eieio" : "=3Dr" (ret) :
			     "r" (addr), "m" (*addr));
	return ret;
}

inline void
evfsadd(volatile unsigned *addr)
{
	unsigned int rA;
	unsigned int rB;
__asm__ __volatile__ ("evlddx %1, 0, %2\n"
		      "evlddx %4, 0, %3\n"
		      "evfsadd %1, %1, %4\n"
		      "evstdwx %1, 0, %5\n"
		      : "=3Dm" (*addr)
		      : "r" (rA), "r" (addr), "r" (addr+2), "r" (rB), "r" (addr+4)
		      );
}

inline void
evfssub(volatile unsigned *addr)
{
	unsigned int rA;
	unsigned int rB;
__asm__ __volatile__ ("evlddx %1, 0, %2\n"
		      "evlddx %4, 0, %3\n"
		      "evfssub %1, %1, %4\n"
		      "evstdwx %1, 0, %5\n"
		      : "=3Dm" (*addr)
		      : "r" (rA), "r" (addr), "r" (addr+2), "r" (rB), "r" (addr+4)
		      );
}

inline void
evfsmul(volatile unsigned *addr)
{
	unsigned int rA;
	unsigned int rB;
__asm__ __volatile__ ("evlddx %1, 0, %2\n"
		      "evlddx %4, 0, %3\n"
		      "evfsmul %1, %1, %4\n"
		      "evstdwx %1, 0, %5\n"
		      : "=3Dm" (*addr)
		      : "r" (rA), "r" (addr), "r" (addr+2), "r" (rB), "r" (addr+4)
		      );
}

inline void
evfsdiv(volatile unsigned *addr)
{
	unsigned int rA;
	unsigned int rB;
__asm__ __volatile__ ("evlddx %1, 0, %2\n"
		      "evlddx %4, 0, %3\n"
		      "evfsdiv %1, %1, %4\n"
		      "evstdwx %1, 0, %5\n"
		      : "=3Dm" (*addr)
		      : "r" (rA), "r" (addr), "r" (addr+2), "r" (rB), "r" (addr+4)
		      );
}

inline int
evfscmpeq(volatile unsigned *addr)
{
	unsigned int rA;
	unsigned int rB;
	unsigned int val;
__asm__ __volatile__ ("evlddx %1, 0, %2\n"
		      "evlddx %4, 0, %3\n"
		      "evfscmpeq %0, %1, %4\n"
		      "mfcr %0\n"
		      : "=3Dr" (val)
		      : "r" (rA), "r" (addr), "r" (addr+2), "r" (rB));
	return (val);
}

inline int
evfscmpgt(volatile unsigned *addr)
{
	unsigned int rA;
	unsigned int rB;
	unsigned int val;
__asm__ __volatile__ ("evlddx %1, 0, %2\n"
		      "evlddx %4, 0, %3\n"
		      "evfscmpgt %0, %1, %4\n"
		      "mfcr %0\n"
		      : "=3Dr" (val)
		      : "r" (rA), "r" (addr), "r" (addr+2), "r" (rB));
	return (val);
}

inline int
evfscmplt(volatile unsigned *addr)
{
	unsigned int rA;
	unsigned int rB;
	unsigned int val;
__asm__ __volatile__ ("evlddx %1, 0, %2\n"
		      "evlddx %4, 0, %3\n"
		      "evfscmplt %0, %1, %4\n"
		      "mfcr %0\n"
		      : "=3Dr" (val)
		      : "r" (rA), "r" (addr), "r" (addr+2), "r" (rB));
	return (val);
}

inline void
evfsabs(volatile unsigned *addr)
{
	unsigned int rD;
__asm__ __volatile__ ("evlddx %1, 0, %2\n"
		      "evfsabs %1, %1\n"
		      "evstdwx %1, 0, %3\n"
		      : "=3Dm" (*addr)
		      : "r" (rD), "r" (addr), "r" (addr+4)
		      );
}

inline void
evfsnabs(volatile unsigned *addr)
{
	unsigned int rD;
__asm__ __volatile__ ("evlddx %1, 0, %2\n"
		      "evfsnabs %1, %1\n"
		      "evstdwx %1, 0, %3\n"
		      : "=3Dm" (*addr)
		      : "r" (rD), "r" (addr), "r" (addr+4)
		      );
}

inline void
evfsneg(volatile unsigned *addr)
{
	unsigned int rD;
__asm__ __volatile__ ("evlddx %1, 0, %2\n"
		      "evfsneg %1, %1\n"
		      "evstdwx %1, 0, %3\n"
		      : "=3Dm" (*addr)
		      : "r" (rD), "r" (addr), "r" (addr+4)
		      );
}

inline void
evfsctui(volatile unsigned *addr)
{
	unsigned int rD;
__asm__ __volatile__ ("evlddx %1, 0, %2\n"
		      "evfsctui %1, %1\n"
		      "evstdwx %1, 0, %3\n"
		      : "=3Dm" (*addr)
		      : "r" (rD), "r" (addr), "r" (addr+4)
		      );
}

inline void
evfsctsi(volatile unsigned *addr)
{
	unsigned int rD;
__asm__ __volatile__ ("evlddx %1, 0, %2\n"
		      "evfsctsi %1, %1\n"
		      "evstdwx %1, 0, %3\n"
		      : "=3Dm" (*addr)
		      : "r" (rD), "r" (addr), "r" (addr+4)
		      );
}

inline void
evfsctsiz(volatile unsigned *addr)
{
	unsigned int rD;
__asm__ __volatile__ ("evlddx %1, 0, %2\n"
		      "evfsctsiz %1, %1\n"
		      "evstdwx %1, 0, %3\n"
		      : "=3Dm" (*addr)
		      : "r" (rD), "r" (addr), "r" (addr+4)
		      );
}

inline void
evfsctuiz(volatile unsigned *addr)
{
	unsigned int rD;
__asm__ __volatile__ ("evlddx %1, 0, %2\n"
		      "evfsctuiz %1, %1\n"
		      "evstdwx %1, 0, %3\n"
		      : "=3Dm" (*addr)
		      : "r" (rD), "r" (addr), "r" (addr+4)
		      );
}

inline void
evfsctuf(volatile unsigned *addr)
{
	unsigned int rD;
__asm__ __volatile__ ("evlddx %1, 0, %2\n"
		      "evfsctuf %1, %1\n"
		      "evstdwx %1, 0, %3\n"
		      : "=3Dm" (*addr)
		      : "r" (rD), "r" (addr), "r" (addr+4)
		      );
}

inline void
evfsctsf(volatile unsigned *addr)
{
	unsigned int rD;
__asm__ __volatile__ ("evlddx %1, 0, %2\n"
		      "evfsctsf %1, %1\n"
		      "evstdwx %1, 0, %3\n"
		      : "=3Dm" (*addr)
		      : "r" (rD), "r" (addr), "r" (addr+4)
		      );
}

inline void
efsctsf(volatile unsigned *addr)
{
	unsigned int rD;
__asm__ __volatile__ ("lwzx %1, 0, %2\n"
		      "efsctsf %1, %1\n"
		      "stwx %1, 0, %3\n"
		      : "=3Dm" (*addr)
		      : "r" (rD), "r" (addr), "r" (addr+4)
		      );
}

inline void
efsctuf(volatile unsigned *addr)
{
	unsigned int rD;
__asm__ __volatile__ ("lwzx %1, 0, %2\n"
		      "efsctuf %1, %1\n"
		      "stwx %1, 0, %3\n"
		      : "=3Dm" (*addr)
		      : "r" (rD), "r" (addr), "r" (addr+4)
		      );
}

inline void
efdctuf(volatile unsigned *addr)
{
	unsigned int rD;
__asm__ __volatile__ ("evlddx %1, 0, %2\n"
		      "efdctuf %1, %1\n"
		      "evstdwx %1, 0, %3\n"
		      : "=3Dm" (*addr)
		      : "r" (rD), "r" (addr), "r" (addr+4)
		      );
}

inline void
efdctsf(volatile unsigned *addr)
{
	unsigned int rD;
__asm__ __volatile__ ("evlddx %1, 0, %2\n"
		      "efdctsf %1, %1\n"
		      "evstdwx %1, 0, %3\n"
		      : "=3Dm" (*addr)
		      : "r" (rD), "r" (addr), "r" (addr+4)
		      );
}
inline void
write_reg_vec (unsigned int *addr, float rA0, float rA1, float rB0, =
float rB1)
{
	write_reg (addr, rA0);
	write_reg (addr+1, rA1);
	write_reg (addr+2, rB0);
	write_reg (addr+3, rB1);
}

int main()
{
	unsigned *store_addr;
	float a0 =3D 2.1e-44;=20
	float a1 =3D -5.738e-42;
	float b0 =3D 1.5666666;
	float b1 =3D 1.0001221;
	float d0, d1;
	double b =3D 0.9999999996507541e+320;
	unsigned int d0_uint, d1_uint;
	unsigned int crD;
	double result;

	printf ("a0, a1 =3D %g, %g\n", a0, a1);
	printf ("b0, b1 =3D %g, %g\n", b0, b1);
	printf ("b =3D %g\n", b);
=09
	store_addr =3D malloc (sizeof(float)*6);
	write_reg_vec (store_addr, a0, a1, b0, b1);=20

	evfsadd(store_addr);
	d0 =3D read_reg (store_addr+4);
	d1 =3D read_reg (store_addr+5);
	printf ("evfsadd: d0 =3D %g, d1 =3D %g\n", d0, d1);

	evfssub(store_addr);
	d0 =3D read_reg (store_addr+4);
	d1 =3D read_reg (store_addr+5);
	printf ("evfssub: d0 =3D %g, d1 =3D %g\n", d0, d1);
=09
	evfsmul(store_addr);
	d0 =3D read_reg (store_addr+4);
	d1 =3D read_reg (store_addr+5);
	printf ("evfsmul: d0 =3D %g, d1 =3D %g\n", d0, d1);
=09
	evfsdiv(store_addr);
	d0 =3D read_reg (store_addr+4);
	d1 =3D read_reg (store_addr+5);
	printf ("evfsdiv: d0 =3D %g, d1 =3D %g\n", d0, d1);
=09
	evfsabs(store_addr);
	d0 =3D read_reg (store_addr+4);
	d1 =3D read_reg (store_addr+5);
	printf ("evfsabs: d0 =3D %g, d1 =3D %g\n", d0, d1);
=09
	evfsnabs(store_addr);
	d0 =3D read_reg (store_addr+4);
	d1 =3D read_reg (store_addr+5);
	printf ("evfsnabs: d0 =3D %g, d1 =3D %g\n", d0, d1);

	evfsneg(store_addr);
	d0 =3D read_reg (store_addr+4);
	d1 =3D read_reg (store_addr+5);
	printf ("evfsneg: d0 =3D %g, d1 =3D %g\n", d0, d1);
=09
	crD =3D evfscmpeq(store_addr);
	printf ("efscmpeq: crD =3D %08x\n", crD);
=09
	crD =3D evfscmpgt(store_addr);
	printf ("efscmpgt: crD =3D %08x\n", crD);

	crD =3D evfscmplt(store_addr);
	printf ("efscmplt: crD =3D %08x\n", crD);
=09
	evfsctui(store_addr);
	d0_uint =3D read_reg_int (store_addr+4);
	d1_uint =3D read_reg_int (store_addr+5);
	printf ("evfsctui: d0 =3D %u, d1 =3D %u\n", d0_uint, d1_uint);
=09
	evfsctuiz(store_addr);
	d0_uint =3D read_reg_int (store_addr+4);
	d1_uint =3D read_reg_int (store_addr+5);
	printf ("evfsctuiz: d0 =3D %u, d1 =3D %u\n", d0_uint, d1_uint);

	evfsctsi(store_addr);
	d0_uint =3D read_reg_int (store_addr+4);
	d1_uint =3D read_reg_int (store_addr+5);
	printf ("evfsctsi: d0 =3D %d, d1 =3D %d\n", d0_uint, d1_uint);

	evfsctsiz(store_addr);
	d0_uint =3D read_reg_int (store_addr+4);
	d1_uint =3D read_reg_int (store_addr+5);
	printf ("evfsctsiz: d0 =3D %d, d1 =3D %d\n", d0_uint, d1_uint);

	evfsctuf(store_addr);
	d0_uint =3D read_reg_int (store_addr+4);
	d1_uint =3D read_reg_int (store_addr+5);
	printf ("evfsctuf: d0 =3D %08x, d1 =3D %08x\n", d0_uint, d1_uint);
=09
=09
	evfsctsf(store_addr);
	d0_uint =3D read_reg_int (store_addr+4);
	d1_uint =3D read_reg_int (store_addr+5);
	printf ("evfsctsf: d0 =3D %08x, d1 =3D %08x\n", d0_uint, d1_uint);

	efsctsf(store_addr);
	d0_uint =3D read_reg_int (store_addr+4);
	printf ("efsctsf: d0 =3D %08x\n", d0_uint);
=09
	efsctuf(store_addr);
	d0_uint =3D read_reg_int (store_addr+4);
	printf ("efsctuf: d0 =3D %08x\n", d0_uint);

	write_reg_dbl (store_addr, b);=20
=09
	efdctuf(store_addr);
	d0_uint =3D read_reg_int (store_addr+4);
	d1_uint =3D read_reg_int (store_addr+5);
	printf ("efdctuf: d0 =3D %08x, d1 =3D %08x\n", d0_uint, d1_uint);
=09
	efdctsf(store_addr);
	d0_uint =3D read_reg_int (store_addr+4);
	d1_uint =3D read_reg_int (store_addr+5);
	printf ("efdctsf: d0 =3D %08x, d1 =3D %08x\n", d0_uint, d1_uint);
=09
}
--------------------------Snip-------------------------------------------=
----------


Ebony
