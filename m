Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wx98K4n0MzDr1p
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Jun 2017 23:37:05 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Al Viro <viro@ZenIV.linux.org.uk>,
 Segher Boessenkool <segher@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 Thorsten Leemhuis <regressions@leemhuis.info>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>, Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: gcc 4.6.3 miscompile on ppc32 (was Re: Regression in kernel
 4.12-rc1 for Powerpc 32 - bisected to commit 3448890c32c3)
In-Reply-To: <20170625222106.GX10672@ZenIV.linux.org.uk>
References: <20170622141203.GP10672@ZenIV.linux.org.uk>
 <7bbd4c87-e8ff-5f83-8c4c-e205872083bf@lwfinger.net>
 <20170622192515.GQ10672@ZenIV.linux.org.uk>
 <2346c306-8e26-94cb-3c63-b866a7f4625d@lwfinger.net>
 <20170623202943.GS10672@ZenIV.linux.org.uk>
 <3e093314-5148-2e14-33a9-e5d67bd2e7cf@lwfinger.net>
 <20170625095351.GU10672@ZenIV.linux.org.uk>
 <20170625111404.GV10672@ZenIV.linux.org.uk>
 <20170625205324.GW10672@ZenIV.linux.org.uk>
 <20170625214408.GT16550@gate.crashing.org>
 <20170625222106.GX10672@ZenIV.linux.org.uk>
Date: Mon, 26 Jun 2017 23:37:04 +1000
Message-ID: <87zicudg5b.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Al Viro <viro@ZenIV.linux.org.uk> writes:

> On Sun, Jun 25, 2017 at 04:44:09PM -0500, Segher Boessenkool wrote:
>
>> Do you have a short stand-alone testcase?  4.6 is ancient, of course, but
>> the actual problem may still exist in more recent compilers (if it _is_
>> a compiler problem; if it's not, you *really* want to know :-) )
>
> Enjoy.  At least 6.3 doesn't step into that.  Look for mtctr in the resulting
> asm...
>
> cat <<'EOF' >a.c
...

I pointed creduce at that and got the version below, which I'm pretty
sure still exhibits the weird mtctr behaviour.

cheers

# cat input.c
struct {
  void *iov_base;
  unsigned iov_len;
} * c;
long v;
void *a;
int b;
unsigned bar();
foo(unsigned p1) {
  unsigned d, e = p1;
  if (p1 == 0)
    goto out;
  if (p1 > 4)
    goto out;
  if (__builtin_expect(!!(0, v && a), 1))
    e = bar();
  if (e)
    barf(e);
  if (e)
    goto out;
  d = 0;
  for (; d < p1; d++) {
    int f = c[d].iov_len;
    if (__builtin_expect(c[d].iov_base && f, 0))
      b = 4;
  }
out:;
}

$ cat output.s 
	.file	"input.c"

 # rs6000/powerpc options: -mcpu=powerpc -msdata=data -G 8
 # GNU C (GCC) version 4.6.3 (powerpc64-linux)
 #	compiled by GNU C version 4.3.2, GMP version 4.3.2, MPFR version 2.4.2, MPC version 0.8.2
 # ...

 # Compiler executable checksum: 4b51a6b899110d06c9e3310ac66ad26c

	.section	".text"
	.align 2
	.globl foo
	.type	foo, @function
foo:
	cmpwi 0,3,0	 # tmp169, p1
	stwu 1,-16(1)	 #,,
	mflr 0	 #,
	stw 0,20(1)	 #,
	beq- 0,.L9	 #
	cmplwi 7,3,4	 #, tmp170, p1
	bgt- 7,.L9	 #
	lis 9,v@ha	 # tmp172,
	lwz 0,v@l(9)	 # v, v
	cmpwi 7,0,0	 #, tmp174, v
	beq- 7,.L3	 #
	lis 9,a@ha	 # tmp176,
	lwz 0,a@l(9)	 # a, a
	cmpwi 7,0,0	 #, tmp178, a
	beq- 7,.L3	 #
	bl bar	 #
	cmpwi 0,3,0	 # tmp179, e
	beq+ 0,.L4	 #
.L3:
	bl barf	 #
	b .L9	 #
.L4:
	lis 8,0x2000	 #,
	lis 9,c@ha	 # tmp181,
	mtctr 8	 # tmp192,
	lwz 11,c@l(9)	 # c, c.3
	lis 10,b@ha	 # tmp190,
	li 9,0	 # ivtmp.12,
	li 0,4	 # tmp191,
.L6:
	lwzx 7,11,9	 # MEM[base: c.3_14, index: ivtmp.12_25, offset: 0B], MEM[base: c.3_14, index: ivtmp.12_25, offset: 0B]
	add 8,11,9	 # tmp182, c.3, ivtmp.12
	lwz 8,4(8)	 # MEM[base: D.1310_21, offset: 4B], D.1287
	cmpwi 7,7,0	 #, tmp184, MEM[base: c.3_14, index: ivtmp.12_25, offset: 0B]
	beq+ 7,.L5	 #
	cmpwi 7,8,0	 #, tmp185, D.1287
	beq+ 7,.L5	 #
	stw 0,b@l(10)	 # b, tmp191
.L5:
	addi 9,9,8	 # ivtmp.12, ivtmp.12,
	bdnz .L6	 #
.L2:
.L9:
	lwz 0,20(1)	 #,
	addi 1,1,16	 #,,
	mtlr 0	 #,
	blr	 #
	.size	foo,.-foo
	.globl b
	.globl a
	.globl v
	.globl c
	.section	.sbss,"aw",@nobits
	.align 2
	.type	b, @object
	.size	b, 4
b:
	.zero	4
	.type	a, @object
	.size	a, 4
a:
	.zero	4
	.type	v, @object
	.size	v, 4
v:
	.zero	4
	.type	c, @object
	.size	c, 4
c:
	.zero	4
	.ident	"GCC: (GNU) 4.6.3"
	.section	.note.GNU-stack,"",@progbits
