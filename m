Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vyyqG0hsGzDqJ9
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Apr 2017 06:58:17 +1000 (AEST)
Message-ID: <1491425881.4166.90.camel@kernel.crashing.org>
Subject: Re: [PATCH 2/3] of/fdt: introduce of_scan_flat_dt_subnodes and
 of_get_flat_dt_phandle
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Rob Herring <robh+dt@kernel.org>, Nicholas Piggin <npiggin@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Frank Rowand <frowand.list@gmail.com>
Date: Thu, 06 Apr 2017 06:58:01 +1000
In-Reply-To: <CAL_JsqLEvjb8S-+-JEa4ALHeCWHiR1A_4ur9kd3pBRJaFYWVKw@mail.gmail.com>
References: <20170405123706.6081-1-npiggin@gmail.com>
 <20170405123706.6081-3-npiggin@gmail.com>
 <CAL_JsqK4zbACwWVb-rsrvBb4hjBCexrqKRKrzSiZrZH5w=bKqQ@mail.gmail.com>
 <20170406003251.533e2845@roar.ozlabs.ibm.com>
 <CAL_JsqLEvjb8S-+-JEa4ALHeCWHiR1A_4ur9kd3pBRJaFYWVKw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-04-05 at 10:58 -0500, Rob Herring wrote:
> Well, I'd like to avoid expanding usage of flat DT parsing in the
> kernel. But you could just put this function into arch/powerpc and I'd
> never see it, but I like that even less. Mainly, I just wanted to
> raise the point.
> 
> Your argument works until you need that setup in assembly code, then
> you are in the situation that you need to either handle the setup in
> bootloader/firmware or have an simple way to determine that condition.

The main issue is that changing that is a very very invasive change in
an extremely fragile and rather nasty area of code shared by 32 and 64-
bit for which we don't even have easy access to all the machines to
test with anymore :)

It's probably not impossible, but it would delay the new cpu feature
stuff that Nick is making by a lot, probably monthes, making it nearly
impossible to get back into distros etc... 

So while it might be something to consider, I would definitely keep
that as a separate unit of work to do later.

Cheers,
Ben.
