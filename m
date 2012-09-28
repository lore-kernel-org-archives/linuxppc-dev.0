Return-Path: <kosaki.motohiro@gmail.com>
Received: from mail-vb0-f51.google.com (mail-vb0-f51.google.com
 [209.85.212.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 26A1D2C00B5
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Sep 2012 08:21:45 +1000 (EST)
Received: by vbbfn1 with SMTP id fn1so3470066vbb.38
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Sep 2012 15:21:41 -0700 (PDT)
MIME-Version: 1.0
Sender: kosaki.motohiro@gmail.com
In-Reply-To: <50651E68.3040208@jp.fujitsu.com>
References: <1346837155-534-1-git-send-email-wency@cn.fujitsu.com>
 <1346837155-534-2-git-send-email-wency@cn.fujitsu.com>
 <506509E4.1090000@gmail.com> <50651E68.3040208@jp.fujitsu.com>
From: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
Date: Fri, 28 Sep 2012 18:15:22 -0400
Message-ID: <CAHGf_=oJ_Jmjqcdr4cPJghf7PX+vfmZe=CV2sdQQhS5agzG15w@mail.gmail.com>
Subject: Re: [RFC v9 PATCH 01/21] memory-hotplug: rename remove_memory() to
 offline_memory()/offline_pages()
To: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1
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

On Thu, Sep 27, 2012 at 11:50 PM, Yasuaki Ishimatsu
<isimatu.yasuaki@jp.fujitsu.com> wrote:
> Hi Chen,
>
>
> 2012/09/28 11:22, Ni zhan Chen wrote:
>>
>> On 09/05/2012 05:25 PM, wency@cn.fujitsu.com wrote:
>>>
>>> From: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
>>>
>>> remove_memory() only try to offline pages. It is called in two cases:
>>> 1. hot remove a memory device
>>> 2. echo offline >/sys/devices/system/memory/memoryXX/state
>>>
>>> In the 1st case, we should also change memory block's state, and notify
>>> the userspace that the memory block's state is changed after offlining
>>> pages.
>>>
>>> So rename remove_memory() to offline_memory()/offline_pages(). And in
>>> the 1st case, offline_memory() will be used. The function
>>> offline_memory()
>>> is not implemented. In the 2nd case, offline_pages() will be used.
>>
>>
>> But this time there is not a function associated with add_memory.
>
>
> To associate with add_memory() later, we renamed it.

Then, you introduced bisect breakage. It is definitely unacceptable.

NAK.
