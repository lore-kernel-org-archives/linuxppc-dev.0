Return-Path: <det.nicolas@free.fr>
Received: from smtp3.wanadoo.fr (smtp3.wanadoo.fr [193.252.22.28])
	by ozlabs.org (Postfix) with ESMTP id 6ACA467A88
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Mar 2005 23:58:11 +1100 (EST)
From: Nicolas DET <det.nicolas@free.fr>
To: James Chapman <jchapman@katalix.com>, linuxppc-dev@ozlabs.org
Date: 07 Mar 2005 13:57:39 +0100
In-Reply-To: <422C495B.8090805@katalix.com>
Message-Id: <20050307125808.6585A200008A@mwinf0308.wanadoo.fr>
Subject: Re: mv64x60 updates
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello James,

On 07/03/2005, you wrote:
> Hi Nicolas,

> A few general comments:-

> - mv64x60 stuff is best posted to linuxppc-embedded

ok.
I would just add that our platform (Pegasos II) is using MV64361 from
Marvell and is a complete computer.

> - you change several generic files to support your platform. It should
>    be possible to support new mv64x60 platforms by writing a new
>    xxx_setup.c file in arch/ppc/platforms with no other generic changes.
>    It is a goal that all mv64x60 boards can be supported by the generic
>    code in arch/ppc/syslib. If some changes need to be made outside
>    arch/ppc/platforms to support your board, try to make them generic so
>    that other similar boards would be able to use them. I suggest you
>    clone chrp_setup.c or katana.c rather than adding conditionals in
>    chrp_setup.c for your board. Then use code in your board specific
>    setup file to call arch/ppc/syslib mv64x60 routines as appropriate.

There is almost no changes compare to 2.6.11 (from kernel.org).

Pegasos II is a CHRP machine, as a result all related code is inside
arch/ppc/platform/chrp_*
There is almost nothing to do (but normal CHRP stuff) for the Pegasos
machine. I don't think it's plan clone
chrp_setup.c
I think Sven Luther could answer this better than me anyway.

About arch/ppc/syslibs/ mv64x60 code. Well, it's a bit evil as it has
hardcoded IRQ, hardcoded register base, it changes 
chipset configuration... whereas all of these is already done by the
Pegasos II OpenFirmWare.

I'm open to any solution to have every MV64x60 platform supported.
The Pegasos would _only_ requiere to get correct IRQ and register base for
get_resources stuff and to have the correct flags for the request_irq().
This is only for the ethernet driver.

> - you shouldn't need to add board-specific changes in mv643xx_eth.c.
>    Setup device platform data for your board in your platform file.
>    If something needs to be added to the platform data for a generic
>    change to mv643xx_eth, do that rather than add platform conditionals
>    in the driver.

In this case, the ethernet driver should get the request_irq() flags from
something in arch/ppc/ or arch/mips/

> - why do you need to use SA_SHIRQ in the ethernet driver?

Because the IRQ we use for ethernet is shared with others devices.

Regards
-- 
Nicolas DET
MorphOS & Linux developer
