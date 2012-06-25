Return-Path: <gaowanlong@cn.fujitsu.com>
Received: from song.cn.fujitsu.com (unknown [222.73.24.84])
 by ozlabs.org (Postfix) with ESMTP id 4C21FB6EF3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2012 21:04:53 +1000 (EST)
Message-ID: <4FE84352.8090303@cn.fujitsu.com>
Date: Mon, 25 Jun 2012 18:54:10 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
To: Li Zhong <zhong@linux.vnet.ibm.com>
Subject: Re: [PATCH SLUB 1/2] duplicate the cache name in saved_alias list
References: <1340617984.13778.37.camel@ThinkPad-T420>
In-Reply-To: <1340617984.13778.37.camel@ThinkPad-T420>
Content-Type: text/plain; charset=UTF-8
Cc: Christoph Lameter <cl@linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>, Pekka Enberg <penberg@kernel.org>,
 linux-mm <linux-mm@kvack.org>, Paul Mackerras <paulus@samba.org>,
 Matt Mackall <mpm@selenic.com>,
 PowerPC email list <linuxppc-dev@lists.ozlabs.org>
Reply-To: gaowanlong@cn.fujitsu.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/25/2012 05:53 PM, Li Zhong wrote:
> SLUB duplicates the cache name in kmem_cache_create(). However if the
> cache could be merged to others during early booting, the name pointer
> is saved in saved_alias list, and the string needs to be kept valid
> before slab_sysfs_init() is called. 
> 
> This patch tries to duplicate the cache name in saved_alias list, so
> that the cache name could be safely kfreed after calling
> kmem_cache_create(), if that name is kmalloced. 
> 
> Signed-off-by: Li Zhong <zhong@linux.vnet.ibm.com>
> ---
>  mm/slub.c |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 8c691fa..3dc8ed5 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -5373,6 +5373,11 @@ static int sysfs_slab_alias(struct kmem_cache *s,
> const char *name)
>  
>  	al->s = s;
>  	al->name = name;
> +	al->name = kstrdup(name, GFP_KERNEL);

dup assigned the al->name ?


Thanks,
Wanlong Gao

> +	if (!al->name) {
> +		kfree(al);
> +		return -ENOMEM;
> +	}
>  	al->next = alias_list;
>  	alias_list = al;
>  	return 0;
> @@ -5409,6 +5414,7 @@ static int __init slab_sysfs_init(void)
>  		if (err)
>  			printk(KERN_ERR "SLUB: Unable to add boot slab alias"
>  					" %s to sysfs\n", s->name);
> +		kfree(al->name);
>  		kfree(al);
>  	}
>  
> 
