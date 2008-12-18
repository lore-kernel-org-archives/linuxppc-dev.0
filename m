Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BE313DDEE9
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Dec 2008 09:47:01 +1100 (EST)
Date: Thu, 18 Dec 2008 14:45:53 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Yuri Tikhonov <yur@emcraft.com>
Subject: Re: [PATCH][v2] fork_init: fix division by zero
Message-Id: <20081218144553.91226f50.akpm@linux-foundation.org>
In-Reply-To: <200812181047.50332.yur@emcraft.com>
References: <200812101950.51958.yur@emcraft.com>
	<20081211121635.ff58193f.akpm@linux-foundation.org>
	<18753.46301.944770.779390@cargo.ozlabs.ibm.com>
	<200812181047.50332.yur@emcraft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: wd@denx.de, dzu@denx.de, linux-kernel@vger.kernel.org, miltonm@bga.com,
	linuxppc-dev@ozlabs.org, paulus@samba.org,
	viro@zeniv.linux.org.uk, Hugh Dickins <hugh@veritas.com>,
	Geert.Uytterhoeven@sonycom.com, yanok@emcraft.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 18 Dec 2008 10:47:50 +0300
Yuri Tikhonov <yur@emcraft.com> wrote:

> Hello Paul,
> 
> On Friday 12 December 2008 03:48, Paul Mackerras wrote:
> > Andrew Morton writes:
> > 
> > > > +#if (8 * THREAD_SIZE) > PAGE_SIZE
> > > >  	max_threads = mempages / (8 * THREAD_SIZE / PAGE_SIZE);
> > > > +#else
> > > > +	max_threads = mempages * (PAGE_SIZE / (8 * THREAD_SIZE));
> > > > +#endif
> > > 
> > > The expression you've chosen here can be quite inacccurate, because
> > > ((PAGE_SIZE / (8 * THREAD_SIZE)) is a small number.  The way to
> > > preserve accuracy is
> > 
> > The assumption is that THREAD_SIZE is a power of 2, as is PAGE_SIZE.
> > 
> > I think Yuri should be increasing THREAD_SIZE for the larger page
> > sizes he's implementing, because we have on-stack arrays whose size
> > depends on the page size.  I suspect that having THREAD_SIZE less than
> > 1/8 of PAGE_SIZE risks stack overflows, and the better fix is for Yuri
> > to make sure THREAD_SIZE is at least 1/8 of PAGE_SIZE.  (In fact, more
> > may be needed - someone should work out what fraction is actually
> > needed.)
> 
>   Right, thanks for pointing this. I guess, I was just lucky since didn't run into
> problems with stack overflows. So, I agree that we should increase the 
> THREAD_SIZE in case of 256KB pages up to 1/8 of PAGE_SIZE, that is up 
> to 32KB.
> 
>  There is one more warning from the common code when I use 256KB pages:
> 
>    CC      mm/shmem.o
> mm/shmem.c: In function 'shmem_truncate_range':
> mm/shmem.c:613: warning: division by zero
> mm/shmem.c:619: warning: division by zero
> mm/shmem.c:644: warning: division by zero
> mm/shmem.c: In function 'shmem_unuse_inode':
> mm/shmem.c:873: warning: division by zero
> 
>  The problem here is that ENTRIES_PER_PAGEPAGE becomes 0x1.0000.0000
> when PAGE_SIZE is 256K.
> 
>  How about the following fix ?
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 0ed0752..99d7c91 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -57,7 +57,7 @@
>  #include <asm/pgtable.h>
>  
>  #define ENTRIES_PER_PAGE (PAGE_CACHE_SIZE/sizeof(unsigned long))
> -#define ENTRIES_PER_PAGEPAGE (ENTRIES_PER_PAGE*ENTRIES_PER_PAGE)
> +#define ENTRIES_PER_PAGEPAGE ((unsigned long long)ENTRIES_PER_PAGE*ENTRIES_PER_PAGE)
>  #define BLOCKS_PER_PAGE  (PAGE_CACHE_SIZE/512)
>  
>  #define SHMEM_MAX_INDEX  (SHMEM_NR_DIRECT + (ENTRIES_PER_PAGEPAGE/2) * (ENTRIES_PER_PAGE+1))
> @@ -95,7 +95,7 @@ static unsigned long shmem_default_max_inodes(void)
>  }
>  #endif
>  
> -static int shmem_getpage(struct inode *inode, unsigned long idx,
> +static int shmem_getpage(struct inode *inode, unsigned long long idx,
>  			 struct page **pagep, enum sgp_type sgp, int *type);
>  
>  static inline struct page *shmem_dir_alloc(gfp_t gfp_mask)
> @@ -533,7 +533,7 @@ static void shmem_truncate_range(struct inode *inode, loff_t start, loff_t end)
>  	int punch_hole;
>  	spinlock_t *needs_lock;
>  	spinlock_t *punch_lock;
> -	unsigned long upper_limit;
> +	unsigned long long upper_limit;
>  
>  	inode->i_ctime = inode->i_mtime = CURRENT_TIME;
>  	idx = (start + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
> @@ -1175,7 +1175,7 @@ static inline struct mempolicy *shmem_get_sbmpol(struct shmem_sb_info *sbinfo)
>   * vm. If we swap it in we mark it dirty since we also free the swap
>   * entry since a page cannot live in both the swap and page cache
>   */
> -static int shmem_getpage(struct inode *inode, unsigned long idx,
> +static int shmem_getpage(struct inode *inode, unsigned long long idx,
>  			struct page **pagep, enum sgp_type sgp, int *type)
>  {
>  	struct address_space *mapping = inode->i_mapping;
> 

Looks sane.  But to apply this I'd prefer a changelog, a signoff and a
grunt from Hugh.

Thanks.
