Return-Path: <isimatu.yasuaki@jp.fujitsu.com>
Received: from fgwmail5.fujitsu.co.jp (fgwmail5.fujitsu.co.jp [192.51.44.35])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 46570B6F77
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jun 2012 16:02:06 +1000 (EST)
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 7CBE43EE081
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jun 2012 15:02:01 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 65A4845DEAD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jun 2012 15:02:01 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 5009345DEA6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jun 2012 15:02:01 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 4497E1DB803E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jun 2012 15:02:01 +0900 (JST)
Received: from g01jpexchyt05.g01.fujitsu.local
 (g01jpexchyt05.g01.fujitsu.local [10.128.194.44])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id DF6611DB8038
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jun 2012 15:02:00 +0900 (JST)
Message-ID: <4FEBF342.9030303@jp.fujitsu.com>
Date: Thu, 28 Jun 2012 15:01:38 +0900
From: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
MIME-Version: 1.0
To: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
Subject: Re: [RFC PATCH 2/12] memory-hogplug : check memory offline in
 offline_pages
References: <4FEA9C88.1070800@jp.fujitsu.com>
 <4FEA9DB1.7010303@jp.fujitsu.com> <4FEAC916.7030506@cn.fujitsu.com>
 <4FEBE646.5090801@jp.fujitsu.com>
 <CAHGf_=rzRthh+hpKWAVF9OyL+P_NhFw4y+W-tF3j0zB8pr0QjA@mail.gmail.com>
In-Reply-To: <CAHGf_=rzRthh+hpKWAVF9OyL+P_NhFw4y+W-tF3j0zB8pr0QjA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Cc: len.brown@intel.com, Wen Congyang <wency@cn.fujitsu.com>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 paulus@samba.org, minchan.kim@gmail.com, cl@linux.com,
 linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Kosaki-san,

2012/06/28 14:27, KOSAKI Motohiro wrote:
> On Thu, Jun 28, 2012 at 1:06 AM, Yasuaki Ishimatsu
> <isimatu.yasuaki@jp.fujitsu.com> wrote:
>> Hi Wen,
>>
>> 2012/06/27 17:49, Wen Congyang wrote:
>>> At 06/27/2012 01:44 PM, Yasuaki Ishimatsu Wrote:
>>>> When offline_pages() is called to offlined memory, the function fails since
>>>> all memory has been offlined. In this case, the function should succeed.
>>>> The patch adds the check function into offline_pages().
>>>
>>> You miss such case: some pages are online, while some pages are offline.
>>> offline_pages() will fail too in such case.
>>
>> You are right. But current code fails, when the function is called to offline
>> memory. In this case, the function should succeed. So the patch confirms
>> whether the memory was offlined or not. And if memory has already been
>> offlined, offline_pages return 0.
>
> Can you please explain why the caller can't check it? I hope to avoid
> an ignorance
> as far as we can.

Of course, caller side can check it. But there is a possibility that
offline_pages() is called by many functions. So I do not think that it
is good that all functions which call offline_pages() check it.

Thanks,
Yasuaki Ishimatsu
