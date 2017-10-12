Return-Path: <robh@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yCd6J5MdJzDr4T
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Oct 2017 04:25:43 +1100 (AEDT)
Received: from mail-qk0-f181.google.com (mail-qk0-f181.google.com
 [209.85.220.181])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6B87D2190B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Oct 2017 17:25:40 +0000 (UTC)
Received: by mail-qk0-f181.google.com with SMTP id y23so2065501qkb.10
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Oct 2017 10:25:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170926084000.29105-1-stewart@linux.vnet.ibm.com>
References: <CAL_JsqL29j59wJtmOAuD=N7Tccv2rxEMav90yxTyGTfhwHQUsw@mail.gmail.com>
 <20170926084000.29105-1-stewart@linux.vnet.ibm.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 12 Oct 2017 12:25:19 -0500
Message-ID: <CAL_JsqJCoc7AdRNZnR0wp6SB8f_w49ORpCe0g-rWPUwLHMYJZg@mail.gmail.com>
Subject: Re: [PATCH] drivers: of: increase MAX_RESERVED_REGIONS to 32
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

On Tue, Sep 26, 2017 at 3:40 AM, Stewart Smith
<stewart@linux.vnet.ibm.com> wrote:
> There are two types of memory reservations firmware can ask the kernel
> to make in the device tree: static and dynamic.
> See Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
>
> If you have greater than 16 entries in /reserved-memory (as we do on
> POWER9 systems) you would get this scary looking error message:
>  [    0.000000] OF: reserved mem: not enough space all defined regions.
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
> A Google search shows up no occurances of that exact error message, so we're
> probably safe in that no machine that people use has memory not being reserved
> when it should be.
>
> The simple fix is to bump the length of the array to 32 which "should be
> enough for everyone(TM)". The simple fix of not recording static allocations
> in the array would cause problems for devices with "memory-region" properties.
> A more future-proof fix is likely possible, although more invasive and this
> simple fix is perfectly suitable in the meantime while a more future-proof
> fix is developed.
>
> Signed-off-by: Stewart Smith <stewart@linux.vnet.ibm.com>
> ---
>  drivers/of/of_reserved_mem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied.

Rob
