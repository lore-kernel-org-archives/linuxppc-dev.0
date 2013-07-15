Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-f48.google.com (mail-pa0-f48.google.com
 [209.85.220.48])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 45CEC2C0146
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jul 2013 20:04:37 +1000 (EST)
Received: by mail-pa0-f48.google.com with SMTP id kp12so10934262pab.7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jul 2013 03:04:35 -0700 (PDT)
Message-ID: <51E3C92B.2070704@ozlabs.ru>
Date: Mon, 15 Jul 2013 20:04:27 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH] hashtable: add hash_for_each_possible_rcu_notrace()
References: <1373084210-27767-1-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1373084210-27767-1-git-send-email-aik@ozlabs.ru>
Content-Type: text/plain; charset=KOI8-R
Cc: linux-kernel@vger.kernel.org, Sasha Levin <sasha.levin@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anyone, ping?

On 07/06/2013 02:16 PM, Alexey Kardashevskiy wrote:
> This adds hash_for_each_possible_rcu_notrace() which is basically
> a notrace clone of hash_for_each_possible_rcu() which cannot be
> used in real mode due to its tracing/debugging capability.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  include/linux/hashtable.h | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/include/linux/hashtable.h b/include/linux/hashtable.h
> index a9df51f..af8b169 100644
> --- a/include/linux/hashtable.h
> +++ b/include/linux/hashtable.h
> @@ -174,6 +174,21 @@ static inline void hash_del_rcu(struct hlist_node *node)
>  		member)
>  
>  /**
> + * hash_for_each_possible_rcu_notrace - iterate over all possible objects hashing
> + * to the same bucket in an rcu enabled hashtable in a rcu enabled hashtable
> + * @name: hashtable to iterate
> + * @obj: the type * to use as a loop cursor for each entry
> + * @member: the name of the hlist_node within the struct
> + * @key: the key of the objects to iterate over
> + *
> + * This is the same as hash_for_each_possible_rcu() except that it does
> + * not do any RCU debugging or tracing.
> + */
> +#define hash_for_each_possible_rcu_notrace(name, obj, member, key)	\
> +	hlist_for_each_entry_rcu_notrace(obj, &name[hash_min(key, HASH_BITS(name))],\
> +		member)
> +
> +/**
>   * hash_for_each_possible_safe - iterate over all possible objects hashing to the
>   * same bucket safe against removals
>   * @name: hashtable to iterate
> 


-- 
Alexey
