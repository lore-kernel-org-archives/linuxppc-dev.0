Date: Tue, 13 Feb 2001 11:20:49 -0600 (CST)
From: Grant Erickson <erick205@umn.edu>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Patch for Soft-Float Problems w/ Glibc & Gcc?
Message-Id: <Pine.SOL.4.20.0102131051470.8375-100000@garnet.tc.umn.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


For some time I've noted but have never bothered chasing down the *printf
problems associated with using -msoft-float/-D_SOFT_FLOAT on Linux/PPC.

Needing to remedy the issue, I started chasing it down using the code
samples below. When compiled using just '$(CROSS_COMPILE)gcc -o pi-test
*.c' everything works fine:

	user@host% ./pi-test
	The value of Pi is approximately: 3.142857

If I turn-around and compile it with '$(CROSS_COMPILE)gcc -o pi-test
-msoft-float *.c' or '$(CROSS_COMPILE)gcc -o pi-test -msoft-float
-D_SOFT_FLOAT *.c' I get:

	user@host% ./pi-test
	The value of Pi is approximately: 0.000000

After disassembling the code, from what I can see both bits of code are
generating the right output for the IEEE single-precision result. Both
bits of code appear to be following the correct register callee/caller
convetions for both 'pi' and 'float_print'. So, I have to assume that the
problem lies somewhere within either the '__extendsfdf2' or 'printf'
subroutine calls within 'float_print':

	Disassembly of section .text:

	00000000 <float_print>:
	   0:   94 21 ff e0     stwu    r1,-32(r1)
	   4:   7c 08 02 a6     mflr    r0
	   8:   93 e1 00 1c     stw     r31,28(r1)
	   c:   90 01 00 24     stw     r0,36(r1)
	  10:   7c 3f 0b 78     mr      r31,r1
	  14:   90 7f 00 08     stw     r3,8(r31)
	  18:   90 9f 00 0c     stw     r4,12(r31)
	  1c:   80 7f 00 0c     lwz     r3,12(r31)
	  20:   48 00 00 01     bl      __extendsfdf2
	  24:   7c 69 1b 78     mr      r9,r3
	  28:   7c 8a 23 78     mr      r10,r4
	  2c:   3d 60 00 00     lis     r11,.rodata@h
	  30:   38 6b 00 00     addi    r3,r11,.rodata@l
	  34:   80 9f 00 08     lwz     r4,8(r31)
	  38:   7d 25 4b 78     mr      r5,r9
	  3c:   7d 46 53 78     mr      r6,r10
	  40:   48 00 00 01     bl      printf
	  44:   7c 60 1b 78     mr      r0,r3
	  48:   7c 03 03 78     mr      r3,r0
	  4c:   48 00 00 04     b       50 <float_print+0x50>
	  50:   81 61 00 00     lwz     r11,0(r1)
	  54:   80 0b 00 04     lwz     r0,4(r11)
	  58:   7c 08 03 a6     mtlr    r0
	  5c:   83 eb ff fc     lwz     r31,-4(r11)
	  60:   7d 61 5b 78     mr      r1,r11
	  64:   4e 80 00 20     blr

I've heard and have read in back messages that this problem lies in either
the varags implementation or in the stdio-common (i.e. printf) bits of
glibc. Does anyone have a patch which addresses this specific problem?

This problem happens on both a Solaris/SPARC to Linux/PPC cross compiler
as well as on a native Linux/PPC compiler. The former is
gcc-2.95.3-20010112 (prerelease) with glibc-2.1.3 and the latter is
gcc-2.95.2-19991024 (release/franzo) with 'glibc-2.1.3 from
'glibc-2.1.3-4a'.

For the cross-compiler, the compiler and libraries were configured w/

	GCC:

	./configure --host=sparc-sun-solaris2.7 --target=powerpc-linux
	--prefix=$TOOLROOT/host/sparc-sun-solaris
	--with-headers=$TOOLROOT/target/powerpc-linux-gnu/include
	--with-libs=$TOOLROOT/target/powerpc-linux-gnu/lib
	--enable-shared --enable-languages=c,c++
	--with-cpu=403 --without-fp

	GLIBC:

	./configure --host=powerpc-linux --with-headers=/usr/src/linux/include
	--enable-shared --enable-add-ons=crypt,linuxthreads
	--prefix=$TOOLROOT/target/powerpc-linux-gnu --without-fp

The test code:

main.c:

int main (void)
{
        float value;
        int status;

        value = pi();
        status = float_print("The value of Pi is approximately", value);

        return (status);
}

pi.c:

float
pi(void)
{
        return (22.0/7.0);
}

float_print.c:

int float_print(const char *string, float value)
{
        return (printf("%s: %f\n", string, value));
}


--
 Grant Erickson                       University of Minnesota Alumni
  o mail:erick205@umn.edu                                 1996 BSEE
  o http://www.umn.edu/~erick205                          1998 MSEE

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
