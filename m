Return-Path: <wency@cn.fujitsu.com>
Received: from song.cn.fujitsu.com (unknown [222.73.24.84])
 by ozlabs.org (Postfix) with ESMTP id 6ED292C0092
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jul 2012 20:30:41 +1000 (EST)
Message-ID: <50166379.4090305@cn.fujitsu.com>
Date: Mon, 30 Jul 2012 18:35:37 +0800
From: Wen Congyang <wency@cn.fujitsu.com>
MIME-Version: 1.0
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [RFC PATCH v5 12/19] memory-hotplug: introduce new function
 arch_remove_memory()
References: <50126B83.3050201@cn.fujitsu.com> <50126E2F.8010301@cn.fujitsu.com>
 <20120730102305.GB3631@osiris.boeblingen.de.ibm.com>
In-Reply-To: <20120730102305.GB3631@osiris.boeblingen.de.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-s390@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-acpi@vger.kernel.org, len.brown@intel.com, linux-sh@vger.kernel.org,
 linux-kernel@vger.kernel.org, cmetcalf@tilera.com, linux-mm@kvack.org,
 Yasuaki ISIMATU <isimatu.yasuaki@jp.fujitsu.com>, paulus@samba.org,
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

At 07/30/2012 06:23 PM, Heiko Carstens Wrote:
> On Fri, Jul 27, 2012 at 06:32:15PM +0800, Wen Congyang wrote:
>> We don't call __add_pages() directly in the function add_memory()
>> because some other architecture related things need to be done
>> before or after calling __add_pages(). So we should introduce
>> a new function arch_remove_memory() to revert the things
>> done in arch_add_memory().
>>
>> Note: the function for s390 is not implemented(I don't know how to
>> implement it for s390).
> 
> There is no hardware or firmware interface which could trigger a
> hot memory remove on s390. So there is nothing that needs to be
> implemented.

Thanks for providing this information.

According to this, arch_remove_memory() for s390 can just return -EBUSY.

Thanks
Wen Congyang

> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
