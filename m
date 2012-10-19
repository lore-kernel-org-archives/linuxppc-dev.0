Return-Path: <kosaki.motohiro@gmail.com>
Received: from mail-ob0-f179.google.com (mail-ob0-f179.google.com
 [209.85.214.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 231B42C008F
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Oct 2012 05:33:41 +1100 (EST)
Received: by mail-ob0-f179.google.com with SMTP id lz20so669804obb.38
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Oct 2012 11:33:38 -0700 (PDT)
MIME-Version: 1.0
Sender: kosaki.motohiro@gmail.com
In-Reply-To: <5081609C.9080702@gmail.com>
References: <506E43E0.70507@jp.fujitsu.com> <506E451E.1050403@jp.fujitsu.com>
 <CAHGf_=rVDm-JygjPoLHbmF28Dgd52HFc4-b5KCxhEieG60okuw@mail.gmail.com>
 <50812F13.20503@cn.fujitsu.com> <5081609C.9080702@gmail.com>
From: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
Date: Fri, 19 Oct 2012 14:33:17 -0400
Message-ID: <CAHGf_=q=Agidyj_j6jhBdhNmJBy2u1dP+UMAoXbM=_=DyZJs_w@mail.gmail.com>
Subject: Re: [PATCH 1/10] memory-hotplug : check whether memory is offline or
 not when removing memory
To: Wen Congyang <wencongyang@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-s390@vger.kernel.org, linux-ia64@vger.kernel.org,
 Wen Congyang <wency@cn.fujitsu.com>, linux-acpi@vger.kernel.org,
 linux-sh@vger.kernel.org, len.brown@intel.com, x86@kernel.org,
 linux-kernel@vger.kernel.org, cmetcalf@tilera.com, linux-mm@kvack.org,
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

> I think it again, and found that this check is necessary. Because we only
> lock memory hotplug when offlining pages. Here is the steps to offline and
> remove memory:
>
> 1. lock memory hotplug
> 2. offline a memory section
> 3. unlock memory hotplug
> 4. repeat 1-3 to offline all memory sections
> 5. lock memory hotplug
> 6. remove memory
> 7. unlock memory hotplug
>
> All memory sections must be offlined before removing memory. But we don't
> hold
> the lock in the whole operation. So we should check whether all memory
> sections
> are offlined before step6.

You should describe the race scenario in the patch description. OK?
