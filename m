From: Thomas Graichen <news-innominate.list.linux.ppc.dev@innominate.de>
Reply-To: Thomas Graichen <graichen@innominate.de>
Subject: shifts on 64bit ints
Date: 3 Aug 2000 22:38:06 GMT
Message-ID: <news2mail-8mcs8e$kdj$2@mate.bln.innominate.de>
Reply-To: thomas.graichen@innominate.de
To: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


while trying to debug the sgi xfs code on the ppc i ran across the
following thing which looks a bit like a bug to me - maybe some-
one here can confirm - even better describe or solve this (this
for now the reason - don't know if the last or not - why the sgi
xfs code does not run on the ppc so far)

ok - now the story - let's have a look at the following code:

unsigned int myint;

for (myint = 0; myint < 64; myint++) {
  printf("Mask %d is ",myint);
  printf("0x%8x", (int)((1LL << myint) >> 32));
  printf("%8x - ", (int)(1LL << myint));
  printf("0x%8x", (int)(~(1LL << myint) >> 32));
  printf("%8x\n", (int)(~(1LL << myint)));
}

which should do about the same as shifting a bit through a 64bit
(long long - LL) int and print the result for each step and the
inverse of it - it is a bit more complicated (the 32 shifts) be-
cause there seems to be no %llx support for printk so i had to
work around it this way - i hope it is right that way - so
basically it is the function of

for (myint = 0; myint < 64; myint++) {
  printf("Mask %d is ",myint);
  printf("0x%llx - ", (1LL << myint));
  printf("%llx\n", ~(1LL << myint));
}

ok - if you compile it on i386 and on ppc in userland and in the
kernel you get the following results:

...
Mask 29 is 0x       020000000 - 0xffffffffdfffffff
Mask 30 is 0x       040000000 - 0xffffffffbfffffff
Mask 31 is 0x       080000000 - 0xffffffff7fffffff
Mask 32 is 0x       1       0 - 0xfffffffeffffffff
Mask 33 is 0x       2       0 - 0xfffffffdffffffff
Mask 34 is 0x       4       0 - 0xfffffffbffffffff
...

on i386 and ppc userland and i386 in the kernel - and this is
i think what one would expect to get as the result - but in the
kernel on ppc you get:

...
Mask 29 is 0x       020000000 - 0xffffffffdfffffff
Mask 30 is 0x       040000000 - 0xffffffffbfffffff
Mask 31 is 0x       080000000 - 0xffffffff7fffffff
Mask 32 is 0x       1       0 - 0xfffffffeffffffff
Mask 33 is 0x       0       0 - 0xffffffffffffffff
Mask 34 is 0x       0       0 - 0xffffffffffffffff
...

which is a bit confusing to me and i think it is a bug some-
where - any shift greater than 32 gives trash ... can anyone
confirm this or have an idea or solution to this ?

btw. if you shift 33 times by one instead of 33 at once it
works fine ...

btw. this is on the sgi xfs tree from oss.sgi.com with some
patches to get it working on ppc from

  http://innominate.org/~graichen/projects/xfs-ppc/

so basically 2.4.0-test5 ...

a lot of thanks in advance

t

p.s.: am i right that there is no simple way to print 64bit with
      printk (no %xll etc.) - or do i just not know the trick ?

--
thomas.graichen@innominate.de
Technical Director                                       innominate AG
Clustering & Security                                networking people
tel: +49.30.308806-13 fax: -77               web: http://innominate.de

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
