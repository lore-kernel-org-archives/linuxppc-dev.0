Return-Path: <nickpiggin@yahoo.com.au>
Received: from n12.bullet.mail.mud.yahoo.com (n12.bullet.mail.mud.yahoo.com
	[209.191.125.209]) by ozlabs.org (Postfix) with SMTP id AFD02DDE1B
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Feb 2008 15:47:36 +1100 (EST)
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH 1/3] Fix Unlikely(x) == y
Date: Tue, 19 Feb 2008 15:41:01 +1100
References: <47B70A61.9030306@tiscali.nl>
	<200802191333.53607.nickpiggin@yahoo.com.au>
	<20080218184027.429cf47b@laptopd505.fenrus.org>
In-Reply-To: <20080218184027.429cf47b@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200802191541.01398.nickpiggin@yahoo.com.au>
Cc: Roel Kluin <12o3l@tiscali.nl>, lkml <linux-kernel@vger.kernel.org>,
	cbe-oss-dev@ozlabs.org, linuxppc-dev@ozlabs.org,
	Andi Kleen <andi@firstfloor.org>, Willy Tarreau <w@1wt.eu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 19 February 2008 13:40, Arjan van de Ven wrote:
> On Tue, 19 Feb 2008 13:33:53 +1100
>
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> > Actually one thing I don't like about gcc is that I think it still
> > emits cmovs for likely/unlikely branches, which is silly (the gcc
> > developers seem to be in love with that instruction). If that goes
> > away, then branch hints may be even better.
>
> only for -Os and only if the result is smaller afaik.

What is your evidence for saying this? Because here, with the latest
kernel and recent gcc-4.3 snapshot, it spits out cmov like crazy even
when compiled with -O2.

npiggin@am:~/usr/src/linux-2.6$ grep cmov kernel/sched.s | wc -l
45

And yes it even does for hinted branches and even at -O2/3

npiggin@am:~/tests$ cat cmov.c
int test(int a, int b)
{
        if (__builtin_expect(a < b, 0))
                return a;
        else
                return b;
}
npiggin@am:~/tests$ gcc-4.3 -S -O2 cmov.c
npiggin@am:~/tests$ head -13 cmov.s
        .file   "cmov.c"
        .text
        .p2align 4,,15
..globl test
        .type   test, @function
test:
..LFB2:
        cmpl    %edi, %esi
        cmovle  %esi, %edi
        movl    %edi, %eax
        ret
..LFE2:
        .size   test, .-test

This definitely should be a branch, IMO.

> (cmov tends to be a performance loss most of the time so for -O2 and such
> it isn't used as far as I know.. it does make for nice small code however
> ;-)

It shouldn't be hard to work out the cutover point based on how
expensive cmov is, how expensive branch and branch mispredicts are,
and how often the branch is likely to be mispredicted. For an
unpredictable branch, cmov is normally quite a good win even on
modern CPUs. But gcc overuses it I think.
