Return-Path: <glommer@parallels.com>
Received: from mx2.parallels.com (mx2.parallels.com [64.131.90.16])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 53A4B2C00AE
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Dec 2012 19:48:11 +1100 (EST)
Message-ID: <50D96543.6010903@parallels.com>
Date: Tue, 25 Dec 2012 12:35:15 +0400
From: Glauber Costa <glommer@parallels.com>
MIME-Version: 1.0
To: Tang Chen <tangchen@cn.fujitsu.com>
Subject: Re: [PATCH v5 01/14] memory-hotplug: try to offline the memory twice
 to avoid dependence
References: <1356350964-13437-1-git-send-email-tangchen@cn.fujitsu.com>
 <1356350964-13437-2-git-send-email-tangchen@cn.fujitsu.com>
In-Reply-To: <1356350964-13437-2-git-send-email-tangchen@cn.fujitsu.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, linux-mm@kvack.org,
 paulus@samba.org, hpa@zytor.com, sparclinux@vger.kernel.org, cl@linux.com,
 linux-s390@vger.kernel.org, x86@kernel.org, linux-acpi@vger.kernel.org,
 isimatu.yasuaki@jp.fujitsu.com, linfeng@cn.fujitsu.com, mgorman@suse.de,
 kosaki.motohiro@jp.fujitsu.com, rientjes@google.com, liuj97@gmail.com,
 len.brown@intel.com, wency@cn.fujitsu.com, cmetcalf@tilera.com,
 wujianguo@huawei.com, yinghai@kernel.org, laijs@cn.fujitsu.com,
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

On 12/24/2012 04:09 PM, Tang Chen wrote:
> From: Wen Congyang <wency@cn.fujitsu.com>
> 
> memory can't be offlined when CONFIG_MEMCG is selected.
> For example: there is a memory device on node 1. The address range
> is [1G, 1.5G). You will find 4 new directories memory8, memory9, memory10,
> and memory11 under the directory /sys/devices/system/memory/.
> 
> If CONFIG_MEMCG is selected, we will allocate memory to store page cgroup
> when we online pages. When we online memory8, the memory stored page cgroup
> is not provided by this memory device. But when we online memory9, the memory
> stored page cgroup may be provided by memory8. So we can't offline memory8
> now. We should offline the memory in the reversed order.
> 
> When the memory device is hotremoved, we will auto offline memory provided
> by this memory device. But we don't know which memory is onlined first, so
> offlining memory may fail. In such case, iterate twice to offline the memory.
> 1st iterate: offline every non primary memory block.
> 2nd iterate: offline primary (i.e. first added) memory block.
> 
> This idea is suggested by KOSAKI Motohiro.
> 
> Signed-off-by: Wen Congyang <wency@cn.fujitsu.com>

Maybe there is something here that I am missing - I admit that I came
late to this one, but this really sounds like a very ugly hack, that
really has no place in here.

Retrying, of course, may make sense, if we have reasonable belief that
we may now succeed. If this is the case, you need to document - in the
code - while is that.

The memcg argument, however, doesn't really cut it. Why can't we make
all page_cgroup allocations local to the node they are describing? If
memcg is the culprit here, we should fix it, and not retry. If there is
still any benefit in retrying, then we retry being very specific about why.
