Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 042ACDDF32
	for <linuxppc-dev@ozlabs.org>; Fri,  1 May 2009 00:34:04 +1000 (EST)
Date: Thu, 30 Apr 2009 18:10:13 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Nick Piggin <npiggin@suse.de>
Subject: Re: Next April 28: boot failure on PowerPC with SLQB
Message-ID: <20090430141013.GA17480@oksana.dev.rtsoft.ru>
References: <20090430041146.GB23746@wotan.suse.de>
	<49F938E4.2030703@in.ibm.com>
	<20090430064127.GF23746@wotan.suse.de>
	<49F973A0.8070106@in.ibm.com> <20090430103528.GA6900@wotan.suse.de>
	<1241087884.19252.5.camel@penberg-laptop>
	<20090430210004.05a61841.sfr@canb.auug.org.au>
	<20090430111825.GC6900@wotan.suse.de>
	<1241090429.19252.7.camel@penberg-laptop>
	<20090430130542.GF6900@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20090430130542.GF6900@wotan.suse.de>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Christoph Lameter <cl@linux-foundation.org>,
	Pekka Enberg <penberg@cs.helsinki.fi>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org, linux-next@vger.kernel.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 30, 2009 at 03:05:42PM +0200, Nick Piggin wrote:
[...]
> ---
> SLQB: fix dumb early allocation cache
> 
> The dumb early allocation cache had a bug where it could allow allocation
> to go past the end of a page, which could cause crashes or random memory
> corruption. Fix this and simplify the logic.
> 
> Signed-off-by: Nick Piggin <npiggin@suse.de>
> ---
>  mm/slqb.c |   19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
> 
> Index: linux-2.6/mm/slqb.c
> ===================================================================
> --- linux-2.6.orig/mm/slqb.c
> +++ linux-2.6/mm/slqb.c
> @@ -2185,8 +2185,11 @@ static void *kmem_cache_dyn_array_alloc(
>  {
>  	size_t size = sizeof(void *) * ids;
>  
> +	BUG_ON(!size);
> +
>  	if (unlikely(!slab_is_available())) {
>  		static void *nextmem;
> +		static size_t nextleft;
>  		void *ret;
>  
>  		/*
> @@ -2194,16 +2197,16 @@ static void *kmem_cache_dyn_array_alloc(
>  		 * never get freed by definition so we can do it rather
>  		 * simply.
>  		 */
> -		if (!nextmem) {
> -			nextmem = alloc_pages_exact(size, GFP_KERNEL);
> -			if (!nextmem)
> -				return NULL;
> +		if (size > nextleft) {
> +                        nextmem = alloc_pages_exact(size, GFP_KERNEL);
> +                        if (!nextmem)
> +                                return NULL;

Cosmetic issue: spaces instead of tabs are used on these
three lines.

> +			nextleft = roundup(size, PAGE_SIZE);
>  		}
> +
>  		ret = nextmem;
> -		nextmem = (void *)((unsigned long)ret + size);
> -		if ((unsigned long)ret >> PAGE_SHIFT !=
> -				(unsigned long)nextmem >> PAGE_SHIFT)
> -			nextmem = NULL;
> +		nextleft -= size;
> +		nextmem += size;
>  		memset(ret, 0, size);
>  		return ret;
>  	} else {

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
