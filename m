Return-Path: <jaegeuk.hanse@gmail.com>
Received: from mail-pb0-f51.google.com (mail-pb0-f51.google.com
 [209.85.160.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6E7E82C0093
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Nov 2012 22:17:01 +1100 (EST)
Received: by mail-pb0-f51.google.com with SMTP id ro12so1994164pbb.38
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Nov 2012 03:16:59 -0800 (PST)
Message-ID: <50AB669D.3060007@gmail.com>
Date: Tue, 20 Nov 2012 19:16:45 +0800
From: Jaegeuk Hanse <jaegeuk.hanse@gmail.com>
MIME-Version: 1.0
To: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>,
 Wen Congyang <wency@cn.fujitsu.com>
Subject: Re: [PATCH v3 06/12] memory-hotplug: unregister memory section on
 SPARSEMEM_VMEMMAP
References: <1351763083-7905-1-git-send-email-wency@cn.fujitsu.com>
 <1351763083-7905-7-git-send-email-wency@cn.fujitsu.com>
In-Reply-To: <1351763083-7905-7-git-send-email-wency@cn.fujitsu.com>
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

On 11/01/2012 05:44 PM, Wen Congyang wrote:
> From: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
>
> Currently __remove_section for SPARSEMEM_VMEMMAP does nothing. But even if
> we use SPARSEMEM_VMEMMAP, we can unregister the memory_section.
>
> So the patch add unregister_memory_section() into __remove_section().

Hi Yasuaki,

I have a question about these sparse vmemmap memory related patches. Hot 
add memory need allocated vmemmap pages, but this time is allocated by 
buddy system. How can gurantee virtual address is continuous to the 
address allocated before? If not continuous, page_to_pfn and pfn_to_page 
can't work correctly.

Regards,
Jaegeuk

>
> CC: David Rientjes <rientjes@google.com>
> CC: Jiang Liu <liuj97@gmail.com>
> CC: Len Brown <len.brown@intel.com>
> CC: Christoph Lameter <cl@linux.com>
> Cc: Minchan Kim <minchan.kim@gmail.com>
> CC: Andrew Morton <akpm@linux-foundation.org>
> CC: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
> CC: Wen Congyang <wency@cn.fujitsu.com>
> Signed-off-by: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
> ---
>   mm/memory_hotplug.c | 13 ++++++++-----
>   1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index ca07433..66a79a7 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -286,11 +286,14 @@ static int __meminit __add_section(int nid, struct zone *zone,
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
