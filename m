Date: Wed, 20 Oct 1999 20:40:25 -0500 (CDT)
From: ian reinhart geiser <geiseri@msoe.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: C++ Question
Message-ID: <Pine.LNX.4.10.9910202034270.9611-100000@sleepchamber.apt5.msoe.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have confirmed that this works under 2.95 under RH 6.1
one ix86 so I am thinking this is a LinuxPPC problem.

I am building the gcc cross compiler for th 68HC11 using
the 2.8.1 source code and a patch supplied by my professor.

i get the following error:

gcc -c -DCROSS_COMPILE -DIN_GCC    -g  -DHAVE_CONFIG_H    -I. -I.
-I./config fol
d-const.c
fold-const.c: In function `exact_real_inverse':
fold-const.c:945: parse error before `if'
fold-const.c: At top level:
fold-const.c:945: parse error before `else'
fold-const.c:945: parse error before `.'
fold-const.c:945: parse error before `.'
fold-const.c:945: parse error before `.'
fold-const.c:959: parse error before `('
fold-const.c:960: `y' undeclared here (not in a function)
fold-const.c:960: warning: data definition has no type or storage class
fold-const.c:961: parse error before `return'
make: *** [fold-const.o] Error 1     

When I looked at the code i found the following:

exact_real_inverse (mode, r)
     enum machine_mode mode;
     REAL_VALUE_TYPE *r;
{
  union
    {
      double d;
      unsigned short i[4];
    }x, t, y;     
----SNIP----
and at 945 the following code...
941:  /* Truncate to the required mode and range-check the result.  */
942:  y.d = REAL_VALUE_TRUNCATE (mode, t.d);
943:#ifdef CHECK_FLOAT_VALUE
944:  i = 0;
945:	  if (CHECK_FLOAT_VALUE (mode, y.d, i))
946:    goto fail;
947:#endif 

why did i get an error on y.d on 945 and not 941?

any ideas?

sorry if i am missing info, i have been beating on this
for a week and it is all getting blurry...

-ian reinhart geiser


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
