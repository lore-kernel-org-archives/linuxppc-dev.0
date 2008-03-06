Return-Path: <randy.dunlap@oracle.com>
Received: from agminet02.oracle.com (agminet02.oracle.com [141.146.126.229])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 187DBDE002
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Mar 2008 07:35:44 +1100 (EST)
Received: from agminet01.oracle.com (agminet01.oracle.com [141.146.126.228])
	by agminet02.oracle.com (Switch-3.2.4/Switch-3.1.7) with ESMTP id
	m26JAVVC014751
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Mar 2008 13:10:32 -0600
Date: Thu, 6 Mar 2008 11:08:47 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Badari Pulavarty <pbadari@us.ibm.com>
Subject: Re: [PATCH 1/5] generic __remove_pages() support
Message-Id: <20080306110847.11d7cb26.randy.dunlap@oracle.com>
In-Reply-To: <1204829734.7939.61.camel@dyn9047017100.beaverton.ibm.com>
References: <1204829673.7939.59.camel@dyn9047017100.beaverton.ibm.com>
	<1204829734.7939.61.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	paulus@samba.org, lkml <linux-kernel@vger.kernel.org>,
	Yasunori Goto <y-goto@jp.fujitsu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 06 Mar 2008 10:55:34 -0800 Badari Pulavarty wrote:

> Generic helper function to remove section mappings and sysfs entries
> for the section of the memory we are removing.  offline_pages() correctly 
> adjusted zone and marked the pages reserved.

Such generic (exported, non-static) interfaces could use some
(kernel-)docs, please.

> Issue: If mem_map, usemap allocation could come from different places -
> kmalloc, vmalloc, alloc_pages or bootmem. There is no easy way
> to find and free up bootmem allocations.
> 
> Signed-off-by: Badari Pulavarty <pbadari@us.ibm.com>
> 
> ---
>  include/linux/memory_hotplug.h |    4 +++
>  mm/memory_hotplug.c            |   44 +++++++++++++++++++++++++++++++++++++++++
>  mm/sparse.c                    |   43 +++++++++++++++++++++++++++++++++++++---
>  3 files changed, 88 insertions(+), 3 deletions(-)

> Index: linux-2.6.25-rc2/include/linux/memory_hotplug.h
> ===================================================================
> --- linux-2.6.25-rc2.orig/include/linux/memory_hotplug.h	2008-02-27 12:58:17.000000000 -0800
> +++ linux-2.6.25-rc2/include/linux/memory_hotplug.h	2008-02-27 13:00:04.000000000 -0800
> @@ -64,6 +65,8 @@ extern int offline_pages(unsigned long, 
>  /* reasonably generic interface to expand the physical pages in a zone  */
>  extern int __add_pages(struct zone *zone, unsigned long start_pfn,
>  	unsigned long nr_pages);
> +extern int __remove_pages(struct zone *zone, unsigned long start_pfn,
> +	unsigned long nr_pages);
>  
>  /*
>   * Walk thorugh all memory which is registered as resource.

           through :)

---
~Randy
