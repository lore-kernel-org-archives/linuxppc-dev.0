Return-Path: <bsingharora@gmail.com>
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42KKlM4BPQzF3Jv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Sep 2018 22:15:11 +1000 (AEST)
Received: by mail-pf1-x443.google.com with SMTP id m77-v6so2421292pfi.8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Sep 2018 05:15:10 -0700 (PDT)
Date: Tue, 25 Sep 2018 22:15:04 +1000
From: Balbir Singh <bsingharora@gmail.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-acpi@vger.kernel.org, xen-devel@lists.xenproject.org,
 devel@linuxdriverproject.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Rashmica Gupta <rashmica.g@gmail.com>, Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH v2 5/6] powerpc/powernv: hold device_hotplug_lock when
 calling memtrace_offline_pages()
Message-ID: <20180925121504.GH8537@350D>
References: <20180925091457.28651-1-david@redhat.com>
 <20180925091457.28651-6-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180925091457.28651-6-david@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 25, 2018 at 11:14:56AM +0200, David Hildenbrand wrote:
> Let's perform all checking + offlining + removing under
> device_hotplug_lock, so nobody can mess with these devices via
> sysfs concurrently.
> 
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Rashmica Gupta <rashmica.g@gmail.com>
> Cc: Balbir Singh <bsingharora@gmail.com>
> Cc: Michael Neuling <mikey@neuling.org>
> Reviewed-by: Pavel Tatashin <pavel.tatashin@microsoft.com>
> Reviewed-by: Rashmica Gupta <rashmica.g@gmail.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/powerpc/platforms/powernv/memtrace.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/memtrace.c b/arch/powerpc/platforms/powernv/memtrace.c
> index fdd48f1a39f7..d84d09c56af9 100644
> --- a/arch/powerpc/platforms/powernv/memtrace.c
> +++ b/arch/powerpc/platforms/powernv/memtrace.c
> @@ -70,6 +70,7 @@ static int change_memblock_state(struct memory_block *mem, void *arg)
>  	return 0;
>  }
>  
> +/* called with device_hotplug_lock held */
>  static bool memtrace_offline_pages(u32 nid, u64 start_pfn, u64 nr_pages)
>  {
>  	u64 end_pfn = start_pfn + nr_pages - 1;
> @@ -111,6 +112,7 @@ static u64 memtrace_alloc_node(u32 nid, u64 size)
>  	end_pfn = round_down(end_pfn - nr_pages, nr_pages);
>  
>  	for (base_pfn = end_pfn; base_pfn > start_pfn; base_pfn -= nr_pages) {
> +		lock_device_hotplug();

Why not grab the lock before the for loop? That way we can avoid bad cases like a
large node being scanned for a small number of pages (nr_pages). Ideally we need
a cond_resched() in the loop, but I guess offline_pages() has one.

Acked-by: Balbir Singh <bsingharora@gmail.com>
