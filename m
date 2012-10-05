Return-Path: <kosaki.motohiro@gmail.com>
Received: from mail-ob0-f179.google.com (mail-ob0-f179.google.com
 [209.85.214.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4D14D2C031C
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Oct 2012 05:07:02 +1000 (EST)
Received: by mail-ob0-f179.google.com with SMTP id lz20so1950982obb.38
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Oct 2012 12:07:00 -0700 (PDT)
MIME-Version: 1.0
Sender: kosaki.motohiro@gmail.com
In-Reply-To: <506E43E0.70507@jp.fujitsu.com>
References: <506E43E0.70507@jp.fujitsu.com>
From: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
Date: Fri, 5 Oct 2012 15:06:35 -0400
Message-ID: <CAHGf_=qCZvL7xcOkea80Y995sZWkOMQLLVnuvLUto4W+qpUbWA@mail.gmail.com>
Subject: Re: [PATCH 0/10] memory-hotplug: hot-remove physical memory
To: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-s390@vger.kernel.org, linux-ia64@vger.kernel.org,
 wency@cn.fujitsu.com, len.brown@intel.com, linux-acpi@vger.kernel.org,
 linux-sh@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 cmetcalf@tilera.com, linux-mm@kvack.org, minchan.kim@gmail.com,
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

> Known problems:
> 1. memory can't be offlined when CONFIG_MEMCG is selected.
>    For example: there is a memory device on node 1. The address range
>    is [1G, 1.5G). You will find 4 new directories memory8, memory9, memory10,
>    and memory11 under the directory /sys/devices/system/memory/.
>    If CONFIG_MEMCG is selected, we will allocate memory to store page cgroup
>    when we online pages. When we online memory8, the memory stored page cgroup
>    is not provided by this memory device. But when we online memory9, the memory
>    stored page cgroup may be provided by memory8. So we can't offline memory8
>    now. We should offline the memory in the reversed order.
>    When the memory device is hotremoved, we will auto offline memory provided
>    by this memory device. But we don't know which memory is onlined first, so
>    offlining memory may fail. In such case, you should offline the memory by
>    hand before hotremoving the memory device.

Just iterate twice. 1st iterate: offline every non primary memory
block. 2nd iterate:
offline primary (i.e. first added) memory block. It may work.
