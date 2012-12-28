Return-Path: <kamezawa.hiroyu@jp.fujitsu.com>
Received: from fgwmail5.fujitsu.co.jp (fgwmail5.fujitsu.co.jp [192.51.44.35])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 6F0522C00C2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Dec 2012 11:29:54 +1100 (EST)
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 08F873EE0C1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Dec 2012 09:29:51 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id E21F645DE55
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Dec 2012 09:29:50 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id C82C045DE4F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Dec 2012 09:29:50 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id B99E7E08005
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Dec 2012 09:29:50 +0900 (JST)
Received: from m1000.s.css.fujitsu.com (m1000.s.css.fujitsu.com
 [10.240.81.136])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 6EE8B1DB8040
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Dec 2012 09:29:50 +0900 (JST)
Message-ID: <50DCE7C0.8070407@jp.fujitsu.com>
Date: Fri, 28 Dec 2012 09:28:48 +0900
From: Kamezawa Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
MIME-Version: 1.0
To: Wen Congyang <wency@cn.fujitsu.com>
Subject: Re: [PATCH v5 14/14] memory-hotplug: free node_data when a node is
 offlined
References: <1356350964-13437-1-git-send-email-tangchen@cn.fujitsu.com>
 <1356350964-13437-15-git-send-email-tangchen@cn.fujitsu.com>
 <50DA7533.6060407@jp.fujitsu.com> <50DC3C26.6060308@cn.fujitsu.com>
In-Reply-To: <50DC3C26.6060308@cn.fujitsu.com>
Content-Type: text/plain; charset=ISO-2022-JP
Cc: linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
 Tang Chen <tangchen@cn.fujitsu.com>, linux-mm@kvack.org, paulus@samba.org,
 hpa@zytor.com, sparclinux@vger.kernel.org, cl@linux.com,
 linux-s390@vger.kernel.org, x86@kernel.org, linux-acpi@vger.kernel.org,
 isimatu.yasuaki@jp.fujitsu.com, linfeng@cn.fujitsu.com, mgorman@suse.de,
 kosaki.motohiro@jp.fujitsu.com, rientjes@google.com, liuj97@gmail.com,
 len.brown@intel.com, cmetcalf@tilera.com, wujianguo@huawei.com,
 yinghai@kernel.org, laijs@cn.fujitsu.com, linux-kernel@vger.kernel.org,
 minchan.kim@gmail.com, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

(2012/12/27 21:16), Wen Congyang wrote:
> At 12/26/2012 11:55 AM, Kamezawa Hiroyuki Wrote:
>> (2012/12/24 21:09), Tang Chen wrote:
>>> From: Wen Congyang <wency@cn.fujitsu.com>
>>>
>>> We call hotadd_new_pgdat() to allocate memory to store node_data. So we
>>> should free it when removing a node.
>>>
>>> Signed-off-by: Wen Congyang <wency@cn.fujitsu.com>
>>
>> I'm sorry but is it safe to remove pgdat ? All zone cache and zonelists are
>> properly cleared/rebuilded in synchronous way ? and No threads are visinting
>> zone in vmscan.c ?
> 
> We have rebuilt zonelists when a zone has no memory after offlining some pages.
> 

How do you guarantee that the address of pgdat/zone is not on stack of any kernel
threads or other kernel objects without reference counting or other syncing method ?


Thanks,
-Kame
