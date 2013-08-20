Return-Path: <anton@samba.org>
Date: Tue, 20 Aug 2013 12:37:50 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, Alan Modra
 <amodra@gmail.com>, wschmidt@us.ibm.com
Subject: BUG_ON and gcc don't mix
Message-ID: <20130820123750.7353f2f1@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi,

I noticed our BUG_ON macros were taking a large number of instructions.
I've built a testcase to analyse it:


#if defined(ASMBUG)

#define BUG_ON(x) do {	\
	__asm__ __volatile__("tdnei %0,0\n" : : "r" ((long)(x))); \
} while (0)

#elif defined(BUILTIN)

#define BUG_ON(x) do { \
	if (x) \
		__builtin_trap(); \
} while (0)

#else

#define BUG_ON(x) do { \
	if (x) { \
		__asm__ __volatile__("twi 31,0,0\n"); \
		__builtin_unreachable(); \
	} \
} while (0)

#endif

int foo(unsigned int *bar)
{
	unsigned int holder_cpu;

	holder_cpu = *bar & 0xffff;
	BUG_ON(holder_cpu >= 32);

	return 1;
}


3 versions. First our current upstream behaviour (-DASMBUG):

   0:	00 00 23 a1 	lhz     r9,0(r3)
   4:	1f 00 89 2b 	cmplwi  cr7,r9,31
   8:	26 00 20 7d 	mfcr    r9
   c:	fe f7 29 55 	rlwinm  r9,r9,30,31,31
  10:	00 00 09 0b 	tdnei   r9,0
  14:	01 00 60 38 	li      r3,1
  18:	20 00 80 4e 	blr

What a load of work. We do the compare, then pull it out of the
condition register and do some more work. We are trying to help gcc
but it seems to be backfiring. Let's try doing a simple version in c:

   0:	00 00 23 a1 	lhz     r9,0(r3)
   4:	1f 00 89 2b 	cmplwi  cr7,r9,31
   8:	0c 00 9d 41 	bgt     cr7,14
   c:	01 00 60 38 	li      r3,1
  10:	20 00 80 4e 	blr
  14:	00 00 e0 0f 	twui    r0,0

Better, we branch out of line to do the trap. But if we could do a
conditional trap properly then we should be able to do even better
(-DBUILTIN):

   0:	00 00 23 a1 	lhz     r9,0(r3)
   4:	01 00 60 38 	li      r3,1
   8:	20 00 a9 0c 	twlgei  r9,32
   c:	20 00 80 4e 	blr

Nice! I remember chasing this down before and the issue is we need the
address of the trap instruction for our bug exception table. Maybe
we need a gcc builtin in which we can get a label on the trap
instruction. Would that be possible?

Anton
