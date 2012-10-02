Return-Path: <isimatu.yasuaki@jp.fujitsu.com>
Received: from fgwmail6.fujitsu.co.jp (fgwmail6.fujitsu.co.jp [192.51.44.36])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 54A252C0098
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Oct 2012 11:19:41 +1000 (EST)
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id A9DAE3EE0BC
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Oct 2012 10:19:37 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 8F1A445DEBF
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Oct 2012 10:19:37 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 735F245DEB6
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Oct 2012 10:19:37 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 663D61DB8044
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Oct 2012 10:19:37 +0900 (JST)
Received: from g01jpexchyt23.g01.fujitsu.local
 (g01jpexchyt23.g01.fujitsu.local [10.128.193.106])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 1136B1DB8043
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Oct 2012 10:19:37 +0900 (JST)
Message-ID: <506A4100.7070305@jp.fujitsu.com>
Date: Tue, 2 Oct 2012 10:18:56 +0900
From: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
MIME-Version: 1.0
To: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
Subject: Re: [RFC v9 PATCH 01/21] memory-hotplug: rename remove_memory() to
 offline_memory()/offline_pages()
References: <1346837155-534-1-git-send-email-wency@cn.fujitsu.com>
 <1346837155-534-2-git-send-email-wency@cn.fujitsu.com>
 <506509E4.1090000@gmail.com> <50651E68.3040208@jp.fujitsu.com>
 <CAHGf_=oJ_Jmjqcdr4cPJghf7PX+vfmZe=CV2sdQQhS5agzG15w@mail.gmail.com>
In-Reply-To: <CAHGf_=oJ_Jmjqcdr4cPJghf7PX+vfmZe=CV2sdQQhS5agzG15w@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Cc: linux-s390@vger.kernel.org, linux-ia64@vger.kernel.org,
 wency@cn.fujitsu.com, linux-acpi@vger.kernel.org, linux-sh@vger.kernel.org,
 len.brown@intel.com, x86@kernel.org, Ni zhan Chen <nizhan.chen@gmail.com>,
 linux-kernel@vger.kernel.org, cmetcalf@tilera.com, linux-mm@kvack.org,
 paulus@samba.org, minchan.kim@gmail.com, rientjes@google.com,
 sparclinux@vger.kernel.org, cl@linux.com, linuxppc-dev@lists.ozlabs.org,
 akpm@linux-foundation.org, liuj97@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Kosaki-san,

2012/09/29 7:15, KOSAKI Motohiro wrote:
> On Thu, Sep 27, 2012 at 11:50 PM, Yasuaki Ishimatsu
> <isimatu.yasuaki@jp.fujitsu.com> wrote:
>> Hi Chen,
>>
>>
>> 2012/09/28 11:22, Ni zhan Chen wrote:
>>>
>>> On 09/05/2012 05:25 PM, wency@cn.fujitsu.com wrote:
>>>>
>>>> From: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
>>>>
>>>> remove_memory() only try to offline pages. It is called in two cases:
>>>> 1. hot remove a memory device
>>>> 2. echo offline >/sys/devices/system/memory/memoryXX/state
>>>>
>>>> In the 1st case, we should also change memory block's state, and notify
>>>> the userspace that the memory block's state is changed after offlining
>>>> pages.
>>>>
>>>> So rename remove_memory() to offline_memory()/offline_pages(). And in
>>>> the 1st case, offline_memory() will be used. The function
>>>> offline_memory()
>>>> is not implemented. In the 2nd case, offline_pages() will be used.
>>>
>>>
>>> But this time there is not a function associated with add_memory.
>>
>>
>> To associate with add_memory() later, we renamed it.
>
> Then, you introduced bisect breakage. It is definitely unacceptable.

What is "bisect breakage" meaning?

Thanks,
Yasuaki Ishimatsu

>
> NAK.
>
