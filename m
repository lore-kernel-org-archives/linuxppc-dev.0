Return-Path: <paulus@ozlabs.org>
Date: Wed, 13 Mar 2013 13:47:25 +1100
From: Paul Mackerras <paulus@samba.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH -V2 07/26] powerpc: Add size argument to pgtable_cache_add
Message-ID: <20130313024725.GA21125@iris.ozlabs.ibm.com>
References: <1362550227-575-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1362550227-575-8-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1362550227-575-8-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 06, 2013 at 11:40:08AM +0530, Aneesh Kumar K.V wrote:
> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> 
> We will use this later with THP changes to request for pmd table of double the size.
> THP code does PTE page allocation along with large page request and deposit them
> for later use. This is to ensure that we won't have any failures when we split
> huge pages to regular pages.
> 
> On powerpc we want to use the deposited PTE page for storing hash pte slot and
> secondary bit information for the HPTEs. Hence we save them in the second half
> of the pmd table.

That much is fine, but...

> -void pgtable_cache_add(unsigned shift, void (*ctor)(void *));
> +extern void __pgtable_cache_add(unsigned shift, unsigned long table_size,
> +				void (*ctor)(void *));
>  void pgtable_cache_init(void);
> +static inline void pgtable_cache_add(unsigned shift, void (*ctor)(void *))
> +{
> +	return __pgtable_cache_add(shift, sizeof(void *) << shift, ctor);
> +}

NAK to this (and in fact the rest of this patch).

If you need twice the size, use the next slot along in pgtable_cache,
which will give you the size you need, rather than breaking the
relationship between slot index and allocation size.

Paul.
