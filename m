Return-Path: <wency@cn.fujitsu.com>
Received: from song.cn.fujitsu.com (unknown [222.73.24.84])
 by ozlabs.org (Postfix) with ESMTP id 6CC422C008D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jul 2012 11:52:45 +1000 (EST)
Message-ID: <5015EA0D.9050501@cn.fujitsu.com>
Date: Mon, 30 Jul 2012 09:57:33 +0800
From: Wen Congyang <wency@cn.fujitsu.com>
MIME-Version: 1.0
To: Tony Luck <tony.luck@intel.com>
Subject: Re: [RFC PATCH v5 05/19] memory-hotplug: check whether memory is
 present or not
References: <50126B83.3050201@cn.fujitsu.com>	<50126D44.7070608@cn.fujitsu.com>
 <CA+8MBbL+G=xqkWU4xGF3_Ra7KoeoHuzL6QYcRiKqtVZoOBfLdQ@mail.gmail.com>
In-Reply-To: <CA+8MBbL+G=xqkWU4xGF3_Ra7KoeoHuzL6QYcRiKqtVZoOBfLdQ@mail.gmail.com>
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

At 07/28/2012 04:17 AM, Tony Luck Wrote:
> On Fri, Jul 27, 2012 at 3:28 AM, Wen Congyang <wency@cn.fujitsu.com> wrote:
>> +static inline int pfns_present(unsigned long pfn, unsigned long nr_pages)
>> +{
>> +       int i;
>> +       for (i = 0; i < nr_pages; i++) {
>> +               if (pfn_present(pfn + 1))
> 
> Typo? I think you meant "pfn + i"

Typo error.

Thanks for pointing it out.
Wen Congyang

> 
>> +                       continue;
>> +               else
>> +                       return -EINVAL;
>> +       }
>> +       return 0;
>> +}
> 
> -Tony
> 
