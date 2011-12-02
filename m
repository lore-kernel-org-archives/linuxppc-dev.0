Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id EB2C0B6F18
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Dec 2011 19:49:18 +1100 (EST)
Message-ID: <1322815749.11728.8.camel@pasglop>
Subject: Re: [PATCH] powerpc: Add support for OpenBlockS 600
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olof Johansson <olof@lixom.net>
Date: Fri, 02 Dec 2011 19:49:09 +1100
In-Reply-To: <CAOesGMgkh-OzyRH_O+2TT7AzhY0bHWazua9s6Mj9qmb174DANw@mail.gmail.com>
References: <1322804108.3729.50.camel@pasglop>
 <CAOesGMgkh-OzyRH_O+2TT7AzhY0bHWazua9s6Mj9qmb174DANw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2011-12-01 at 22:40 -0800, Olof Johansson wrote:
> Hi,
> 
> On Thu, Dec 1, 2011 at 9:35 PM, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> 
> >  arch/powerpc/boot/dts/obs600.dts           |  314 ++++++++++++++++++++++++++++
> 
> It'd be nice to have dtsi files for the SoCs, there's a lot of boiler
> plate in there. That shouldn't hold up this specific patch though.

Right definitely. One thing that I wonder tho (I haven't looked at the
dtsi stuff specifically), can it "remove" a node ?

Ie. The 405EX dtsi will probably expose the PCIe bridges in that
specific case, but I want them out as they aren't wired and trying to
use them causes a hang on this board.

Another approach is to stick in a disabled property and make sure the
ppc4xx_pci code checks it.

> >  arch/powerpc/boot/wrapper                  |   22 ++-
> >  arch/powerpc/configs/40x/obs600_defconfig  |   83 ++++++++
> 
> A new single-board defconfig? On arm that is a strong NACK, I'd say
> it's a bad idea on powerpc as well.

The defconfigs are just there for the user sake, I find them handy
myself. I have no objection (as maintainer) to having them since
nowadays they are really small and can be handy for embedded systems
(ie, on a tiny 405 based machine you really want to cut out the bloat
you don't need).

As long as the board -can- be built as part of a combo that is.

So as maintainer, I think I'll keep applying a different policy than ARM
in that area ;-)

Cheers,
Ben.
