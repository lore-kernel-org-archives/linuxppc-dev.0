Return-Path: <wency@cn.fujitsu.com>
Received: from song.cn.fujitsu.com (unknown [222.73.24.84])
 by ozlabs.org (Postfix) with ESMTP id AC07E2C0078
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jul 2012 16:12:26 +1000 (EST)
Message-ID: <5012326F.80702@cn.fujitsu.com>
Date: Fri, 27 Jul 2012 14:17:19 +0800
From: Wen Congyang <wency@cn.fujitsu.com>
MIME-Version: 1.0
To: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
Subject: Re: [RFC PATCH v4 12/13] memory-hotplug : add node_device_release
References: <50068974.1070409@jp.fujitsu.com> <50068D41.9090109@jp.fujitsu.com>
In-Reply-To: <50068D41.9090109@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-2022-JP
Cc: len.brown@intel.com, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, paulus@samba.org,
 minchan.kim@gmail.com, kosaki.motohiro@jp.fujitsu.com, rientjes@google.com,
 cl@linux.com, linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org,
 liuj97@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

At 07/18/2012 06:17 PM, Yasuaki Ishimatsu Wrote:
> When calling unregister_node(), the function shows following message at
> device_release().
> 
> Device 'node2' does not have a release() function, it is broken and must be
> fixed.
> 
> So the patch implements node_device_release()
> 
> CC: David Rientjes <rientjes@google.com>
> CC: Jiang Liu <liuj97@gmail.com>
> CC: Len Brown <len.brown@intel.com>
> CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> CC: Paul Mackerras <paulus@samba.org> 
> CC: Christoph Lameter <cl@linux.com>
> Cc: Minchan Kim <minchan.kim@gmail.com>
> CC: Andrew Morton <akpm@linux-foundation.org>
> CC: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com> 
> CC: Wen Congyang <wency@cn.fujitsu.com>
> Signed-off-by: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
> 
> ---
>  drivers/base/node.c |    7 +++++++
>  1 file changed, 7 insertions(+)
> 
> Index: linux-3.5-rc6/drivers/base/node.c
> ===================================================================
> --- linux-3.5-rc6.orig/drivers/base/node.c	2012-07-18 18:24:29.191121066 +0900
> +++ linux-3.5-rc6/drivers/base/node.c	2012-07-18 18:25:47.111146983 +0900
> @@ -252,6 +252,12 @@ static inline void hugetlb_register_node
>  static inline void hugetlb_unregister_node(struct node *node) {}
>  #endif
>  
> +static void node_device_release(struct device *dev)
> +{
> +	struct node *node_dev = to_node(dev);
> +
> +	memset(node_dev, 0, sizeof(struct node));

This line is wrong. node_dev->work_struct may be queued in workqueue.
So, it is very dangerous to clear node_dev->work_struct here.
In my test, it will cause kernel panicked.

Thanks
Wen Congyang
> +}
>  
>  /*
>   * register_node - Setup a sysfs device for a node.
> @@ -265,6 +271,7 @@ int register_node(struct node *node, int
>  
>  	node->dev.id = num;
>  	node->dev.bus = &node_subsys;
> +	node->dev.release = node_device_release;
>  	error = device_register(&node->dev);
>  
>  	if (!error){
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
