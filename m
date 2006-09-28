Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 6D84567B6D
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Sep 2006 01:00:42 +1000 (EST)
Date: Thu, 28 Sep 2006 19:00:41 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 8/12] qe_lib: Fix rheap alignment problem
Message-ID: <20060928190041.1300dabb@vitb.ru.mvista.com>
In-Reply-To: <9672B4B6-1DC0-48D6-99BA-7160421CB24C@kernel.crashing.org>
References: <451B8584.1070403@freescale.com>
	<9672B4B6-1DC0-48D6-99BA-7160421CB24C@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, Li Yang <leoli@freescale.com>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 28 Sep 2006 09:10:18 -0500
Kumar Gala <galak@kernel.crashing.org> wrote:

> 
> On Sep 28, 2006, at 3:19 AM, Li Yang wrote:
> 
> > Honor alignment parameter in the rheap allocator.  This is
> > needed by qe_lib.
> > Remove compile warning.
> >
> > Signed-off-by: Pantelis Antoniou <pantelis@embeddedalley.com>
> > Signed-off-by: Li Yang <leoli@freescale.com>
> 
> Vitaly, have you tested this with any of your PQ2 powerpc ports?
> 

Had no such a chance... Well I can give it a quick test for 8560 today,
and PQ2 next week. I think the fix was introduced and verified a while ago,
but don't recall if it is the one below :)

-Vitaly

> - k
> 
> > ---
> > arch/powerpc/lib/Makefile |    1 +
> > arch/powerpc/lib/rheap.c  |   24 ++++++++++++++++++++----
> > include/asm-ppc/rheap.h   |    4 ++++
> > 3 files changed, 25 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
> > index ff70964..fe61c92 100644
> > --- a/arch/powerpc/lib/Makefile
> > +++ b/arch/powerpc/lib/Makefile
> > @@ -14,6 +14,7 @@ endif
> > obj-$(CONFIG_PPC64)	+= checksum_64.o copypage_64.o copyuser_64.o \
> > 			   memcpy_64.o usercopy_64.o mem_64.o string.o \
> > 			   strcase.o
> > +obj-$(CONFIG_QUICC_ENGINE) += rheap.o
> > obj-$(CONFIG_PPC_ISERIES) += e2a.o
> > obj-$(CONFIG_XMON)	+= sstep.o
> > diff --git a/arch/powerpc/lib/rheap.c b/arch/powerpc/lib/rheap.c
> > index 31e5118..57bf991 100644
> > --- a/arch/powerpc/lib/rheap.c
> > +++ b/arch/powerpc/lib/rheap.c
> > @@ -423,17 +423,21 @@ void *rh_detach_region(rh_info_t * info,
> > 	return (void *)s;
> > }
> > -void *rh_alloc(rh_info_t * info, int size, const char *owner)
> > +void *rh_alloc_align(rh_info_t * info, int size, int alignment,  
> > const char *owner)
> > {
> > 	struct list_head *l;
> > 	rh_block_t *blk;
> > 	rh_block_t *newblk;
> > 	void *start;
> > -	/* Validate size */
> > -	if (size <= 0)
> > +	/* Validate size, (must be power of two) */
> > +	if (size <= 0 || (alignment & (alignment - 1)) != 0)
> > 		return ERR_PTR(-EINVAL);
> > +	/* given alignment larger that default rheap alignment */
> > +	if (alignment > info->alignment)
> > +		size += alignment - 1;
> > +
> > 	/* Align to configured alignment */
> > 	size = (size + (info->alignment - 1)) & ~(info->alignment - 1);
> > @@ -476,15 +480,27 @@ void *rh_alloc(rh_info_t * info, int siz
> > 	attach_taken_block(info, newblk);
> > +	/* for larger alignment return fixed up pointer  */
> > +	/* this is no problem with the deallocator since */
> > +	/* we scan for pointers that lie in the blocks   */
> > +	if (alignment > info->alignment)
> > +		start = (void *)(((unsigned long)start + alignment - 1) &
> > +				~(alignment - 1));
> > +
> > 	return start;
> > }
> > +void *rh_alloc(rh_info_t * info, int size, const char *owner)
> > +{
> > +	return rh_alloc_align(info, size, info->alignment, owner);
> > +}
> > +
> > /* allocate at precisely the given address */
> > void *rh_alloc_fixed(rh_info_t * info, void *start, int size, const  
> > char *owner)
> > {
> > 	struct list_head *l;
> > 	rh_block_t *blk, *newblk1, *newblk2;
> > -	unsigned long s, e, m, bs, be;
> > +	unsigned long s, e, m, bs = 0, be = 0;
> > 	/* Validate size */
> > 	if (size <= 0)
> > diff --git a/include/asm-ppc/rheap.h b/include/asm-ppc/rheap.h
> > index e6ca1f6..65b9322 100644
> > --- a/include/asm-ppc/rheap.h
> > +++ b/include/asm-ppc/rheap.h
> > @@ -62,6 +62,10 @@ extern int rh_attach_region(rh_info_t * /*  
> > Detach a free region */
> > extern void *rh_detach_region(rh_info_t * info, void *start, int  
> > size);
> > +/* Allocate the given size from the remote heap (with alignment) */
> > +extern void *rh_alloc_align(rh_info_t * info, int size, int  
> > alignment,
> > +		const char *owner);
> > +
> > /* Allocate the given size from the remote heap */
> > extern void *rh_alloc(rh_info_t * info, int size, const char *owner);
> 
> 


-- 
Sincerely, 
Vitaly
