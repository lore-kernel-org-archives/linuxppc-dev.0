Return-Path: <wency@cn.fujitsu.com>
Received: from song.cn.fujitsu.com (unknown [222.73.24.84])
 by ozlabs.org (Postfix) with ESMTP id 9D8BC2C0093
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Oct 2012 12:47:41 +1100 (EST)
Message-ID: <5081F565.8020605@cn.fujitsu.com>
Date: Sat, 20 Oct 2012 08:50:45 +0800
From: Wen Congyang <wency@cn.fujitsu.com>
MIME-Version: 1.0
To: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
Subject: Re: [PATCH 1/10] memory-hotplug : check whether memory is offline
 or not when removing memory
References: <506E43E0.70507@jp.fujitsu.com> <506E451E.1050403@jp.fujitsu.com>
 <CAHGf_=rVDm-JygjPoLHbmF28Dgd52HFc4-b5KCxhEieG60okuw@mail.gmail.com>
 <50812F13.20503@cn.fujitsu.com> <5081609C.9080702@gmail.com>
 <CAHGf_=q=Agidyj_j6jhBdhNmJBy2u1dP+UMAoXbM=_=DyZJs_w@mail.gmail.com>
In-Reply-To: <CAHGf_=q=Agidyj_j6jhBdhNmJBy2u1dP+UMAoXbM=_=DyZJs_w@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-s390@vger.kernel.org, linux-ia64@vger.kernel.org, len.brown@intel.com,
 linux-acpi@vger.kernel.org, linux-sh@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, cmetcalf@tilera.com,
 Wen Congyang <wencongyang@gmail.com>, linux-mm@kvack.org,
 Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>, minchan.kim@gmail.com,
 rientjes@google.com, sparclinux@vger.kernel.org, cl@linux.com,
 linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org, liuj97@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

At 10/20/2012 02:33 AM, KOSAKI Motohiro Wrote:
>> I think it again, and found that this check is necessary. Because we only
>> lock memory hotplug when offlining pages. Here is the steps to offline and
>> remove memory:
>>
>> 1. lock memory hotplug
>> 2. offline a memory section
>> 3. unlock memory hotplug
>> 4. repeat 1-3 to offline all memory sections
>> 5. lock memory hotplug
>> 6. remove memory
>> 7. unlock memory hotplug
>>
>> All memory sections must be offlined before removing memory. But we don't
>> hold
>> the lock in the whole operation. So we should check whether all memory
>> sections
>> are offlined before step6.
> 
> You should describe the race scenario in the patch description. OK?
> 

OK

Thanks
Wen Congyang
