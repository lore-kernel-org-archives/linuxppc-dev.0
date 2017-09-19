Return-Path: <robh@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xxVmN4ybgzDq8f
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Sep 2017 03:51:16 +1000 (AEST)
Received: from mail-qk0-f175.google.com (mail-qk0-f175.google.com
 [209.85.220.175])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 891C921C9B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Sep 2017 17:51:14 +0000 (UTC)
Received: by mail-qk0-f175.google.com with SMTP id r141so407658qke.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Sep 2017 10:51:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170914102415.26395-1-stewart@linux.vnet.ibm.com>
References: <20170914102415.26395-1-stewart@linux.vnet.ibm.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 19 Sep 2017 12:50:53 -0500
Message-ID: <CAL_JsqL29j59wJtmOAuD=N7Tccv2rxEMav90yxTyGTfhwHQUsw@mail.gmail.com>
Subject: Re: [PATCH] drivers: of: static DT reservations incorrectly added to
 dynamic list
To: Stewart Smith <stewart@linux.vnet.ibm.com>
Cc: obh+dt@kernel.org, Frank Rowand <frowand.list@gmail.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 14, 2017 at 5:24 AM, Stewart Smith
<stewart@linux.vnet.ibm.com> wrote:
> There are two types of memory reservations firmware can ask the kernel
> to make in the device tree: static and dynamic.
> See Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
>
> If you have greater than 16 entries in /reserved-memory (as we do on
> POWER9 systems) you would get this scary looking error message:
> [    0.000000] OF: reserved mem: not enough space all defined regions.
>
> This is harmless if all your reservations are static (which with OPAL on
> POWER9, they are).
>
> It is not harmless if you have any dynamic reservations after the 16th.
>
> In the first pass over the fdt to find reservations, the child nodes of
> /reserved-memory are added to a static array in of_reserved_mem.c so that
> memory can be reserved in a 2nd pass. The array has 16 entries. This is why,
> on my dual socket POWER9 system, I get that error 4 times with 20 static
> reservations.
>
> We don't have a problem on ppc though, as in arch/powerpc/kernel/prom.c
> we look at the new style /reserved-ranges property to do reservations,
> and this logic was introduced in 0962e8004e974 (well before any powernv
> system shipped).
>
> Google shows up no occurances of that exact error message, so we're probably
> safe in that no machine that people use has memory not being reserved when
> it should be.
>
> The fix is simple, as there's a different code path for static and dynamic
> allocations, we just don't add the region to the list if it's static. Since
> it's a static *OR* dynamic region, this is a perfectly valid thing to do
> (although I have not checked every real world device tree on the planet
> for this condition)

If the region is dynamic (i.e. no reg prop), then we bail from
__reserved_mem_reserve_reg. So wouldn't this change make the list be
empty always?

Won't we have problems with lookups for devices with a "memory-region"
property if static allocations are not in the list?

I'm inclined to just make the safe and easy change of increasing the
array to 32 entries. That should be enough for everyone (TM).

Rob
