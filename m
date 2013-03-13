Return-Path: <paulus@ozlabs.org>
Date: Wed, 13 Mar 2013 22:34:12 +1100
From: Paul Mackerras <paulus@samba.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH -V2 07/26] powerpc: Add size argument to pgtable_cache_add
Message-ID: <20130313113412.GA29597@iris.ozlabs.ibm.com>
References: <1362550227-575-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1362550227-575-8-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20130313024725.GA21125@iris.ozlabs.ibm.com>
 <877glbd536.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <877glbd536.fsf@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 13, 2013 at 02:55:17PM +0530, Aneesh Kumar K.V wrote:
> Paul Mackerras <paulus@samba.org> writes:
> > NAK to this (and in fact the rest of this patch).
> >
> > If you need twice the size, use the next slot along in pgtable_cache,
> > which will give you the size you need, rather than breaking the
> > relationship between slot index and allocation size.
> 
> That would mean we will have to do 
> 
>  static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long addr)
>  {
> -	return kmem_cache_alloc(PGT_CACHE(PMD_INDEX_SIZE),
> +	return kmem_cache_alloc(PGT_CACHE(PMD_INDEX_SIZE + 1),
>  				GFP_KERNEL|__GFP_REPEAT);
>  }
> 
> is that ok ?

I would define a symbol such as PMD_CACHE_INDEX and arrange for that
to be either PMD_INDEX_SIZE or PMD_INDEX_SIZE + 1, as needed, and then
use PGT_CACHE(PMD_CACHE_INDEX) everywhere instead of
PGT_CACHE(PMD_INDEX_SIZE).  If you want, you could also do
PUD_CACHE_INDEX and PGD_CACHE_INDEX for consistency, but it's not
totally necessary.

Paul.
