Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DDD0E1A084B
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Apr 2015 19:50:03 +1100 (AEDT)
Message-ID: <1428051002.27245.1.camel@ellerman.id.au>
Subject: Re: [PATCH 0/2] Add a MTD driver for OpenPower PNOR flash
From: Michael Ellerman <mpe@ellerman.id.au>
To: Jeremy Kerr <jk@ozlabs.org>
Date: Fri, 03 Apr 2015 19:50:02 +1100
In-Reply-To: <1427868330.741478.119647151764.0.gpush@pablo>
References: <1427868330.741478.119647151764.0.gpush@pablo>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-mtd@lists.infradead.org,
 Cyril Bur <cyrilbur@gmail.com>, Joel Stanley <joel@jms.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-04-01 at 14:05 +0800, Jeremy Kerr wrote:
> Hi all,
> 
> This series implements a simple mtd device to allow access to the PNOR
> flash on OpenPower machines. The flash is accessed through firmware
> calls.
> 
> Patch 1/2 adds the Linux interface to these calls. Patch 2/2 adds a mtd
> driver that uses these calls.
> 
> Because there's two subsystems involved here, there are a couple of
> methods to merge this:
> 
>  1) The powerpc folks take 1/2, and the mtd folks take 2/2, to be
>     applied once 1/2 is available (Michael has created a topic branch for
>     this in the past, which can make things a little easier), or

Unfortunately the topic branch approach is problematic for this series, because
we already have changes to opal.h in powerpc-next that clash.

I can still make a topic branch, but it would have to include ~10 powerpc
commits prior to this patch.

>  2) One of the maintainers takes both patches, once the other has acked
>     their patch. I'd suggest that it goes through the powerpc tree in
>     this case, as that will be less likely to conflict.

If the mtd maintainers are happy with it this would be the easier approach in
this instance.

cheers
