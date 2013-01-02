Return-Path: <0000013bfba5f7f2-ba70da31-0707-48fd-949e-0bad11ba0e10-000000@amazonses.com>
Received: from a193-30.smtp-out.amazonses.com (a193-30.smtp-out.amazonses.com
 [199.255.193.30]) by ozlabs.org (Postfix) with ESMTP id BB2432C0086
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Jan 2013 01:24:20 +1100 (EST)
Date: Wed, 2 Jan 2013 14:24:17 +0000
From: Christoph Lameter <cl@linux.com>
To: Tang Chen <tangchen@cn.fujitsu.com>
Subject: Re: [PATCH v5 04/14] memory-hotplug: remove /sys/firmware/memmap/X
 sysfs
In-Reply-To: <50DBBBEF.70701@cn.fujitsu.com>
Message-ID: <0000013bfba5f7f2-ba70da31-0707-48fd-949e-0bad11ba0e10-000000@email.amazonses.com>
References: <1356350964-13437-1-git-send-email-tangchen@cn.fujitsu.com>
 <1356350964-13437-5-git-send-email-tangchen@cn.fujitsu.com>
 <50DA6F5A.2070601@jp.fujitsu.com> <50DBBBEF.70701@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, linux-mm@kvack.org,
 paulus@samba.org, hpa@zytor.com, sparclinux@vger.kernel.org,
 linux-s390@vger.kernel.org, x86@kernel.org, linux-acpi@vger.kernel.org,
 isimatu.yasuaki@jp.fujitsu.com, linfeng@cn.fujitsu.com, mgorman@suse.de,
 kosaki.motohiro@jp.fujitsu.com, rientjes@google.com, liuj97@gmail.com,
 len.brown@intel.com, wency@cn.fujitsu.com, cmetcalf@tilera.com,
 wujianguo@huawei.com, yinghai@kernel.org,
 Kamezawa Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, laijs@cn.fujitsu.com,
 linux-kernel@vger.kernel.org, minchan.kim@gmail.com, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 27 Dec 2012, Tang Chen wrote:

> On 12/26/2012 11:30 AM, Kamezawa Hiroyuki wrote:
> >> @@ -41,6 +42,7 @@ struct firmware_map_entry {
> >>    	const char		*type;	/* type of the memory range */
> >>    	struct list_head	list;	/* entry for the linked list */
> >>    	struct kobject		kobj;   /* kobject for each entry */
> >> +	unsigned int		bootmem:1; /* allocated from bootmem */
> >>    };
> >
> > Can't we detect from which the object is allocated from, slab or bootmem ?
> >
> > Hm, for example,
> >
> >      PageReserved(virt_to_page(address_of_obj)) ?
> >      PageSlab(virt_to_page(address_of_obj)) ?
> >
>
> Hi Kamezawa-san,
>
> I think we can detect it without a new member. I think bootmem:1 member
> is just for convenience. I think I can remove it. :)

Larger size slab allocations may fall back to the page allocator but then
the slabs do not track this allocation. That memory can be freed using the
page allocator.

If you see pageslab then you can always remove using the slab allocator.
Otherwise the page allocator should work (unless it was some
special case bootmem allocation).
