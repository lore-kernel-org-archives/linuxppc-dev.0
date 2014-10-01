Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D8A871A03A1
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Oct 2014 10:32:13 +1000 (EST)
In-Reply-To: <1411586681-21262-3-git-send-email-sukadev@linux.vnet.ibm.com>
To: sukadev@linux.vnet.ibm.com, Arnaldo Carvalho de Melo <acme@kernel.org>,
 ak@linux.intel.com, Jiri Olsa <jolsa@redhat.com>, peterz@infradead.org,
 eranian@google.com, Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [v2,2/4] Simplify catalog_read()
Message-Id: <20141001003213.A8F78140273@ozlabs.org>
Date: Wed,  1 Oct 2014 10:32:13 +1000 (EST)
Cc: linuxppc-dev@lists.ozlabs.org, dev@codyps.com, linux-kernel@vger.kernel.org,
 Michael Ellerman <michaele@au1.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-24-09 at 19:24:39 UTC, sukadev@linux.vnet.ibm.com wrote:
> catalog_read() implements the read interface for the sysfs file
> 
> 	/sys/bus/event_source/devices/hv_24x7/interface/catalog
> 
> It essentially takes a buffer, an offset and count as parameters
> to the read() call.  It makes a hypervisor call to read a specific
> page from the catalog and copy the required bytes into the given
> buffer. Each call to catalog_read() returns at most one 4K page.
> 
> Given these requirements, we should be able to simplify the
> catalog_read().
> 
> diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
> index 2f2215c..9427ef7 100644
> --- a/arch/powerpc/perf/hv-24x7.c
> +++ b/arch/powerpc/perf/hv-24x7.c
> @@ -185,6 +105,8 @@ static ssize_t catalog_read(struct file *filp, struct kobject *kobj,
>  	ssize_t ret = 0;
>  	size_t catalog_len = 0, catalog_page_len = 0, page_count = 0;
>  	loff_t page_offset = 0;
> +	loff_t offset_in_page;
> +	size_t copy_len;
>  	uint64_t catalog_version_num = 0;
>  	void *page = kmem_cache_alloc(hv_page_cache, GFP_USER);
>  	struct hv_24x7_catalog_page_0 *page_0 = page;
> @@ -203,6 +125,7 @@ static ssize_t catalog_read(struct file *filp, struct kobject *kobj,
>  
>  	page_offset = offset / 4096;
>  	page_count  = count  / 4096;

I don't see where page_count is used.

> +	offset_in_page = count % 4096;

Shouldn't offset_in_page be based on offset ?

cheers
