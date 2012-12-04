Return-Path: <tangchen@cn.fujitsu.com>
Received: from song.cn.fujitsu.com (unknown [222.73.24.84])
 by ozlabs.org (Postfix) with ESMTP id 359BF2C008D
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Dec 2012 20:35:18 +1100 (EST)
Message-ID: <50BDC38C.1060209@cn.fujitsu.com>
Date: Tue, 04 Dec 2012 17:34:04 +0800
From: Tang Chen <tangchen@cn.fujitsu.com>
MIME-Version: 1.0
To: Wen Congyang <wency@cn.fujitsu.com>
Subject: Re: [Patch v4 06/12] memory-hotplug: unregister memory section on
 SPARSEMEM_VMEMMAP
References: <1354010422-19648-1-git-send-email-wency@cn.fujitsu.com>
 <1354010422-19648-7-git-send-email-wency@cn.fujitsu.com>
In-Reply-To: <1354010422-19648-7-git-send-email-wency@cn.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-s390@vger.kernel.org, linux-ia64@vger.kernel.org,
 Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org,
 linux-sh@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 cmetcalf@tilera.com, Jianguo Wu <wujianguo@huawei.com>, linux-mm@kvack.org,
 Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>, paulus@samba.org,
 Minchan Kim <minchan.kim@gmail.com>,
 KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
 David Rientjes <rientjes@google.com>, sparclinux@vger.kernel.org,
 Christoph Lameter <cl@linux.com>, linuxppc-dev@lists.ozlabs.org,
 Andrew Morton <akpm@linux-foundation.org>, Jiang Liu <liuj97@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/27/2012 06:00 PM, Wen Congyang wrote:
> From: Yasuaki Ishimatsu<isimatu.yasuaki@jp.fujitsu.com>
>
> Currently __remove_section for SPARSEMEM_VMEMMAP does nothing. But even if
> we use SPARSEMEM_VMEMMAP, we can unregister the memory_section.
>
> So the patch add unregister_memory_section() into __remove_section().
>
> CC: David Rientjes<rientjes@google.com>
> CC: Jiang Liu<liuj97@gmail.com>
> CC: Len Brown<len.brown@intel.com>
> CC: Christoph Lameter<cl@linux.com>
> Cc: Minchan Kim<minchan.kim@gmail.com>
> CC: Andrew Morton<akpm@linux-foundation.org>
> CC: KOSAKI Motohiro<kosaki.motohiro@jp.fujitsu.com>
> Signed-off-by: Yasuaki Ishimatsu<isimatu.yasuaki@jp.fujitsu.com>
> Signed-off-by: Wen Congyang<wency@cn.fujitsu.com>

__remove_section() of CONFIG_SPARSEMEM_VMEMMAP will be integrated
into one in [PATCH 08/12], so I think we can merge this patch into
[PATCH 08/12].

Reviewed-by: Tang Chen <tangchen@cn.fujitsu.com>

> ---
>   mm/memory_hotplug.c | 13 ++++++++-----
>   1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index e741732..171610d 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -279,11 +279,14 @@ static int __meminit __add_section(int nid, struct zone *zone,
>   #ifdef CONFIG_SPARSEMEM_VMEMMAP
>   static int __remove_section(struct zone *zone, struct mem_section *ms)
>   {
> -	/*
> -	 * XXX: Freeing memmap with vmemmap is not implement yet.
> -	 *      This should be removed later.
> -	 */
> -	return -EBUSY;
> +	int ret = -EINVAL;
> +
> +	if (!valid_section(ms))
> +		return ret;
> +
> +	ret = unregister_memory_section(ms);
> +
> +	return ret;
>   }
>   #else
>   static int __remove_section(struct zone *zone, struct mem_section *ms)
