Return-Path: <frowand.list@gmail.com>
Received: from mail-pa0-x244.google.com (mail-pa0-x244.google.com
 [IPv6:2607:f8b0:400e:c03::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rVrSK6c5WzDqpc
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jun 2016 03:47:29 +1000 (AEST)
Received: by mail-pa0-x244.google.com with SMTP id fg1so4112227pad.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jun 2016 10:47:29 -0700 (PDT)
Subject: Re: [PATCH v2] of: fix memory leak related to safe_name()
To: Mathieu Malaterre <mathieu.malaterre@gmail.com>
References: <5761BDAD.3060107@gmail.com>
 <CA+7wUszph+weTn=bu24d6YdkChOk39ae_dOkQXJQxykkQH0PNg@mail.gmail.com>
 <CA+7wUsz0OnOHVyGTE=nzAbCi_GbmLvU-Q4wQHjs=SOLRUB4E5w@mail.gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <5762E629.8060301@gmail.com>
Date: Thu, 16 Jun 2016 10:47:21 -0700
MIME-Version: 1.0
In-Reply-To: <CA+7wUsz0OnOHVyGTE=nzAbCi_GbmLvU-Q4wQHjs=SOLRUB4E5w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/16/16 00:51, Mathieu Malaterre wrote:
> Sorry, symptoms not solved. According to kmemleak, I have now:
> 
> [  661.323100] kmemleak: 100 new suspected memory leaks (see
> /sys/kernel/debug/kmemleak)
> [ 1260.226120] kmemleak: 1 new suspected memory leaks (see
> /sys/kernel/debug/kmemleak)
> 
> # head -40 /sys/kernel/debug/kmemleak
> unreferenced object 0xdf5326a0 (size 32):
>   comm "swapper", pid 1, jiffies 4294892300 (age 2564.708s)
>   hex dump (first 32 bytes):
>     62 61 73 65 00 00 4c d8 c5 78 df dc cc 43 e4 bc  base..L..x...C..
>     c4 c8 ec 8c ee de ce cf e8 c9 8a ea dc cc c6 fd  ................
>   backtrace:
>     [<c014d4d8>] kstrdup+0x48/0x88
>     [<c0454678>] __of_attach_node_sysfs+0xf0/0x100
>     [<c075f21c>] of_core_init+0x8c/0xf8
>     [<c0729594>] kernel_init_freeable+0xd4/0x208
>     [<c00047e8>] kernel_init+0x24/0x11c
>     [<c00158ec>] ret_from_kernel_thread+0x5c/0x64

< snip >

Brown paper bag time.  I left out the kfree() in the one place that
your first patch added it.  Version 3 on the way.

-Frank
