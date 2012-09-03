Return-Path: <wency@cn.fujitsu.com>
Received: from song.cn.fujitsu.com (unknown [222.73.24.84])
 by ozlabs.org (Postfix) with ESMTP id 18F572C008D
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Sep 2012 11:25:23 +1000 (EST)
Message-ID: <5044084B.3050705@cn.fujitsu.com>
Date: Mon, 03 Sep 2012 09:30:51 +0800
From: Wen Congyang <wency@cn.fujitsu.com>
MIME-Version: 1.0
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC v8 PATCH 04/20] memory-hotplug: offline and remove memory
 when removing the memory device
References: <1346148027-24468-1-git-send-email-wency@cn.fujitsu.com>	<1346148027-24468-5-git-send-email-wency@cn.fujitsu.com>
 <20120831135514.2a2dc0d4.akpm@linux-foundation.org>
In-Reply-To: <20120831135514.2a2dc0d4.akpm@linux-foundation.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-s390@vger.kernel.org, linux-ia64@vger.kernel.org, len.brown@intel.com,
 linux-acpi@vger.kernel.org, linux-sh@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, cmetcalf@tilera.com, linux-mm@kvack.org,
 isimatu.yasuaki@jp.fujitsu.com, paulus@samba.org, minchan.kim@gmail.com,
 kosaki.motohiro@jp.fujitsu.com, rientjes@google.com,
 sparclinux@vger.kernel.org, cl@linux.com, linuxppc-dev@lists.ozlabs.org,
 liuj97@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

At 09/01/2012 04:55 AM, Andrew Morton Wrote:
> On Tue, 28 Aug 2012 18:00:11 +0800
> wency@cn.fujitsu.com wrote:
> 
>> +int remove_memory(int nid, u64 start, u64 size)
>> +{
>> +	int ret = -EBUSY;
>> +	lock_memory_hotplug();
>> +	/*
>> +	 * The memory might become online by other task, even if you offine it.
>> +	 * So we check whether the cpu has been onlined or not.
> 
> I think you meant "memory", not "cpu".

Yes. I will fix it.

Thanks
Wen Congyang

> 
> Actually, "check whether any part of this memory range has been
> onlined" would be better.  If that is accurate ;)
> 
>> +	 */
>> +	if (!is_memblk_offline(start, size)) {
>> +		pr_warn("memory removing [mem %#010llx-%#010llx] failed, "
>> +			"because the memmory range is online\n",
>> +			start, start + size);
>> +		ret = -EAGAIN;
>> +	}
>> +
>> +	unlock_memory_hotplug();
>> +	return ret;
>> +
>> +}
>> +EXPORT_SYMBOL_GPL(remove_memory);
> 
