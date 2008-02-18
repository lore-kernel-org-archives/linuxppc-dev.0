Return-Path: <bunk@kernel.org>
Received: from smtp5.pp.htv.fi (smtp5.pp.htv.fi [213.243.153.39])
	by ozlabs.org (Postfix) with ESMTP id 24376DDED3
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Feb 2008 00:56:42 +1100 (EST)
Date: Mon, 18 Feb 2008 15:56:09 +0200
From: Adrian Bunk <bunk@kernel.org>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 1/3] Fix Unlikely(x) == y
Message-ID: <20080218135609.GD21080@cs181133002.pp.htv.fi>
References: <47B70A61.9030306@tiscali.nl>
	<20080216092552.325e5726@laptopd505.fenrus.org>
	<20080216173315.GU8953@1wt.eu>
	<20080216094226.1e8eede1@laptopd505.fenrus.org>
	<47B72BFE.9060302@am.sony.com>
	<20080216103927.2a02352b@laptopd505.fenrus.org>
	<1203249003.6718.24.camel@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1203249003.6718.24.camel@concordia>
Cc: Roel Kluin <12o3l@tiscali.nl>, lkml <linux-kernel@vger.kernel.org>,
	cbe-oss-dev@ozlabs.org, linuxppc-dev@ozlabs.org,
	Willy Tarreau <w@1wt.eu>, Arjan van de Ven <arjan@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Feb 17, 2008 at 10:50:03PM +1100, Michael Ellerman wrote:
> On Sat, 2008-02-16 at 10:39 -0800, Arjan van de Ven wrote:
>...
> > for mordern (last 10 years) x86 cpus... the cpu branchpredictor is better
> > than the coder in general. Same for most other architectures.
> > 
> > unlikely() creates bigger code as well.
> > 
> > Now... we're talking about your super duper hotpath function here right?
> > One where you care about 0.5 cycle speed improvement? (less on modern
> > systems ;)
> 
> The first patch was to platforms/ps3 code, which runs on the Cell, in
> particular the PPE ... which is not an x86 :)
> 
> eg:
> 
> [michael@schoenaich ~]$ cat branch.c
> #include <stdio.h>
> int main(void)
> {
>         int i, j;
> 
>         for (i = 0, j = 0; i < 1000000000; i++)
>                 if (i % 4 == 0)
>                         j++;
> 
>         printf("j = %d\n", j);
>         return 0;
> }
> [michael@schoenaich ~]$ ppu-gcc -Wall -O3 -o branch branch.c
> [michael@schoenaich ~]$ time ./branch
> real    0m5.172s
> 
> [michael@schoenaich ~]$ cat branch.c
> ..
>         for (i = 0, j = 0; i < 1000000000; i++)
>                 if (__builtin_expect(i % 4 == 0, 0))
>                         j++;
> ..
> [michael@schoenaich ~]$ ppu-gcc -Wall -O3 -o branch branch.c
> [michael@schoenaich ~]$ time ./branch
> real    0m3.762s
> 
> 
> Which looks as though unlikely() is helping. Admittedly we don't have a
> lot of kernel code that looks like that, but at least unlikely is doing
> what we want it to.


This means it generates faster code with a current gcc for your platform.

But a future gcc might e.g. replace the whole loop with a division
(gcc SVN head (that will soon become gcc 4.3) already does 
transformations like replacing loops with divisions [1]).

And your __builtin_expect() then might have unwanted effects on gcc.

Or the kernel code changes much but the likely/unlikely stays unchanged
although it becomes wrong.

If it is a real hotpath in the kernel where you have _measurable_ 
performance advantages from using likely/unlikely it's usage might be 
justified, but otherwise it shouldn't be used.


> cheers

cu
Adrian

[1] e.g. the while() loop in timespec_add_ns() in include/linux/time.h
    gets replaced by a division and a modulo (whether this 
    transformation is correct in this specific case is a different
    question, but that's the level of code transformation gcc already 
    does today)

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
