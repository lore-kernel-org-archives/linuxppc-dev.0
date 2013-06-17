Return-Path: <aik@ozlabs.ru>
Received: from mail-ie0-x22b.google.com (mail-ie0-x22b.google.com
 [IPv6:2607:f8b0:4001:c03::22b])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 23B9B2C01FC
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Jun 2013 19:17:45 +1000 (EST)
Received: by mail-ie0-f171.google.com with SMTP id qd12so6401366ieb.30
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Jun 2013 02:17:43 -0700 (PDT)
Message-ID: <51BED42F.9000507@ozlabs.ru>
Date: Mon, 17 Jun 2013 19:17:35 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/4] powerpc: Prepare to support kernel handling of IOMMU
 map/unmap
References: <1370412673-1345-1-git-send-email-aik@ozlabs.ru>
 <1370412673-1345-3-git-send-email-aik@ozlabs.ru>
 <1371356818.21896.114.camel@pasglop>
In-Reply-To: <1371356818.21896.114.camel@pasglop>
Content-Type: text/plain; charset=KOI8-R
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
 Alexander Graf <agraf@suse.de>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/16/2013 02:26 PM, Benjamin Herrenschmidt wrote:
>> +#if defined(CONFIG_SPARSEMEM_VMEMMAP) || defined(CONFIG_FLATMEM)
>> +int realmode_get_page(struct page *page)
>> +{
>> +	if (PageCompound(page))
>> +		return -EAGAIN;
>> +
>> +	get_page(page);
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(realmode_get_page);
>> +
>> +int realmode_put_page(struct page *page)
>> +{
>> +	if (PageCompound(page))
>> +		return -EAGAIN;
>> +
>> +	if (!atomic_add_unless(&page->_count, -1, 1))
>> +		return -EAGAIN;
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(realmode_put_page);
>> +#endif
> 
> Several worries here, mostly that if the generic code ever changes
> (something gets added to get_page() that makes it no-longer safe for use
> in real mode for example, or some other condition gets added to
> put_page()), we go out of sync and potentially end up with very hard and
> very subtle bugs.
> 
> It might be worth making sure that:
> 
>  - This is reviewed by some generic VM people (and make sure they
> understand why we need to do that)
> 
>  - A comment is added to get_page() and put_page() to make sure that if
> they are changed in any way, dbl check the impact on our
> realmode_get_page() (or "ping" us to make sure things are still ok).

After changing get_page() to get_page_unless_zero(), the get_page API I use is:
get_page_unless_zero() - basically atomic_inc_not_zero()
atomic_add_unless() - just operated with the counter
PageCompound() - check if it is a huge page.

No usage of get_page or put_page.

If any of those changes, I would expect it to hit us immediately, no?

So it may only make sense to add a comment to PageCompound(). But the
comment says "PageCompound is generally not used in hot code paths", and
our path is hot. Heh.

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 6d53675..c70a654 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -329,7 +329,8 @@ static inline void set_page_writeback(struct page *page)
  * System with lots of page flags available. This allows separate
  * flags for PageHead() and PageTail() checks of compound pages so that bit
  * tests can be used in performance sensitive paths. PageCompound is
- * generally not used in hot code paths.
+ * generally not used in hot code paths except arch/powerpc/mm/init_64.c
+ * which uses it to detect huge pages and avoid handling those in real mode.
  */
 __PAGEFLAG(Head, head) CLEARPAGEFLAG(Head, head)
 __PAGEFLAG(Tail, tail)


So?


-- 
Alexey
