Return-Path: <MELGOR@ie.ibm.com>
Received: from mtagate2.uk.ibm.com (mtagate2.uk.ibm.com [194.196.100.162])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate2.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6E7AFB7B73
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 23 Sep 2009 00:48:03 +1000 (EST)
Received: from d06nrmr1507.portsmouth.uk.ibm.com
	(d06nrmr1507.portsmouth.uk.ibm.com [9.149.38.233])
	by mtagate2.uk.ibm.com (8.13.1/8.13.1) with ESMTP id n8MElvYE007920
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2009 14:47:58 GMT
Received: from d06av06.portsmouth.uk.ibm.com (d06av06.portsmouth.uk.ibm.com
	[9.149.37.217])
	by d06nrmr1507.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id n8MElvf63506336
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2009 15:47:57 +0100
Received: from d06av06.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av06.portsmouth.uk.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with
	ESMTP id n8MElvMF013141
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2009 08:47:57 -0600
In-Reply-To: <20090922025235.GD31801@kryten>
References: <20090922025235.GD31801@kryten>
Subject: Re: powerpc: Move 64bit heap above 1TB on machines with 1TB segments
To: Anton Blanchard <anton@samba.org>
Message-ID: <OFE590BAE9.6FD7FAB3-ON80257639.0050F8A6-80257639.00514A5E@ie.ibm.com>
From: Mel Gorman <MELGOR@ie.ibm.com>
Date: Tue, 22 Sep 2009 15:47:55 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anton Blanchard <anton@samba.org> wrote on 22/09/2009 03:52:35:

> If we are using 1TB segments and we are allowed to randomise the heap, we
can
> put it above 1TB so it is backed by a 1TB segment. Otherwise the heap
will be
> in the bottom 1TB which always uses 256MB segments and this may result in
a
> performance penalty.
>
> This functionality is disabled when heap randomisation is turned off:
>
> echo 1 > /proc/sys/kernel/randomize_va_space
>
> which may be useful when trying to allocate the maximum amount of 16M or
16G
> pages.
>
> On a microbenchmark that repeatedly touches 32GB of memory with a stride
of
> 256MB + 4kB (designed to stress 256MB segments while still mapping nicely
into
> the L1 cache), we see the improvement:
>
> Force malloc to use heap all the time:
> # export MALLOC_MMAP_MAX_=0 MALLOC_TRIM_THRESHOLD_=-1
>
> Disable heap randomization:
> # echo 1 > /proc/sys/kernel/randomize_va_space
> # time ./test
> 12.51s
>
> Enable heap randomization:
> # echo 2 > /proc/sys/kernel/randomize_va_space
> # time ./test
> 1.70s
>
> Signed-off-by: Anton Blanchard <anton@samba.org>
> ---
>
> I've cc-ed Mel on this one. As you can see it definitely helps the base
> page size performance, but I'm a bit worried of the impact of taking away
> another of our 1TB slices.
>

Unfortunately, I am not sensitive to issues surrounding 1TB segments or how
they are currently being used. However, as this clearly helps performance
for large amounts of memory, is it worth providing an option to
libhugetlbfs to locate 16MB pages above 1TB when they are otherwise being
unused?

> Index: linux.trees.git/arch/powerpc/kernel/process.c
> ===================================================================
> --- linux.trees.git.orig/arch/powerpc/kernel/process.c   2009-09-17
> 15:47:46.000000000 +1000
> +++ linux.trees.git/arch/powerpc/kernel/process.c   2009-09-17 15:
> 49:11.000000000 +1000
> @@ -1165,7 +1165,22 @@ static inline unsigned long brk_rnd(void
>
>  unsigned long arch_randomize_brk(struct mm_struct *mm)
>  {
> -   unsigned long ret = PAGE_ALIGN(mm->brk + brk_rnd());
> +   unsigned long base = mm->brk;
> +   unsigned long ret;
> +
> +#ifdef CONFIG_PPC64
> +   /*
> +    * If we are using 1TB segments and we are allowed to randomise
> +    * the heap, we can put it above 1TB so it is backed by a 1TB
> +    * segment. Otherwise the heap will be in the bottom 1TB
> +    * which always uses 256MB segments and this may result in a
> +    * performance penalty.
> +    */
> +   if (!is_32bit_task() && (mmu_highuser_ssize == MMU_SEGSIZE_1T))
> +      base = max_t(unsigned long, mm->brk, 1UL << SID_SHIFT_1T);
> +#endif
> +
> +   ret = PAGE_ALIGN(base + brk_rnd());
>
>     if (ret < mm->brk)
>        return mm->brk;
