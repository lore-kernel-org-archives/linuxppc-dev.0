Return-Path: <kosaki.motohiro@gmail.com>
Received: from mail-yw0-f44.google.com (mail-yw0-f44.google.com
 [209.85.213.44])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 276CB10083A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jun 2012 15:27:58 +1000 (EST)
Received: by yhq56 with SMTP id 56so2060424yhq.17
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jun 2012 22:27:56 -0700 (PDT)
MIME-Version: 1.0
Sender: kosaki.motohiro@gmail.com
In-Reply-To: <4FEBE646.5090801@jp.fujitsu.com>
References: <4FEA9C88.1070800@jp.fujitsu.com> <4FEA9DB1.7010303@jp.fujitsu.com>
 <4FEAC916.7030506@cn.fujitsu.com> <4FEBE646.5090801@jp.fujitsu.com>
From: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
Date: Thu, 28 Jun 2012 01:27:35 -0400
Message-ID: <CAHGf_=rzRthh+hpKWAVF9OyL+P_NhFw4y+W-tF3j0zB8pr0QjA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/12] memory-hogplug : check memory offline in
 offline_pages
To: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1
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

On Thu, Jun 28, 2012 at 1:06 AM, Yasuaki Ishimatsu
<isimatu.yasuaki@jp.fujitsu.com> wrote:
> Hi Wen,
>
> 2012/06/27 17:49, Wen Congyang wrote:
>> At 06/27/2012 01:44 PM, Yasuaki Ishimatsu Wrote:
>>> When offline_pages() is called to offlined memory, the function fails since
>>> all memory has been offlined. In this case, the function should succeed.
>>> The patch adds the check function into offline_pages().
>>
>> You miss such case: some pages are online, while some pages are offline.
>> offline_pages() will fail too in such case.
>
> You are right. But current code fails, when the function is called to offline
> memory. In this case, the function should succeed. So the patch confirms
> whether the memory was offlined or not. And if memory has already been
> offlined, offline_pages return 0.

Can you please explain why the caller can't check it? I hope to avoid
an ignorance
as far as we can.
