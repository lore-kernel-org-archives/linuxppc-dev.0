Message-ID: <382B39C8.EF61D039@kerbango.com>
Date: Thu, 11 Nov 1999 13:48:56 -0800
From: Jim Reekes <reekes@kerbango.com>
Reply-To: reekes@kerbango.com
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
CC: nick@kerbango.com
Subject: does soft-float work?
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I've copied a few lines of code that work as I would expect, expect with
I add the -soft-float option or -mcpu=823. I'm building with a YellowDog
release on a G3 PowerMac, where I removed EGCS and installed GCC
2.95.1-1e. I also have glibc 2.1.1-6h. But, I've also built this with a
clean install of YellowDog on a different PowerMac which included
egcs-2.91.66. There I get incorrect but different results. I've also put
the executable onto our 823 board, and it also gives different yet
incorrect results.

So I'm stumped. Does this float emulation package work? Here's what I do
know.

* printf with a float always fails.

* gdb shows that "i" and "f" are always correct.

* the assignment of "d" from "i" is correct

* the result of pow() returns 9.1981921218154364e-232

* here's the console output

float number (should be 4.000000): -0.000000
int cast of float (should be 4): 4
float number (should be 16.000000): 0.000000
int cast of double (should be 16): 0



  gcc -g -lm -msoft-float mathtest.c

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#include <stdio.h>
#include <math.h>

main(int ac, char **av)
{
  float   f;
  double  d;
  int     i;

  i = 2;
	
  f = (float)i;
  f *= f;
  printf("float number (should be 4.000000): %f\n", f);
  printf("int cast of float (should be 4): %d\n", (int)f);

  d = (double)i;
  d = pow(d, f);
  printf("float number (should be 16.000000): %f\n", d);
  printf("int cast of double (should be 16): %d\n", (int)d);
}

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
