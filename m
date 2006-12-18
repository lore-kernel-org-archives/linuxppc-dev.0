Return-Path: <haveblue@us.ibm.com>
Subject: Re: [PATCH] Fix sparsemem on Cell
From: Dave Hansen <haveblue@us.ibm.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20061216170353.2dfa27b1.kamezawa.hiroyu@jp.fujitsu.com>
References: <20061215165335.61D9F775@localhost.localdomain>
	<4582D756.7090702@shadowen.org>
	<1166203440.8105.22.camel@localhost.localdomain>
	<20061215114536.dc5c93af.akpm@osdl.org>
	<20061216170353.2dfa27b1.kamezawa.hiroyu@jp.fujitsu.com>
Content-Type: text/plain
Date: Mon, 18 Dec 2006 13:13:57 -0800
Message-Id: <1166476437.8648.7.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Andrew Morton <akpm@osdl.org>, linux-mm@kvack.org, kmannth@us.ibm.com,
	linux-kernel@vger.kernel.org, hch@infradead.org,
	linuxppc-dev@ozlabs.org, paulus@samba.org, mkravetz@us.ibm.com,
	gone@us.ibm.com, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2006-12-16 at 17:03 +0900, KAMEZAWA Hiroyuki wrote:
>  /* add this memory to iomem resource */
>  static struct resource *register_memory_resource(u64 start, u64 size)
>  {
> @@ -273,10 +284,13 @@
>  		if (ret)
>  			goto error;
>  	}
> +	atomic_inc(&memory_hotadd_count);
>  
>  	/* call arch's memory hotadd */
>  	ret = arch_add_memory(nid, start, size);
>  
> +	atomic_dec(&memory_hotadd_count);

I'd be willing to be that this will work just fine.  But, I think we can
do it without any static state at all, if we just pass a runtime-or-not
flag down into the arch_add_memory() call chain.

I'll code that up so we can compare to yours.  

-- Dave
